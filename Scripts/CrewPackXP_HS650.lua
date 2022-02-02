--[[
    Crew Pack Script for Hot Start Challenger 650

    Voices by https://www.naturalreaders.com/
    Captain - Will
    FO - Rodney

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
    local cpxpFLCH = true
    local cpxpLocgsCalls = true

    -- Sounds
    local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_1.wav")
    local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_2.wav")
    local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_3.wav")
    local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_4.wav")
    local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/output.wav")
    local cpxpStartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_StartLeft.wav")
   local cpxpStartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_StartRight.wav")
   local cpxpStartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Start1.wav")
   local cpxpStartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Start2.wav")
   local cpxpSetThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_SetThrust.wav")
   local cpxpThrustSet_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_ThrustSet.wav")
   local cpxpEightyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_80kts.wav")
   local cpxpV1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_V1.wav")
   local cpxpVR_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_VR.wav")
   local cpxpV2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_V2.wav")
   local cpxpPosRate_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_PosRate.wav")
   local cpxpClimbThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_pnf_ClimbThrust.wav")
   local cpxpGearUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_GearUp.wav")
   local cpxpGearIsUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_GearUp.wav")
   local cpxpGearDn_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_GearDn.wav")
   local cpxpGearIsDn_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_GearDn.wav")
   local cpxpFlap0_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Flap0.wav")
   local cpxpFlap20_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Flap20.wav")
   local cpxpFlap30_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Flap30.wav")
   local cpxpFlap45_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pf_Flap45.wav")
   local cpxpFlapIs0_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_Flap0.wav")
   local cpxpFlapIs20_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_Flap20.wav")
   local cpxpFlapIs30_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_Flap30.wav")
   local cpxpFlapIs45_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_Flap45.wav")
   local cpxpGScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_GS.wav")
   local cpxpLOCcap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_LOC.wav")
   local cpxpLOCGScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_LOCandGS.wav")
   local cpxpAltAlert_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/pnf_60kts.wav")
   local cpxpFLCH_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/SpeedMode.wav")
   local cpxpAutopilot_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/Autopilot.wav")

    function cpxpSetGain()
        set_sound_gain(cpxpStart1, cpxpSoundVol)
        set_sound_gain(cpxpStart2, cpxpSoundVol)
        set_sound_gain(cpxpStart3, cpxpSoundVol)
        set_sound_gain(cpxpStart4, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartLeft1_snd, cpxpSoundVol)
        set_sound_gain(cpxpStartRight2_snd, cpxpSoundVol)
        set_sound_gain(cpxpSetThrust_snd, cpxpSoundVol)
        set_sound_gain(cpxpThrustSet_snd, cpxpSoundVol)
        set_sound_gain(cpxpEightyKts_snd, cpxpSoundVol)
        set_sound_gain(cpxpV1_snd, cpxpSoundVol)
        set_sound_gain(cpxpVR_snd, cpxpSoundVol)
        set_sound_gain(cpxpV2_snd, cpxpSoundVol)
        set_sound_gain(cpxpPosRate_snd, cpxpSoundVol)
        set_sound_gain(cpxpClimbThrust_snd, cpxpSoundVol)
        set_sound_gain(cpxpGearUp_snd, cpxpSoundVol)
        set_sound_gain(cpxpGearIsUp_snd, cpxpSoundVol)
        set_sound_gain(cpxpGearDn_snd, cpxpSoundVol)
        set_sound_gain(cpxpGearIsDn_snd, cpxpSoundVol)
        set_sound_gain(cpxpFlap0_snd, cpxpSoundVol)
        set_sound_gain(cpxpFlap20_snd, cpxpSoundVol)
        set_sound_gain(cpxpFlap30_snd, cpxpSoundVol)
        set_sound_gain(cpxpGScap_snd, cpxpSoundVol)
        set_sound_gain(cpxpLOCcap_snd, cpxpSoundVol)
        set_sound_gain(cpxpLOCGScap_snd, cpxpSoundVol)
        set_sound_gain(cpxpAltAlert_snd, cpxpSoundVol)
        set_sound_gain(cpxpFLCH_snd, cpxpSoundVol)
        set_sound_gain(cpxpAutopilot_snd, cpxpSoundVol)
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
            set("CL650/CDU/3/idx", 1)
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
                if cpxpTORaw ~= nil then
                    cpxpTON1 = string.sub(cpxpTORaw, 1, 4)
                    cpxpTOACT = string.sub(cpxpTORaw, 7, 9)
                else
                    cpxpTON1 = 85
                    print("CrewPackXP: TO N1 not found, using 85")
                end
                if cpxpCLBRaw ~= nil then
                    cpxpCLBN1 = string.sub(cpxpCLBRaw, 1, 4)
                    cpxpCLBACT = string.sub(cpxpCLBRaw, 7, 9)
                else
                    cpxpCLBN1 = 85
                    print("CrewPackXP: CLB N1 not found, using 85")    
                end
                
            else
                print("CrewPackXP: CDU3 Mode is wrong " .. cpxpCDU3Mode)
                set("CL650/CDU/3/perf_value" ,1)
                print("CrewPackXP: Attempting to change mode")
                cpxpTON1 = 85
                print("CrewPackXP: TO N1 not found, substituting 85%")
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

    -- Takeoff Calls

    local cpxpToCalloutMode = false
    local cpxpCalloutTimer = 5
    local cpxpPlaySeq = 0
    local cpxpSixtyPlayed = true
    local cpxpClimbThrustPressed = false
    local cpxpV1 = 0
    local cpxpVR = 0
    local cpxpV2 = 0
    local cpxpFLCHPress = false
    local cpxpFLCHPlay = false

    function CPXPTakeoffTrigger()
    -- TO Callout mode - Reset by climb thurst set call
        if cpxpToEngRate and cpxpWEIGHT_ON_WHEELS == 1 then
            cpxpToCalloutMode = true
            print("CrewPackXP: TO Callouts Armed")
        end

    end

    do_often("CPXPTakeoffTrigger()")

    function CPXPTakeoffCalls()
        if not cpxpReady then
            return
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
            CPXPThrustRef()
        end
        if cpxpToCalloutMode and cpxpPlaySeq == 1 then
            CPXPThrustRef()
            if cpxpTON1 ~= nil and cpxpCalloutTimer >= 2 then
                if cpxpENG1_N1 >= (cpxpTON1 * 0.95)  then
                play_sound(cpxpThrustSet_snd)
                cpxpCalloutTimer = 0
                print("CrewPackXP: Looking for TO Thrust of " .. cpxpTON1)
                print("CrewPackXP: TO Thrust Set")       
                cpxpPlaySeq = 2             
                end
            elseif cpxpTON1 == nil then
                cpxpPlaySeq = 2
                print("CrewPackXP: TO Thrust Skiped")
            end
        end
        
        -- 80 Kts
        if cpxpToCalloutMode and cpxpPlaySeq == 2 and cpxpIAS > 78 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpEightyKts_snd)
            cpxpCalloutTimer = 0 
            cpxpSixtyPlayed = false
            cpxpPlaySeq = 3   
        end 

        -- Obtain EFIS VSpeeds
        if get("CL650/xp_sys_bridge/efis/v1") > 0 and cpxpV1 ~= get("CL650/xp_sys_bridge/efis/v1") then
            cpxpV1 = get("CL650/xp_sys_bridge/efis/v1")
        end

        if get("CL650/xp_sys_bridge/efis/vr") > 0 and cpxpVR ~= get("CL650/xp_sys_bridge/efis/vr") then
            cpxpVR = get("CL650/xp_sys_bridge/efis/vr")
        end

        if get("CL650/xp_sys_bridge/efis/v2") > 0 and cpxpV2 ~= get("CL650/xp_sys_bridge/efis/v2") then
            cpxpV2 = get("CL650/xp_sys_bridge/efis/v2")
        end

        -- V1
        if cpxpToCalloutMode and cpxpV1 ~= 0 and cpxpIAS > (cpxpV1 - 3) and cpxpPlaySeq == 3 and cpxpCalloutTimer >= 1 then
            play_sound(cpxpV1_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: V1 of " .. math.floor(cpxpV1) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 4
        elseif cpxpToCalloutMode and cpxpV1 == 0 and cpxpPlaySeq == 3 then
            cpxpPlaySeq = 4
            print("CrewPackXP: V1 Speed not valid")
        end

         -- VR
        if cpxpToCalloutMode and cpxpVR ~= 0 and cpxpIAS > (cpxpVR - 3) and cpxpPlaySeq == 4 and cpxpCalloutTimer >= 1 then
            play_sound(cpxpVR_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: VR of " .. math.floor(cpxpVR) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 5
        elseif cpxpToCalloutMode and cpxpVR == 0 and cpxpPlaySeq == 4 then
            cpxpPlaySeq = 5
            print("CrewPackXP: VR Speed not valid")
        end

     -- V2
        if cpxpToCalloutMode and cpxpV2 ~= 0 and cpxpIAS > (cpxpV2 - 3) and cpxpPlaySeq == 5 and cpxpCalloutTimer >= 1 then
            play_sound(cpxpV2_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: V2 of " .. math.floor(cpxpVR) .. " Played at " .. math.floor(cpxpIAS) .. " kts")
            cpxpPlaySeq = 6
        elseif cpxpToCalloutMode and cpxpV2 == 0 and cpxpPlaySeq == 5 then
            cpxpPlaySeq = 6
            print("CrewPackXP: V2 Speed not valid")
        end
    
        -- Pos Rate
        if cpxpToCalloutMode and cpxpWEIGHT_ON_WHEELS == 0 and cpxpVSI > 50 and cpxpAGL > 328 and cpxpPlaySeq == 6 and cpxpCalloutTimer >= 2 then
            play_sound(cpxpPosRate_snd)
            cpxpCalloutTimer = 0
            print("CrewPackXP: Positive Rate " .. math.floor(cpxpAGL) .. " AGL and " .. math.floor(cpxpVSI) .. " ft/min")
            cpxpPlaySeq = 7
         end

         -- FLCH

         if cpxpFLCH and cpxpToCalloutMode and cpxpVSI > 50 and cpxpAGL > 1312 and cpxpPlaySeq == 7 and not cpxpFLCHPress then
            set("CL650/FCP/flc_mode", 1)
            cpxpFLCHPress = true
            print("CrewPackXP: Pressing FLCH")
         end

         if cpxpFLCH and cpxpPlaySeq == 7 and cpxpFLCHPress and not cpxpFLCHPlay and cpxpCalloutTimer >= 2 then
            if get("CL650/lamps/glareshield/FCP/flc_1") == 1 then
                play_sound(cpxpFLCH_snd)
                cpxpFLCHPlay = true
                cpxpCalloutTimer = 0
                print("CrewPackXP: FLCH Engaged")
            else
                cpxpFLCHPlay = true
                print("CrewPackXP: Appears FLCH Failed")
            end
         end

         -- Climb Thrust Workaround
         if cpxpToCalloutMode and cpxpPlaySeq == 7 and (cpxpAGL / 0.3048) > 1100 and not cpxpClimbThrustPressed then
            if cpxpFLAP_IND == 0 and cpxpGEAR_UPIND == 1 and cpxpCalloutTimer >= 2 then
                if tostring(get("CL650/CDU/3/screen/text_line0")) == "      THRUST LIMIT      " and cpxpCLBACT ~= "ACT" then
                    set("CL650/CDU/3/lsk_l2_value", 1)
                    print("CrewPackXP Attempting to set climb thrust")
                    CPXPThrustRef()
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


    do_every_frame("CPXPTakeoffCalls()")

    --Autopilot on
    local cpxpAPmode = 0
    local cpxpAPPlay = false

    function CPXPAutoPilot()
        if not cpxpReady then
            return
        end

        if get("CL650/lamps/glareshield/FCP/ap_eng_1") ~= cpxpAPmode then
            if get("CL650/lamps/glareshield/FCP/ap_eng_1") == 1 and not cpxpAPPlay then
                play_sound(cpxpAutopilot_snd)
                print("CrewPackXP: AP On")
                cpxpAPmode = 1
                cpxpAPPlay = true
            elseif get("CL650/lamps/glareshield/FCP/ap_eng_1") == 0 and cpxpAPmode == 1 then
                cpxpAPmode = 0
                cpxpAPPlay = false
            end
        end     
    end
    
    do_often("CPXPAutoPilot()")

    -- Gear Selection
    local cpxpGearUpSelectedPlay = false
    local cpxpGearUpIndPlay = true
    local cpxpGearDnSelectedPlay = true
    local cpxpGearDnIndPlay = true

    function CPXPGearSelection()
        if not cpxpReady then
            return
        end
        if cpxpAGL > 15 and cpxpGEAR_LEVER == 1 and cpxpCalloutTimer >= 2 and not cpxpGearUpSelectedPlay then
            play_sound(cpxpGearUp_snd)
            cpxpCalloutTimer = 0
            cpxpGearUpSelectedPlay = true
            cpxpGearUpIndPlay = false
            cpxpGearDnSelectedPlay = false
          --  cpxpFlightOccoured = true
          --  cpxpApuStart = false
          --  cpxpSpdBrkNotPlayed = false
          -- cpxpSpdBrkPlayed = false
          --  cpxpSixtyPlayed = false
          --  cpxpHorsePlayed = false
          --  cpxpTodPaPlayed = false
          --  cpxpSeatsLandingPlayed = false
          --  cpxpPaxSeatBeltsPlayed = false
          --  set("1-sim/lights/landingN/switch", 0)
            print("CrewPackXP: Gear Up Selected")
        end
        if cpxpAGL > 15 and cpxpGEAR_LEVER == 1 and cpxpGEAR_UPIND == 1 and cpxpCalloutTimer >= 2 and not cpxpGearUpIndPlay then
            play_sound(cpxpGearIsUp_snd)
            cpxpCalloutTimer = 0
            cpxpGearUpIndPlay = true
            print("CrewPackXP: Gear Up Indicated")
        end

        -- Gear Down
        if cpxpAGL > 15 and cpxpGEAR_LEVER == 0 and cpxpCalloutTimer >= 2 and not cpxpGearDnSelectedPlay then
            play_sound(cpxpGearDn_snd)
            cpxpCalloutTimer = 0
            cpxpGearUpSelectedPlay = false
            cpxpGearDnSelectedPlay = true
            cpxpGearDnIndPlay = false
            cpxpPosRatePlayed = false
           -- cpxpTogaEvent = false
           -- cpxpTogaMsg = false
           -- set("1-sim/lights/landingN/switch", 1)
            print("CrewPackXP: Gear Down")
        end
        if cpxpAGL > 15 and cpxpGEAR_LEVER == 0 and cpxpGEAR_DNIND == 1 and cpxpCalloutTimer >= 2 and not cpxpGearDnIndPlay then
            play_sound(cpxpGearIsDn_snd)
            cpxpCalloutTimer = 0
            cpxpGearDnIndPlay = true
            print("CrewPackXP: Gear Down Indicated")
        end
    end

    do_often("CPXPGearSelection()")


    -- Flaps Callouts in air only

    local cpxpFlapPos = 0
    local cpxpFlapTime = 3
    local cpxpFlapInd = 0
    local cpxpFlapIndTime = 3
    local cpxpFlap0IndPlay = false
    local cpxpFlap20IndPlay = false

   function CPXPFlapsSelection()
    if not cpxpReady then
       return
    end

    if cpxpFlapPos == 0 and cpxpFlapTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
       play_sound(cpxpFlap0_snd)
       print("CrewPackXP: Flaps 0 Selected for 1 Seconds -- ")
    end
    if cpxpFLAP_IND == 0 and cpxpFlapIndTime == 1 and not cpxpFlap0IndPlay and cpxpWEIGHT_ON_WHEELS == 0 then
        play_sound(cpxpFlapIs0_snd)
        print("CrewPackXP: Flaps 0 Indicated")    
        cpxpFlap0IndPlay = true
    end 

    if cpxpFlapPos == 1 and cpxpFlapTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
        play_sound(cpxpFlap20_snd)
        print("CrewPackXP: Flaps 20 Selected for 1 Seconds -- ")
     end
     if cpxpFLAP_IND == 20 and cpxpFlapIndTime == 1 and not cpxpFlap20IndPlay and cpxpWEIGHT_ON_WHEELS == 0 then
         play_sound(cpxpFlapIs20_snd)
         print("CrewPackXP: Flaps 20 Indicated")    
         cpxpFlap20IndPlay = true
     end

     if cpxpFlapPos == 2 and cpxpFlapTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
        play_sound(cpxpFlap30_snd)
        print("CrewPackXP: Flaps 30 Selected for 1 Seconds -- ")
     end
     if cpxpFLAP_IND == 30 and cpxpFlapIndTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
         play_sound(cpxpFlapIs30_snd)
         print("CrewPackXP: Flaps 30 Indicated")    
     end 

     if cpxpFlapPos == 3 and cpxpFlapTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
        play_sound(cpxpFlap45_snd)
        print("CrewPackXP: Flaps 45 Selected for 1 Seconds -- ")
     end
     if cpxpFLAP_IND == 45 and cpxpFlapIndTime == 1 and cpxpWEIGHT_ON_WHEELS == 0 then
         play_sound(cpxpFlapIs45_snd)
         print("CrewPackXP: Flaps 45 Indicated")    
     end 
    
 end

 do_often("CPXPFlapsSelection()")

 --Monitor Flap Movement
 function CPXPFlapPosCheck()
    if not cpxpReady then
       return
    end
    if cpxpFlapPos ~= cpxpFLAP_LEVER then
       cpxpFlapTime = 0
       cpxpFlapPos = cpxpFLAP_LEVER
       cpxpFlap0IndPlay = false
       cpxpFlap20IndPlay = false
       print("CrewPackXP: Flaps Moved to " .. cpxpFlapPos)
    else
       if cpxpFlapTime <= 1 then
          cpxpFlapTime = cpxpFlapTime + 1
          print("CrewPackXP: cpxpFlapTime = " .. cpxpFlapTime)
       end
    end
    if cpxpFlapInd ~= cpxpFLAP_IND then
        cpxpFlapIndTime = 0
        cpxpFlapInd = cpxpFLAP_IND
        print("CrewPackXP: Flaps Set to " .. cpxpFlapPos)
     else
        if cpxpFlapIndTime <= 1 then
           cpxpFlapIndTime = cpxpFlapIndTime + 1
           print("CrewPackXP: cpxpFlapTime = " .. cpxpFlapIndTime)
        end
     end
 end -- End FlapPosCheck

 do_often("CPXPFlapPosCheck()")


-- 1000 to go call
    local cpxpAltAlert = 0
    local cpxpAltAlertPlay = false

    function CPXPAltAlert()
        if get("CL650/snd/reu/alt_alert", 0) ~= cpxpAltAlert then
            if get("CL650/snd/reu/alt_alert", 0) == 1 and not cpxpAltAlertPlay then
                play_sound(cpxpAltAlert_snd)
                print("1000 to go")
                cpxpAltAlert = 1
                cpxpAltAlertPlay = true
            elseif get("CL650/snd/reu/alt_alert", 0) == 0 and cpxpAltAlert == 1 then
                cpxpAltAlert = 0
                cpxpAltAlertPlay = false
            end
        end       
    end

    do_often("CPXPAltAlert()")

    -- Localiser / GlideSlope
    
    local cpxpLocPlayed = true
    local cpxpGsPlayed = true

   dataref("cpxpLOC_DEVIATION", "sim/cockpit/radios/nav1_hdef_dot")
   dataref("cpxpLOC_RECEIVED", "libradio/nav1/have_loc_signal")
   dataref("cpxpGS_DEVIATION", "sim/cockpit/radios/nav1_vdef_dot")
   dataref("cpxpGS_RECEIVED", "libradio/nav1/have_gp_signal")

   function CPXPLocGsAlive()
    if not cpxpReady then
       return
    end
    -- Loc Capture Right of localiser (CDI Left) Reset by: Full scale LOC deflection
    if cpxpLocgsCalls then
       if  cpxpWEIGHT_ON_WHEELS == 0 and cpxpLOC_RECEIVED == 1 and cpxpLOC_DEVIATION > -1.95 and cpxpLOC_DEVIATION <= 0 and not cpxpLocPlayed and not cpxpToCalloutMode then
          if cpxpGS_RECEIVED == 1 and cpxpGS_DEVIATION > -1.95 and cpxpGS_DEVIATION < 1  then
             play_sound(cpxpLOCGScap_snd)
             print("CrewPackXP: LOC and GS Active")
             cpxpCalloutTimer = 0
             cpxpLocPlayed = true
             cpxpGsPlayed = true
          else
             play_sound(cpxpLOCcap_snd)
             print("CrewPackXP: LOC Active")
             cpxpCalloutTimer = 0
             cpxpLocPlayed = true
          end
       end

       if cpxpLOC_DEVIATION <= -2.5 and cpxpLocPlayed then
          print("CrewPackXP: Reset Loc Active Logic")
          print("CrewPackXP: Reset GS Alive Logic")
          cpxpLocPlayed = false
          cpxpGsPlayed = false
       end
       -- Loc Capture Left of localiser (CDI Right)
       if cpxpWEIGHT_ON_WHEELS == 0 and cpxpLOC_RECEIVED == 1 and cpxpLOC_DEVIATION < 1.95 and cpxpLOC_DEVIATION >= 0 and not cpxpLocPlayed and not cpxpToCalloutMode then
          if cpxpGS_RECEIVED == 1 and cpxpGS_DEVIATION > -1.95 and cpxpGS_DEVIATION < 1  then
             play_sound(cpxpLOCGScap_snd)
             print("CrewPackXP: LOC and GS Active")
             cpxpCalloutTimer = 0
             cpxpLocPlayed = true
             cpxpGsPlayed = true
          else
             play_sound(cpxpLOCcap_snd)
             print("CrewPackXP: LOC Active")
             cpxpCalloutTimer = 0
             cpxpLocPlayed = true
          end
       end

       if cpxpLOC_DEVIATION >= 2.5 and cpxpLocPlayed then
          cpxpLocPlayed = false
          cpxpGsPlayed = false
          print("CrewPackXP: Reset Loc Active Logic")
          print("CrewPackXP: Reset GS Alive Logic")
       end
       -- GS
       if
       cpxpWEIGHT_ON_WHEELS == 0 and  cpxpGS_RECEIVED == 1 and cpxpGS_DEVIATION > -1.95 and cpxpGS_DEVIATION < 1 and cpxpLocPlayed and not cpxpGsPlayed and cpxpCalloutTimer >= 2 and not cpxpToCalloutMode then
          play_sound(cpxpGScap_snd)
          print("CrewPackXP: GS Alive")
          cpxpGsPlayed = true
       end
    end
 end

 do_often("CPXPLocGsAlive()")




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
        if imgui.Selectable("1 / 2", cpxpEngStartType == 2) then
            cpxpEngStartType = 2
            SaveCrewPackXPData()
            print("CrewPackXP: Engine start call set to 1 / 2")
        end
       imgui.EndCombo()
    end
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("Play Localiser and Glideslop calls", cpxpLocgsCalls)
    if changed then
       cpxpLocgsCalls = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: LOC / GS Call logic set to " .. tostring(syncAlt))
    end
    imgui.SetCursorPos(20, imgui.GetCursorPosY())
    local changed, newVal = imgui.Checkbox("Automate FLCH at 400ft on TO", cpxpFLCH)
    if changed then
       cpxpFLCH = newVal
       SaveCrewPackXPData()
       print("CrewPackXP: FLCH press at 400ft set to " .. tostring(syncAlt))
    end
    
        --[[
  
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Crew Pack FA Onboard?", cpxpFaOnboard)
        if changed then
           cpxpFaOnboard = newVal
           SaveCrewPackXPData()
           print("CrewPackXP: Start message logic set to " .. tostring(cpxpStartMsg))
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
            cpxpFLCH = cpxpCrewPackXPSettings.CrewPackXP.cpxpFLCH
            cpxpLocgsCalls = cpxpCrewPackXPSettings.CrewPackXP.cpxpLocgsCalls
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
                cpxpFLCH = cpxpFLCH,
                cpxpLocgsCalls = cpxpLocgsCalls,
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
