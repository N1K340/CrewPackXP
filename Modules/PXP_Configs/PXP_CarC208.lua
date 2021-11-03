--[[
PersistenceXP data file for Carenado C208HD / C208EX
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")

local pxpSwitchData = {}

local CARGOPOD = nil
local LYOKE = nil
local RYOKE = nil
local LARM = nil
local RARM = nil
local BOOST_PMP1 = nil
local STB_PWR = nil
local IGN1 = nil
local STRT1 = nil
local DCAMP = nil
local WING_LT = nil
local AC = nil
local CAB_FAN1 = nil
local CAB_FAN2 = nil
local CAB_FAN3 = nil
local TEMP_CTRL = nil
local PNL_LT = nil
local CAB_LT = nil
local ANNUN_DIM = nil
local THRTL = nil
local PROP = nil
local FUEL_SEL_L = nil
local FUEL_SEL_R = nil
--
local PROP_HEAT = nil
local CAB_UTIL = nil
local STALL_HT = nil
local FLOOD_LFT = nil
local FLOOD_RT = nil
local BLEED_AIR = nil


function pxpCompile()
   if (XPLMFindDataRef("com/dkmp/cargopod") ~= nil) then
      CARGOPOD = get("com/dkmp/cargopod")
   end
   if (XPLMFindDataRef("Carenado/Switch/Dummy/Dummy1") ~= nil) then
      LYOKE = get("Carenado/Switch/Dummy/Dummy1")
   end
   if (XPLMFindDataRef("Carenado/Switch/Dummy/Dummy2") ~= nil) then
      RYOKE = get("Carenado/Switch/Dummy/Dummy2")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestLR") ~= nil) then
      LARM = get("thranda/cockpit/animations/ArmRestLR")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestRL") ~= nil) then
      RARM = get("thranda/cockpit/animations/ArmRestRL")
   end
   if (XPLMFindDataRef("com/dkmp/FuelBoost") ~= nil) then
      BOOST_PMP1 = get("com/dkmp/FuelBoost")
   end
   if (XPLMFindDataRef("com/dkmp/StbyPwr") ~= nil) then
      STB_PWR = get("com/dkmp/StbyPwr")
   end
   if (XPLMFindDataRef("com/dkmp/Ignition") ~= nil) then
      IGN1 = get("com/dkmp/Ignition")
   end
   if (XPLMFindDataRef("com/dkmp/Starter") ~= nil) then
      STRT1 = get("com/dkmp/Starter")
   end
   if (XPLMFindDataRef("com/dkmp/AmpsVoltsSwitch") ~= nil) then
      DCAMP = get("com/dkmp/AmpsVoltsSwitch")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/generic_lights_switch", 30) ~= nil) then
      WING_LT = get("sim/cockpit2/switches/generic_lights_switch", 30)
   end
   if (XPLMFindDataRef("com/dkmp/Ventilate") ~= nil) then
      AC = get("com/dkmp/Ventilate")
   end
   if (XPLMFindDataRef("com/dkmp/ACFansLeft") ~= nil) then
      CAB_FAN1 = get("com/dkmp/ACFansLeft")
   end
   if (XPLMFindDataRef("com/dkmp/ACFansRight") ~= nil) then
      CAB_FAN2 = get("com/dkmp/ACFansRight")
   end
   if (XPLMFindDataRef("com/dkmp/ACFansAft") ~= nil) then
      CAB_FAN3 = get("com/dkmp/ACFansAft")
   end
   if (XPLMFindDataRef("com/dkmp/TempHot") ~= nil) then
      TEMP_CTRL = get("com/dkmp/TempHot")
   end
   if (XPLMFindDataRef("com/dkmp/PanelLit") ~= nil) then
      PNL_LT = get("com/dkmp/PanelLit")
   end
   if (XPLMFindDataRef("Carenado/lights/CortesyLight") ~= nil) then
      CAB_LT = get("Carenado/lights/CortesyLight")
   end
   if (XPLMFindDataRef("com/dkmp/AnnunLITsw") ~= nil) then
      ANNUN_DIM = get("com/dkmp/AnnunLITsw")
   end
   if (XPLMFindDataRef("com/dkmp/Throttle") ~= nil) then
      THRTL = get("com/dkmp/Throttle")
   end
   if (XPLMFindDataRef("sim/flightmodel/engine/ENGN_prop", 0) ~= nil) then
      PROP = get("sim/flightmodel/engine/ENGN_prop", 0)
   end
   if (XPLMFindDataRef("com/dkmp/FuelSwL") ~= nil) then
      FUEL_SEL_L = get("com/dkmp/FuelSwL")
   end
   if (XPLMFindDataRef("com/dkmp/FuelSwR") ~= nil) then
      FUEL_SEL_R = get("com/dkmp/FuelSwR")
   end

   -- C208 EX
   if (XPLMFindDataRef("Carenado/visibilities/CargoPod") ~= nil) then
      CARGOPOD = get("Carenado/visibilities/CargoPod")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/PropHeat") ~= nil) then
      PROP_HEAT = get("Carenado/Switch/dummy/PropHeat")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/PowerOutlet") ~= nil) then
      CAB_UTIL = get("Carenado/Switch/dummy/PowerOutlet")
   end
   if (XPLMFindDataRef("Carenado/Heat/StallHeat") ~= nil) then
      STALL_HT = get("Carenado/Heat/StallHeat")
   end
   if (XPLMFindDataRef("Carenado/lights/WingLight") ~= nil) then
      WING_LT = get("Carenado/lights/WingLight")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/FuelBoost") ~= nil) then
      BOOST_PMP1 = get("Carenado/Switch/dummy/FuelBoost")
   end
   if (XPLMFindDataRef("Carenado/battery/StbyBatt") ~= nil) then
      STB_PWR = get("Carenado/battery/StbyBatt")
   end
   if (XPLMFindDataRef("Carenado/Switch/Ignition") ~= nil) then
      IGN1 = get("Carenado/Switch/Ignition")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/Starter") ~= nil) then
      STRT1 = get("Carenado/Switch/dummy/Starter")
   end
   if (XPLMFindDataRef("Carenado/lights/leftFloodLight") ~= nil) then
      FLOOD_LFT = get("Carenado/lights/leftFloodLight")
   end
   if (XPLMFindDataRef("Carenado/lights/rightFloodLight") ~= nil) then
      FLOOD_RT = get("Carenado/lights/rightFloodLight")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioning") ~= nil) then
      AC = get("Carenado/Switch/dummy/AirConditioning")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningLeft") ~= nil) then
      CAB_FAN1 = get("Carenado/Switch/dummy/AirConditioningLeft")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningRigth") ~= nil) then
      CAB_FAN2 = get("Carenado/Switch/dummy/AirConditioningRigth")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningAft") ~= nil) then
      CAB_FAN3 = get("Carenado/Switch/dummy/AirConditioningAft")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/TempBleedAir") ~= nil) then
      TEMP_CTRL = get("Carenado/Switch/dummy/TempBleedAir")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/BleedAir") ~= nil) then
      BLEED_AIR = get("Carenado/Switch/dummy/BleedAir")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/FuelSelectorL") ~= nil) then
      FUEL_SEL_L = get("Carenado/Switch/dummy/FuelSelectorL")
   end
   if (XPLMFindDataRef("Carenado/Switch/dummy/FuelSelectorR") ~= nil) then
      FUEL_SEL_R = get("Carenado/Switch/dummy/FuelSelectorR")
   end
   if (XPLMFindDataRef("Carenado/Cockpit/RestArmL") ~= nil) then
      LARM = get("Carenado/Cockpit/RestArmL")
   end
   if (XPLMFindDataRef("Carenado/Cockpit/RestArmR") ~= nil) then
      RARM = get("Carenado/Cockpit/RestArmR")
   end

   pxpSwitchData = {
      PersistenceData = {
         CARGOPOD = CARGOPOD,
         LYOKE = LYOKE,
         RYOKE = RYOKE,
         LARM = LARM,
         RARM = RARM,
         BOOST_PMP1 = BOOST_PMP1,
         STB_PWR = STB_PWR,
         IGN1 = IGN1,
         STRT1 = STRT1,
         DCAMP = DCAMP,
         WING_LT = WING_LT,
         AC = AC,
         CAB_FAN1 = CAB_FAN1,
         CAB_FAN2 = CAB_FAN2,
         CAB_FAN3 = CAB_FAN3,
         TEMP_CTRL = TEMP_CTRL,
         PNL_LT = PNL_LT,
         CAB_LT = CAB_LT,
         ANNUN_DIM = ANNUN_DIM,
         THRTL = THRTL,
         PROP = PROP,
         FUEL_SEL_L = FUEL_SEL_L,
         FUEL_SEL_R = FUEL_SEL_R,
      --
         PROP_HEAT = PROP_HEAT,
         CAB_UTIL = CAB_UTIL,
         STALL_HT = STALL_HT,
         FLOOD_LFT = FLOOD_LFT,
         FLOOD_RT = FLOOD_RT,
         BLEED_AIR = BLEED_AIR,
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceCar208.ini", pxpSwitchData)
   print("PersistenceXP Carenado C208 Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceCar208.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceCar208.ini")

      if (XPLMFindDataRef("Carenado/Switch/Dummy/Dummy1") ~= nil) then
         if pxpSwitchData.PersistenceData.LYOKE ~= nil then
            set("Carenado/Switch/Dummy/Dummy1", pxpSwitchData.PersistenceData.LYOKE)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/Dummy/Dummy2") ~= nil) then
         if pxpSwitchData.PersistenceData.RYOKE ~= nil then
            set("Carenado/Switch/Dummy/Dummy2", pxpSwitchData.PersistenceData.RYOKE)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestLR") ~= nil) then
         if pxpSwitchData.PersistenceData.LARM ~= nil then
            set("thranda/cockpit/animations/ArmRestLR", pxpSwitchData.PersistenceData.LARM) -- Left Arm Rests
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestRL") ~= nil) then
         if pxpSwitchData.PersistenceData.RARM ~= nil then
            set("thranda/cockpit/animations/ArmRestRL", pxpSwitchData.PersistenceData.RARM) -- Right Arm Rest
         end
      end
      if (XPLMFindDataRef("com/dkmp/cargopod") ~= nil) then
         if pxpSwitchData.PersistenceData.CARGOPOD ~= nil then
            set("com/dkmp/cargopod", pxpSwitchData.PersistenceData.CARGOPOD)
         end
      end
      if (XPLMFindDataRef("com/dkmp/FuelBoost") ~= nil) then
         if pxpSwitchData.PersistenceData.BOOST_PMP1 ~= nil then
            set("com/dkmp/FuelBoost", pxpSwitchData.PersistenceData.BOOST_PMP1)
         end
      end
      if (XPLMFindDataRef("com/dkmp/StbyPwr") ~= nil) then
         if pxpSwitchData.PersistenceData.STB_PWR ~= nil then
            set("com/dkmp/StbyPwr", pxpSwitchData.PersistenceData.STB_PWR)
         end
      end
      if (XPLMFindDataRef("com/dkmp/Ignition") ~= nil) then
         if pxpSwitchData.PersistenceData.IGN1 ~= nil then
            set("com/dkmp/Ignition", pxpSwitchData.PersistenceData.IGN1)
         end
      end
      if (XPLMFindDataRef("com/dkmp/Starter") ~= nil) then
         if pxpSwitchData.PersistenceData.STRT1 ~= nil then
            set("com/dkmp/Starter", pxpSwitchData.PersistenceData.STRT1)
         end
      end
      if (XPLMFindDataRef("com/dkmp/AmpsVoltsSwitch") ~= nil) then
         if pxpSwitchData.PersistenceData.DCAMP ~= nil then
            set("com/dkmp/AmpsVoltsSwitch", pxpSwitchData.PersistenceData.DCAMP)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/generic_lights_switch", 30) ~= nil) then
         if pxpSwitchData.PersistenceData.WING_LT ~= nil then
            set_array("sim/cockpit2/switches/generic_lights_switch", 30, pxpSwitchData.PersistenceData.WING_LT)
         end
      end
      if (XPLMFindDataRef("com/dkmp/Ventilate") ~= nil) then
         if pxpSwitchData.PersistenceData.AC ~= nil then
            set("com/dkmp/Ventilate", pxpSwitchData.PersistenceData.AC)
         end
      end
      if (XPLMFindDataRef("com/dkmp/ACFansLeft") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN1 ~= nil then
            set("com/dkmp/ACFansLeft", pxpSwitchData.PersistenceData.CAB_FAN1)
         end
      end
      if (XPLMFindDataRef("com/dkmp/ACFansRight") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN2 ~= nil then
            set("com/dkmp/ACFansRight", pxpSwitchData.PersistenceData.CAB_FAN2)
         end
      end
      if (XPLMFindDataRef("com/dkmp/ACFansAft") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN3 ~= nil then
            set("com/dkmp/ACFansAft", pxpSwitchData.PersistenceData.CAB_FAN3)
         end
      end
      if (XPLMFindDataRef("com/dkmp/TempHot") ~= nil) then
         if pxpSwitchData.PersistenceData.TEMP_CTRL ~= nil then
            set("com/dkmp/TempHot", pxpSwitchData.PersistenceData.TEMP_CTRL)
         end
      end
      if (XPLMFindDataRef("com/dkmp/PanelLit") ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT ~= nil then
            set("com/dkmp/PanelLit", pxpSwitchData.PersistenceData.PNL_LT)
         end
      end
      if (XPLMFindDataRef("com/dkmp/AnnunLITsw") ~= nil) then
         if pxpSwitchData.PersistenceData.ANNUN_DIM ~= nil then
            set("com/dkmp/AnnunLITsw", pxpSwitchData.PersistenceData.ANNUN_DIM)
         end
      end
      if (XPLMFindDataRef("com/dkmp/Throttle") ~= nil) then
         if pxpSwitchData.PersistenceData.THRTL ~= nil then
            set("com/dkmp/Throttle", pxpSwitchData.PersistenceData.THRTL)
         end
      end
      if (XPLMFindDataRef("sim/flightmodel/engine/ENGN_prop") ~= nil) then
         if pxpSwitchData.PersistenceData.PROP ~= nil then
            set_array("sim/flightmodel/engine/ENGN_prop", 0, pxpSwitchData.PersistenceData.PROP)
         end
      end
      if (XPLMFindDataRef("com/dkmp/FuelSwL") ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL_SEL_L ~= nil then
            set("com/dkmp/FuelSwL", pxpSwitchData.PersistenceData.FUEL_SEL_L)
         end
      end
      if (XPLMFindDataRef("com/dkmp/FuelSwR") ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL_SEL_R ~= nil then
            set("com/dkmp/FuelSwR", pxpSwitchData.PersistenceData.FUEL_SEL_R)
         end
      end



      -- C208 EX
      if (XPLMFindDataRef("Carenado/visibilities/CargoPod") ~= nil) then
         if pxpSwitchData.PersistenceData.CARGOPOD ~= nil then
            set("Carenado/visibilities/CargoPod", pxpSwitchData.PersistenceData.CARGOPOD)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/PropHeat") ~= nil) then
         if pxpSwitchData.PersistenceData.PROP_HEAT ~= nil then
            set("Carenado/Switch/dummy/PropHeat", pxpSwitchData.PersistenceData.PROP_HEAT)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/PowerOutlet") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_UTIL ~= nil then
            set("Carenado/Switch/dummy/PowerOutlet", pxpSwitchData.PersistenceData.CAB_UTIL)
         end
      end
      if (XPLMFindDataRef("Carenado/lights/CortesyLight") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_LT ~= nil then
            set("Carenado/lights/CortesyLight", pxpSwitchData.PersistenceData.CAB_LT)
         end
      end
      if (XPLMFindDataRef("Carenado/Heat/StallHeat") ~= nil) then
         if pxpSwitchData.PersistenceData.STALL_HT ~= nil then
            set("Carenado/Heat/StallHeat", pxpSwitchData.PersistenceData.STALL_HT)
         end
      end
      if (XPLMFindDataRef("Carenado/lights/WingLight") ~= nil) then
         if pxpSwitchData.PersistenceData.WING_LT ~= nil then
            set("Carenado/lights/WingLight", pxpSwitchData.PersistenceData.WING_LT)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/FuelBoost") ~= nil) then
         if pxpSwitchData.PersistenceData.BOOST_PMP1 ~= nil then
            set("Carenado/Switch/dummy/FuelBoost", pxpSwitchData.PersistenceData.BOOST_PMP1)
         end
      end
      if (XPLMFindDataRef("Carenado/battery/StbyBatt") ~= nil) then
         if pxpSwitchData.PersistenceData.STB_PWR ~= nil then
            set("Carenado/battery/StbyBatt", pxpSwitchData.PersistenceData.STB_PWR)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/Ignition") ~= nil) then
         if pxpSwitchData.PersistenceData.IGN1 ~= nil then
            set("Carenado/Switch/Ignition", pxpSwitchData.PersistenceData.IGN1)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/Starter") ~= nil) then
         if pxpSwitchData.PersistenceData.STRT1 ~= nil then
            set("Carenado/Switch/dummy/Starter", pxpSwitchData.PersistenceData.STRT1)
         end
      end
      if (XPLMFindDataRef("Carenado/lights/leftFloodLight") ~= nil) then
         if pxpSwitchData.PersistenceData.FLOOD_LFT ~= nil then
            set("Carenado/lights/leftFloodLight", pxpSwitchData.PersistenceData.FLOOD_LFT)
         end
      end
      if (XPLMFindDataRef("Carenado/lights/rightFloodLight") ~= nil) then
         if pxpSwitchData.PersistenceData.FLOOD_RT ~= nil then
            set("Carenado/lights/rightFloodLight", pxpSwitchData.PersistenceData.FLOOD_RT)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioning") ~= nil) then
         if pxpSwitchData.PersistenceData.AC ~= nil then
            set("Carenado/Switch/dummy/AirConditioning", pxpSwitchData.PersistenceData.AC)
         end
      end

      if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningLeft") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN1 ~= nil then
            set("Carenado/Switch/dummy/AirConditioningLeft", pxpSwitchData.PersistenceData.CAB_FAN1)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningRigth") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN2 ~= nil then
            set("Carenado/Switch/dummy/AirConditioningRigth", pxpSwitchData.PersistenceData.CAB_FAN2)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/AirConditioningAft") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_FAN3 ~= nil then
            set("Carenado/Switch/dummy/AirConditioningAft", pxpSwitchData.PersistenceData.CAB_FAN3)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/TempBleedAir") ~= nil) then
         if pxpSwitchData.PersistenceData.TEMP_CTRL ~= nil then
            set("Carenado/Switch/dummy/TempBleedAir", pxpSwitchData.PersistenceData.TEMP_CTRL)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/BleedAir") ~= nil) then
         if pxpSwitchData.PersistenceData.BLEED_AIR ~= nil then
            set("Carenado/Switch/dummy/BleedAir", pxpSwitchData.PersistenceData.BLEED_AIR)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/FuelSelectorL") ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL_SEL_L ~= nil then
            set("Carenado/Switch/dummy/FuelSelectorL", pxpSwitchData.PersistenceData.FUEL_SEL_L)
         end
      end
      if (XPLMFindDataRef("Carenado/Switch/dummy/FuelSelectorR") ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL_SEL_R ~= nil then
            set("Carenado/Switch/dummy/FuelSelectorR", pxpSwitchData.PersistenceData.FUEL_SEL_R)
         end
      end
      if (XPLMFindDataRef("Carenado/Cockpit/RestArmL") ~= nil) then
         if pxpSwitchData.PersistenceData.LARM ~= nil then
            set("Carenado/Cockpit/RestArmL", pxpSwitchData.PersistenceData.LARM) -- Left Arm Rests
         end
      end
      if (XPLMFindDataRef("Carenado/Cockpit/RestArmR") ~= nil) then
         if pxpSwitchData.PersistenceData.RARM ~= nil then
            set("Carenado/Cockpit/RestArmR", pxpSwitchData.PersistenceData.RARM) -- Right Arm Rest
         end
      end
      print("PersistenceXP Carenado C208 Panel State Loaded")
   end
end

