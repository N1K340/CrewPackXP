--[[
Crew Pack Script for Leading Edge Sim Saab 340A

Voices by https://www.naturalreaders.com/
Captn: Guy
FO: Ranald
Ground Crew: en-AU-B-Male (what a name...)
Safety: Leslie
Fun fact for those that read comments:
I have 1,800hrs on the Saab, about half on the A.
They are tanks, such a solid plane.

Changelog:
V0.1 - Initial release
--]]

if AIRCRAFT_FILENAME == "LES_Saab_340A_Cargo.acf" or AIRCRAFT_FILENAME == "LES_Saab_340A.acf" then

    -- Initialisation Variables
    local version = "LES340: 0.1"
    local initDelay = 5
    local cpxpStartTime = 0
    dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")

    -- dependencies
    local LIP = require("LIP")
    require "graphics"

    -- Saved Vars
    local cpxpMaster = true
    local cpxpStartMsg = true
    local cpxpEngStartType = 1
    local cpxpPaVol = 0.3
    local cpxpSoundVol = 0.7

    -- Sound Files
    local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_1.wav")
    local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_2.wav")
    local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_3.wav")
    local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_4.wav")
    local cpxpEightyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_pf_80kts.wav")
    local cpxpStartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/LES340/pf_StartLft.wav")
    local cpxpStartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/LES340/pf_StartRt.wav")
    local cpxpStartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/LES340/pf_Start1.wav")
    local cpxpStartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/LES340/pf_Start2.wav")
    local cpxpStartCutOut_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/LES340/StartCutOut.wav")
    local cpxpOutput_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/output.wav")
    local cpxpOutputPA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/output.wav")

    function cpxpSetGain()
        set_sound_gain(cpxpStart1, cpxpSoundVol)
        set_sound_gain(cpxpStart2, cpxpSoundVol)
        set_sound_gain(cpxpStart3, cpxpSoundVol)
        set_sound_gain(cpxpStart4, cpxpSoundVol)
        set_sound_gain(cpxpEightyKts_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft1_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight2_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartCutOut_snd, cpxpSoundVol)
        set_sound_gain(cpxpOutput_snd, cpxpSoundVol)
        set_sound_gain(cpxpOutputPA_snd, cpxpSoundVol)
    end

    -- Generic Dataref
    dataref("cpxpLEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
    dataref("cpxpRIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)

    -- Message Functions
    print("CrewPackXP: Initialising version " .. version)
    print("CrewPackXP: Starting at sim time " .. math.floor(cpxp_SIM_TIME))

    -- Bubble for messages
    local cpxpMsgStr = nil
    local cpxpBubbleTimer = 0

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

    -- Delaying Initialisation till aircraft loads
    local cpxpStartTime = 0
    local cpxpInitDelay = 10
    local cpxpReady = false

    function CPXPDelayedInit()
        if cpxpStartTime == 0 then
            cpxpStartTime = (cpxp_SIM_TIME + cpxpInitDelay)
            cpxpBubbleTimer = 0 - cpxpInitDelay
            ParseCrewPackXPSettings()
         end
         if (cpxp_SIM_TIME < cpxpStartTime) then
            print(
            "CrewPackXP: Init Delay " .. math.floor(cpxp_SIM_TIME) .. " waiting for " .. math.floor(cpxpStartTime) .. " --"
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
    end

    do_often("CPXPDelayedInit()")

    -- Test Commands
    local cpxpCargoDoor = false
    local cpxpMainDoor = false
    local cpxpMainHandle = false
    local cpxpFASeat = false
    local cpxpStairSlide = false
    local cpxpStairFold = false


    function CPXPDoors()

      if cpxpReady then
         if get("LES/saab/GS/wheel_chock_nose") == 0 then
            set("LES/saab/GS/wheel_chock_nose" , 1)
         end
      end
  
      --cargo door  
      if cpxpReady and not cpxpCargoDoor then
          if get("les/sf34a/acft/emrg/anm/cargo_door_handle") == 1 then
              command_once("les/sf34a/acft/emrg/mnp/cargo_door_handle")
          end
          if get("les/sf34a/acft/emrg/anm/cargo_door_handle") == 0 then
            command_once("les/sf34a/acft/emrg/mnp/cargo_door")
            cpxpCargoDoor = true
          end
      end
  
      -- Main Door
      if cpxpReady then
          if not cpxpMainHandle then
               if get("les/sf34a/acft/emrg/anm/main_door_handle") == 1 then
                  command_once("les/sf34a/acft/emrg/mnp/main_door_handle")
               elseif get("les/sf34a/acft/emrg/anm/main_door_handle") == 0 then
                  cpxpMainHandle = true
               end
          end
          if not cpxpMainDoor and cpxpMainHandle then
              if get("les/sf34a/acft/emrg/anm/main_door") == 1 then
                  command_once("les/sf34a/acft/emrg/mnp/main_door")
              elseif get("les/sf34a/acft/emrg/anm/main_door") == 0 then
              cpxpMainDoor = true
              end
          end
          if not cpxpFASeat and not cpxpStairSlide then
               if get("les/sf34a/acft/gnrl/anm/cabin_attendant_seat") == 0 then
                  command_once("les/sf34a/acft/gnrl/mnp/cabin_attendant_seat")
               elseif get("les/sf34a/acft/gnrl/anm/cabin_attendant_seat") == 1 then
                  cpxpFASeat = true
               end
          end
          if cpxpFASeat and not cpxpStairSlide then
            if get("les/sf34a/acft/emrg/anm/cabin_stair_slide") == 0 then
               command_once("les/sf34a/acft/emrg/mnp/cabin_stair_slide_button")
            elseif get("les/sf34a/acft/emrg/anm/cabin_stair_slide") == 1 then
               cpxpStairSlide = true
            end
          end
          if cpxpFASeat and cpxpStairSlide then
            if get("les/sf34a/acft/emrg/anm/cabin_stair_fold") == 0 then
              command_once("les/sf34a/acft/emrg/mnp/cabin_stair_fold_button")
            elseif get("les/sf34a/acft/emrg/anm/cabin_stair_fold") == 1 then
              cpxpStairFold = true
            end
          end
          if cpxpStairFold and cpxpFASeat then
              command_once("les/sf34a/acft/gnrl/mnp/cabin_attendant_seat")
              cpxpFASeat = false
          end
      end
   end

  do_often("CPXPDoors()")

    -- Start Up Sounds
    local cpxpStartPlayed = false

   function CPXPStartSound()
    if not cpxpReady then
       return
    end
    if cpxpStartMsg and not cpxpStartPlayed then
       local soundFile = {
          cpxpStart1,
          cpxpStart2,
          cpxpStart3,
          cpxpStart4,
       }
       math.randomseed(os.time())
       play_sound(soundFile[math.random(1,4)])
       cpxpStartPlayed = true
       print("Playing Startup")
        end
    end

    do_often("CPXPStartSound()")


    -- Engine Start Calls
    local cpxpLeftStart = false
    local cpxpRightStart = false

    function CPXPEngineStart()
        if not cpxpReady then
            return
        end
        if cpxpLEFT_STARTER == 1 and not cpxpLeftStart then
            print("CrewPackXP: Start Left Engine")
            if cpxpEngStartType == 1 then
                play_sound(cpxpStartLeft_snd)
            else
                play_sound(cpxpStartLeft1_snd)
            end
            cpxpLeftStart = true
        end
        if cpxpLEFT_STARTER == 0 and cpxpLeftStart then
            play_sound(cpxpStartCutOut_snd)
            cpxpLeftStart = false
        end
        if cpxpRIGHT_STARTER == 1 and not cpxpRightStart then
            print("CrewPackXP: Start Right Engine")
            if cpxpEngStartType == 1 then
                play_sound(cpxpStartRight_snd)
            else
                play_sound(cpxpStartRight2_snd)
            end
            cpxpRightStart = true
        end
        if cpxpRIGHT_STARTER == 0  and cpxpRightStart then
            play_sound(cpxpStartCutOut_snd)
            cpxpRightStart = false
        end
    end

    do_often("CPXPEngineStart()")

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
        --[[imgui.SetCursorPos(20, imgui.GetCursorPosY())
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
        end]]
        imgui.TextUnformatted("")
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal = imgui.SliderFloat("Crew Volume", (cpxpSoundVol * 100), 1, 100, "%.0f")
        if changed then
           cpxpSoundVol = (newVal / 100)
           set_sound_gain(cpxpOutput_snd, cpxpSoundVol)
           play_sound(cpxpOutput_snd)
           SaveCrewPackXPData()
           print("CrewPackXP: Volume set to " .. (cpxpSoundVol * 100) .. " %")
        end
        imgui.TextUnformatted("")
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal1 = imgui.SliderFloat("PA Volume", (cpxpPaVol * 100), 1, 100, "%.0f")
        if changed then
           cpxpPaVol = (newVal1 / 100)
           set_sound_gain(cpxpOutputPA_snd, cpxpPaVol)
           play_sound(cpxpOutputPA_snd)
           SaveCrewPackXPData()
           print("CrewPackXP: Volume set to " .. (cpxpPaVol * 100) .. " %")
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
        local f = io.open(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini","r")
        if f ~= nil then
           io.close(f)
           cpxpCrewPackXPSettings = LIP.load(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini")
           cpxpMaster = cpxpCrewPackXPSettings.CrewPackLES340.cpxpMaster
           cpxpStartMsg = cpxpCrewPackXPSettings.CrewPackLES340.cpxpStartMsg
           cpxpPaVol = cpxpCrewPackXPSettings.CrewPackLES340.cpxpPaVol
           cpxpSoundVol = cpxpCrewPackXPSettings.CrewPackLES340.cpxpSoundVol
           cpxpEngStartType = cpxpCrewPackXPSettings.CrewPackLES340.cpxpEngStartType
           print("CrewPackXP: Settings Loaded")
           cpxpSetGain()
        else
           print("CPXP: No settings file found, using defaults")
        end
     end
  
     function SaveCrewPackXPData()
        cpxpCrewPackXPSettings = {
           CrewPackLES340 = {
                cpxpMaster = cpxpMaster,
              cpxpStartMsg = cpxpStartMsg,
              cpxpPaVol = cpxpPaVol,
              cpxpSoundVol = cpxpSoundVol,
              cpxpEngStartType = cpxpEngStartType,
           }
        }
        print("CrewPackXP: Settings Saved")
        cpxpBubbleTimer = 0
        cpxpMsgStr = "CrewPackXP settings saved"
        cpxpSetGain()
        SaveCrewPack767Settings(cpxpCrewPackXPSettings)
     end

     function SaveCrewPack767Settings(cpxpCrewPackXPSettings)
        LIP.save(AIRCRAFT_PATH .. "/CrewPackXPSettings.ini", cpxpCrewPackXPSettings)
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