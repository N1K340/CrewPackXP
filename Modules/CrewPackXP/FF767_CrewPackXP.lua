--[[
CrewPackXP Aircraft File Flight Factor 767 / 757
]]

module(..., package.seeall)

local cpxp_aircraftReady = false

function cpxpAircraftDelay()
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
    if not cpxp_aircraftReady then
        cpxp_aircraftReady = true
        print("CrewPackXP 767 initialised")
        print("Module: " .. cpxp_aircraftReady)
    end
end
