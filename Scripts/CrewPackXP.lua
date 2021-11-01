--[[
	CrewPackXP
	
	Voices by https://www.naturalreaders.com/
	Captn: Guy
	FO: Ranald
    Ground Crew: en-AU-B-Male (what a name...)
    Safety: Leslie
	
	Changelog:
	V0.1 - Initial Test Beta
    V0.2 - Variable name corrections
    V0.3 - Crosscheck and correction of variable adjustments
    V0.4 - Corrected TO VNAV and LOC logic Bug#3
    v0.5 - Added GPU connection logic to cockpit setup and shutdown. Cargo doors and L1 open on eng off setup with belt loaders. N.B. Ext Pwr will fail if disconnected whilst on bus.
    v0.5.1 - Finally found chocks dataref. Adjust doors logic per frame. Added beacon on to remove all GSE. Cockpit Setup expanded to FO preflight and Baro sync.
    v0.6 - Added settings widnow, require LIP module to save and load settigns. Options added for ammount of automation.
    v0.7 - rewrite to create individual aircraft modules
--]]

-- Initial Variables
local cpxp_version = "0.7-beta"
local cpxp_initDelay = 15
local cpxp_startTime = 0
dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")

-- Dependencies
local LIP = require("LIP")
local FF767 = require("CrewPackXP/FF767_CrewPackXP")

require "graphics"

-- Generic Datarefs
dataref("cpxp_AGL", "sim/flightmodel/position/y_agl")
dataref("cpxp_FLAP_LEVER", "sim/flightmodel/controls/flaprqst", "writeable")
dataref("cpxp_GEAR_HANDLE", "1-sim/cockpit/switches/gear_handle")
dataref("cpxp_SPEED_BRAKE", "sim/cockpit2/controls/speedbrake_ratio")
dataref("cpxp_WEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
dataref("cpxp_PARK_BRAKE", "sim/cockpit2/controls/parking_brake_ratio")
dataref("cpxp_ENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
dataref("cpxp_ENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
dataref("cpxp_LOC_DEVIATION", "sim/cockpit/radios/nav2_hdef_dot")
dataref("cpxp_LOC_RECEIVED", "1-sim/radios/isReceivingIlsLoc1")
dataref("cpxp_GS_DEVIATION", "sim/cockpit/radios/nav2_vdef_dot")
dataref("cpxp_GS_RECEIVED", "1-sim/radios/isReceivingIlsGs1")
dataref("cpxp_STROBE_SWITCH", "sim/cockpit2/switches/strobe_lights_on")
dataref("cpxp_ENGINE_MODE", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
dataref("cpxp_MCP_SPEED", "sim/cockpit/autopilot/airspeed", "writeable")
dataref("cpxp_FLCH_BUTTON", "1-sim/AP/flchButton", "writeable")
dataref("cpxp_VNAV_ENGAGED_LT", "1-sim/AP/lamp/4")
dataref("cpxp_VNAV_BUTTON", "1-sim/AP/vnavButton", "writeable")
dataref("cpxp_LNAV_BUTTON", "1-sim/AP/lnavButton", "writeable")
dataref("cpxp_AUTO_BRAKE", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
dataref("cpxp_TOGA_BUTTON", "1-sim/AP/togaButton")
dataref("cpxp_BEACON", "sim/cockpit2/switches/beacon_on")
dataref("cpxp_LEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
dataref("cpxp_RIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)
dataref("cpxp_BELTS_SIGN", "sim/cockpit2/annunciators/fasten_seatbelt")

print("CrewPackXP: Initialising version " .. cpxp_version)
print("CrewPackXP: Starting at sim time " .. math.floor(cpxp_SIM_TIME))

-- Message Bubbles
local cpxp_msgStr = nil
local cpxp_bubbleTimer = 0



function cpxpDisplayMessage()
    bubble(20, get("sim/graphics/view/window_height") - 100, cpxp_msgStr)
end

function cpxpMsg()
    if cpxp_bubbleTimer < 3 then
        cpxpDisplayMessage()
    else
        cpxp_msgStr = ""
    end 
end

function cpxpBubbleTiming()
    if cpxp_bubbleTimer < 3 then
        cpxp_bubbleTimer = cpxp_bubbleTimer + 1
    end        
end

do_every_draw("cpxpMsg()")
do_often("cpxpBubbleTiming()")

-- Delay Init
local cpxp_timeReady = false

function cpxpDelayInit()
    if cpxp_startTime == 0 then
        cpxp_startTime = (cpxp_SIM_TIME + cpxp_initDelay)
        cpxp_bubbleTimer = -12
        -- cpxpParseSettings()
    end
    if (cpxp_SIM_TIME < cpxp_startTime) then
        print("CrewPackXP: Waiting to start " .. math.floor(cpxp_SIM_TIME) .. " waiting for " .. math.floor(cpxp_startTime))
        cpxp_msgStr = "CrewPackXP loading in " .. math.floor(cpxp_startTime - cpxp_SIM_TIME) .. " seconds"
        return
    end

    if not FF767.cpxp_aircraftReady then
        if PLANE_ICAO == "B752" then
        print("CrewPackXP: Waiting for aircraft module to report ready")
        FF767.cpxpAircraftDelay()
        print("Main: " .. FF767.cpxp_aircraftReady)
        end
    end


    if not cpxp_timeReady then
        print("CrewPackXP: Plugin Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(cpxp_SIM_TIME))
        cpxp_msgStr = "CrewPackXP Initialised for " .. PLANE_ICAO
        cpxp_bubbleTimer = 0
        cpxp_timeReady = true
    end
end

do_often("cpxpDelayInit()")


