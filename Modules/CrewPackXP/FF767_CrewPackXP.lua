--[[
CrewPackXP Aircraft File Flight Factor 767 / 757
]]

local cpxpData = {}
local cpxpModuleReady = false


function cpxpData.cpxpAircraftDelay()
    if (XPLMFindDataRef("anim/17/button") == nil) then
        return false
    else
        print("CrewPackXP 767 initialised")
        cpxpModuleReady = true
        return true
    end
end

-- Initialise Refs

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


 



return cpxpData
