--[[
	Crew Pack Script for Flight Factor B757 / B767
	
	Voices by https://www.naturalreaders.com/
	Captn: Ronald
	FO: Guy
    Ground Crew: en-AU-B-Male (what a name...)
	
	Changelog:
	V0.1 - Initial Test Beta
    V0.2 - Variable name corrections
--]]


if PLANE_ICAO == "B752" or PLANE_ICAO == "B753" or PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
    -- Initialisation Variables
    local version = "0.2-beta"
    local initDelay = 15
    local startTime = 0
    dataref("SIM_TIME", "sim/time/total_running_time_sec")

    -- Local Variables

    local ready = false
    local startPlayed = false
    local playSeq = 0
    local posRatePlayed = false
    local gearUpPlayed = false
    local flapPos = 0.000000
    local flapTime = 3
    local gearDownPlayed = true
    local spdBrkPlayed = false
    local spdBrkNotPlayed = false
    local sixtyPlayed = true
    local gndTime = 0
    local horsePlayed = false
    local locPlayed = false
    local gsPlayed = false
    local cockpitSetup = false
    local flightOccoured = false
    local gaPlayed = false
    local togaMsg = false
    local vnavPlayed = true
    local vnavPressed = true
    local flaps20Retracted = true
    local toEngRate = false
	local togaEvent = false
    local togaState = nil
    local toCalloutMode = false
    local calloutTimer = 4
    local invalidVSpeed = false
    local clbThrustPlayed = false
    local flchPressed = true
    local gaVnavPressed = true
    local lnavPressed = true
    

    -- Sound Files
    local EightyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_pf_80kts.wav")
    local V1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_V1.wav")
    local VR_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_VR.wav")
    local PosRate_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_PosRate.wav")
    local GearUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_GearUp.wav")
    local GearDwn_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_GearDn.wav")
    local Flap0_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap0.wav")
    local Flap1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap1.wav")
    local Flap5_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap5.wav")
    local Flap15_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap15.wav")
    local Flap20_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap20.wav")
    local Flap25_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap25.wav")
    local Flap30_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Flap30.wav")
    local SpdBrkUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_SpdBrkUp.wav")
    local SpdBrkNot_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_SpdBrkNot.wav")
    local SixtyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_60kts.wav")
    local GScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_GS.wav")
    local LOCcap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_LOC.wav")
    local Horse_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/gnd_horse.wav")
    local Start757_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_start_757.wav")
    local Start767_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_start_767.wav")
    local ClbThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_ClbThr.wav")
    local VNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_VNAV.wav")

    -- Generic Datarefs
    dataref("AGL", "sim/flightmodel/position/y_agl")
    dataref("FLAP_LEVER", "sim/flightmodel/controls/flaprqst", "writeable")
    dataref("GEAR_HANDLE", "1-sim/cockpit/switches/gear_handle")
    dataref("SPEED_BRAKE", "sim/cockpit2/controls/speedbrake_ratio")
    dataref("WEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
    dataref("PARK_BRAKE", "sim/cockpit2/controls/parking_brake_ratio")
    dataref("ENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
    dataref("ENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
    dataref("LOC_DEVIATION", "sim/cockpit/radios/nav2_hdef_dot")
    dataref("LOC_RECEIVED", "1-sim/radios/isReceivingIlsLoc1")
    dataref("GS_DEVIATION", "sim/cockpit/radios/nav2_vdef_dot")
    dataref("GS_RECEIVED", "1-sim/radios/isReceivingIlsGs1")
    dataref("STROBE_SWITCH", "sim/cockpit2/switches/strobe_lights_on")
    dataref("ENGINE_MODE", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
    dataref("MCP_SPEED", "sim/cockpit/autopilot/airspeed", "writeable")
    dataref("FLCH_BUTTON", "1-sim/AP/flchButton", "writeable")
    dataref("VNAV_ENGAGED_LT", "1-sim/AP/lamp/4")
    dataref("VNAV_BUTTON", "1-sim/AP/vnavButton", "writeable")
    dataref("LNAV_BUTTON", "1-sim/AP/lnavButton", "writeable")
    dataref("AUTO_BRAKE", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
    dataref("TOGA_BUTTON", "1-sim/AP/togaButton")

    print("767Callouts: Initialising version " .. version)
    print("767Callouts: Starting at sim time " .. math.floor(SIM_TIME))

--	Delaying initialisation of datarefs till aircraft loaded
    function DelayedInit()
        -- Dealy based on time

        if startTime == 0 then
            startTime = (SIM_TIME + initDelay)
        end
        if (SIM_TIME < startTime) then
            print("767Callouts: Init Delay " .. math.floor(SIM_TIME) .. " waiting for " .. math.floor(startTime) .. " --")
            return
        end
            -- Delay based on 757 specific variables
            if (XPLMFindDataRef("757Avionics/adc1/outIas") ~= nil) then
                dataref("IAS", "757Avionics/adc1/outIas")
            end
            if (XPLMFindDataRef("757Avionics/fms/v1") ~= nil) then
                dataref("V1", "757Avionics/fms/v1")
            end
            if (XPLMFindDataRef("757Avionics/fms/vr") ~= nil) then
                dataref("VR", "757Avionics/fms/vr")
            end
            if (XPLMFindDataRef("757Avionics/adc1/outVs") ~= nil) then
                dataref("VSI", "757Avionics/adc1/outVs")
            end
            if (XPLMFindDataRef("757Avionics/fms/accel_height") ~= nil) then
                dataref("FMS_ACCEL_HT", "757Avionics/fms/accel_height")
            end
            if (XPLMFindDataRef("757Avionics/adc1/adc_fail") ~= nil) then
                dataref("ADC1", "757Avionics/adc1/adc_fail")
            end
            if (XPLMFindDataRef("757Avionics/fms/vref30") ~= nil) then
                dataref("VREF_30", "757Avionics/fms/vref30")
            end
            if (XPLMFindDataRef("757Avionics/options/ND/advEfisPanel") ~= nil) then
                dataref("EFIS_TYPE", "757Avionics/options/ND/advEfisPanel")
            end
            if (XPLMFindDataRef("anim/armCapt/1") == nil) then
               return
            end
            
            if not ready then
                print("767Callouts: Datarefs Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(SIM_TIME))
                ready = true
            end
    end -- End of DelayedInit

     do_often("DelayedInit()")

-- Start Up Sounds
    function StartSound()
        if not ready then
           return
        end
        if startPlayed == false then
            if PLANE_ICAO == "B752" or PLANE_ICAO == "B753" then
                play_sound(Start757_snd)
                print("767Callouts: Script ready at time " .. math.floor(SIM_TIME))
                startPlayed = true
            end
            if PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
                play_sound(Start767_snd)
                print("767Callouts: Script ready at time " .. math.floor(SIM_TIME))
                startPlayed = true
            end
        end
    end

    do_often("StartSound()")

-- Monitor for ADC1 Failure
   function MonitorADC1()
        if not ready then
            return
        end
        if ADC1 == 1 then
            print("767Callouts: ADC1 Failure, callouts degraded")
        end
    end -- End of MonitorADC1

    do_often("MonitorADC1()")

-- Cockpit Setup
    function CockpitSetup()
        if not ready then
            return
        end
        if not cockpitSetup then
            set("anim/armCapt/1", 2)
            set("anim/armFO/1", 2)
            if EFIS_TYPE == 1 then
                set("1-sim/ndpanel/1/hsiModeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeRotary", 1)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/2/hsiModeRotary", 2)
                set("1-sim/ndpanel/2/hsiRangeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
            end
            if EFIS_TYPE == 0 then
                set("1-sim/ndpanel/1/hsiModeRotary", 4)
                set("1-sim/ndpanel/1/hsiRangeRotary", 1)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/2/hsiModeRotary", 4)
                set("1-sim/ndpanel/2/hsiRangeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
            end
            set("anim/43/button", 1)
            set("sim/cockpit2/controls/elevator_trim", 0.046353)
            set("1-sim/ndpanel/1/dhRotary", 0.00)
            set("1-sim/ndpanel/2/dhRotary", 0.00)
            cockpitSetup = true
            print("767Callouts: Attempting to setup cockpit")
        end
    end -- End of CockpitSetup

    do_often("CockpitSetup()")

-- Engine Rate Monitor
    --TOGA 6 | TO 1, 11, 12 |
    function EngRateMonitor()
        if not ready then
            return
        end
        if ENGINE_MODE == 6 and not togaMsg then
           -- GAEngRate = true
			print("767Callouts: GA Mode Armed")
            togaMsg = true
        end
        if not toEngRate  and ENGINE_MODE == 1 then
            toEngRate = true
            print("767Callouts: TO Mode detected")
        end
        if not toEngRate  and ENGINE_MODE == 11 then
            toEngRate = true
            print("767Callouts: TO-1 Mode detected")
        end
        if not toEngRate  and ENGINE_MODE == 12 then
            toEngRate = true
            print("767Callouts: TO-2 Mode detected")
        end
    end

    do_every_frame("EngRateMonitor()")


-- Takeoff Calls
    function TakeoffCalls()
        if not ready then
            return
        end

        -- TO Callout Mode (Reset by: VNAV call at accel
        if toEngRate and WEIGHT_ON_WHEELS == 1 then
            toCalloutMode = true
        end

        -- TO Call Times
        if calloutTimer < 3 then
            calloutTimer = (calloutTimer + 1)
            print("767Callouts: Call Timer" .. calloutTimer)
        end

        -- 80 Kts
        if toCalloutMode and IAS > 78 and playSeq == 0 then
            play_sound(EightyKts_snd)
            calloutTimer = 0
            print("767Callouts: 80 Kts Played at " .. math.floor(IAS).. " kts")
            -- Confirm XPDR TA/RA and Brakes RTO
            set("anim/rhotery/35", 5)
            set("1-sim/gauges/autoBrakeModeSwitcher", -1)
			playSeq = 1
        end

        -- V1
        if toCalloutMode and IAS > V1 - 3 and playSeq == 1 and calloutTimer >= 2 then
            play_sound(V1_snd)
            calloutTimer = 0
            print("767Callouts: V1 of " .. math.floor(V1) .. " Played at " .. math.floor(IAS) .. " kts")
			playSeq = 2
        end

        -- VR
        if toCalloutMode and IAS > VR - 3 and playSeq == 2 and calloutTimer >= 2 then
            play_sound(VR_snd)
            calloutTimer = 0
            print("767Callouts: VR of " .. math.floor(VR) .. " Played at " .. math.floor(IAS) .. " kts")
			playSeq = 3
        end

        -- Positive Rate
        if toCalloutMode and AGL > 15 and VSI > 10 and playSeq == 3 and calloutTimer >= 2 then
            play_sound(PosRate_snd)
            calloutTimer = 0
            print("767Callouts: Positive Rate " .. math.floor(AGL) .. " AGL and " .. math.floor(VSI) .. " ft/min")
			playSeq = 4
        end
    end

    do_often("TakeoffCalls()")

-- TakeoffNoSpeeds
    function TakeoffNoSpeeds()
        if not ready then
            return
        end
        if not invalidVSpeed and toCalloutMode and IAS > 100 and V1 < 100 then
            print("767Callouts: V1 Speed invalid value " .. math.floor(V1))
            invalidVSpeed = true
        end
        if not invalidVSpeed and toCalloutMode and IAS > 100 and VR < 100 then
            print("767Callouts: VR Speed invalid value " .. math.floor(VR))
            invalidVSpeed = true
        end
    end

    do_often("TakeoffNoSpeeds()")

-- Takeoff VNAV Call
    function TakeoffVNAV()
        if not ready then
            return
        end
        if toCalloutMode and (AGL / 0.3048) > FMS_ACCEL_HT + 50 and not vnavPlayed and VNAV_ENGAGED_LT == 0 then
            print(ENGINE_MODE .. " " .. VNAV)
            if VNAV_BUTTON == 0 and not vnavPressed then
                set("1-sim/AP/vnavButton", 1)
                print("767Callouts: VNAV pressed")
                vnavPressed = true
            end
            if VNAV_BUTTON == 1 and not vnavPressed then
                set("1-sim/AP/vnavButton", 0)
                print("767Callouts: VNAV pressed")
                vnavPressed = true
            end
        end
        if not vnavPlayed and VNAV_ENGAGED_LT > 0 then
            play_sound(VNAV_snd)
            calloutTimer = 0
            vnavPlayed = true
            toCalloutMode = false
            print("767Callouts: VNAV at " .. FMS_ACCEL_HT .. " accel height")
            print("767Callouts: TO Mode off")
        end
    end

    do_often("TakeoffVNAV()")

-- Gear Selection
    function GearSelection()
        if not ready then
            return
        end
        if AGL > 15 and GEAR_HANDLE == 0 and calloutTimer >= 2 and not gearUpPlayed then
            play_sound(GearUp_snd)
            calloutTimer = 0
            gearUpPlayed = true
            gearDownPlayed = false
            flightOccoured = true
            set("1-sim/lights/landingN/switch", 0)
            print("767Callouts: Gear Up")
        end
        -- Gear Down
        if AGL > 15 and GEAR_HANDLE == 1 and calloutTimer >= 2 and not gearDownPlayed then
            play_sound(GearDwn_snd)
            calloutTimer = 0
            gearUpPlayed = false
            gearDownPlayed = true
            posRatePlayed = false
            togaEvent = false
            togaMsg = false
            spdBrkPlayed = false
            SixtyPlayed = false
            HorsePlay = false
            set("1-sim/lights/landingN/switch", 1)
            print("767Callouts: Gear Down")
        end
    end

    do_often("GearSelection()")
    
-- Flaps Selection
   
    -- Flaps Callouts
    function FlapsSelection()
        if not ready then
            return
        end
        if flapPos == 0 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap0_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 0 position for 1 Seconds -- ")
        end
        if flapPos > 0 and flapPos < 0.2 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap1_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 1 position for 1 Seconds -- ")
        end
        if flapPos > 0.3 and flapPos < 0.4 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap5_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 5 position for 1 Seconds -- ")
        end
        if flapPos == 0.5 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap15_snd)
            calloutTimer = 0
            print("767Callouts: 15 position for 1 Seconds -- ")
        end
        if flapPos > 0.6 and flapPos < 0.7 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap20_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 20 position for 1 Seconds -- ")
        end
        if flapPos > 0.8 and flapPos < 0.9 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap25_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 25 position for 1 Seconds -- ")
        end
        if flapPos == 1 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap30_snd)
            calloutTimer = 0
            print("767Callouts: Flaps 30 position for 1 Seconds -- ")
        end
    end

    do_often("FlapsSelection()")

    --Monitor Flap Movement
    function FlapPosCheck()
        if not ready then
            return
        end
        if flapPos ~= FLAP_LEVER then
            flapTime = 0
            flapPos = FLAP_LEVER
            print("767Callouts: FlapPos = " .. flapPos)
            print("767Callouts: FLAP_LEVER = " .. FLAP_LEVER)
            print("767Callouts: Flaps Moved to " .. flapPos .. " --")
        else
            if flapTime <= 1 then
                flapTime = flapTime + 1
                print("767Callouts: FlapTime = " .. flapTime)
            end
        end
    end -- End FlapPosCheck

    do_often("FlapPosCheck()")

-- Localiser / GlideSlope
    function LocGsAlive()
        if not ready then
            return
        end
        -- Loc Capture Right of localiser (CDI Left)
        if LOC_RECEIVED == 1 and LOC_DEVIATION < -1.95 and LOC_DEVIATION >= 0 and not locPlayed and not togaEvent and not toCalloutMode then
            play_sound(LOCcap_snd)
            locPlayed = true
            calloutTimer = 0
            print("767Callouts: LOC Active")
        end
        if LOC_DEVIATION <= -2.5 and locPlayed then
            locPlayed = false
            gsPlayed = false
            print("767Callouts: Reset Loc Active Logic")
            print("767Callouts: Reset GS Alive Logic")
        end
        -- Loc Capture Left of localiser (CDI Right)
        if LOC_RECEIVED == 1 and LOC_DEVIATION < 1.95 and LOC_DEVIATION >= 0 and not locPlayed  and not togaEvent then
            play_sound(LOCcap_snd)
            locPlayed = true
            calloutTimer = 0
            print("767Callouts: LOC Active")
        end
        if LOC_DEVIATION >= 2.5 and locPlayed then
            locPlayed = false
            gsPlayed = false
            print("767Callouts: Reset Loc Active Logic")
            print("767Callouts: Reset GS Alive Logic")
        end
        -- GS
        if GS_RECEIVED == 1 and GS_DEVIATION > -1.95 and GS_DEVIATION < 1 and locPlayed and not gsPlayed and calloutTimer >= 2  and not togaEvent and not toCalloutMode then
            play_sound(GScap_snd)
            gsPlayed = true
            print("767Callouts: GS Alive")
        end
    end

    do_often("LocGsAlive()")

-- Landing Roll / Speedbrakes (Requires Gear Up, Ground Reset)
    function Landing()
        if not ready then
            return
        end
        if WEIGHT_ON_WHEELS == 1 and flightOccoured then
            if SPEED_BRAKE == 1  and not spdBrkPlayed then
                play_sound(SpdBrkUp_snd)
                spdBrkPlayed = true
                print("767Callouts: Speed Brake On Landing")
            end
            if SPEED_BRAKE ~= 1 and gndTime == 5 and not spdBrkPlayed and not spdBrkNotPlayed then
                play_sound(SpdBrkNot_snd)
                spdBrkNotPlayed = true
                print("767Callouts: Speed Brake Not Up On Landing")
            end
        end
        if WEIGHT_ON_WHEELS == 1 and flightOccoured and not sixtyPlayed and IAS <= 62 then
            play_sound(SixtyKts_snd)
            sixtyPlayed = true
            print("767Callouts: 60kts on landing played at " .. math.floor(IAS))
        end
    end

    do_often("Landing()")

    function OnGrndCheck()
        if not ready then
            return
        end
        if WEIGHT_ON_WHEELS == 0 then
            gndTime = 0
        else
            if gndTime <= 5 then
                gndTime = gndTime + 1
            end
            if gndTime == 5 then
                print("767Callouts: Sustained Weight on wheels for " .. gndTime .. " seconds")
            end
        end
    end -- End of OnGrndCheck

    do_often("OnGrndCheck()")

-- Reset Variables for next Flight
    function MasterReset()
        if not ready then
            return
        end
        if IAS > 30 and IAS < 40 and WEIGHT_ON_WHEELS == 1 then
            playSeq = 0
            posRatePlayed = false
            GearUp_Played = false
            GearDown_Played = true
            VNAV_msg = false
            toEngRate = false
            print("767Callouts: Reset For Flight")
        end
    end

    do_often("MasterReset()")

-- Shut Down Message
    function ShutDown()
        if not ready then
            return
        end

        if ENG1_N2 < 25 and ENG2_N2 < 25 and WEIGHT_ON_WHEELS == 1 and PARK_BRAKE == 1 and flightOccoured and not horsePlayed then
            play_sound(Horse)
            horsePlayed = true
            flightOccoured = false
            print("767Callouts: You Suck")
            print("767Callouts: " .. math.floor(ENG1_N2) .. " | " .. math.floor(ENG2_N2))
        end
    end

    do_often("ShutDown()")

-- Go Around Monitor

    function TogaTrigger()
        togaEvent = true
        flaps20Retracted = false
        flchPressed = false
        gaVnavPressed = false
        lnavPressed = false
        gaPlayed = false
        print("767Callouts: TOGA Event Detected at time " .. math.floor(SIM_TIME))
        togaState = TOGA_BUTTON
    end

    function TogaMonitor()
        if togaState == nil then
            togaState = TOGA_BUTTON
        elseif togaState ~= TOGA_BUTTON then
            TogaTrigger()
        end
    end

    do_often("TogaMonitor()")
        
-- Go Around Function

function GoAround()
    if WEIGHT_ON_WHEELS == 0 and togaEvent and ENGINE_MODE == 6 and not flaps20Retracted then
        if flapPos > 0.8 then
            set("sim/flightmodel/controls/flaprqst", 0.66667)
            print("767Callouts: Go Around - Flaps 20 selected")
            flaps20Retracted = true
        end
    end
    if togaEvent and not posRatePlayed and VSI > 10 then
        play_sound(PosRate_snd)
        set("1-sim/cockpit/switches/gear_handle", 0)
        print("767Callouts: Go Around Positive Rate " ..math.floor(AGL / 0.3048) .. " AGL and " .. math.floor(VSI) .. " ft/min")
        print("767Callouts: Waiting for accel height of " .. FMS_ACCEL_HT .. " ft")
        posRatePlayed = true
    end
    if togaEvent and GEAR_HANDLE == 0 and (AGL / 0.3048) > 410 and posRatePlayed and not lnavPressed and LNAV_BUTTON == 0 then
       set("1-sim/AP/lnavButton", 1)
       print("767Callouts: Attempting to engage LNAV")
       lnavPressed = true
    end
    if togaEvent and GEAR_HANDLE == 0 and (AGL / 0.3048) > 410 and posRatePlayed and not lnavPressed and LNAV_BUTTON == 1 then
        set("1-sim/AP/lnavButton", 0)
        print("767Callouts: Attempting to engage LNAV")
        lnavPressed = true
    end
    if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and not clbThrustPlayed then
        set("1-sim/eng/thrustRefMode", 32)
        play_sound(ClbThrust_snd)
        clbThrustPlayed = true
        print("767Callouts: Go Around Climb Thrust " .. FMS_ACCEL_HT)
    end
    if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and clbThrustPlayed and VNAV_BUTTON == 0 and not gaVnavPressed then
        set("1-sim/AP/vnavButton", 1)
        print("767Callouts: Attempting VNAV")
        gaVnavPressed = true
    end
    if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and clbThrustPlayed and VNAV_BUTTON == 1 and not gaVnavPressed then
        set("1-sim/AP/vnavButton", 0)
        print("767Callouts: Attempting VNAV")
        gaVnavPressed = true
    end
    if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and gaVnavPressed and VNAV_ENGAGED_LT ~= 0.8 and FLCH_BUTTON == 0 and not flchPressed then
        set("1-sim/AP/flchButton", 1)
        print("767Callouts: Negative VNAV ".. VNAV_ENGAGED_LT .." , attempting FLCH")
        flchPressed = true
    end
    if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and gaVnavPressed and VNAV_ENGAGED_LT ~= 0.8 and FLCH_BUTTON == 1 and not flchPressed then
        set("1-sim/AP/flchButton", 0)
        print("767Callouts: Negative VNAV ".. VNAV_ENGAGED_LT .." , attempting FLCH")
        flchPressed = true
    end
    if togaEvent and not gaPlayed and (AGL / 0.3048) > (FMS_ACCEL_HT + 100) then
        if flchPressed then
            set("757Avionics/ap/spd_act", VREF_30 + 80)
            print("767Callouts: FLCH Vref+80 = " .. math.floor(VREF_30 + 80))
        end
        gaPlayed = true
        togaEvent = false
        print("767Callouts: GA Mode Off")
    end
end

do_often("GoAround()")


--------

else
    print("767Callouts: Unsupported Aircraft Type " .. PLANE_ICAO)

end -- Master End
