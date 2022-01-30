--[[
    Crew Pack Script for Hot Start Challenger 650

    Voices by https://www.naturalreaders.com/


    Changelog:
    v0.1 - Initial Release
]]
if AIRCRAFT_FILENAME == "CL650.acf" then
    -- Initiialisation Variables
    local cpxpVersion = "HS650: 0.1"
    local cpxpInitDelay = 20
    local cpxpStartTime = 0
    dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")

    -- dependencies
    local LIP = require("LIP")
    require "graphics"

    -- Var
    local cpxpBubbleTimer = 0
    local cpxpMsgStr = ""
    local cpxpReady = false
    local cpxpStartPlayed = false

    local cpxpCrewPackXPSettings = {}
    local cpxpShowSettingsWindow = true
    local cpxpMaster = true
    local cpxpStartMsg = false
    local cpxpPaVol = 0.3
    local cpxpSoundVol = 1.0

    -- Sounds
    local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_1.wav")
    local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_2.wav")
    local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_3.wav")
    local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_4.wav")
    local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/output.wav")

    function cpxpSetGain()
        set_sound_gain(cpxpStart1, cpxpSoundVol)
        set_sound_gain(cpxpStart2, cpxpSoundVol)
        set_sound_gain(cpxpStart3, cpxpSoundVol)
        set_sound_gain(cpxpStart4, cpxpSoundVol)
    end

    -- Generic Datarefs
    dataref("cpxpAGL", "sim/flightmodel/position/y_agl")
    dataref("cpxpFLAP_LEVER", "sim/flightmodel/controls/flaprqst", "writeable")
    dataref("cpxpGEAR_HANDLE", "1-sim/cockpit/switches/gear_handle")
    dataref("cpxpSPEED_BRAKE", "sim/cockpit2/controls/speedbrake_ratio")
    dataref("cpxpWEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
    dataref("cpxpPARK_BRAKE", "sim/cockpit2/controls/parking_brake_ratio")
    dataref("cpxpENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
    dataref("cpxpENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
    dataref("cpxpLOC_DEVIATION", "sim/cockpit/radios/nav2_hdef_dot")
    dataref("cpxpLOC_RECEIVED", "1-sim/radios/isReceivingIlsLoc1")
    dataref("cpxpGS_DEVIATION", "sim/cockpit/radios/nav2_vdef_dot")
    dataref("cpxpGS_RECEIVED", "1-sim/radios/isReceivingIlsGs1")
    --  dataref("cpxpSTROBE_SWITCH", "sim/cockpit2/switches/strobe_lights_on")
    dataref("cpxpENGINE_MODE", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
    --  dataref("cpxpMCP_SPEED", "sim/cockpit/autopilot/airspeed", "writeable")
    dataref("cpxpFLCH_BUTTON", "1-sim/AP/flchButton", "writeable")
    dataref("cpxpVNAV_ENGAGED_LT", "1-sim/AP/lamp/4")
    dataref("cpxpVNAV_BUTTON", "1-sim/AP/vnavButton", "writeable")
    dataref("cpxpLNAV_BUTTON", "1-sim/AP/lnavButton", "writeable")
    --  dataref("cpxpAUTO_BRAKE", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
    dataref("cpxpTOGA_BUTTON", "1-sim/AP/togaButton")
    dataref("cpxpBEACON", "sim/cockpit2/switches/beacon_on")
    dataref("cpxpLEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
    dataref("cpxpRIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)
    dataref("cpxpBELTS_SIGN", "sim/cockpit2/annunciators/fasten_seatbelt")

    print("CrewPackXP: Initialising cpxpVersion " .. cpxpVersion)
    print("CrewPackXP: Starting at sim time " .. math.floor(cpxp_SIM_TIME))

    -- Bubble for messages
    function CPXPDisplayMessage()
        bubble(20, get("sim/graphics/view/window_height") - 100, cpxpMsgStr)
    end

    function CPXPmsg()
        if cpxpBubbleTimer < 3 then
            CPXPDisplayMessage()
        else
            cpxpMsgStr = ""
        end
    end

    function CPXPBubbleTiming()
        if cpxpBubbleTimer < 3 then
            cpxpBubbleTimer = cpxpBubbleTimer + 1
        end
    end

    do_every_draw("CPXPmsg()")
    do_often("CPXPBubbleTiming()")

    --	Delaying initialisation of datarefs till aircraft loaded
    function CPXPDelayedInit()
        -- Dealy based on time

        if cpxpStartTime == 0 then
            cpxpStartTime = (cpxp_SIM_TIME + cpxpInitDelay)
            cpxpBubbleTimer = 0 - cpxpInitDelay
            ParseCrewPackXPSettings()
        end
        if (cpxp_SIM_TIME < cpxpStartTime) then
            print(
                "CrewPackXP: Init Delay " ..
                    math.floor(cpxp_SIM_TIME) .. " waiting for " .. math.floor(cpxpStartTime) .. " --"
            )
            cpxpMsgStr = "CrewPackXP Loading in " .. math.floor(cpxpStartTime - cpxp_SIM_TIME) .. " seconds"
            return
        end

        if not cpxpReady then
            print("CrewPackXP: Datarefs Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(cpxp_SIM_TIME))
            cpxpMsgStr = "CrewPackXP Initialised for " .. PLANE_ICAO
            cpxpBubbleTimer = 0
            cpxpReady = true
        end
    end -- End of DelayedInit

    do_often("CPXPDelayedInit()")

    -- Start Up Sounds
    function CPXPStartSound()
        if not cpxpReady then
            return
        end
        if cpxpStartMsg and not cpxpStartPlayed then
            local soundFile = {
                cpxpStart1,
                cpxpStart2,
                cpxpStart3,
                cpxpStart4
            }
            math.randomseed(os.time())
            play_sound(soundFile[math.random(1, 4)])
            cpxpStartPlayed = true
        end
    end

    do_often("CPXPStartSound()")

    -- Settings

    if not SUPPORTS_FLOATING_WINDOWS then
        -- to make sure the script doesn't stop old FlyWithLua versions
        print("imgui not supported by your FlyWithLua cpxpVersion, please update to latest cpxpVersion")
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
        local changed, newVal = imgui.Checkbox("Play corny sound bite on loading", cpxpStartMsg)
        if changed then
            cpxpStartMsg = newVal
            SaveCrewPackXPData()
            print("CrewPackXP: Start message logic set to " .. tostring(cpxpStartMsg))
        end

        --[[
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("Crew Pack FA Onboard?", cpxpFaOnboard)
    if changed then
       cpxpFaOnboard = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: Start message logic set to " .. tostring(cpxpStartMsg))
    end

    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("Play Localiser and Glideslop calls", cpxpLocgsCalls)
    if changed then
       cpxpLocgsCalls = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: LOC / GS Call logic set to " .. tostring(syncAlt))
    end
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("FO Performs Preflight Scan Flow", cpxpFoPreflight)
    if changed then
       cpxpFoPreflight = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: FO PreScan logic set to " .. tostring(cpxpFoPreflight))
    end
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("Supress default flight attendant from pestering", cpxpDefaultFA)
    if changed then
       cpxpDefaultFA = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: Default FA logic set to " .. tostring(cpxpFoPreflight))
    end
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("FO automation on go around", cpxpGaAutomation)
    if changed then
       cpxpGaAutomation = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: Go Around automation logic set to " .. tostring(cpxpGaAutomation))
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
    end --]]
        imgui.TextUnformatted("")
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal = imgui.SliderFloat("Crew Volume", (cpxpSoundVol * 100), 1, 100, "%.0f")
        if changed then
            cpxpSoundVol = (newVal / 100)
            set_sound_gain(Output_snd, cpxpSoundVol)
            play_sound(Output_snd)
            SaveCrewPackXPData()
            print("767CrewPacks: Volume set to " .. (cpxpSoundVol * 100) .. " %")
        end
        imgui.TextUnformatted("")
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal1 = imgui.SliderFloat("PA Volume", (cpxpPaVol * 100), 1, 100, "%.0f")
        if changed then
            cpxpPaVol = (newVal1 / 100)
            set_sound_gain(Output_snd, cpxpPaVol)
            play_sound(Output_snd)
            SaveCrewPackXPData()
            print("767CrewPacks: Volume set to " .. (cpxpPaVol * 100) .. " %")
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
        if not cpxpShowSettingsWindow then
            ShowCrewPackXPSettings_wnd()
            cpxpShowSettingsWindow = true
        elseif cpxpShowSettingsWindow then
            CloseCrewPackXPSettings_wnd()
            cpxpShowSettingsWindow = false
        end
    end

    function ParseCrewPackXPSettings()
        local f = io.open(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini", "r")
        if f ~= nil then
            io.close(f)
            cpxpCrewPackXPSettings = LIP.load(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini")
            cpxpMaster = cpxpCrewPackXPSettings.CrewPackXP.cpxpMaster
            cpxpStartMsg = cpxpCrewPackXPSettings.CrewPackXP.cpxpStartMsg
            cpxpSoundVol = cpxpCrewPackXPSettings.CrewPackXP.cpxpSoundVol
            cpxpPaVol = cpxpCrewPackXPSettings.CrewPackXP.cpxpPaVol
            print("CrewPackXP: Settings Loaded")
            cpxpSetGain()
        else
            print("CPXP: No settings file found, using defaults")
        end
    end

    function SaveCrewPack767Settings(cpxpCrewPackXPSettings)
        LIP.save(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini", cpxpCrewPackXPSettings)
    end

    function SaveCrewPackXPData()
        cpxpCrewPackXPSettings = {
            CrewPackXP = {
                cpxpStartMsg = cpxpStartMsg,
                cpxpMaster = cpxpMaster,
                cpxpSoundVol = cpxpSoundVol,
                cpxpPaVol = cpxpPaVol
            }
        }
        print("CrewPackXP: Settings Saved")
        cpxpBubbleTimer = 0
        cpxpMsgStr = "CrewPackXP settings saved"
        cpxpSetGain()
        SaveCrewPack767Settings(cpxpCrewPackXPSettings)
    end

    add_macro("CrewPackXP Settings", "ShowCrewPackXPSettings_wnd()", "CloseCrewPackXPSettings_wnd()", "deactivate")
    create_command(
        "FlyWithLua/CrewPackXP/toggle_settings",
        "Toggle CrewPackXP Settings",
        "ToggleCrewPackXPSettings()",
        "",
        ""
    )
end
