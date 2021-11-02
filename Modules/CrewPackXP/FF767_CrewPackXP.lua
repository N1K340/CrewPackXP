--[[
CrewPackXP Aircraft File Flight Factor 767 / 757

changelog:
v0.1 - Initial Release
]]

--Initial Variables
local cpxpModuleVersion = "FF767 - v0.1"

-- Dependencies

-- Global Var

-- Local Var
local cpxpFlightOccoured = false

-- Datarefs
if _G.cpxpReady then
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

-- Functions

print("CrewPackXP: Loading module " .. cpxpModuleVersion)


-- Initialisation Check
function cpxpAircraftDelay()
    if (XPLMFindDataRef("anim/17/button") == nil) then
        return
    else 
        _G.cpxpReady = true
        print("CrewPackXP: Initialising FF767 datarefs")
    end
end 

-- Monitor for ADC1 Failure
function cpxpMonitorADC1()
    if cpxpADC1 == 1 then
        print("767CrewPack: ADC1 Failure, callouts degraded")
        msgStr = "CrewPackXP: Aircraft data computer failure detected"
        bubbleTimer = 0
    end
end 

-- Engine Start Calls
local cpxpLeftStart = false
local cpxpRightStart = false

function cpxpEngineStart()
    if cpxp_LEFT_STARTER == 1 and not cpxpLeftStart then
        print("CrewPackXP: Start Left Engine")
        FF767snd.cpxpPlayEngineStartLft()
        cpxpLeftStart = true
    end
    if cpxp_LEFT_STARTER == 0 then
        cpxpLeftStart = false
    end
    if cpxp_RIGHT_STARTER == 1 and not cpxpRightStart then
        print("CrewPackXP: Start Right Engine")
        FF767snd.cpxpPlayEngineStartRt()             
        cpxpRightStart = true
    end
    if cpxp_RIGHT_STARTER == 0 then
        cpxpRightStart = false
    end
end

--Flight Attendant Interaction
local cpxpPaTimer = 230
local cpxpFaPlaySeq = 0
local cpxpTodPlayed = false
local cpxpPaxSeatBeltsPlayed = false
local cpxpSeatsLandingPlayed = false
local cpxpFaTaxiInPaPlayed = false

function cpxpFlightAttendant()
    if _G.cpxpMurderFA then
        set("params/saiftydone", 1)
    end
    if cpxpPaTimer < 241 then
        cpxpPaTimer = cpxpPaTimer + 1
        print("767CrewPack: Cabin timer " .. cpxpPaTimer)
    end
    if _G.cpxpFA then
        if cpxp_BEACON == 1 and cpxp_WEIGHT_ON_WHEELS == 1 and cpxp_ENG2_N2 > 10 and cpxp_FaPlaySeq == 0 then
            cpxpPaTimer = 150
            FF767snd.cpxpPlayFaWelcome()
            cpxp_FaPlaySeq = 1
            print("767CrewPack: Playing FA welcome PA - Engine Start")
        end
        if cpxp_BEACON == 1 and cpxp_WEIGHT_ON_WHEELS == 1 and (math.floor(get("sim/flightmodel2/position/groundspeed"))) ~= 0 and cpxp_FaPlaySeq == 0 then
            cpxpPaTimer = 150
            FF767snd.cpxpPlayFaWelcome()
            cpxp_FaPlaySeq = 1
            print("767CrewPack: Playing FA welcome PA, GS "..(math.floor(get("sim/flightmodel2/position/groundspeed"))))
        end
        if cpxp_BEACON == 1 and cpxp_WEIGHT_ON_WHEELS == 1 and cpxp_FaPlaySeq == 1 and cpxpPaTimer == 241 then
            cpxpPaTimer = 0
            FF767snd.cpxpPlaySafetyDemo()
            print("767CrewPack: Playing Safety Demo")
            cpxp_FaPlaySeq = 2
        end
        if cpxp_BEACON == 1 and cpxp_WEIGHT_ON_WHEELS == 1 and cpxp_FaPlaySeq == 2 and cpxpPaTimer == 241 then
            FF767snd.cpxpPlayCabinSecure()
            print("767CrewPack: Played Cabin Secure")
            cpxp_FaPlaySeq = 3
        end
        if FMS_MODE == 4 and not cpxpTodPlayed then
            FF767snd.cpxpPlayTod()
            print("767CrewPack: Played FO TOD PA")
            cpxpTodPlayed = true
            for i = 1, 90, 1 do
                local ref = "anim/blind/L/"..i
                set(ref, 0)
            end
            for i = 1, 90, 1 do
                local ref = "anim/blind/R/"..i
                set(ref, 0)
            end
        end
        if FMS_MODE == 4 and not cpxpPaxSeatBeltsPlayed and BELTS_SIGN == 2 then
            FF767.cpxpPlayBeltsOn()
            print("767CrewPack: Seatbelts selected on during descent")
            cpxpPaxSeatBeltsPlayed = true
        end
        --[[if gearDownPlayed and calloutTimer >=2 and not cpxpSeatsLandingPlayed then
            
            for i = 1, 90, 1 do
                local ref = "anim/blind/L/"..i
                set(ref, 0)
            end
            for i = 1, 90, 1 do
                local ref = "anim/blind/R/"..i
                set(ref, 0)
            end
            print("767CrewPack: Played seats for landing")
            cpxpSeatsLandingPlayed = true
        end]]
        if cpxp_WEIGHT_ON_WHEELS == 1 and cpxpFlightOccoured and not cpxpFaTaxiInPaPlayed and cpxp_IAS <= 30 then
            FF767snd.cpxpPlayTaxiInPa()
            for i = 1, 90, 1 do
                local ref = "anim/blind/L/"..i
                set(ref, 0)
            end
            for i = 1, 90, 1 do
                local ref = "anim/blind/R/"..i
                set(ref, 0)
            end
            print("767CrewPack: After landing PA")      
            faTaxiInPaPlayed = true       
        end
    end
end

