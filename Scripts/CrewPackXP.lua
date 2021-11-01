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
local cpxp_initDelay = 5
local cpxp_startTime = 0
dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")

-- Dependencies
local LIP = require("LIP")
local FF767 = require("CrewPackXP/FF767_CrewPackXP")
local FF767snd = require("CrewPackXP/FF767_SND_CrewPackXP")

require "graphics"

-- Generic Datarefs


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
local cpxp_Ready = false

function cpxpDelayInit()
    if not cpxp_Ready then
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
        if PLANE_ICAO == "B752" then
            if not FF767.cpxpAircraftDelay() then
                print("CPXP: Aircraft Module reporting not ready")
            else
                print("CPXP: Aircraft Module reports it has worked")
                cpxp_Ready = true
            end
        else 
            cpxp_Ready = true
            print("Aircraft Not Recognised")
        end
    end
end

do_often("cpxpDelayInit()")
--[[
function cpxpMainCall()
    if PLANE_ICAO == "B752" and cpxp_Ready then
        FF767snd.SetGain()
        FF767snd.cpxpStartSound()
    end
end
]]