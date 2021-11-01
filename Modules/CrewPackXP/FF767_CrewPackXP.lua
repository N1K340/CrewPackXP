--[[
CrewPackXP FF767 Sound Config File
]]

module(..., package.seeall)

local FF767init = require("CrewPackXP/FF767init_CrewPackXP")

local cpxpSoundVol = 1.0
local cpxpPaVol = 0.3
local cpxpStartPlayed = false


-- Sounds
local EightyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_pf_80kts.wav")
local V1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_V1.wav")
local VR_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_VR.wav")
local PosRate_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_PosRate.wav")
local GearUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_GearUp.wav")
local GearDwn_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_GearDn.wav")
local Flap0_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap0.wav")
local Flap1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap1.wav")
local Flap5_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap5.wav")
local Flap15_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap15.wav")
local Flap20_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap20.wav")
local Flap25_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap25.wav")
local Flap30_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Flap30.wav")
local SpdBrkUp_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_SpdBrkUp.wav")
local SpdBrkNot_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_SpdBrkNot.wav")
local SixtyKts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_60kts.wav")
local GScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_GS.wav")
local LOCcap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_LOC.wav")
local LOCGScap_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_LOCandGS.wav")
local Horse_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/gnd_horse.wav")
local ClbThrust_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_ClbThr.wav")
local VNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_VNAV.wav")
local LNAV_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_LNAV.wav")
local StartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartLeft.wav")
local StartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartRight.wav")
local StartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start1.wav")
local StartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start2.wav")
local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/output.wav")
local Start1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_1.wav")
local Start2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_2.wav")
local Start3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_3.wav")
local Start4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_4.wav")
local FA_Welcome_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_welcome.wav")
local SafetyDemo767_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/safetyDemo767.wav")
local CabinSecure_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_cabinSecure.wav")
local TOD_PA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_todPa.wav")
local SeatLand_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_seatsLanding.wav")
local Pax_Seatbelts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_paxseatbelt.wav")
local TaxiInPA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_goodbye.wav")

function cpxpSetGain()
    set_sound_gain(EightyKts_snd, cpxpSoundVol)
    set_sound_gain(V1_snd, cpxpSoundVol)
    set_sound_gain(VR_snd, cpxpSoundVol)
    set_sound_gain(PosRate_snd, cpxpSoundVol)
    set_sound_gain(GearUp_snd, cpxpSoundVol)
    set_sound_gain(GearDwn_snd, cpxpSoundVol)
    set_sound_gain(Flap0_snd, cpxpSoundVol)
    set_sound_gain(Flap1_snd, cpxpSoundVol)
    set_sound_gain(Flap5_snd, cpxpSoundVol)
    set_sound_gain(Flap15_snd, cpxpSoundVol)
    set_sound_gain(Flap20_snd, cpxpSoundVol)
    set_sound_gain(Flap25_snd, cpxpSoundVol)
    set_sound_gain(Flap30_snd, cpxpSoundVol)
    set_sound_gain(SpdBrkUp_snd, cpxpSoundVol)
    set_sound_gain(SpdBrkNot_snd, cpxpSoundVol)
    set_sound_gain(SixtyKts_snd, cpxpSoundVol)
    set_sound_gain(GScap_snd, cpxpSoundVol)
    set_sound_gain(LOCcap_snd, cpxpSoundVol)
    set_sound_gain(LOCGScap_snd, cpxpSoundVol)
    set_sound_gain(Horse_snd, cpxpSoundVol)
    set_sound_gain(ClbThrust_snd, cpxpSoundVol)
    set_sound_gain(VNAV_snd, cpxpSoundVol)
    set_sound_gain(LNAV_snd, cpxpSoundVol)
    set_sound_gain(StartLeft_snd, cpxpSoundVol)
    set_sound_gain(StartRight_snd, cpxpSoundVol)
    set_sound_gain(StartLeft1_snd, cpxpSoundVol)
    set_sound_gain(StartRight2_snd, cpxpSoundVol)
    set_sound_gain(Start1, cpxpSoundVol)
    set_sound_gain(Start2, cpxpSoundVol)
    set_sound_gain(Start3, cpxpSoundVol)
    set_sound_gain(Start4, cpxpSoundVol)
    set_sound_gain(FA_Welcome_snd, cpxpPaVol)
    set_sound_gain(SafetyDemo767_snd, cpxpPaVol)
    set_sound_gain(TOD_PA_snd, cpxpPaVol)
    set_sound_gain(SeatLand_snd, cpxpPaVol)
    set_sound_gain(Pax_Seatbelts_snd, cpxpPaVol)
    set_sound_gain(TaxiInPA_snd, cpxpPaVol)
    set_sound_gain(CabinSecure_snd, cpxpSoundVol)
end

-- Start Up Sounds
function cpxpStartSound()
    if FF767init.cpxpAircraftDelay() and not cpxpStartPlayed then
        local soundFile = {
            Start1,
            Start2,
            Start3,
            Start4,
        }
        math.randomseed(os.time())
        play_sound(soundFile[math.random(1,4)])
        cpxpStartPlayed = true        
    end
end

-- Initialise Refs
function cpxpAircraftDatRef()
    if FF767init.cpxpAircraftDelay() then
        dataref("cpxp_AGL", "sim/flightmodel/position/y_agl")
        dataref("cpxp_FLAP_LEVER", "sim/flightmodel/controls/flaprqst", "writeable")
        dataref("cpxp_GEAR_HANDLE", "1-sim/cockpit/switches/gear_handle")
        dataref("cpxp_SPEED_BRAKE", "sim/cockpit2/controls/speedbrake_ratio")
        dataref("cpxp_WEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
        dataref("cpxp_PARK_BRAKE", "sim/cockpit2/controls/parking_brake_ratio")
        dataref("cpxp_ENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
        dataref("cpxp_ENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
        dataref("cpxp_LOC_DEVIATION", "sim/cockpit/radios/nav2_hdef_dot")
        dataref("cpxp_LOC_RECEIVED", "1-sim/radios/isReceivingIlsLoc1")
        dataref("cpxp_GS_DEVIATION", "sim/cockpit/radios/nav2_vdef_dot")
        dataref("cpxp_GS_RECEIVED", "1-sim/radios/isReceivingIlsGs1")
        dataref("cpxp_STROBE_SWITCH", "sim/cockpit2/switches/strobe_lights_on")
        dataref("cpxp_ENGINE_MODE", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
        dataref("cpxp_MCP_SPEED", "sim/cockpit/autopilot/airspeed", "writeable")
        dataref("cpxp_FLCH_BUTTON", "1-sim/AP/flchButton", "writeable")
        dataref("cpxp_VNAV_ENGAGED_LT", "1-sim/AP/lamp/4")
        dataref("cpxp_VNAV_BUTTON", "1-sim/AP/vnavButton", "writeable")
        dataref("cpxp_LNAV_BUTTON", "1-sim/AP/lnavButton", "writeable")
        dataref("cpxp_AUTO_BRAKE", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
        dataref("cpxp_TOGA_BUTTON", "1-sim/AP/togaButton")
        dataref("cpxp_BEACON", "sim/cockpit2/switches/beacon_on")
        dataref("cpxp_LEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
        dataref("cpxp_RIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)
        dataref("cpxp_BELTS_SIGN", "sim/cockpit2/annunciators/fasten_seatbelt")
        if (XPLMFindDataRef("757Avionics/adc1/outIas") ~= nil) then
        dataref("cpxpIAS", "757Avionics/adc1/outIas")
        end
        if (XPLMFindDataRef("757Avionics/fms/v1") ~= nil) then
        dataref("cpxpV1", "757Avionics/fms/v1")
        end
        if (XPLMFindDataRef("757Avionics/fms/vr") ~= nil) then
        dataref("cpxpVR", "757Avionics/fms/vr")
        end
        if (XPLMFindDataRef("757Avionics/adc1/outVs") ~= nil) then
        dataref("cpxpVSI", "757Avionics/adc1/outVs")
        end
        if (XPLMFindDataRef("757Avionics/fms/accel_height") ~= nil) then
        dataref("cpxpFMS_ACCEL_HT", "757Avionics/fms/accel_height")
        end
        if (XPLMFindDataRef("757Avionics/adc1/adc_fail") ~= nil) then
        dataref("cpxpADC1", "757Avionics/adc1/adc_fail")
        end
        if (XPLMFindDataRef("757Avionics/fms/vref30") ~= nil) then
        dataref("cpxpVREF_30", "757Avionics/fms/vref30")
        end
        if (XPLMFindDataRef("757Avionics/options/ND/advEfisPanel") ~= nil) then
        dataref("cpxpEFIS_TYPE", "1-sim/ngpanel")
        end
        if (XPLMFindDataRef("757Avionics/fms/vnav_phase") ~= nil) then
        dataref("cpxpFMS_MODE", "757Avionics/fms/vnav_phase")
        end
    end
end

-- Monitor for ADC1 Failure
function cpxpMonitorADC1()
    if cpxpADC1 == 1 then
        print("767CrewPack: ADC1 Failure, callouts degraded")
        msgStr = "CrewPackXP: Aircraft data computer failure detected"
        bubbleTimer = 0
    end
end -- End of MonitorADC1

-- Engine Start Calls

local cpxpLeftStart = false

function CP767EngineStart()
        if cpxpLEFT_STARTER == 1 and not cpxpleftStart then
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