--[[
    Crew Pack Script for Hot Start Challenger 650

    Voices by https://www.naturalreaders.com/


    Changelog:
    v0.1 - Initial Release
]]
if AIRCRAFT_FILENAME == "CL650.acf" then
    -- Initiialisation Variables
    local cpxpVersion = "HS650: 0.1"
    local cpxpInitDelay = 10
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
    local cpxpLeftStart = false
   local cpxpRightStart = false
   local cpxpPaTimer = 230
   local cpxpFaPlaySeq = 0

    local cpxpCrewPackXPSettings = {}
    local cpxpShowSettingsWindow = true
    local cpxpMaster = true
    local cpxpStartMsg = true
    local cpxpPaVol = 0.3
    local cpxpSoundVol = 1.0
    local cpxpEngStartType = 1

    -- Sounds
    local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_1.wav")
    local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_2.wav")
    local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_3.wav")
    local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_4.wav")
    local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/output.wav")
    local cpxpStartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartLeft.wav")
   local cpxpStartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartRight.wav")
   local cpxpStartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start1.wav")
   local cpxpStartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start2.wav")
   local cpxpFA_Welcome_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_welcome.wav")
   local cpxpCabinSecure_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_cabinSecure.wav")
   local cpxpSetThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_SetThrust.wav")
   local cpxpThrustSet_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_ThrustSet.wav")
   local cpxpEightyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_pf_80kts.wav")
   local cpxpV1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_V1.wav")
   local cpxpVR_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_VR.wav")
   local cpxpV2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_V2.wav")
   local cpxpPosRate_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_PosRate.wav")
   local cpxpClimbThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_pnf_ClimbThrust.wav")
   

    function cpxpSetGain()
        set_sound_gain(cpxpStart1, cpxpSoundVol)
        set_sound_gain(cpxpStart2, cpxpSoundVol)
        set_sound_gain(cpxpStart3, cpxpSoundVol)
        set_sound_gain(cpxpStart4, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft1_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight2_snd, cpxpSoundVol)
        set_sound_gain(cpxpFA_Welcome_snd, cpxpPaVol)
        set_sound_gain(cpxpCabinSecure_snd, cpxpSoundVol)
        set_sound_gain(cpxpSetThrust_snd, cpxpSoundVol)
        set_sound_gain(cpxpThrustSet_snd, cpxpSoundVol)
        set_sound_gain(cpxpEightyKts_snd, cpxpSoundVol)
        set_sound_gain(cpxpV1_snd, cpxpSoundVol)
        set_sound_gain(cpxpVR_snd, cpxpSoundVol)
        set_sound_gain(cpxpV2_snd, cpxpSoundVol)
        set_sound_gain(cpxpPosRate_snd, cpxpSoundVol)
        set_sound_gain(cpxpClimbThrust_snd, cpxpSoundVol)

    end

    -- Generic Datarefs
    dataref("cpxpASI", "sim/flightmodel/position/indicated_airspeed")
    dataref("cpxpLEFT_STARTER", "CL650/overhead/eng_start/start_L")
    dataref("cpxpRIGHT_STARTER", "CL650/overhead/eng_start/start_R")
    dataref("cpxpBEACON", "sim/cockpit2/switches/beacon_on")
    dataref("cpxpWEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
    dataref("cpxpENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
    dataref("cpxpENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
    dataref("cpxpENG1_N1", "sim/flightmodel2/engines/N1_percent", "readonly", 0)
    dataref("cpxpENG2_N1", "sim/flightmodel2/engines/N1_percent", "readonly", 1)
    dataref("cpxpIAS", "sim/flightmodel/position/indicated_airspeed")
    dataref("cpxpVSI", "sim/cockpit2/gauges/indicators/vvi_fpm_pilot")
    dataref("cpxpAGL", "sim/flightmodel/position/y_agl")
    

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
        -- Delay based on CL650 specific variables
        if (XPLMFindDataRef("CL650/xp_sys_bridge/efis/v1") ~= nil) then
            dataref("cpxpV1", "CL650/xp_sys_bridge/efis/v1")
        end
        if (XPLMFindDataRef("CL650/xp_sys_bridge/efis/vr") ~= nil) then
            dataref("cpxpVR", "CL650/xp_sys_bridge/efis/vr")
        end
        if (XPLMFindDataRef("CL650/xp_sys_bridge/efis/v2") ~= nil) then
            dataref("cpxpV2", "CL650/xp_sys_bridge/efis/v2")
        end
        if (XPLMFindDataRef("CL650/pedestal/flaps") ~= nil) then
            dataref("cpxpFLAP_LEVER", "CL650/pedestal/flaps")
        end
        if (XPLMFindDataRef("CL650/fo_state/flaps_ind") ~= nil) then
            dataref("cpxpFLAP_IND", "CL650/fo_state/flaps_ind")
        end
        if (XPLMFindDataRef("CL650/pedestal/gear/ldg_value") ~= nil) then
            dataref("cpxpGEAR_LEVER", "CL650/pedestal/gear/ldg_value")
        end
        if (XPLMFindDataRef("CL650/fo_state/gear_up_all") ~= nil) then
            dataref("cpxpGEAR_UPIND", "CL650/fo_state/gear_up_all")
        end
        if (XPLMFindDataRef("CL650/fo_state/gear_dn_all") ~= nil) then
            dataref("cpxpGEAR_DNIND", "CL650/fo_state/gear_dn_all")
        end

        if (XPLMFindDataRef("CL650/overhead/elec/batt_master") == nil) then
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

    -- Engine Start Calls

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
        if cpxpLEFT_STARTER == 0 then
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
        if cpxpRIGHT_STARTER == 0 then
            cpxpRightStart = false
        end
    end
    
    do_often("CPXPEngineStart()")
    
    function CPXPFlightAttendant()
        if not cpxpReady then
            return
        end
        if cpxpPaTimer < 241 then
            cpxpPaTimer = cpxpPaTimer + 1
            print("CrewPackXP: Cabin timer " .. cpxpPaTimer)
            print(math.floor(get("sim/flightmodel2/position/groundspeed")))
         end
        if cpxpFaOnboard then
            if cpxpBEACON == 1 and cpxpWEIGHT_ON_WHEELS == 1 and cpxpENG2_N2 > 30 and cpxpFaPlaySeq == 0 then
                cpxpPaTimer = 150
                play_sound(cpxpFA_Welcome_snd)
                cpxpFaPlaySeq = 2
                print("CrewPackXP: Playing FA welcome PA - Engine Start")
             end
             if cpxpBEACON == 1 and cpxpWEIGHT_ON_WHEELS == 1 and (math.floor(get("sim/flightmodel2/position/groundspeed"))) ~= 0 and cpxpFaPlaySeq == 0 then
                cpxpPaTimer = 150
                play_sound(cpxpFA_Welcome_snd)
                cpxpFaPlaySeq = 2
                print("CrewPackXP: Playing FA welcome PA, GS "..(math.floor(get("sim/flightmodel2/position/groundspeed"))))
             end

             if cpxpBEACON == 1 and cpxpWEIGHT_ON_WHEELS == 1 and cpxpFaPlaySeq == 2 and cpxpPaTimer == 241 then
                play_sound(cpxpCabinSecure_snd)
                print("CrewPackXP: Played Cabin Secure")
                cpxpFaPlaySeq = 3
             end
        end
    end

    do_often("CPXPFlightAttendant()")

    local cpxpCDU3Mode = ""
    local cpxpTORaw = ""
    local cpxpCLBRaw = ""
    local cpxpTON1 = ""
    local cpxpTOACT = ""
    local cpxpCLBN1 = ""
    local cpxpCLBACT = ""

    --[[function testreading()
        if not cpxpReady then
            return
        end
        cpxpCDU3Mode = tostring(get("CL650/CDU/3/screen/text_line0"))
        if cpxpCDU3Mode == "      THRUST LIMIT      " then
            print("Yeet we are in thrust")
            cpxpCLBRaw = tostring(get("CL650/CDU/3/screen/text_line4"))
            cpxpClbN1 = string.sub(cpxpCLBRaw, 1, 4)
            print("Climb Thrust is : " .. cpxpClbN1)
            cpxpClbInt = tonumber(cpxpClbN1) - 10
            print("Is it numerical? " .. cpxpClbInt)
            cpxpCLBRaw = tostring(get("CL650/CDU/3/screen/text_line4"))
            cpxpClbAct = string.sub(cpxpCLBRaw, 7, 9)
            print("Is Climb Mode Active? " .. cpxpClbAct)
        else
            print("Mode is wrong " .. cpxpCDU3Mode)
            set("CL650/CDU/3/perf_value" ,1)
            print("Attempting to change mode")
        end
        print("CDU 3 Reading: " .. tostring(get("CL650/CDU/3/screen/text_line0")))
        print("CDU3Var = " .. cpxpCDU3Mode)
    end

    do_sometimes ("testreading()")]]

    function CPXPThrustRef()
        -- Cant directly read the mode ooofty
        -- Routine Called as req
        if cpxpENG1_N2 >=  60 and cpxpENG2_N2 >= 60 then
            -- Check CDU 3 is showing thrust ref
            cpxpCDU3Mode = tostring(get("CL650/CDU/3/screen/text_line0"))
            if cpxpCDU3Mode == "      THRUST LIMIT      " then
                print("CDU3 Display Valid")
                cpxpTORaw = tostring(get("CL650/CDU/3/screen/text_line2"))
                cpxpCLBRaw = tostring(get("CL650/CDU/3/screen/text_line4"))
                -- Convert to useable
                cpxpTON1 = string.sub(cpxpTORaw, 1, 4)
                cpxpTOACT = string.sub(cpxpTORaw, 7, 9)
                cpxpCLBN1 = string.sub(cpxpCLBRaw, 1, 4)
                cpxpCLBACT = string.sub(cpxpCLBACT, 7, 9)
            else
                print("Mode is wrong " .. cpxpCDU3Mode)
                set("CL650/CDU/3/perf_value" ,1)
                print("Attempting to change mode")
            end
        end
    end

    local cpxpToEngRate = false
    

    function CPXPEngRateMonitor()
        if not cpxpReady then
            return
        end

        if not cpxpToEngRate and get("CL650/fo_state/ats_n1_to") == 1 then
            cpxpToEngRate = true
            print("CrewPackXP: TO Mode Detected")
        end
    end

    do_often("CPXPEngRateMonitor()")

    -- Takeoff Calls - Reset by master

    local cpxpToCalloutMode = false
    local cpxpCalloutTimer = 5
    local cpxpPlaySeq = 0
    local cpxpSixtyPlayed = true

    function CPXPTakeoffCalls()
        if not cpxpReady then
            return
        end

        -- TO Callout mode - Reset by climb thurst set call
        if cpxpToEngRate and cpxpWEIGHT_ON_WHEELS == 1 then
            cpxpToCalloutMode = true
            print("CrewPackXP: TO Callouts Armed")
        end

        -- TO Call Timer
        if cpxpCalloutTimer < 4 then
            cpxpCalloutTimer = (cpxpCalloutTimer + 1)
            print("CrewPackXP: Call Timer" .. cpxpCalloutTimer)
        end
        
        -- Set Thrust
        if cpxpToCalloutMode and cpxpENG1_N1 >= 60 and cpxpENG2_N1 >= 60 and cpxpPlaySeq == 0 then
            play_sound(cpxpSetThrust_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: TO Mode > 60 N1 Set Thrust")
            cpxpPlaySeq = 1
        end
        if cpxpToCalloutMode and cpxpPlaySeq == 1 then
            CPXPThrustRef()
            print("CrewPackXP: Looking for TO Thrust of " .. cpxpTON1)
            if cpxpTON1 ~= nil and cpxpCalloutTimer >= 2 then
                if cpxpENG1_N1 >= (cpxpTON1 * 0.95)  then
                play_sound(cpxpThrustSet_snd)
                cpxpCalloutTimer = 0
                print("CrewPackXP: TO Thrust Set")       
                cpxpPlaySeq = 2             
                end
            end
        end
        
        -- 80 Kts
        if cpxpToCalloutMode and cpxpPlaySeq == 2 and cpxpIAS > 78 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpEightyKts_snd)
            cpxpCalloutTimer = 0 
            cpxpSixtyPlayed = false
            cpxpPlaySeq = 3   
        end 

        -- V1
        if cpxpToCalloutMode and cpxpIAS > cpxpV1 - 3 and cpxpPlaySeq == 6 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpV1_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: V1 of " .. math.floor(cpxpV1) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 3
         end

         -- VR
        if cpxpToCalloutMode and cpxpIAS > cpxpVR - 3 and cpxpPlaySeq == 3 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpVR_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: VR of " .. math.floor(cpxpVR) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 4
        end

     -- V2
        if cpxpToCalloutMode and cpxpIAS > cpxpV2 - 3 and cpxpPlaySeq == 4 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpV2_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: V2 of " .. math.floor(cpxpVR) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 5
        end
    
        -- Pos Rate
        if cpxpToCalloutMode and cpxpWEIGHT_ON_WHEELS == 0 and cpxpVSI > 50 and cpxpPlaySeq == 5 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpPosRate_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: Positive Rate " .. math.floor(cpxpAGL) .. " AGL and " .. math.floor(cpxpVSI) .. " ft/min")
            cpxpPlaySeq = 6
         end

    end

    do_often("CPXPTakeoffCalls()")

    local cpxpInvalidVSpeed = false

    function CPXPTakeoffNoSpeeds()
        if not cpxpReady then
           return
        end
        if not cpxpInvalidVSpeed and cpxpToCalloutMode and cpxpIAS > 100 and cpxpV1 < 100 then
           print("CrewPackXP: V1 Speed invalid value " .. math.floor(cpxpV1))
           cpxpInvalidVSpeed = true
        end
        if not cpxpInvalidVSpeed and cpxpToCalloutMode and cpxpIAS > 100 and cpxpVR < 100 then
           print("CrewPackXP: VR Speed invalid value " .. math.floor(cpxpVR))
           cpxpInvalidVSpeed = true
        end
        if not cpxpInvalidVSpeed and cpxpToCalloutMode and cpxpIAS > 100 and cpxpV2 < 100 then
            print("CrewPackXP: V2 Speed invalid value " .. math.floor(cpxpVR))
            cpxpInvalidVSpeed = true
         end
     end
  
     do_often("CPXPTakeoffNoSpeeds()")

     local cpxpClimbThrustPressed = false
     -- Takeoff Climb Thrust - Reset by Master
     function CPXPClimbThrust()
        if not cpxpReady then
            return
        end

        CPXPThrustRef()
        if cpxpToCalloutMode and cpxpPlaySeq == 6 and (cpxpAGL / 0.3048) > 1100 and not cpxpClimbThrustPressed then
            if cpxpFLAP_IND == 0 and cpxpGEAR_UPIND == 1 and cpxpCalloutTimer >= 2 then
                if tostring(get("CL650/CDU/3/screen/text_line0")) == "      THRUST LIMIT      " and cpxpCLBACT ~= "ACT" then
                    set("CL650/CDU/3/lsk_l2_value", 1)
                    print("CrewPackXP Attempting to set climb thrust")
                elseif cpxpCLBACT == "ACT" then
                    play_sound(cpxpClimbThrust_snd)
                    cpxpCalloutTimer = 0
                    cpxpClimbThrustPressed = true
                    cpxpToCalloutMode = false
                    print("CrewPackXP: ClimbThrust at ".. math.floor(cpxpAGL / 0.3048))
                    print("CrewPackXP: TO Mode off")
                end
            end
        end
    end

    do_often("CPXPClimbThrust()")



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
        local changed, newVal = imgui.Checkbox("Crew Pack FA Onboard?", cpxpFaOnboard)
        if changed then
           cpxpFaOnboard = newVal
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

    
        --[[
  

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
            cpxpEngStartType = cpxpCrewPackXPSettings.CrewPackXP.cpxpEngStartType
            cpxpFaOnboard = cpxpCrewPackXPSettings.CrewPackXP.cpxpFaOnboard
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
                cpxpPaVol = cpxpPaVol,
                cpxpEngStartType = cpxpEngStartType,
                cpxpFaOnboard = cpxpFaOnboard,
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
    --]]
end -- Master end
