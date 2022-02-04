--[[
CrewPackXP FF767 Sound Config File

changelog:
v0.1 - Initial Release
]]

module(..., package.seeall)

--Initial Variables
local cpxpModuleVersion = "FF767 SND - v0.1"

-- Dependencies

-- Global Var

-- Local Var
local cpxpStartPlayed = false



print("CrewPackXP: Loading module " .. cpxpModuleVersion)



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
local cpxpStartLeft_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartLeft.wav")
local cpxpStartRight_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_StartRight.wav")
local cpxpStartLeft1_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start1.wav")
local cpxpStartRight2_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pf_Start2.wav")
local Output_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/output.wav")
local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_1.wav")
local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_2.wav")
local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_3.wav")
local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/start_4.wav")
local cpxpFA_Welcome_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_welcome.wav")
local cpxpSafetyDemo767_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/safetyDemo767.wav")
local cpxpCabinSecure_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_cabinSecure.wav")
local cpxpTOD_PA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/pnf_todPa.wav")
local cpxpSeatLand_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_seatsLanding.wav")
local cpxpPax_Seatbelts_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_paxseatbelt.wav")
local TaxiInPA_snd = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/FF767/fa_goodbye.wav")

function cpxpSetGain()
    set_sound_gain(cpxpEightyKts_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpV1_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpVR_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpPosRate_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpGearUp_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpGearDwn_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap0_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap1_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap5_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap15_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap20_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap25_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpFlap30_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpSpdBrkUp_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpSpdBrkNot_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpSixtyKts_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpGScap_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpLOCcap_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpLOCGScap_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpHorse_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpClbThrust_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpVNAV_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpLNAV_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpStartLeft_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpStartRight_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpStartLeft1_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpStartRight2_snd, _G.cpxpSoundVol)
    set_sound_gain(cpxpStart1, _G.cpxpSoundVol)
    set_sound_gain(cpxpStart2, _G.cpxpSoundVol)
    set_sound_gain(cpxpStart3, _G.cpxpSoundVol)
    set_sound_gain(cpxpStart4, _G.cpxpSoundVol)
    set_sound_gain(cpxpFA_Welcome_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpSafetyDemo767_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpTOD_PA_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpSeatLand_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpPax_Seatbelts_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpTaxiInPA_snd, _G.cpxpPaVol)
    set_sound_gain(cpxpCabinSecure_snd, _G.cpxpSoundVol)
end

-- Startup Byte
function cpxpStartSound()
    if _G.cpxpReady and not cpxpStartPlayed then
        local soundFile = {
            cpxpStart1,
            cpxpStart2,
            cpxpStart3,
            cpxpStart4,
        }
        math.randomseed(os.time())
        play_sound(soundFile[math.random(1,4)])
        cpxpStartPlayed = true        
    end
end

-- Engine Start Callout
function cpxpPlayEngineStartLft()
    if _G.cpxpEngStartType == 1 then
        play_sound(cpxpStartLeft_snd)
    else
        play_sound(cpxpStartLeft1_snd)
    end
end 

function cpxpPlayEngineStartRt()
    if _G.cpxpEngStartType == 1 then
        play_sound(cpxpStartRight_snd)
    else
        play_sound(cpxpStartRight1_snd)
    end
end 

-- FA PA's
function cpxpPlayFaWelcome()
    play_sound(cpxpFA_Welcome_snd)
end

function cpxpPlaySafetyDemo()
    play_sound(cpxpSafetyDemo767_snd)
end

function cpxpPlayCabinSecure()
    play_sound(cpxpCabinSecure_snd)
end

function cpxpPlayTod()
    play_sound(cpxpTOD_PA_snd)
end

function cpxpPlayBeltsOn()
    play_sound(cpxpPax_Seatbelts_snd)
end

function cpxpPlaySeatsLanding()
    play_sound(cpxpSeatLand_snd)
end

function cpxpPlayTaxiInPa()
    play_sound(TaxiInPA_snd)
end