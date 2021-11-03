--[[
PersistenceXP data file for Carenado PC12 / Citation 550
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")

local pxpSwitchData = {}

-- Carenado Citation II / Carenado PC12
local pxp_LYOKE = nil
local pxp_RYOKE = nil
local pxp_LARM = nil
local pxp_RARM = nil
local pxp_PNL_LT = nil
local pxp_FLOOD_LT = nil
local pxp_PNL_LFT = nil
local pxp_PNL_CTR = nil
local pxp_PNL_RT = nil
local pxp_PNL_EL = nil
local pxp_INV = nil
local pxp_WREFL = nil
local pxp_IREFL = nil
local pxp_COVERS = nil
local pxp_VOLT_SEL = nil
local pxp_TEST_SEL = nil
local pxp_FUEL_SEL = nil
local pxp_RECOG = nil
local pxp_BARO_UNIT = nil
local pxp_N1_DIAL = nil
local pxp_L_LND = nil
local pxp_R_LND = nil
local pxp_ASKID = nil
local pxp_TEMP_MAN = nil
local pxp_TEMP_CTRL = nil
local pxp_PRES_SRC = nil
local pxp_FLOW_DIST = nil
local pxp_L_WS = nil
local pxp_R_WS = nil
local pxp_CAB_FAN1 = nil
local pxp_CAB_FAN2 = nil
local pxp_CAB_FOG = nil
local pxp_AC = nil
local pxp_BLWR = nil
local pxp_CAB_VNT = nil
local pxp_NAV_IDENT = nil
local pxp_MIC_SEL = nil
-- Carenado PC12
local pxp_LVISARM = nil
local pxp_LVIS = nil
local pxp_RVISARM = nil
local pxp_RVIS = nil

function pxpCompile()
   if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeL") ~= nil) then
      pxp_LYOKE = get("thranda/cockpit/actuators/HideYokeL")
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeR") ~= nil) then
      pxp_RYOKE = get("thranda/cockpit/actuators/HideYokeR")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestLR") ~= nil) then
      pxp_LARM = get("thranda/cockpit/animations/ArmRestLR")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestRL") ~= nil) then
      pxp_RARM = get("thranda/cockpit/animations/ArmRestRL")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/generic_lights_switch", 30) ~= nil) then
      pxp_PNL_LT = get("sim/cockpit2/switches/generic_lights_switch", 30)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 1) ~= nil) then
      pxp_FLOOD_LT = get("sim/cockpit2/switches/instrument_brightness_ratio", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 2) ~= nil) then
      pxp_PNL_LFT = get("sim/cockpit2/switches/instrument_brightness_ratio", 2)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 3) ~= nil) then
      pxp_PNL_CTR = get("sim/cockpit2/switches/instrument_brightness_ratio", 3)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 4) ~= nil) then
      pxp_PNL_RT = get("sim/cockpit2/switches/instrument_brightness_ratio", 4)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 5) ~= nil) then
      pxp_PNL_EL = get("sim/cockpit2/switches/instrument_brightness_ratio", 5)
   end
   if (XPLMFindDataRef("thranda/electrical/AC_InverterSwitch") ~= nil) then -- Inverter
      pxp_INV = get("thranda/electrical/AC_InverterSwitch")
   end
   if (XPLMFindDataRef("thranda/views/WindowRefl") ~= nil) then -- Window Reflections
      pxp_WREFL = get("thranda/views/WindowRefl")
   end
   if (XPLMFindDataRef("thranda/views/InstRefl") ~= nil) then -- Instrument Reflections
      pxp_IREFL = get("thranda/views/InstRefl")
   end
   if (XPLMFindDataRef("thranda/views/staticelements") ~= nil) then -- Pitot Covers etc.
      pxp_COVERS = get("thranda/views/staticelements")
   end
   if (XPLMFindDataRef("thranda/actuators/VoltSelAct") ~= nil) then -- Volt Meter
      pxp_VOLT_SEL = get("thranda/actuators/VoltSelAct")
   end
   if (XPLMFindDataRef("thranda/annunciators/AnnunTestKnob") ~= nil) then -- Annun Test
      pxp_TEST_SEL = get("thranda/annunciators/AnnunTestKnob")
   end
   if (XPLMFindDataRef("thranda/fuel/CrossFeedLRSw") ~= nil) then
      pxp_FUEL_SEL = get("thranda/fuel/CrossFeedLRSw")
   end
   if (XPLMFindDataRef("thranda/lights/RecogLights") ~= nil) then
      pxp_RECOG = get("thranda/lights/RecogLights")
   end
   if (XPLMFindDataRef("thranda/instruments/BaroUnits") ~= nil) then
      pxp_BARO_UNIT = get("thranda/instruments/BaroUnits")
   end
   if (XPLMFindDataRef("thranda/knobs/N1_Dial") ~= nil) then
      pxp_N1_DIAL = get("thranda/knobs/N1_Dial")
   end
   if (XPLMFindDataRef("thranda/lights/LandingLightLeft") ~= nil) then
      pxp_L_LND = get("thranda/lights/LandingLightLeft")
   end
   if (XPLMFindDataRef("thranda/lights/LandingLightRight") ~= nil) then
      pxp_R_LND = get("thranda/lights/LandingLightRight")
   end
   if (XPLMFindDataRef("thranda/gear/AntiSkid") ~= nil) then
      pxp_ASKID = get("thranda/gear/AntiSkid")
   end
   if (XPLMFindDataRef("thranda/BT", 22) ~= nil) then
      pxp_TEMP_MAN = get("thranda/BT", 22)
   end
   if (XPLMFindDataRef("thranda/pneumatic/CabinTempAct") ~= nil) then
      pxp_TEMP_CTRL = get("thranda/pneumatic/CabinTempAct")
   end
   if (XPLMFindDataRef("thranda/pneumatic/PressureSource") ~= nil) then
      pxp_PRES_SRC = get("thranda/pneumatic/PressureSource")
   end
   if (XPLMFindDataRef("thranda/pneumatic/AirFlowDistribution") ~= nil) then
      pxp_FLOW_DIST = get("thranda/pneumatic/AirFlowDistribution")
   end
   if (XPLMFindDataRef("thranda/ice/WindshieldIceL") ~= nil) then
      pxp_L_WS = get("thranda/ice/WindshieldIceL")
   end
   if (XPLMFindDataRef("thranda/ice/WindshieldIceR") ~= nil) then
      pxp_R_WS = get("thranda/ice/WindshieldIceR")
   end
   if (XPLMFindDataRef("thranda/BT", 23) ~= nil) then
      pxp_CAB_FAN1 = get("thranda/BT", 23)
   end
   if (XPLMFindDataRef("thranda/pneumatic/CabinFan") ~= nil) then
      pxp_CAB_FAN2 = get("thranda/pneumatic/CabinFan")
   end
   if (XPLMFindDataRef("thranda/BT", 24) ~= nil) then
      pxp_CAB_FOG = get("thranda/BT", 24)
   end
   if (XPLMFindDataRef("thranda/pneumatic/AC") ~= nil) then
      pxp_AC = get("thranda/pneumatic/AC")
   end
   if (XPLMFindDataRef("thranda/pneumatic/BlowerIntensity") ~= nil) then
      pxp_BLWR = get("thranda/pneumatic/BlowerIntensity")
   end
   if (XPLMFindDataRef("thranda/pneumatic/CabinVent") ~= nil) then
      pxp_CAB_VNT = get("thranda/pneumatic/CabinVent")
   end
   if (XPLMFindDataRef("thranda/BT", 2) ~= nil) then
      pxp_NAV_IDENT = get("thranda/BT", 2)
   end
   if (XPLMFindDataRef("thranda/BT", 32) ~= nil) then
      pxp_MIC_SEL = get("thranda/BT", 32)
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/VisorSwingL") ~= nil) then
      pxp_LVISARM = get("thranda/cockpit/actuators/VisorSwingL")
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/VisorL") ~= nil) then
      pxp_LVIS = get("thranda/cockpit/actuators/VisorL")
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/VisorSwingR") ~= nil) then
      pxp_RVISARM = get("thranda/cockpit/actuators/VisorSwingR")
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/VisorR") ~= nil) then
      pxp_RVIS = get("thranda/cockpit/actuators/VisorR")
   end

   pxpSwitchData = {
      PersistenceData = {
         pxp_LYOKE = pxp_LYOKE,
         pxp_RYOKE = pxp_RYOKE,
         pxp_LARM = pxp_LARM,
         pxp_RARM = pxp_RARM,
         pxp_PNL_LT = pxp_PNL_LT,
         pxp_FLOOD_LT = pxp_FLOOD_LT,
         pxp_PNL_LFT = pxp_PNL_LFT,
         pxp_PNL_CTR = pxp_PNL_CTR,
         pxp_PNL_RT = pxp_PNL_RT,
         pxp_PNL_EL = pxp_PNL_EL,
         pxp_INV = pxp_INV,
         pxp_WREFL = pxp_WREFL,
         pxp_IREFL = pxp_IREFL,
         pxp_COVERS = pxp_COVERS,
         pxp_VOLT_SEL = pxp_VOLT_SEL,
         pxp_TEST_SEL = pxp_TEST_SEL,
         pxp_FUEL_SEL = pxp_FUEL_SEL,
         pxp_RECOG = pxp_RECOG,
         pxp_BARO_UNIT = pxp_BARO_UNIT,
         pxp_N1_DIAL = pxp_N1_DIAL,
         pxp_L_LND = pxp_L_LND,
         pxp_R_LND = pxp_R_LND,
         pxp_ASKID = pxp_ASKID,
         pxp_TEMP_MAN = pxp_TEMP_MAN,
         pxp_TEMP_CTRL = pxp_TEMP_CTRL,
         pxp_PRES_SRC = pxp_PRES_SRC,
         pxp_FLOW_DIST = pxp_FLOW_DIST,
         pxp_L_WS = pxp_L_WS,
         pxp_R_WS = pxp_R_WS,
         pxp_CAB_FAN1 = pxp_CAB_FAN1,
         pxp_CAB_FAN2 = pxp_CAB_FAN2,
         pxp_CAB_FOG = pxp_CAB_FOG,
         pxp_AC = pxp_AC,
         pxp_BLWR = pxp_BLWR,
         pxp_CAB_VNT = pxp_CAB_VNT,
         pxp_NAV_IDENT = pxp_NAV_IDENT,
         pxp_MIC_SEL = pxp_MIC_SEL,
         -- Carenado PC12
         pxp_LVISARM = pxp_LVISARM,
         pxp_LVIS = pxp_LVIS,
         pxp_RVISARM = pxp_RVISARM,
         pxp_RVIS = pxp_RVIS,
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceCar12550.ini", pxpSwitchData)
   print("PersistenceXP Carenado PC12 / C550 Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceCar12550.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceCar12550.ini")

      if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_LYOKE ~= nil then
            set("thranda/cockpit/actuators/HideYokeL", pxpSwitchData.PersistenceData.pxp_LYOKE)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeR") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_RYOKE ~= nil then
            set("thranda/cockpit/actuators/HideYokeR", pxpSwitchData.PersistenceData.pxp_RYOKE)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestLR") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_LARM ~= nil then
            set("thranda/cockpit/animations/ArmRestLR", pxpSwitchData.PersistenceData.pxp_LARM) -- Left Arm Rests
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestRL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_RARM ~= nil then
            set("thranda/cockpit/animations/ArmRestRL", pxpSwitchData.PersistenceData.pxp_RARM) -- Right Arm Rest
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/generic_lights_switch", 30) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PNL_LT ~= nil then
            set_array("sim/cockpit2/switches/generic_lights_switch", 30, pxpSwitchData.PersistenceData.pxp_PNL_LT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_FLOOD_LT ~= nil then
            set_array("sim/cockpit2/switches/instrument_brightness_ratio", 1, pxpSwitchData.PersistenceData.pxp_FLOOD_LT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PNL_LFT ~= nil then
            set_array("sim/cockpit2/switches/instrument_brightness_ratio", 2, pxpSwitchData.PersistenceData.pxp_PNL_LFT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 3) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PNL_CTR ~= nil then
            set_array("sim/cockpit2/switches/instrument_brightness_ratio", 3, pxpSwitchData.PersistenceData.pxp_PNL_CTR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 4) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PNL_RT ~= nil then
            set_array("sim/cockpit2/switches/instrument_brightness_ratio", 4, pxpSwitchData.PersistenceData.pxp_PNL_RT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/instrument_brightness_ratio", 5) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PNL_EL ~= nil then
            set_array("sim/cockpit2/switches/instrument_brightness_ratio", 5, pxpSwitchData.PersistenceData.pxp_PNL_EL)
         end
      end
      if (XPLMFindDataRef("thranda/electrical/AC_InverterSwitch") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_INV ~= nil then
            set("thranda/electrical/AC_InverterSwitch", pxpSwitchData.PersistenceData.pxp_INV)
         end
      end
      if (XPLMFindDataRef("thranda/views/WindowRefl") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_WREFL ~= nil then
            set("thranda/views/WindowRefl", pxpSwitchData.PersistenceData.pxp_WREFL)
         end
      end
      if (XPLMFindDataRef("thranda/views/InstRefl") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_IREFL ~= nil then
            set("thranda/views/InstRefl", pxpSwitchData.PersistenceData.pxp_IREFL)
         end
      end
      if (XPLMFindDataRef("thranda/views/staticelements") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_COVERS ~= nil then
            set("thranda/views/staticelements", pxpSwitchData.PersistenceData.pxp_COVERS)
         end
      end
      if (XPLMFindDataRef("thranda/actuators/VoltSelAct") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_VOLT_SEL ~= nil then
            set("thranda/actuators/VoltSelAct", pxpSwitchData.PersistenceData.pxp_VOLT_SEL)
         end
      end
      if (XPLMFindDataRef("thranda/annunciators/AnnunTestKnob") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_TEST_SEL ~= nil then
            set("thranda/annunciators/AnnunTestKnob", pxpSwitchData.PersistenceData.pxp_TEST_SEL)
         end
      end
      if (XPLMFindDataRef("thranda/fuel/CrossFeedLRSw") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_FUEL_SEL ~= nil then
            set("thranda/fuel/CrossFeedLRSw", pxpSwitchData.PersistenceData.pxp_FUEL_SEL)
         end
      end
      if (XPLMFindDataRef("thranda/lights/RecogLights") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_RECOG ~= nil then
            set("thranda/lights/RecogLights", pxpSwitchData.PersistenceData.pxp_RECOG)
         end
      end
      if (XPLMFindDataRef("thranda/instruments/BaroUnits") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_BARO_UNIT ~= nil then
            set("thranda/instruments/BaroUnits", pxpSwitchData.PersistenceData.pxp_BARO_UNIT)
         end
      end
      if (XPLMFindDataRef("thranda/knobs/N1_Dial") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_N1_DIAL ~= nil then
            set("thranda/knobs/N1_Dial", pxpSwitchData.PersistenceData.pxp_N1_DIAL)
         end
      end
      if (XPLMFindDataRef("thranda/lights/LandingLightLeft") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_L_LND ~= nil then
            set("thranda/lights/LandingLightLeft", pxpSwitchData.PersistenceData.pxp_L_LND)
         end
      end
      if (XPLMFindDataRef("thranda/lights/LandingLightRight") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_R_LND ~= nil then
            set("thranda/lights/LandingLightRight", pxpSwitchData.PersistenceData.pxp_R_LND)
         end
      end
      if (XPLMFindDataRef("thranda/gear/AntiSkid") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_ASKID ~= nil then
            set("thranda/gear/AntiSkid", pxpSwitchData.PersistenceData.pxp_ASKID)
         end
      end
      if (XPLMFindDataRef( "thranda/BT", 22) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_TEMP_MAN ~= nil then
            set_array( "thranda/BT", 22, pxpSwitchData.PersistenceData.pxp_TEMP_MAN)
         end
      end
      if (XPLMFindDataRef( "thranda/BT", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_NAV_IDENT ~= nil then
            set_array( "thranda/BT", 2, pxpSwitchData.PersistenceData.pxp_NAV_IDENT)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/CabinTempAct") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_TEMP_CTRL ~= nil then
            set("thranda/pneumatic/CabinTempAct", pxpSwitchData.PersistenceData.pxp_TEMP_CTRL)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/PressureSource") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_PRES_SRC ~= nil then
            set("thranda/pneumatic/PressureSource", pxpSwitchData.PersistenceData.pxp_PRES_SRC)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/AirFlowDistribution") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_FLOW_DIST ~= nil then
            set("thranda/pneumatic/AirFlowDistribution", pxpSwitchData.PersistenceData.pxp_FLOW_DIST)
         end
      end
      if (XPLMFindDataRef("thranda/ice/WindshieldIceL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_L_WS ~= nil then
            set("thranda/ice/WindshieldIceL", pxpSwitchData.PersistenceData.pxp_L_WS)
         end
      end
      if (XPLMFindDataRef("thranda/ice/WindshieldIceR") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_R_WS ~= nil then
            set("thranda/ice/WindshieldIceR", pxpSwitchData.PersistenceData.pxp_R_WS)
         end
      end
      if (XPLMFindDataRef( "thranda/BT", 23) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_CAB_FAN1 ~= nil then
            set_array( "thranda/BT", 23, pxpSwitchData.PersistenceData.pxp_CAB_FAN1)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/CabinFan") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_CAB_FAN2 ~= nil then
            set("thranda/pneumatic/CabinFan", pxpSwitchData.PersistenceData.pxp_CAB_FAN2)
         end
      end
      if (XPLMFindDataRef( "thranda/BT", 24) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_CAB_FOG ~= nil then
            set_array( "thranda/BT", 24, pxpSwitchData.PersistenceData.pxp_CAB_FOG)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/AC") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_AC ~= nil then
            set("thranda/pneumatic/AC", pxpSwitchData.PersistenceData.pxp_AC)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/BlowerIntensity") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_BLWR ~= nil then
            set("thranda/pneumatic/BlowerIntensity", pxpSwitchData.PersistenceData.pxp_BLWR)
         end
      end
      if (XPLMFindDataRef("thranda/pneumatic/CabinVent") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_CAB_VNT ~= nil then
            set("thranda/pneumatic/CabinVent", pxpSwitchData.PersistenceData.pxp_CAB_VNT)
         end
      end
      if (XPLMFindDataRef( "thranda/BT", 32) ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_MIC_SEL ~= nil then
            set_array( "thranda/BT", 32, pxpSwitchData.PersistenceData.pxp_MIC_SEL)
         end
      end
      if ENG1_RUN == 1 and pxpSwitchData.PersistenceData.ENG1_RUN == 0 then
         if (XPLMFindDataRef("thranda/cockpit/ThrottleLatchAnim_0") ~= nil) then
            set("thranda/cockpit/ThrottleLatchAnim_0", 0.5)
            print("Command Shut 1")
         end
      end
      if ENG2_RUN == 1 and pxpSwitchData.PersistenceData.ENG1_RUN == 0 then
         if (XPLMFindDataRef("thranda/cockpit/ThrottleLatchAnim_1") ~= nil) then
            set("thranda/cockpit/ThrottleLatchAnim_1", 0.5)
            print("Command Shut 2")
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/VisorSwingL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_LVISARM ~= nil then
            set("thranda/cockpit/actuators/VisorSwingL", pxpSwitchData.PersistenceData.pxp_LVISARM)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/VisorL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_LVIS ~= nil then
            set("thranda/cockpit/actuators/VisorL", pxpSwitchData.PersistenceData.pxp_LVIS)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/VisorSwingL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_RVISARM ~= nil then
            set("thranda/cockpit/actuators/VisorSwingR", pxpSwitchData.PersistenceData.pxp_RVISARM)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/VisorL") ~= nil) then
         if pxpSwitchData.PersistenceData.pxp_RVIS ~= nil then
            set("thranda/cockpit/actuators/VisorR", pxpSwitchData.PersistenceData.pxp_RVIS)
         end
      end
      print("PersistenceXP Carenado PC12 / C550 Panel State Loaded")
   end
end