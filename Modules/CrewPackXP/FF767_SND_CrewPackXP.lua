--[[
CrewPackXP FF767 Sound Config File
]]

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
    set_sound_gain(Pax_Seatbelts_snd, paVol)
    set_sound_gain(TaxiInPA_snd, paVol)
    set_sound_gain(CabinSecure_snd, soundVol)
end

-- Start Up Sounds
function cpxpStartSound()
    if not cpxpStartPlayed then
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