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
local FF767init = require("CrewPackXP/FF767init_CrewPackXP")
local FF767 = require("CrewPackXP/FF767_CrewPackXP")

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
            if not FF767init.cpxpAircraftDelay() then
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

-- Settings
    -- Settings

    local CrewPackXPSettings = {}
    local cpxpGseOnBeacon = true
    local cpxpGAAuto = true
    local cpxpStartCall = true
    local cpxpLocGs = true
          cpxpSoundVol = 0.8
          cpxpPaVol = 0.5
    local cpxpMaster = true
    local cpxpApuConnect = true
    local cpxpGpuConnect = true
    local cpxpMurderFA = true
    local cpxpFA = true
         cpxpEngStartType = 2

    if not SUPPORTS_FLOATING_WINDOWS then
        -- to make sure the script doesn't stop old FlyWithLua versions
        print("imgui not supported by your FlyWithLua version, please update to latest version")
    end

    -- Create Settings window
    function ShowCrewPackXPSettings_wnd()
        ParseCrewPackXPSettings()
        CrewPackXPSettings_wnd = float_wnd_create(450, 450, 0, true)
        float_wnd_set_title(CrewPackXPSettings_wnd, "CrewPackXP Settings")
        float_wnd_set_imgui_builder(CrewPackXPSettings_wnd, "CrewPackXPSettings_contents")
        float_wnd_set_onclose(CrewPackXPSettings_wnd, "CloseCrewPackXPSettings_wnd")
    end

    function CrewPackXPSettings_contents(CrewPackXPSettings_wnd, x, y)
        local winWidth = imgui.GetWindowWidth()
        local winHeight = imgui.GetWindowHeight()
        local titleText = "CrewPackXP Settings"
        local titleTextWidth, titileTextHeight = imgui.CalcTextSize(titleText)

        imgui.SetCursorPos(winWidth / 2 - titleTextWidth / 2, imgui.GetCursorPosY())
        imgui.TextUnformatted(titleText)

        imgui.Separator()
        imgui.TextUnformatted("")
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("CrewPackXP on/off", cpxpMaster)
        if changed then
            cpxpMaster = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Plugin turned on" .. tostring(cpxpMaster))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Crew Pack FA Onboard?", cpxpFA)
        if changed then
            cpxpFA = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Start message logic set to " .. tostring(cpxpStartCall))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Play corny sound bite on loading", cpxpStartCall)
        if changed then
            cpxpStartCall = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Start message logic set to " .. tostring(cpxpStartCall))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
		local changed, newVal = imgui.Checkbox("Play Localiser and Glideslop calls", cpxpLocGs)
        if changed then
            cpxpLocGs = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: LOC / GS Call logic set to " .. tostring(syncAlt))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Supress default flight attendant from pestering", cpxpMurderFA)
        if changed then
            cpxpMurderFA = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Default FA logic set to " .. tostring(cpxpFoPreflight))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("FO automation on go around", cpxpGAAuto)
        if changed then
            cpxpGAAuto = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Go Around automation logic set to " .. tostring(cpxpGAAuto))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Chocks, Doors and belt loaders tied to Beacon on/off", cpxpGseOnBeacon)
        if changed then
            cpxpGseOnBeacon = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: GSE on beacon set to " .. tostring(cpxpGseOnBeacon))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        if imgui.BeginCombo("Engine Start Call", "", imgui.constant.ComboFlags.NoPreview) then
            if imgui.Selectable("Left / Right", cpxpEngStartType == 1) then
                cpxpEngStartType = 1
                SaveCrewPackXPData()
                print("CrewPackXP: Engine start call set to Left / Right")
            end
            if imgui.Selectable("Engine 1 / 2", cpxpEngStartType == 2) then
                cpxpEngStartType = 2
                SaveCrewPackXPData()
                print("CrewPackXP: Engine start call set to 1 / 2")
            end
            imgui.EndCombo()
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Auto sync Cpt and FO Altimiters", syncAlt)
        if changed then
            syncAlt = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Altimiter Sync logic set to " .. tostring(syncAlt))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        imgui.TextUnformatted("Auto power connections: ") 
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("GPU on bay", cpxpGpuConnect)
        if changed then
            cpxpGpuConnect = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: GPU Power on ground")
        end
        imgui.SameLine()
        local changed, newVal = imgui.Checkbox("APU smart start", cpxpApuConnect)
        if changed then
            cpxpApuConnect = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: APU started on ground")
        end     
        imgui.TextUnformatted("")   
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal = imgui.SliderFloat("Crew Volume", (cpxpSoundVol * 100), 1, 100, "%.0f")
        if changed then
            cpxpSoundVol = (newVal / 100)
            -- play_sound(Output_snd)
            SaveCrewPackXPData()
            print("CrewPackXPs: Volume set to " .. (cpxpSoundVol * 100) .. " %")
        end
        imgui.TextUnformatted("")   
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal1 = imgui.SliderFloat("PA Volume", (cpxpPaVol * 100), 1, 100, "%.0f")
        if changed then
            cpxpPaVol = (newVal1 / 100)
            -- play_sound(Output_snd)
            SaveCrewPackXPData()
            print("CrewPackXPs: Volume set to " .. (cpxpPaVol * 100) .. " %")
        end
        imgui.Separator()
        imgui.TextUnformatted("")
        imgui.SetCursorPos(200, imgui.GetCursorPosY())
        if imgui.Button("CLOSE") then
            CloseCrewPackXPSettings_wnd()
        end
    end

    function CloseCrewPackXPSettings_wnd()
        if CrewPackXPSettings_wnd then
            float_wnd_destroy(CrewPackXPSettings_wnd)
        end
    end

    function ToggleCrewPackXPSettings()
        if not showSettingsWindow then
            ShowCrewPackXPSettings_wnd()
            showSettingsWindow = true
        elseif showSettingsWindow then
            CloseCrewPackXPSettings_wnd()
            showSettingsWindow = false
        end
    end

    function ParseCrewPackXPSettings()
        local f = io.open(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini","r")
        if f ~= nil then
            io.close(f)
            CrewPackXPSettings = LIP.load(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini")
            cpxpFoPreflight = CrewPackXPSettings.CrewPackXP.cpxpFoPreflight
            cpxpGseOnBeacon = CrewPackXPSettings.CrewPackXP.cpxpGseOnBeacon
            cpxpGAAuto = CrewPackXPSettings.CrewPackXP.cpxpGAAuto
            cpxpStartCall = CrewPackXPSettings.CrewPackXP.cpxpStartCall
            cpxpLocGs = CrewPackXPSettings.CrewPackXP.cpxpLocGs
            cpxpSoundVol = CrewPackXPSettings.CrewPackXP.cpxpSoundVol
            cpxpPaVol = CrewPackXPSettings.CrewPackXP.cpxpPaVol
            cpxpMaster = CrewPackXPSettings.CrewPackXP.cpxpMaster
            cpxpApuConnect = CrewPackXPSettings.CrewPackXP.cpxpApuConnect
            cpxpGpuConnect = CrewPackXPSettings.CrewPackXP.cpxpGpuConnect
            cpxpMurderFA = CrewPackXPSettings.CrewPackXP.cpxpMurderFA
            cpxpFA = CrewPackXPSettings.CrewPackXP.cpxpFA
            cpxpEngStartType = CrewPackXPSettings.CrewPackXP.cpxpEngStartType
            print("CrewPackXP: Settings Loaded")
            FF767.cpxpSetGain()
        end
    end

    function SaveCrewPackXPSettings(CrewPackXPSettings)
        LIP.save(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini", CrewPackXPSettings)
    end

    function SaveCrewPackXPData()
        CrewPackXPSettings = {
            CrewPackXP = {
                cpxpFoPreflight = cpxpFoPreflight,
                cpxpGseOnBeacon = cpxpGseOnBeacon,
                cpxpGAAuto = cpxpGAAuto,
                cpxpStartCall = cpxpStartCall,
                cpxpLocGs = cpxpLocGs,
                cpxpSoundVol = cpxpSoundVol,
                cpxpMaster = cpxpMaster,
                cpxpGpuConnect = cpxpGpuConnect,
                cpxpApuConnect = cpxpApuConnect,
                cpxpMurderFA = cpxpMurderFA,
                cpxpFA = cpxpFA,
                cpxpPaVol = cpxpPaVol,
                cpxpEngStartType = cpxpEngStartType,
            }
        }
        print("CrewPackXP: Settings Saved")
        bubbleTimer = 0
        msgStr = "CrewPackXP settings saved"
        FF767.cpxpSetGain()
        SaveCrewPackXPSettings(CrewPackXPSettings)
    end

    add_macro("767 Crew Pack Settings", "ShowCrewPackXPSettings_wnd()", "CloseCrewPackXPSettings_wnd()", "deactivate")
    create_command(
        "FlyWithLua/CrewPackXP/toggle_settings",
        "toggle CrewPackXP Settings",
        "ToggleCrewPackXPSettings()",
        "",
        ""
    )

-- Main Call

function cpxpMainCall()
    if PLANE_ICAO == "B752" and cpxp_Ready then
        FF767.cpxpAircraftDatRef()
        FF767.cpxpStartSound()
        FF767.cpxpMonitorADC1()
        FF767.cpxpEngineStart()
    end
end

do_often("cpxpMainCall()")