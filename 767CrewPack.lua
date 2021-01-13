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
    local Version = 1.0
    local InitDelay = 15
    local StartTime = 0
    dataref("SimTime", "sim/time/total_running_time_sec")

    -- Local Variables

    local ready = false
    local Start_Played = false
    local PlaySeq = 0
    local PosRatePlayed = false
    local GearUpPlayed = false
    local FlapPos = 0.000000
    local FlapTime = 3
    local GearDownPlayed = true
    local SpdBrkPlayed = false
    local SpdBrkNotPlayed = false
    local Sixty_Played = true
    local Gnd_Time = 0
    local Horse_Played = false
    local LOC_Played = false
    local GS_Played = false
    local CockpitSet = false
    local flightoccoured = false
    local GA_Played = false
    local TOGA_msg = false
    local vnavplayed = true
    local vnavpressed = true
    local Flaps20Retract = true
    local TOEngRate = false
	local TOGAevent = false
    local TogaState = nil
    local TOCalloutMode = false
    local TOCallTimer = 4
    local InvalidVSpeed = false
    local CLBthrustplayed = false
    local FLCHpressed = true
    local GA_VNAV_Press = true
    local LNAVpressed = true
    

    -- Sound Files
    local Eightykts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_pf_80kts.wav")
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
    local clbthrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_ClbThr.wav")
    local VNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_VNAV.wav")

    -- Generic Datarefs
    dataref("AGL", "sim/flightmodel/position/y_agl")
    dataref("FlapLvr", "sim/flightmodel/controls/flaprqst", "writeable")
    dataref("GearHndl", "1-sim/cockpit/switches/gear_handle")
    dataref("SpdBrk", "sim/cockpit2/controls/speedbrake_ratio")
    dataref("WtWheel", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
    dataref("PrkBrk", "sim/cockpit2/controls/parking_brake_ratio")
    dataref("Eng1N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
    dataref("Eng2N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
    dataref("loc", "sim/cockpit/radios/nav2_hdef_dot")
    dataref("locThere", "1-sim/radios/isReceivingIlsLoc1")
    dataref("gs", "sim/cockpit/radios/nav2_vdef_dot")
    dataref("gsThere", "1-sim/radios/isReceivingIlsGs1")
    dataref("Strobes", "sim/cockpit2/switches/strobe_lights_on")
    dataref("EngRate", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
    dataref("MCPspd", "sim/cockpit/autopilot/airspeed", "writeable")
    dataref("FLCH", "1-sim/AP/flchButton", "writeable")
    dataref("VNAVeng", "1-sim/AP/lamp/4")
    dataref("VNAV", "1-sim/AP/vnavButton", "writeable")
    dataref("LNAV", "1-sim/AP/lnavButton", "writeable")
    dataref("ATO", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
    dataref("TogaBut", "1-sim/AP/togaButton")

    print("767Callouts: Initialising version " .. Version)
    print("767Callouts: Starting at sim time " .. math.floor(SimTime))

--	Delaying initialisation of datarefs till aircraft loaded
    function DelayedInit()
        -- Dealy based on time

        if StartTime == 0 then
            StartTime = (SimTime + InitDelay)
        end
        if (SimTime < StartTime) then
            print("767Callouts: Init Delay " .. math.floor(SimTime) .. " waiting for " .. math.floor(StartTime) .. " --")
            return
        end
            -- Delay based on 757 specific variables
            if (XPLMFindDataRef("757Avionics/adc1/outIas") ~= nil) then
                DataRef("IAS", "757Avionics/adc1/outIas")
            end
            if (XPLMFindDataRef("757Avionics/fms/v1") ~= nil) then
                DataRef("V1", "757Avionics/fms/v1")
            end
            if (XPLMFindDataRef("757Avionics/fms/vr") ~= nil) then
                DataRef("VR", "757Avionics/fms/vr")
            end
            if (XPLMFindDataRef("757Avionics/adc1/outVs") ~= nil) then
                DataRef("VSI", "757Avionics/adc1/outVs")
            end
            if (XPLMFindDataRef("757Avionics/fms/accel_height") ~= nil) then
                DataRef("FMSaccel", "757Avionics/fms/accel_height")
            end
            if (XPLMFindDataRef("757Avionics/adc1/adc_fail") ~= nil) then
                DataRef("ADC1", "757Avionics/adc1/adc_fail")
            end
            if (XPLMFindDataRef("757Avionics/fms/vref30") ~= nil) then
                DataRef("ref30", "757Avionics/fms/vref30")
            end
            if (XPLMFindDataRef("757Avionics/options/ND/advEfisPanel") ~= nil) then
                DataRef("EFISpanel", "757Avionics/options/ND/advEfisPanel")
            end
            if (XPLMFindDataRef("anim/armCapt/1") == nil) then
               return
            end
            
            if not ready then
                print("767Callouts: Datarefs Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(SimTime))
                ready = true
            end
    end -- End of DelayedInit

     do_often("DelayedInit()")

-- Start Up Sounds
    function StartSound()
        if not ready then
           return
        end
        if Start_Played == false then
            if PLANE_ICAO == "B752" or PLANE_ICAO == "B753" then
                play_sound(Start757_snd)
                print("767Callouts: Script ready at time " .. math.floor(SimTime))
                Start_Played = true
            end
            if PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
                play_sound(Start767_snd)
                print("767Callouts: Script ready at time " .. math.floor(SimTime))
                Start_Played = true
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
        if not CockpitSet then
            set("anim/armCapt/1", 2)
            set("anim/armFO/1", 2)
            if EFISpanel == 1 then
                set("1-sim/ndpanel/1/hsiModeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeRotary", 1)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/2/hsiModeRotary", 2)
                set("1-sim/ndpanel/2/hsiRangeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
            end
            if EFISpanel == 0 then
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
            CockpitSet = true
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
        if EngRate == 6 and not TOGA_msg then
           -- GAEngRate = true
			print("767Callouts: GA Mode Armed")
            TOGA_msg = true
        end
        if not TOEngRate  and EngRate == 1 then
            TOEngRate = true
            print("767Callouts: TO Mode detected")
        end
        if not TOEngRate  and EngRate == 11 then
            TOEngRate = true
            print("767Callouts: TO-1 Mode detected")
        end
        if not TOEngRate  and EngRate == 12 then
            TOEngRate = true
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
        if TOEngRate and WtWheel == 1 then
            TOCalloutMode = true
        end

        -- TO Call Times
        if TOCallTimer < 3 then
            TOCallTimer = (TOCallTimer + 1)
            print("767Callouts: Call Timer" .. TOCallTimer)
        end

        -- 80 Kts
        if TOCalloutMode and IAS > 78 and PlaySeq == 0 then
            play_sound(Eightykts_snd)
            PlaySeq = 1
            TOCallTimer = 0
            print("767Callouts: 80 Kts Played at " .. math.floor(IAS).. " kts")
            -- Confirm XPDR TA/RA and Brakes RTO
            set("anim/rhotery/35", 5)
            set("1-sim/gauges/autoBrakeModeSwitcher", -1)
        end

        -- V1
        if TOCalloutMode and IAS > V1 - 2 and PlaySeq == 1 and TOCallTimer >= 2 then
            play_sound(V1_snd)
            PlaySeq = 2
            TOCallTimer = 0
            print("767Callouts: V1 of " .. math.floor(V1) .. " Played at " .. math.floor(IAS) .. " kts")
        end

        -- VR
        if TOCalloutMode and IAS > VR - 2 and PlaySeq == 2 and TOCallTimer >= 2 then
            play_sound(VR_snd)
            PlaySeq = 3
            TOCallTimer = 0
            print("767Callouts: VR of " .. math.floor(VR) .. " Played at " .. math.floor(IAS) .. " kts")
        end

        -- Positive Rate
        if TOCalloutMode and AGL > 15 and VSI > 10 and PlaySeq == 3 and TOCallTimer >= 2 then
            play_sound(PosRate_snd)
            PlaySeq = 4
            TOCallTimer = 0
            print("767Callouts: Positive Rate " .. math.floor(AGL) .. " AGL and " .. math.floor(VSI) .. " ft/min")
        end
    end

    do_often("TakeoffCalls()")

-- TakeoffNoSpeeds
    function TakeoffNoSpeeds()
        if not ready then
            return
        end
        if not InvalidVSpeed and TOCalloutMode and IAS > 100 and V1 < 100 then
            print("767Callouts: V1 Speed invalid value " .. math.floor(V1))
            InvalidVSpeed = true
        end
        if not InvalidVSpeed and TOCalloutMode and IAS > 100 and VR < 100 then
            print("767Callouts: VR Speed invalid value " .. math.floor(VR))
            InvalidVSpeed = true
        end
    end

    do_often("TakeoffNoSpeeds()")

-- Takeoff VNAV Call
    function TakeoffVNAV()
        if not ready then
            return
        end
        if TOCalloutMode and (AGL / 0.3048) > FMSaccel + 50 and not vnavplayed and VNAVeng == 0 then
            print(EngRate .. " " .. VNAV)
            if VNAV == 0 and not vnavpressed then
                set("1-sim/AP/vnavButton", 1)
                print("767Callouts: VNAV pressed")
                vnavpressed = true
            end
            if VNAV == 1 and not vnavpressed then
                set("1-sim/AP/vnavButton", 0)
                print("767Callouts: VNAV pressed")
                vnavpressed = true
            end
        end
        if not vnavplayed and VNAVeng > 0 then
            play_sound(VNAV_snd)
            TOCallTimer = 0
            vnavplayed = true
            TOCalloutMode = false
            print("767Callouts: VNAV at " .. FMSaccel .. " accel height")
            print("767Callouts: TO Mode off")
        end
    end

    do_often("TakeoffVNAV()")

-- Gear Selection
    function GearSelection()
        if not ready then
            return
        end
        if AGL > 15 and GearHndl == 0 and TOCallTimer >= 2 and not GearUpPlayed then
            play_sound(GearUp_snd)
            TOCallTimer = 0
            GearUpPlayed = true
            GearDownPlayed = false
            flightoccoured = true
            set("1-sim/lights/landingN/switch", 0)
            print("767Callouts: Gear Up")
        end
        -- Gear Down
        if AGL > 15 and GearHndl == 1 and TOCallTimer >= 2 and not GearDownPlayed then
            play_sound(GearDwn_snd)
            TOCallTimer = 0
            GearUpPlayed = false
            GearDownPlayed = true
            PosRatePlayed = false
            TOGAevent = false
            TOGA_msg = false
            SpdBrkPlayed = false
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
        if FlapPos == 0 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap0_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 0 position for 1 Seconds -- ")
        end
        if FlapPos > 0 and FlapPos < 0.2 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap1_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 1 position for 1 Seconds -- ")
        end
        if FlapPos > 0.3 and FlapPos < 0.4 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap5_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 5 position for 1 Seconds -- ")
        end
        if FlapPos == 0.5 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap15_snd)
            TOCallTimer = 0
            print("767Callouts: 15 position for 1 Seconds -- ")
        end
        if FlapPos > 0.6 and FlapPos < 0.7 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap20_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 20 position for 1 Seconds -- ")
        end
        if FlapPos > 0.8 and FlapPos < 0.9 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap25_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 25 position for 1 Seconds -- ")
        end
        if FlapPos == 1 and FlapTime == 1 and WtWheel == 0 then
            play_sound(Flap30_snd)
            TOCallTimer = 0
            print("767Callouts: Flaps 30 position for 1 Seconds -- ")
        end
    end

    do_often("FlapsSelection()")

    --Monitor Flap Movement
    function FlapPosCheck()
        if not ready then
            return
        end
        if FlapPos ~= FlapLvr then
            FlapTime = 0
            FlapPos = FlapLvr
            print("767Callouts: FlapPos = " .. FlapPos)
            print("767Callouts: FlapLvr = " .. FlapLvr)
            print("767Callouts: Flaps Moved to " .. FlapPos .. " --")
        else
            if FlapTime <= 1 then
                FlapTime = FlapTime + 1
                print("767Callouts: FlapTime = " .. FlapTime)
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
        if locThere == 1 and loc < -1.95 and loc >= 0 and not LOC_Played and not TOGAevent and not TOCalloutMode then
            play_sound(LOCcap_snd)
            LOC_Played = true
            TOCallTimer = 0
            print("767Callouts: LOC Active")
        end
        if loc <= -2.5 and LOC_Played then
            LOC_Played = false
            GS_Played = false
            print("767Callouts: Reset Loc Active Logic")
            print("767Callouts: Reset GS Alive Logic")
        end
        -- Loc Capture Left of localiser (CDI Right)
        if locThere == 1 and loc < 1.95 and loc >= 0 and not LOC_Played  and not TOGAevent then
            play_sound(LOCcap_snd)
            LOC_Played = true
            TOCallTimer = 0
            print("767Callouts: LOC Active")
        end
        if loc >= 2.5 and LOC_Played then
            LOC_Played = false
            GS_Played = false
            print("767Callouts: Reset Loc Active Logic")
            print("767Callouts: Reset GS Alive Logic")
        end
        -- GS
        if gsThere == 1 and gs > -1.95 and gs < 1 and LOC_Played and not GS_Played and TOCallTimer >= 2  and not TOGAevent and not TOCalloutMode then
            play_sound(GScap_snd)
            GS_Played = true
            print("767Callouts: GS Alive")
        end
    end

    do_often("LocGsAlive()")

-- Landing Roll / Speedbrakes (Requires Gear Up, Ground Reset)
    function Landing()
        if not ready then
            return
        end
        if WtWheel == 1 and flightoccoured then
            if SpdBrk == 1  and not SpdBrkPlayed then
                play_sound(SpdBrkUp_snd)
                SpdBrkPlayed = true
                print("767Callouts: Speed Brake On Landing")
            end
            if SpdBrk ~= 1 and Gnd_Time == 5 and not SpdBrkPlayed and not SpdBrkNotPlayed then
                play_sound(SpdBrkNot_snd)
                SpdBrkNotPlayed = true
                print("767Callouts: Speed Brake Not Up On Landing")
            end
        end
        if WtWheel == 1 and flightoccoured and not Sixty_Played and IAS <= 62 then
            play_sound(SixtyKts_snd)
            Sixty_Played = true
            print("767Callouts: 60kts on landing played at " .. math.floor(IAS))
        end
    end

    do_often("Landing()")

    function OnGrndCheck()
        if not ready then
            return
        end
        if WtWheel == 0 then
            Gnd_Time = 0
        else
            if Gnd_Time <= 5 then
                Gnd_Time = Gnd_Time + 1
            end
            if Gnd_Time == 5 then
                print("767Callouts: Sustained Weight on wheels for " .. Gnd_Time .. " seconds")
            end
        end
    end -- End of OnGrndCheck

    do_often("OnGrndCheck()")

-- Reset Variables for next Flight
    function MasterReset()
        if not ready then
            return
        end
        if IAS > 30 and IAS < 40 and WtWheel == 1 then
            PlaySeq = 0
            PosRatePlayed = false
            GearUp_Played = false
            GearDown_Played = true
            VNAV_msg = false
            TOEngRate = false
            print("767Callouts: Reset For Flight")
        end
    end

    do_often("MasterReset()")

-- Shut Down Message
    function ShutDown()
        if not ready then
            return
        end

        if Eng1N2 < 25 and Eng2N2 < 25 and WtWheel == 1 and flightoccoured and not Horse_Played then
            play_sound(Horse)
            Horse_Played = true
            flightoccoured = false
            print("767Callouts: You Suck")
            print("767Callouts: " .. math.floor(Eng1N2) .. " | " .. math.floor(Eng2N2))
        end
    end

    do_often("ShutDown()")

-- Go Around Monitor

    function TogaTrigger()
        TOGAevent = true
        Flaps20Retract = false
        FLCHpressed = false
        GA_VNAV_Press = false
        LNAVpressed = false
        GA_Played = false
        print("767Callouts: TOGA Event Detected at time " .. math.floor(SimTime))
        TogaState = TogaBut
    end

    function TogaMonitor()
        if TogaState == nil then
            TogaState = TogaBut
        elseif TogaState ~= TogaBut then
            TogaTrigger()
        end
    end

    do_often("TogaMonitor()")
        
-- Go Around Function

function GoAround()
    if WtWheel == 0 and TOGAevent and EngRate == 6 and not Flaps20Retract then
        if FlapPos > 0.8 then
            set("sim/flightmodel/controls/flaprqst", 0.66667)
            print("767Callouts: Go Around - Flaps 20 selected")
            Flaps20Retract = true
        end
    end
    if TOGAevent and not PosRatePlayed and VSI > 10 then
        play_sound(PosRate_snd)
        set("1-sim/cockpit/switches/gear_handle", 0)
        print("767Callouts: Go Around Positive Rate " ..math.floor(AGL / 0.3048) .. " AGL and " .. math.floor(VSI) .. " ft/min")
        print("767Callouts: Waiting for accel height of " .. FMSaccel .. " ft")
        PosRatePlayed = true
    end
    if TOGAevent and GearHndl == 0 and (AGL / 0.3048) > 410 and PosRatePlayed and not LNAVpressed and LNAV == 0 then
       set("1-sim/AP/lnavButton", 1)
       print("767Callouts: Attempting to engage LNAV")
       LNAVpressed = true
    end
    if TOGAevent and GearHndl == 0 and (AGL / 0.3048) > 410 and PosRatePlayed and not LNAVpressed and LNAV == 1 then
        set("1-sim/AP/lnavButton", 0)
        print("767Callouts: Attempting to engage LNAV")
        LNAVpressed = true
    end
    if TOGAevent and (AGL / 0.3048) > FMSaccel and not CLBthrustplayed then
        set("1-sim/eng/thrustRefMode", 32)
        play_sound(clbthrust_snd)
        CLBthrustplayed = true
        print("767Callouts: Go Around Climb Thrust " .. FMSaccel)
    end
    if TOGAevent and (AGL / 0.3048) > FMSaccel and CLBthrustplayed and VNAV == 0 and not GA_VNAV_Press then
        set("1-sim/AP/vnavButton", 1)
        print("767Callouts: Attempting VNAV")
        GA_VNAV_Press = true
    end
    if TOGAevent and (AGL / 0.3048) > FMSaccel and CLBthrustplayed and VNAV == 1 and not GA_VNAV_Press then
        set("1-sim/AP/vnavButton", 0)
        print("767Callouts: Attempting VNAV")
        GA_VNAV_Press = true
    end
    if TOGAevent and (AGL / 0.3048) > FMSaccel and GA_VNAV_Press and VNAVeng ~= 0.8 and FLCH == 0 and not FLCHpressed then
        set("1-sim/AP/flchButton", 1)
        print("767Callouts: Negative VNAV ".. VNAVeng .." , attempting FLCH")
        FLCHpressed = true
    end
    if TOGAevent and (AGL / 0.3048) > FMSaccel and GA_VNAV_Press and VNAVeng ~= 0.8 and FLCH == 1 and not FLCHpressed then
        set("1-sim/AP/flchButton", 0)
        print("767Callouts: Negative VNAV ".. VNAVeng .." , attempting FLCH")
        FLCHpressed = true
    end
    if TOGAevent and not GA_Played and (AGL / 0.3048) > (FMSaccel + 100) then
        if FLCHpressed then
            set("757Avionics/ap/spd_act", ref30 + 80)
            print("767Callouts: FLCH Vref+80 = " .. math.floor(ref30 + 80))
        end
        GA_Played = true
        TOGAevent = false
        print("767Callouts: GA Mode Off")
    end
end

do_often("GoAround()")


--------

else
    print("767Callouts: Unsupported Aircraft Type " .. PLANE_ICAO)

end -- Master End
