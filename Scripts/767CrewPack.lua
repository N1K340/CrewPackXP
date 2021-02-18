--[[
	Crew Pack Script for Flight Factor B757 / B767
	
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
--]]
if PLANE_ICAO == "B752" or PLANE_ICAO == "B753" or PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
    --------
    -- Initialisation Variables
    local version = "0.6-beta"
    local initDelay = 15
    local startTime = 0
    dataref("SIM_TIME", "sim/time/total_running_time_sec")

    -- dependencies
    local LIP = require("LIP")
    require "graphics"

    -- Local Variables

    local bubbleTimer = 0
    local msgStr = ""
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
    local horsePlayed = true
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
    local gpuDisconnect = true
    local leftStart = false
    local rightStart = false
    local rightBaro = nil
    local showSettingsWindow = true
    local foPreflight = false
    local gseOnBeacon = false
    local syncAlt = false
    local locgsCalls = false
    local goAroundAutomation = false
    local startMsg = false
    local CrewPack767SettingsFile = "/767CrewPack.ini"
    local CrewPack767Settings = {}
    local soundVol = 1.0
    local master = true
    local gpuConnect = false
    local apuConnect = false
    local apuStart = true
    local beaconSetup = false
    local defaultFA = true
    local faOnboard = true
    local faPlaySeq = 0
    local ccpatimer = 230
    local paVol = 0.3
    local engStartType = 1
    local todPaPlayed = true
    local seatsLandingPlayed = true

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
    local LOCGScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_LOCandGS.wav")
    local Horse_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/gnd_horse.wav")
    local ClbThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_ClbThr.wav")
    local VNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_VNAV.wav")
    local LNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_LNAV.wav")
    local StartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_StartLeft.wav")
    local StartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_StartRight.wav")
    local StartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Start1.wav")
    local StartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pf_Start2.wav")
    local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/output.wav")
    local Start1 = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/start_1.wav")
    local Start2 = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/start_2.wav")
    local Start3 = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/start_3.wav")
    local Start4 = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/start_4.wav")
    local FA_Welcome_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/fa_welcome.wav")
    local SafetyDemo767_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/safetyDemo767.wav")
    local CabinSecure_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/fa_cabinSecure.wav")
    local TOD_PA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/pnf_todPa.wav")
    local SeatLand_snd = load_WAV_file(SCRIPT_DIRECTORY .. "767Callouts/fa_seatsLanding.wav")

    function setGain()
        set_sound_gain(EightyKts_snd, soundVol)
        set_sound_gain(V1_snd, soundVol)
        set_sound_gain(VR_snd, soundVol)
        set_sound_gain(PosRate_snd, soundVol)
        set_sound_gain(GearUp_snd, soundVol)
        set_sound_gain(GearDwn_snd, soundVol)
        set_sound_gain(Flap0_snd, soundVol)
        set_sound_gain(Flap1_snd, soundVol)
        set_sound_gain(Flap5_snd, soundVol)
        set_sound_gain(Flap15_snd, soundVol)
        set_sound_gain(Flap20_snd, soundVol)
        set_sound_gain(Flap25_snd, soundVol)
        set_sound_gain(Flap30_snd, soundVol)
        set_sound_gain(SpdBrkUp_snd, soundVol)
        set_sound_gain(SpdBrkNot_snd, soundVol)
        set_sound_gain(SixtyKts_snd, soundVol)
        set_sound_gain(GScap_snd, soundVol)
        set_sound_gain(LOCcap_snd, soundVol)
        set_sound_gain(LOCGScap_snd, soundVol)
        set_sound_gain(Horse_snd, soundVol)
        set_sound_gain(ClbThrust_snd, soundVol)
        set_sound_gain(VNAV_snd, soundVol)
        set_sound_gain(LNAV_snd, soundVol)
        set_sound_gain(StartLeft_snd, soundVol)
        set_sound_gain(StartRight_snd, soundVol)
        set_sound_gain(StartLeft1_snd, soundVol)
        set_sound_gain(StartRight2_snd, soundVol)
        set_sound_gain(Start1, soundVol)
        set_sound_gain(Start2, soundVol)
        set_sound_gain(Start3, soundVol)
        set_sound_gain(Start4, soundVol)
        set_sound_gain(FA_Welcome_snd, paVol)
        set_sound_gain(SafetyDemo767_snd, paVol)
        set_sound_gain(TOD_PA_snd, paVol)
        set_sound_gain(SeatLand_snd, paVol)
        set_sound_gain(CabinSecure_snd, soundVol)
    end

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
    dataref("BEACON", "sim/cockpit2/switches/beacon_on")
    dataref("LEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
    dataref("RIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)
    

    print("767CrewPack: Initialising version " .. version)
    print("767CrewPack: Starting at sim time " .. math.floor(SIM_TIME))

    -- Bubble for messages
    function CP767DisplayMessage()
        bubble(20, get("sim/graphics/view/window_height") - 100, msgStr)
    end

    function CP767msg()
        if bubbleTimer < 3 then
            CP767DisplayMessage()
        else
            msgStr = ""
        end 
    end

    function CP767BubbleTiming()
        if bubbleTimer < 3 then
            bubbleTimer = bubbleTimer + 1
        end        
    end

    do_every_draw("CP767msg()")
    do_often("CP767BubbleTiming()")

    
    --	Delaying initialisation of datarefs till aircraft loaded
    function CP767DelayedInit()
        -- Dealy based on time

        if startTime == 0 then
            startTime = (SIM_TIME + initDelay)
            bubbleTimer = -12
            ParseCrewPack767Settings()
        end
        if (SIM_TIME < startTime) then
            print(
                "767CrewPack: Init Delay " .. math.floor(SIM_TIME) .. " waiting for " .. math.floor(startTime) .. " --"
            )
            msgStr = "767 Crew Pack Loading in " .. math.floor(startTime - SIM_TIME) .. " seconds"
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
            dataref("EFIS_TYPE", "1-sim/ngpanel")
        end
        if (XPLMFindDataRef("757Avionics/fms/vnav_phase") ~= nil) then
            dataref("FMS_MODE", "757Avionics/fms/vnav_phase")
        end

        if (XPLMFindDataRef("anim/17/button") == nil) then
            return
        end

        if not ready then
            print("767CrewPack: Datarefs Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(SIM_TIME))
            msgStr = "767 Crew Pack Initialised for " .. PLANE_ICAO
            bubbleTimer = 0
            ready = true
        end
    end -- End of DelayedInit

    do_often("CP767DelayedInit()")

    -- Start Up Sounds
    function CP767StartSound()
        if not ready then
            return
        end
        if startMsg and not startPlayed then
            local soundFile = {
                Start1,
                Start2,
                Start3,
                Start4,
            }
            math.randomseed(os.time())
            play_sound(soundFile[math.random(1,4)])
                startPlayed = true        
            end
    end

    do_often("CP767StartSound()")

    -- Monitor for ADC1 Failure
    function CP767MonitorADC1()
        if not ready then
            return
        end
        if ADC1 == 1 then
            print("767CrewPack: ADC1 Failure, callouts degraded")
            msgStr = "767 Crew Pack: Aircraft data computer failure detected"
            bubbleTimer = 0
        end
    end -- End of MonitorADC1

    do_often("CP767MonitorADC1()")

    -- Cockpit Setup
    function CP767CockpitSetup()
        if not ready then
            return
        end
        if not cockpitSetup then
            set("anim/armCapt/1", 2)
            set("anim/armFO/1", 2)
            set("lights/ind_rhe", 1)
            set("lights/cabin_com", 1)
            if get("sim/graphics/scenery/sun_pitch_degrees") < 0 then
                set("lights/glareshield1_rhe", 0.1)
                set("lights/aux_rhe", 0.05)
                set("lights/buttomflood_rhe", 0.2)
                set("lights/aisel_rhe", 0.5)
                set("lights/dome/flood_rhe", 1)
                set("anim/52/button", 1)
                set("lights/ind_rhe", 0)
                set("lights/cabin_com", 0.6)
                set("lights/chart_rhe", 0.5)
                set("lights/panel_rhe", 0.2)
                set("lights/flood_rhe", 0.4)
                set("1-sim/CDU/R/CDUbrtRotary", 0.5)
                set("1-sim/CDU/L/CDUbrtRotary", 0.5)
            end
            if EFIS_TYPE == 0 then -- New Type 757
                set("1-sim/ndpanel/1/hsiModeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeRotary", 1)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/2/hsiModeRotary", 2)
                set("1-sim/ndpanel/2/hsiRangeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
            --  set("1-sim/inst/HD/L", 0)
            --  set("1-sim/inst/HD/R", 0)
            end
            if EFIS_TYPE == 1 then
                set("1-sim/ndpanel/1/hsiModeRotary", 4)
                set("1-sim/ndpanel/1/hsiRangeRotary", 1)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/2/hsiModeRotary", 4)
                set("1-sim/ndpanel/2/hsiRangeRotary", 2)
                set("1-sim/ndpanel/1/hsiRangeButton", 1)
                set("1-sim/ndpanel/1/dhRotary", 0.00)
                set("1-sim/ndpanel/2/dhRotary", 0.00)
            end
            set("1-sim/ndpanel/1/hsiTerr", 1)
            set("1-sim/ndpanel/2/hsiTerr", 1)
            calloutTimer = 0
            set("anim/14/button", 1)
            set("1-sim/electrical/stbyPowerSelector", 1)
            if WEIGHT_ON_WHEELS == 1 and BEACON == 0 and ENG1_N2 < 20 and ENG2_N2 < 20 then
                if PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
                    set_array("sim/cockpit2/switches/custom_slider_on", 2, 1)
                    set_array("sim/cockpit2/switches/custom_slider_on", 3, 1)
                    set_array("sim/cockpit2/switches/custom_slider_on", 0, 1)
                end
                if PLANE_ICAO == "B753" or PLANE_ICAO == "B752" then
                    set_array("sim/cockpit2/switches/custom_slider_on", 6, 1)
                    set_array("sim/cockpit2/switches/custom_slider_on", 7, 1)
                    set_array("sim/cockpit2/switches/custom_slider_on", 0, 1)
                end
                set("params/LSU", 1)
                set("params/stop", 1)
                set("params/gate", 1)
                set("sim/cockpit2/controls/elevator_trim", 0.046353)
                set("1-sim/vor1/isAuto", 1)
                set("1-sim/vor1/isAuto", 2)
            end
            cockpitSetup = true
            print("767CrewPack: Attempting basic setup")
            -- blinds
            for i = 1, 90, 1 do
                local ref = "anim/blind/L/"..i
                set(ref, 0)
            end
            for i = 1, 90, 1 do
                local ref = "anim/blind/R/"..i
                set(ref, 0)
            end
            -- FO Preflight
            if foPreflight then
                msgStr = "767 Crew Pack: FO Attempting to setup cockpit"
                bubbleTimer = 0
                set("anim/1/button", 1)
                set("anim/2/button", 1)
                if PLANE_ICAO == "B763" or PLANE_ICAO == "B762" then
                    set("anim/3/button", 1)
                    set("anim/4/button", 1)
                end
                set("1-sim/irs/cdu/dsplSel", 1)
                set("1-sim/irs/1/modeSel", 2)
                set("1-sim/irs/2/modeSel", 2)
                set("1-sim/irs/3/modeSel", 2)
                set("anim/8/button", 1)
                set("anim/11/button", 1)
                set("anim/17/button", 1)
                set("anim/18/button", 1)
                set("anim/20/button", 1)
                set("anim/21/button", 1)
                set("anim/22/button", 1)
                set("anim/25/button", 1)
                set("lights/aux_rhe", 0.2)
                set("lights/buttomflood_rhe", 0.2)
                set("lights/glareshield1_rhe", 0.2)
                set("lights/aisel_rhe", 1)
                set("1-sim/emer/lightsCover", 0)
                set("1-sim/engine/ignitionSelector", 0)
                set("anim/rhotery/8", 1)
                set("anim/rhotery/9", 1)
                set("anim/43/button", 1)
                set("anim/47/button", 1)
                set("anim/48/button", 1)
                set("anim/49/button", 1)
                set("anim/50/button", 1)
                set("anim/53/button", 1)
                set("sim/cockpit/switches/no_smoking", 1)
                set("1-sim/press/rateLimitSelector", 0.3)
                math.randomseed(os.time())
                set("1-sim/press/modeSelector", (math.random(0, 1)))
                set("1-sim/cond/fltdkTempControl", 0.5)
                set("1-sim/cond/fwdTempControl", 0.5)
                set("1-sim/cond/midTempControl", 0.5)
                set("1-sim/cond/aftTempControl", 0.5)
                set("anim/54/button", 1)
                set("anim/55/button", 1)
                set("anim/56/button", 1)
                set("1-sim/cond/leftPackSelector", 1)
                set("1-sim/cond/rightPackSelector", 1)
                set("anim/59/button", 1)
                set("anim/87/button", 1)
                set("anim/90/button", 1)
                set("anim/60/button", 1)
                set("anim/61/button", 1)
                set("anim/62/button", 1)
                set("1-sim/AP/fd2Switcher", 0)
                set("1-sim/eicas/stat2but", 1)
                set("757Avionics/CDU/init_ref", 1)
                set("757Avionics/CDU2/prog", 1)
                set(
                    "sim/cockpit/misc/barometer_setting",
                    (math.floor((tonumber(get("sim/weather/barometer_sealevel_inhg"))) * 100) / 100)
                )
                set(
                    "sim/cockpit/misc/barometer_setting2",
                    (math.floor((tonumber(get("sim/weather/barometer_sealevel_inhg"))) * 100) / 100)
                )
                set("1-sim/press/landingAltitudeSelector", ((math.ceil(get("sim/cockpit2/gauges/indicators/altitude_ft_pilot") / 10))/100) - 2)
            else
                print("FO Preflight inhibited by settings")
                msgStr = "767 Crew Pack: FO Preflight inhibited by settings"
                bubbleTimer = 0
            end
        end
    end -- End of CockpitSetup

    do_often("CP767CockpitSetup()")

    -- AutoSync Alt Settings

    function CP767SyncBaro()
        if not ready then
            return
        end
        if syncAlt then
            if get("sim/cockpit/misc/barometer_setting") ~= rightBaro then
                rightBaro = get("sim/cockpit/misc/barometer_setting")
                if EFIS_TYPE == 0 then
                    print("767CrewPack: FO Altimiter Synced")
                    set("sim/cockpit/misc/barometer_setting2", rightBaro)
                else
                    print("767CrewPack: Unable to sync altimeters in new style 757")
                end
            end
        elseif syncAlt and EFIS_TYPE == 1 then
            print("767CrewPack: Unable to sync baros in new 757 EFIS")
        end
    end

    do_sometimes("CP767SyncBaro()")

    -- Engine Start Calls

    function CP767EngineStart()
        if not ready then
            return
        end
            if LEFT_STARTER == 1 and not leftStart then
                print("767CrewPack: Start Left Engine")
                if engStartType == 1 then
                    play_sound(StartLeft_snd)
                else
                    play_sound(StartLeft1_snd)
                end
                leftStart = true
            end
            if LEFT_STARTER == 0 then
                leftStart = false
            end
            if RIGHT_STARTER == 1 and not rightStart then
                print("767CrewPack: Start Right Engine")
                if engStartType == 1 then
                    play_sound(StartRight_snd)
                else
                    play_sound(StartRight2_snd)
                end               
                rightStart = true
            end
            if RIGHT_STARTER == 0 then
                rightStart = false
            end
    end

    do_often("CP767EngineStart()")

    -- Flight Attendant Interactions

    function CP767FlightAttendant()
        if not ready then
            return
        end
        if defaultFA then
            set("params/saiftydone", 1)
        end
        if ccpatimer < 241 then
            ccpatimer = ccpatimer + 1
            print("767CrewPack: Cabin timer " .. ccpatimer)
            print(math.floor(get("sim/flightmodel2/position/groundspeed")))
        end
        if faOnboard then
            if BEACON == 1 and WEIGHT_ON_WHEELS == 1 and ENG2_N2 > 10 and faPlaySeq == 0 then
                ccpatimer = 150
                play_sound(FA_Welcome_snd)
                faPlaySeq = 1
                print("767CrewPack: Playing FA welcome PA - Engine Start")
            end
            if BEACON == 1 and WEIGHT_ON_WHEELS == 1 and (math.floor(get("sim/flightmodel2/position/groundspeed"))) ~= 0 and faPlaySeq == 0 then
                ccpatimer = 150
                play_sound(FA_Welcome_snd)
                faPlaySeq = 1
                print("767CrewPack: Playing FA welcome PA, GS "..(math.floor(get("sim/flightmodel2/position/groundspeed"))))
            end
            if BEACON == 1 and WEIGHT_ON_WHEELS == 1 and faPlaySeq == 1 and ccpatimer == 241 then
                ccpatimer = 0
                play_sound(SafetyDemo767_snd)
                print("767CrewPack: Playing Safety Demo")
                
                faPlaySeq = 2
            end
            if BEACON == 1 and WEIGHT_ON_WHEELS == 1 and faPlaySeq == 2 and ccpatimer == 241 then
                play_sound(CabinSecure_snd)
                print("767CrewPack: Played Cabin Secure")
                faPlaySeq = 3
            end
            if FMS_MODE == 4 and not todPaPlayed then
                play_sound(TOD_PA_snd)
                print("767CrewPack: Played FO TOD PA")
                todPaPlayed = true
                for i = 1, 90, 1 do
                    local ref = "anim/blind/L/"..i
                    set(ref, 0)
                end
                for i = 1, 90, 1 do
                    local ref = "anim/blind/R/"..i
                    set(ref, 0)
                end
            end
            if gearDownPlayed and calloutTimer >=2 and not seatsLandingPlayed then
                play_sound(SeatLand_snd)
                print("767CrewPack: Played seats for landing")
                seatsLandingPlayed = true
            end
        end
    end

    do_often("CP767FlightAttendant()")

    -- Engine Rate Monitor - Reset by: VNAV action in TO and GA as appropriate
    --TOGA 6 | TO 1, 11, 12 |
    function CP767EngRateMonitor()
        if not ready then
            return
        end
        if ENGINE_MODE == 6 and not togaMsg then
            -- GAEngRate = true
            print("767CrewPack: GA Mode Armed")
            togaMsg = true
        end
        if not toEngRate and ENGINE_MODE == 1 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
        if not toEngRate and ENGINE_MODE == 11 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
        if not toEngRate and ENGINE_MODE == 12 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
        if not toEngRate and ENGINE_MODE == 2 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
        if not toEngRate and ENGINE_MODE == 21 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
        if not toEngRate and ENGINE_MODE == 22 then
            toEngRate = true
            print("767CrewPack: TO Mode detected")
        end
    end

    do_every_frame("CP767EngRateMonitor()")

    -- Takeoff Calls - Reset by: Master Reset
    function CP767TakeoffCalls()
        if not ready then
            return
        end

        -- TO Callout Mode - Reset by: VNAV call at accel
        if toEngRate and WEIGHT_ON_WHEELS == 1 then
            toCalloutMode = true
        end

        -- TO Call Times
        if calloutTimer < 4 then
            calloutTimer = (calloutTimer + 1)
            print("767CrewPack: Call Timer" .. calloutTimer)
        end

        -- 80 Kts
        if toCalloutMode and IAS > 78 and playSeq == 0 then
            play_sound(EightyKts_snd)
            calloutTimer = 0
            print("767CrewPack: 80 Kts Played at " .. math.floor(IAS) .. " kts")
            -- Confirm XPDR TA/RA and Brakes RTO
            set("anim/rhotery/35", 5)
            set("1-sim/gauges/autoBrakeModeSwitcher", -1)
            sixtyPlayed = false
            playSeq = 1
        end

        -- V1
        if toCalloutMode and IAS > V1 - 3 and playSeq == 1 and calloutTimer >= 2 then
            play_sound(V1_snd)
            calloutTimer = 0
            print("767CrewPack: V1 of " .. math.floor(V1) .. " Played at " .. math.floor(IAS) .. " kts")
            playSeq = 2
        end

        -- VR
        if toCalloutMode and IAS > VR - 3 and playSeq == 2 and calloutTimer >= 2 then
            play_sound(VR_snd)
            calloutTimer = 0
            print("767CrewPack: VR of " .. math.floor(VR) .. " Played at " .. math.floor(IAS) .. " kts")
            playSeq = 3
        end

        -- Positive Rate
        if toCalloutMode and WEIGHT_ON_WHEELS == 0 and VSI > 0 and playSeq == 3 and calloutTimer >= 2 then
            play_sound(PosRate_snd)
            calloutTimer = 0
            print("767CrewPack: Positive Rate " .. math.floor(AGL) .. " AGL and " .. math.floor(VSI) .. " ft/min")
            playSeq = 4
        end
    end

    do_often("CP767TakeoffCalls()")

    -- TakeoffNoSpeeds - Reset by: Master Reset
    function CP767TakeoffNoSpeeds()
        if not ready then
            return
        end
        if not invalidVSpeed and toCalloutMode and IAS > 100 and V1 < 100 then
            print("767CrewPack: V1 Speed invalid value " .. math.floor(V1))
            invalidVSpeed = true
            -- msgStr = "767 Crew Pack: Invalid V-Speeds detected"
            -- bubbleTimer = 0
        end
        if not invalidVSpeed and toCalloutMode and IAS > 100 and VR < 100 then
            print("767CrewPack: VR Speed invalid value " .. math.floor(VR))
            invalidVSpeed = true
            -- msgStr = "767 Crew Pack: Invalid V-Speeds detected"
            -- bubbleTimer = 0
        end
    end

    do_often("CP767TakeoffNoSpeeds()")

    -- Takeoff VNAV Call - Reset by Master Reset
    function CP767TakeoffVNAV()
        if not ready then
            return
        end
        if toCalloutMode and (AGL / 0.3048) > FMS_ACCEL_HT + 50 and not vnavPressed then
            if VNAV_ENGAGED_LT == 0 then
                if VNAV_BUTTON == 0 and not vnavPressed then
                    set("1-sim/AP/vnavButton", 1)
                    print("767CrewPack: VNAV pressed")
                    vnavPressed = true
                end
                if VNAV_BUTTON == 1 and not vnavPressed then
                    set("1-sim/AP/vnavButton", 0)
                    print("767CrewPack: VNAV pressed")
                    vnavPressed = true
                end
            elseif VNAV_ENGAGED_LT > 0 then
                vnavPressed = true
            end
        end
        if vnavPressed and not vnavPlayed and VNAV_ENGAGED_LT > 0 then
            play_sound(VNAV_snd)
            calloutTimer = 0
            vnavPlayed = true
            vnavPressed = true
            toCalloutMode = false
            print("767CrewPack: VNAV at ".. math.floor(AGL / 0.3048) .. ", " .. FMS_ACCEL_HT .. " accel height")
            print("767CrewPack: TO Mode off")
        end
    end

    do_often("CP767TakeoffVNAV()")

    -- Gear Selection
    function CP767GearSelection()
        if not ready then
            return
        end
        if AGL > 15 and GEAR_HANDLE == 0 and calloutTimer >= 2 and not gearUpPlayed then
            play_sound(GearUp_snd)
            calloutTimer = 0
            gearUpPlayed = true
            gearDownPlayed = false
            flightOccoured = true
            apuStart = false
            spdBrkNotPlayed = false
            spdBrkPlayed = false
            sixtyPlayed = false
            horsePlayed = false
            todPaPlayed = false
            seatsLandingPlayed = false
            set("1-sim/lights/landingN/switch", 0)
            print("767CrewPack: Gear Up")
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
            set("1-sim/lights/landingN/switch", 1)
            print("767CrewPack: Gear Down")
        end
    end

    do_often("CP767GearSelection()")

    -- Flaps Selection

    -- Flaps Callouts in air only
    function CP767FlapsSelection()
        if not ready then
            return
        end
        if flapPos == 0 and flapTime == 1 and WEIGHT_ON_WHEELS == 0 then
            play_sound(Flap0_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 0 position for 1 Seconds -- ")
        end
        if flapPos > 0 and flapPos < 0.2 and flapTime == 1 then
            play_sound(Flap1_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 1 position for 1 Seconds -- ")
        end
        if flapPos > 0.3 and flapPos < 0.4 and flapTime == 1 then
            play_sound(Flap5_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 5 position for 1 Seconds -- ")
        end
        if flapPos == 0.5 and flapTime == 1 then
            play_sound(Flap15_snd)
            calloutTimer = 0
            print("767CrewPack: 15 position for 1 Seconds -- ")
        end
        if flapPos > 0.6 and flapPos < 0.7 and flapTime == 1 then
            play_sound(Flap20_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 20 position for 1 Seconds -- ")
        end
        if flapPos > 0.8 and flapPos < 0.9 and flapTime == 1 then
            play_sound(Flap25_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 25 position for 1 Seconds -- ")
        end
        if flapPos == 1 and flapTime == 1 then
            play_sound(Flap30_snd)
            calloutTimer = 0
            print("767CrewPack: Flaps 30 position for 1 Seconds -- ")
        end
    end

    do_often("CP767FlapsSelection()")

    --Monitor Flap Movement
    function CP767FlapPosCheck()
        if not ready then
            return
        end
        if flapPos ~= FLAP_LEVER then
            flapTime = 0
            flapPos = FLAP_LEVER
            print("767CrewPack: FlapPos = " .. flapPos)
            print("767CrewPack: FLAP_LEVER = " .. FLAP_LEVER)
            print("767CrewPack: Flaps Moved to " .. flapPos .. " --")
        else
            if flapTime <= 1 then
                flapTime = flapTime + 1
                print("767CrewPack: FlapTime = " .. flapTime)
            end
        end
    end -- End FlapPosCheck

    do_often("CP767FlapPosCheck()")

    -- Localiser / GlideSlope
    function CP767LocGsAlive()
        if not ready then
            return
        end
        -- Loc Capture Right of localiser (CDI Left) Reset by: Full scale LOC deflection
        if locgsCalls then
            if  WEIGHT_ON_WHEELS == 0 and LOC_RECEIVED == 1 and LOC_DEVIATION > -1.95 and LOC_DEVIATION <= 0 and not locPlayed and not togaEvent and not toCalloutMode then
                if GS_RECEIVED == 1 and GS_DEVIATION > -1.95 and GS_DEVIATION < 1  then
                    play_sound(LOCGScap_snd)
                    print("767CrewPack: LOC and GS Active")
                    calloutTimer = 0
                    locPlayed = true
                    gsPlayed = true
                else
                    play_sound(LOCcap_snd)
                    print("767CrewPack: LOC Active")
                    calloutTimer = 0
                    locPlayed = true
                end
            end

            if LOC_DEVIATION <= -2.5 and locPlayed then
                print("767CrewPack: Reset Loc Active Logic")
                print("767CrewPack: Reset GS Alive Logic")
                locPlayed = false
                gsPlayed = false
            end
            -- Loc Capture Left of localiser (CDI Right)
            if WEIGHT_ON_WHEELS == 0 and LOC_RECEIVED == 1 and LOC_DEVIATION < 1.95 and LOC_DEVIATION >= 0 and not locPlayed and not togaEvent and not toCalloutMode then
                if GS_RECEIVED == 1 and GS_DEVIATION > -1.95 and GS_DEVIATION < 1  then
                    play_sound(LOCGScap_snd)
                    print("767CrewPack: LOC and GS Active")
                    calloutTimer = 0
                    locPlayed = true
                    gsPlayed = true
                else
                    play_sound(LOCcap_snd)
                    print("767CrewPack: LOC Active")
                    calloutTimer = 0
                    locPlayed = true
                end
            end
            
            if LOC_DEVIATION >= 2.5 and locPlayed then
                locPlayed = false
                gsPlayed = false
                print("767CrewPack: Reset Loc Active Logic")
                print("767CrewPack: Reset GS Alive Logic")
            end
            -- GS
            if
               WEIGHT_ON_WHEELS == 0 and  GS_RECEIVED == 1 and GS_DEVIATION > -1.95 and GS_DEVIATION < 1 and locPlayed and not gsPlayed and calloutTimer >= 2 and not togaEvent and not toCalloutMode then
                play_sound(GScap_snd)
                print("767CrewPack: GS Alive")
                gsPlayed = true
            end
        end
    end

    do_often("CP767LocGsAlive()")

    -- Landing Roll / Speedbrakes - Reset by: Gear Up
    function CP767Landing()
        if not ready then
            return
        end
        if WEIGHT_ON_WHEELS == 1 and flightOccoured then
            if SPEED_BRAKE == 1 and not spdBrkPlayed then
                play_sound(SpdBrkUp_snd)
                spdBrkPlayed = true
                print("767CrewPack: Speed Brake On Landing")
            end
            if SPEED_BRAKE ~= 1 and gndTime == 5 and not spdBrkPlayed and not spdBrkNotPlayed then
                play_sound(SpdBrkNot_snd)
                spdBrkNotPlayed = true
                print("767CrewPack: Speed Brake Not Up On Landing")
            end
        end
        if WEIGHT_ON_WHEELS == 1 and flightOccoured and not sixtyPlayed and IAS <= 62 then
            play_sound(SixtyKts_snd)
            sixtyPlayed = true
            print("767CrewPack: 60kts on landing played at " .. math.floor(IAS))
        end
        if WEIGHT_ON_WHEELS == 1 and flightOccoured and apuConnect and not apuStart and IAS <= 30 then
            set("1-sim/engine/APUStartSelector", 2)
            apuStart = true
            msgStr = "767 Crew Pack: Starting APU"
            bubbleTimer = 0
        end    
    end

    do_often("CP767Landing()")

    function CP767OnGrndCheck()
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
                print("767CrewPack: Sustained Weight on wheels for " .. gndTime .. " seconds")
            end
        end
    end -- End of OnGrndCheck

    do_often("CP767OnGrndCheck()")

    -- Reset Variables for next Flight
    function CP767MasterReset()
        if not ready then
            return
        end
        if IAS > 30 and IAS < 40 and WEIGHT_ON_WHEELS == 1 then
            playSeq = 0
            posRatePlayed = false
            gearUpPlayed = false
            gearDownPlayed = true
            toEngRate = false
            invalidVSpeed = false
            vnavPlayed = false
            vnavPressed = false
            gpuDisconnect = false
            print("767CrewPack: Reset For Flight")
        end
    end

    do_often("CP767MasterReset()")

    -- Shut Down Message Reset by: Gear Up
    function CP767ShutDown()
        if not ready then
            return
        end

        if
            ENG1_N2 < 25 and ENG2_N2 < 25 and BEACON == 0 and WEIGHT_ON_WHEELS == 1 and PARK_BRAKE == 1 and flightOccoured and
                not horsePlayed
         then
            play_sound(Horse_snd)
            horsePlayed = true
            flightOccoured = false
            calloutTimer = 0
            faPlaySeq = 0
            set("params/stop", 1)
            print("767CrewPack: You Suck")
            print("767CrewPack: " .. math.floor(ENG1_N2) .. " | " .. math.floor(ENG2_N2))
        end
        if
            gseOnBeacon and ENG1_N2 < 25 and ENG2_N2 < 25 and WEIGHT_ON_WHEELS == 1 and PARK_BRAKE == 1 and
                calloutTimer > 3 and
                horsePlayed and
                BEACON == 0 and not beaconSetup
         then
            set("params/stop", 1)
            bubbleTimer = 0
            msgStr = "767 Crew Pack: Ground crew attending to aircraft"
            if gpuConnect then
                set("params/gpu", 1)
                msgStr = "767 Crew Pack: GPU Connected"
                bubbleTimer = 0
            end
            if apuConnect then
                set("1-sim/engine/APUStartSelector", 2)
                print("767CrewPack: Starting APU")
                set("anim/15/button", 1)
            end
            if PLANE_ICAO == "B762" or PLANE_ICAO == "B763" then
                set_array("sim/cockpit2/switches/custom_slider_on", 2, 1)
                set_array("sim/cockpit2/switches/custom_slider_on", 3, 1)
                set_array("sim/cockpit2/switches/custom_slider_on", 0, 1)
            elseif PLANE_ICAO == "B753" or PLANE_ICAO == "B752" then
                set_array("sim/cockpit2/switches/custom_slider_on", 6, 1)
                set_array("sim/cockpit2/switches/custom_slider_on", 7, 1)
                set_array("sim/cockpit2/switches/custom_slider_on", 0, 1)
            end
            set("anim/cabindoor", 1)
            set("params/LSU", 1)
            set("params/gate", 1)
            set("params/fuel_truck", 1)
            gpuDisconnect = false
            beaconSetup = true
        end
    end

    do_often("CP767ShutDown()")

    -- Clear GSE for departure Reset by: Beacon

    function CP767ClearGse()
        if not ready then
            return
        end
        if gseOnBeacon and BEACON == 1 and ENG1_N2 < 25 and ENG2_N2 < 25 and horsePlayed and not gpuDisconnect then
            msgStr = "767 Crew Pack: Ground crew closing doors"
            bubbleTimer = 0
            set("anim/16/button", 0)
            set("anim/cabindoor", 0)
            calloutTimer = 0
            set_array("sim/cockpit2/switches/custom_slider_on", 0, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 1, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 2, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 3, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 4, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 5, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 6, 0)
            set_array("sim/cockpit2/switches/custom_slider_on", 7, 0)
            set("params/LSU", 0)
            set("params/gate", 0)
            set("params/stop", 0)
            set("params/fuel_truck", 0)
            gpuDisconnect = true
            beaconSetup = false
        end
        if BEACON == 1 and get("params/gpu") == 1 and calloutTimer > 3 then
            set("params/gpu", 0)
        end
    end

    do_often("CP767ClearGse()")

    -- Go Around Monitor

    function CP767TogaTrigger()
        togaEvent = true
        flaps20Retracted = false
        flchPressed = false
        gaVnavPressed = false
        lnavPressed = false
        gaPlayed = false
        print("767CrewPack: TOGA Event Detected at time " .. math.floor(SIM_TIME))
        msgStr = "767 Crew Pack: GO Around Mode"
        bubbleTimer = 0
        togaState = TOGA_BUTTON
    end

    function CP767TogaMonitor()
        if togaState == nil then
            togaState = TOGA_BUTTON
        elseif togaState ~= TOGA_BUTTON then
            CP767TogaTrigger()
        end
    end

    do_often("CP767TogaMonitor()")

    -- Go Around Function - Reset by Toga Trigger, cancels on FMS Accel height

    function CP767GoAround()
        if WEIGHT_ON_WHEELS == 0 and togaEvent and ENGINE_MODE == 6 and goAroundAutomation and not flaps20Retracted then
            if flapPos > 0.8 then
                set("sim/flightmodel/controls/flaprqst", 0.66667)
                print("767CrewPack: Go Around - Flaps 20 selected")
                flaps20Retracted = true
            end
        end
        if togaEvent and not posRatePlayed and VSI > 10 then
            play_sound(PosRate_snd)
            set("1-sim/cockpit/switches/gear_handle", 0)
            print(
                "767CrewPack: Go Around Positive Rate " ..
                    math.floor(AGL / 0.3048) .. " AGL and " .. math.floor(VSI) .. " ft/min"
            )
            print("767CrewPack: Waiting for accel height of " .. FMS_ACCEL_HT .. " ft")
            posRatePlayed = true
        end
        if
            togaEvent and goAroundAutomation and GEAR_HANDLE == 0 and (AGL / 0.3048) > 410 and posRatePlayed and
                not lnavPressed and
                LNAV_BUTTON == 0
         then
            set("1-sim/AP/lnavButton", 1)
            print("767CrewPack: Attempting to engage LNAV")
            lnavPressed = true
        end
        if
            togaEvent and goAroundAutomation and GEAR_HANDLE == 0 and (AGL / 0.3048) > 410 and posRatePlayed and
                not lnavPressed and
                LNAV_BUTTON == 1
         then
            set("1-sim/AP/lnavButton", 0)
            print("767CrewPack: Attempting to engage LNAV")
            lnavPressed = true
        end
        if togaEvent and (AGL / 0.3048) > FMS_ACCEL_HT and not clbThrustPlayed then
            set("1-sim/eng/thrustRefMode", 32)
            play_sound(ClbThrust_snd)
            clbThrustPlayed = true
            print("767CrewPack: Go Around Climb Thrust " .. FMS_ACCEL_HT)
        end
        if
            togaEvent and goAroundAutomation and (AGL / 0.3048) > FMS_ACCEL_HT and clbThrustPlayed and VNAV_BUTTON == 0 and
                not gaVnavPressed
         then
            set("1-sim/AP/vnavButton", 1)
            print("767CrewPack: Attempting VNAV")
            gaVnavPressed = true
        end
        if
            togaEvent and goAroundAutomation and (AGL / 0.3048) > FMS_ACCEL_HT and clbThrustPlayed and VNAV_BUTTON == 1 and
                not gaVnavPressed
         then
            set("1-sim/AP/vnavButton", 0)
            print("767CrewPack: Attempting VNAV")
            gaVnavPressed = true
        end
        if
            togaEvent and goAroundAutomation and (AGL / 0.3048) > FMS_ACCEL_HT and gaVnavPressed and
                VNAV_ENGAGED_LT ~= 0.8 and
                FLCH_BUTTON == 0 and
                not flchPressed
         then
            set("1-sim/AP/flchButton", 1)
            print("767CrewPack: Negative VNAV " .. VNAV_ENGAGED_LT .. " , attempting FLCH")
            flchPressed = true
        end
        if
            togaEvent and goAroundAutomation and (AGL / 0.3048) > FMS_ACCEL_HT and gaVnavPressed and
                VNAV_ENGAGED_LT ~= 0.8 and
                FLCH_BUTTON == 1 and
                not flchPressed
         then
            set("1-sim/AP/flchButton", 0)
            print("767CrewPack: Negative VNAV " .. VNAV_ENGAGED_LT .. " , attempting FLCH")
            flchPressed = true
        end
        if togaEvent and not gaPlayed and (AGL / 0.3048) > (FMS_ACCEL_HT + 100) then
            if goAroundAutomation and flchPressed then
                set("757Avionics/ap/spd_act", math.ceil(VREF_30 + 80))
                print("767CrewPack: FLCH Vref+80 = " .. math.floor(VREF_30 + 80))
            end
            gaPlayed = true
            togaEvent = false
            print("767CrewPack: GA Mode Off")
        end
    end

    do_often("CP767GoAround()")

    -- Settings

    if not SUPPORTS_FLOATING_WINDOWS then
        -- to make sure the script doesn't stop old FlyWithLua versions
        print("imgui not supported by your FlyWithLua version, please update to latest version")
    end

    -- Create Settings window
    function ShowCrewPack767Settings_wnd()
        ParseCrewPack767Settings()
        CrewPack767Settings_wnd = float_wnd_create(450, 450, 0, true)
        float_wnd_set_title(CrewPack767Settings_wnd, "767 Crew Pack Settings")
        float_wnd_set_imgui_builder(CrewPack767Settings_wnd, "CrewPack767Settings_contents")
        float_wnd_set_onclose(CrewPack767Settings_wnd, "CloseCrewPack767Settings_wnd")
    end

    function CrewPack767Settings_contents(CrewPack767Settings_wnd, x, y)
        local winWidth = imgui.GetWindowWidth()
        local winHeight = imgui.GetWindowHeight()
        local titleText = "767 Crew Pack Settings"
        local titleTextWidth, titileTextHeight = imgui.CalcTextSize(titleText)

        imgui.SetCursorPos(winWidth / 2 - titleTextWidth / 2, imgui.GetCursorPosY())
        imgui.TextUnformatted(titleText)

        imgui.Separator()
        imgui.TextUnformatted("")
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("767 CrewPack on/off", master)
        if changed then
            master = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Plugin turned on" .. tostring(master))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Crew Pack FA Onboard?", faOnboard)
        if changed then
            faOnboard = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Start message logic set to " .. tostring(startMsg))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Play corny sound bite on loading", startMsg)
        if changed then
            startMsg = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Start message logic set to " .. tostring(startMsg))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
		local changed, newVal = imgui.Checkbox("Play Localiser and Glideslop calls", locgsCalls)
        if changed then
            locgsCalls = newVal
            SaveCrewPack767Data()
            print("767CrewPack: LOC / GS Call logic set to " .. tostring(syncAlt))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
		local changed, newVal = imgui.Checkbox("FO Performs Preflight Scan Flow", foPreflight)
        if changed then
            foPreflight = newVal
            SaveCrewPack767Data()
            print("767CrewPack: FO PreScan logic set to " .. tostring(foPreflight))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Supress default flight attendant from pestering", defaultFA)
        if changed then
            defaultFA = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Default FA logic set to " .. tostring(foPreflight))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("FO automation on go around", goAroundAutomation)
        if changed then
            goAroundAutomation = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Go Around automation logic set to " .. tostring(goAroundAutomation))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Chocks, Doors and belt loaders tied to Beacon on/off", gseOnBeacon)
        if changed then
            gseOnBeacon = newVal
            SaveCrewPack767Data()
            print("767CrewPack: GSE on beacon set to " .. tostring(gseOnBeacon))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        if imgui.BeginCombo("Engine Start Call", "", imgui.constant.ComboFlags.NoPreview) then
            if imgui.Selectable("Left / Right", engStartType == 1) then
                engStartType = 1
                SaveCrewPack767Data()
                print("767CrewPack: Engine start call set to Left / Right")
            end
            if imgui.Selectable("Engine 1 / 2", engStartType == 2) then
                engStartType = 2
                SaveCrewPack767Data()
                print("767CrewPack: Engine start call set to 1 / 2")
            end
            imgui.EndCombo()
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("Auto sync Cpt and FO Altimiters", syncAlt)
        if changed then
            syncAlt = newVal
            SaveCrewPack767Data()
            print("767CrewPack: Altimiter Sync logic set to " .. tostring(syncAlt))
        end
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        imgui.TextUnformatted("Auto power connections: ") 
        imgui.SetCursorPos(20, imgui.GetCursorPosY())
        local changed, newVal = imgui.Checkbox("GPU on bay", gpuConnect)
        if changed then
            gpuConnect = newVal
            SaveCrewPack767Data()
            print("767CrewPack: GPU Power on ground")
        end
        imgui.SameLine()
        local changed, newVal = imgui.Checkbox("APU smart start", apuConnect)
        if changed then
            apuConnect = newVal
            SaveCrewPack767Data()
            print("767CrewPack: APU started on ground")
        end     
        imgui.TextUnformatted("")   
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal = imgui.SliderFloat("Crew Volume", (soundVol * 100), 1, 100, "%.0f")
        if changed then
            soundVol = (newVal / 100)
            set_sound_gain(Output_snd, soundVol)
            play_sound(Output_snd)
            SaveCrewPack767Data()
            print("767CrewPacks: Volume set to " .. (soundVol * 100) .. " %")
        end
        imgui.TextUnformatted("")   
        imgui.SetCursorPos(75, imgui.GetCursorPosY())
        local changed, newVal1 = imgui.SliderFloat("PA Volume", (paVol * 100), 1, 100, "%.0f")
        if changed then
            paVol = (newVal1 / 100)
            set_sound_gain(Output_snd, paVol)
            play_sound(Output_snd)
            SaveCrewPack767Data()
            print("767CrewPacks: Volume set to " .. (paVol * 100) .. " %")
        end
        imgui.Separator()
        imgui.TextUnformatted("")
        imgui.SetCursorPos(200, imgui.GetCursorPosY())
        if imgui.Button("CLOSE") then
            CloseCrewPack767Settings_wnd()
        end
    end

    function CloseCrewPack767Settings_wnd()
        if CrewPack767Settings_wnd then
            float_wnd_destroy(CrewPack767Settings_wnd)
        end
    end

    function ToggleCrewPack767Settings()
        if not showSettingsWindow then
            ShowCrewPack767Settings_wnd()
            showSettingsWindow = true
        elseif showSettingsWindow then
            CloseCrewPack767Settings_wnd()
            showSettingsWindow = false
        end
    end

    function ParseCrewPack767Settings()
        CrewPack767Settings = LIP.load(SCRIPT_DIRECTORY .. CrewPack767SettingsFile)
        foPreflight = CrewPack767Settings.CrewPack767.foPreflight
        gseOnBeacon = CrewPack767Settings.CrewPack767.gseOnBeacon
        syncAlt = CrewPack767Settings.CrewPack767.syncAlt
        goAroundAutomation = CrewPack767Settings.CrewPack767.goAroundAutomation
        startMsg = CrewPack767Settings.CrewPack767.startMsg
        locgsCalls = CrewPack767Settings.CrewPack767.locgsCalls
        soundVol = CrewPack767Settings.CrewPack767.soundVol
        paVol = CrewPack767Settings.CrewPack767.paVol
        master = CrewPack767Settings.CrewPack767.master
        apuConnect = CrewPack767Settings.CrewPack767.apuConnect
        gpuConnect = CrewPack767Settings.CrewPack767.gpuConnect
        defaultFA = CrewPack767Settings.CrewPack767.defaultFA
        faOnboard = CrewPack767Settings.CrewPack767.faOnboard
        engStartType = CrewPack767Settings.CrewPack767.engStartType
        print("767CrewPack: Settings Loaded")
        setGain()
    end

    function SaveCrewPack767Settings(CrewPack767Settings)
        LIP.save(SCRIPT_DIRECTORY .. CrewPack767SettingsFile, CrewPack767Settings)
    end

    function SaveCrewPack767Data()
        CrewPack767Settings = {
            CrewPack767 = {
                foPreflight = foPreflight,
                gseOnBeacon = gseOnBeacon,
                syncAlt = syncAlt,
                goAroundAutomation = goAroundAutomation,
                startMsg = startMsg,
                locgsCalls = locgsCalls,
                soundVol = soundVol,
                master = master,
                gpuConnect = gpuConnect,
                apuConnect = apuConnect,
                defaultFA = defaultFA,
                faOnboard = faOnboard,
                paVol = paVol,
                engStartType = engStartType,
            }
        }
        print("767CrewPack: Settings Saved")
        bubbleTimer = 0
        msgStr = "767 Crew Pack settings saved"
        setGain()
        SaveCrewPack767Settings(CrewPack767Settings)
    end

    add_macro("767 Crew Pack Settings", "ShowCrewPack767Settings_wnd()", "CloseCrewPack767Settings_wnd()", "deactivate")
    create_command(
        "FlyWithLua/767CrewPack/toggle_settings",
        "toggle 767 Crew Pack Settings",
        "ToggleCrewPack767Settings()",
        "",
        ""
    )
else
    print("767CrewPack: Unsupported Aircraft Type " .. PLANE_ICAO)
end -- Master End
