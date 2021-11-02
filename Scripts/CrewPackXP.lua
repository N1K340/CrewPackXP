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
local cpxpVersion = "0.7-beta"
local cpxpStartTime = 0
dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")

-- Dependencies

local FF767 = require("CrewPackXP/FF767_CrewPackXP")
local FF767snd = require("CrewPackXP/FF767_SND_CrewPackXP")
local FF767cfg = require("CrewPackXP/FF767_CFG_CrewPackXP")
FF767cfg.ParseCrewPackXPSettings()

require "graphics"

-- Global Var

cpxpMsgStr = nil
cpxpBubbleTimer = 0
cpxpReady = false
cpxpInitDelay = 10

-- Local Var
local cpxpLoadedAircraft = AIRCRAFT_FILENAME
local cpxpScriptReady = false

-- Generic Datarefs
print("CrewPackXP: Initialising main plugin version " .. cpxpVersion)
print("CrewPackXP: Starting at sim time " .. math.floor(cpxp_SIM_TIME))

-- Message Bubbles
function cpxpDisplayMessage()
    bubble(20, get("sim/graphics/view/window_height") - 100, _G.cpxpMsgStr)
end

function cpxpMsg()
    if _G.cpxpBubbleTimer < 3 then
        cpxpDisplayMessage()
    else
        _G.cpxpMsgStr = ""
    end 
end

function cpxpBubbleTiming()
    if _G.cpxpBubbleTimer < 3 then
        _G.cpxpBubbleTimer = _G.cpxpBubbleTimer + 1
    end        
end

do_every_draw("cpxpMsg()")
do_often("cpxpBubbleTiming()")

-- Delay Init


function cpxpDelayInit()
    if not cpxpScriptReady then
        FF767.cpxpAircraftDelay()
       if cpxpStartTime == 0 then
          cpxpStartTime = (cpxp_SIM_TIME + _G.cpxpInitDelay)
          _G.cpxpBubbleTimer = 0 - _G.cpxpInitDelay
       end
       if (cpxp_SIM_TIME < cpxpStartTime) then
          print("CrewPackXP: Waiting to start " .. math.floor(cpxp_SIM_TIME) .. " waiting for " .. math.floor(cpxpStartTime))
          _G.cpxpMsgStr = "CrewPackXP loading in " .. math.floor(cpxpStartTime - cpxp_SIM_TIME) .. " seconds"
       end
       if cpxpLoadedAircraft == '757-200_xp11.acf' and not _G.cpxpReady then
          print("CPXP: Aircraft Module reporting not ready")
       elseif cpxpLoadedAircraft == '757-200_xp11.acf' and _G.cxpxReady then
          cpxpScriptReady = true
       end
    end
 end

do_often("cpxpDelayInit()")

-- Main Call

function cpxpMainCall()
    if cpxpLoadedAircraft == '757-200_xp11.acf' and cpxpScriptReady then
        FF767snd.cpxpStartSound()
        FF767.cpxpMonitorADC1()
        FF767.cpxpEngineStart()
    end
end

do_often("cpxpMainCall()")