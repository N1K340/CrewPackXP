--[[
CrewPackXP Configuration File for Flight Factor 757/767

changelog:
v0.1 - Initial Release
]]

module(..., package.seeall)

--Initial Variables
local cpxpModuleVersion = "FF767 CFG - v0.1"

-- Dependencies
local LIP = require("LIP")
local FF767snd = require("CrewPackXP/FF767_SND_CrewPackXP")

if not SUPPORTS_FLOATING_WINDOWS then
    -- to make sure the script doesn't stop old FlyWithLua versions
    print("imgui not supported by your FlyWithLua version, please update to latest version")
    return
end

-- Global Var

cpxpGseOnBeacon = true
cpxpGAAuto = true
cpxpStartCall = true
cpxpLocGs = true
cpxpSoundVol = 0.5
cpxpPaVol = 0.5
cpxpMaster = false
cpxpGpuConnect = true
cpxpApuConnect = true
cpxpMurderFA = true
cpxpFA = true
cpxpEngStartType = 2

-- Local Var

local cpxpShowSettingsWindow = false

print("CrewPackXP: Loading module " .. cpxpModuleVersion)

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
    if not CPXPshowSettingsWindow then
        ShowCrewPackXPSettings_wnd()
        CPXPshowSettingsWindow = true
    else
        CloseCrewPackXPSettings_wnd()
        CPXPshowSettingsWindow = false
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
        FF767snd.cpxpSetGain()
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
    FF767snd.cpxpSetGain()
    SaveCrewPackXPSettings(CrewPackXPSettings)
end

--[[add_macro("767 Crew Pack Settings", "ShowCrewPackXPSettings_wnd()", "CloseCrewPackXPSettings_wnd()", "deactivate")
create_command(
    "FlyWithLua/CrewPackXP/toggle_settings",
    "toggle CrewPackXP Settings",
    "ToggleCrewPackXPSettings()",
    "",
    ""
)
]]