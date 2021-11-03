--[[
PersistenceXP data file for Default Aircraft
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")
local pxpSwitchData = {}

-- Deafult Electrical
local BAT = nil
local AVN = nil
local GENL = nil
local GENR = nil
local GENAPU = nil
local GPU = nil
-- Internal Lighting
local ST_BLT = nil
local NO_SMK = nil
local PNL_LT0 = nil
local PNL_LT1 = nil
local PNL_LT2 = nil
local PNL_LT3 = nil
local PNL_LT4 = nil
local PNL_LT5 = nil
local PNL_LT6 = nil
local PNL_LT7 = nil
local PNL_LT8 = nil
local PNL_LT9 = nil
-- Deafult Lighting
local Nav_LT = nil
local BCN = nil
local STROBE = nil
local LNDLIGHT = nil
local TAXILIGHT = nil
-- Doors
local DOOR0 = nil -- 0 Main, 1 Left Bag, 2 Right Bag
local DOOR1 = nil
local DOOR2 = nil


-- Engine
local IGN1 = nil
local IGN2 = nil
local MAG1 = nil
local MAG2 = nil
-- Fuel
local BOOST_PMP1 = nil
local BOOST_PMP2 = nil
local FUEL0 = nil
local FUEL1 = nil
local FUEL2 = nil
local FUEL3 = nil
local FUEL_TTL = nil


function pxpCompile()
   -- Deafult Electrical
   if (XPLMFindDataRef("sim/cockpit/electrical/battery_on") ~= nil) then
      BAT = get("sim/cockpit/electrical/battery_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/avionics_power_on") ~= nil) then
      AVN = get("sim/cockpit2/switches/avionics_power_on")
   end
   if (XPLMFindDataRef("sim/cockpit/electrical/generator_on", 0) ~= nil) then
      GENL = get("sim/cockpit/electrical/generator_on", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/electrical/generator_on", 1) ~= nil) then
      GENR = get("sim/cockpit/electrical/generator_on", 1)
   end
   if (XPLMFindDataRef("sim/cockpit/electrical/generator_apu_on") ~= nil) then
      GENAPU = get("sim/cockpit/electrical/generator_apu_on")
   end
   if (XPLMFindDataRef("sim/cockpit/electrical/gpu_on") ~= nil) then
      GPU = get("sim/cockpit/electrical/gpu_on")
   end

   -- Deafult Lighting

   if (XPLMFindDataRef("sim/cockpit2/switches/navigation_lights_on") ~= nil) then
      Nav_LT = get("sim/cockpit2/switches/navigation_lights_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/beacon_on") ~= nil) then
      BCN = get("sim/cockpit2/switches/beacon_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/strobe_lights_on") ~= nil) then
      STROBE = get("sim/cockpit2/switches/strobe_lights_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_on") ~= nil) then
      LNDLIGHT = get("sim/cockpit2/switches/landing_lights_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/taxi_light_on") ~= nil) then
      TAXILIGHT = get("sim/cockpit2/switches/taxi_light_on")
   end

   -- Doors

   if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 0) ~= nil) then
      DOOR0 = get("sim/cockpit2/switches/door_open", 0)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 1) ~= nil) then
      DOOR1 = get("sim/cockpit2/switches/door_open", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 2) ~= nil) then
      DOOR2 = get("sim/cockpit2/switches/door_open", 2)
   end






   -- Engine
   if (XPLMFindDataRef("sim/cockpit/engine/igniters_on", 0) ~= nil) then
      IGN1 = get("sim/cockpit/engine/igniters_on", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/engine/igniters_on", 1) ~= nil) then
      IGN2 = get("sim/cockpit/engine/igniters_on", 1)
   end
   if (XPLMFindDataRef("sim/cockpit/engine/ignition_on", 0) ~= nil) then
      MAG1 = get("sim/cockpit/engine/ignition_on", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/engine/ignition_on", 1) ~= nil) then
      MAG2 = get("sim/cockpit/engine/ignition_on", 1)
   end

   -- Fuel


   if (XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on", 0) ~= nil) then
      BOOST_PMP1 = get("sim/cockpit/engine/fuel_pump_on", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on", 1) ~= nil) then
      BOOST_PMP2 = get("sim/cockpit/engine/fuel_pump_on", 1)
   end
   if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 0) ~= nil) then
      FUEL0 = get("sim/flightmodel/weight/m_fuel", 0)
   end
   if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 1) ~= nil) then
      FUEL1 = get("sim/flightmodel/weight/m_fuel", 1)
   end
   if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 2) ~= nil) then
      FUEL2 = get("sim/flightmodel/weight/m_fuel", 2)
   end
   if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 3) ~= nil) then
      FUEL3 = get("sim/flightmodel/weight/m_fuel", 3)
   end
   if (XPLMFindDataRef("sim/cockpit2/fuel/fuel_totalizer_sum_kg") ~= nil) then
      FUEL_TTL = get("sim/cockpit2/fuel/fuel_totalizer_sum_kg")
   end



   pxpSwitchData = {
      PersistenceData = {
         --Deafault Electrical
         BAT = BAT,
         AVN = AVN,
         GENL = GENL,
         GENR = GENR,
         GENAPU = GENAPU,
         GPU = GPU,

         -- Default Lighting
         Nav_LT = Nav_LT,
         BCN = BCN,
         STROBE = STROBE,
         LNDLIGHT = LNDLIGHT,
         TAXILIGHT = TAXILIGHT,

         --Doors
         DOOR0 = DOOR0,
         DOOR1 = DOOR1,
         DOOR2 = DOOR2,





         -- Engines
         IGN1 = IGN1,
         IGN2 = IGN2,
         MAG1 = MAG1,
         MAG2 = MAG2,
         ENG1_RUN = ENG1_RUN,
         ENG2_RUN = ENG2_RUN,

         -- Fuel
         BOOST_PMP1 = BOOST_PMP1,
         BOOST_PMP2 = BOOST_PMP2,
         FUEL0 = FUEL0,
         FUEL1 = FUEL1,
         FUEL2 = FUEL2,
         FUEL3 = FUEL3,
         FUEL_TTL = FUEL_TTL,


      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceDefaults.ini", pxpSwitchData)
   print("PersistenceXP Defaults Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceDefaults.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceDefaults.ini")

      --Default Electrical
      if (XPLMFindDataRef("sim/cockpit/electrical/battery_on") ~= nil) then
         if pxpSwitchData.PersistenceData.BAT ~= nil then
            set("sim/cockpit/electrical/battery_on", pxpSwitchData.PersistenceData.BAT) -- Batt Switch
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/avionics_power_on") ~= nil) then
         if pxpSwitchData.PersistenceData.AVN ~= nil then
            set("sim/cockpit2/switches/avionics_power_on", pxpSwitchData.PersistenceData.AVN) -- Avionics Switch
         end
      end
      if (XPLMFindDataRef("sim/cockpit/electrical/generator_on") ~= nil) then
         if pxpSwitchData.PersistenceData.GENL ~= nil then
            set_array("sim/cockpit/electrical/generator_on", 0, pxpSwitchData.PersistenceData.GENL) -- Gen Switches 0 Left, 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit/electrical/generator_on") ~= nil) then
         if pxpSwitchData.PersistenceData.GENR ~= nil then
            set_array("sim/cockpit/electrical/generator_on", 1, pxpSwitchData.PersistenceData.GENR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/electrical/generator_apu_on") ~= nil) then
         if pxpSwitchData.PersistenceData.GENAPU ~= nil then
            set("sim/cockpit/electrical/generator_apu_on", pxpSwitchData.PersistenceData.GENAPU)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/electrical/gpu_on") ~= nil) then
         if pxpSwitchData.PersistenceData.GPU ~= nil then
            set("sim/cockpit/electrical/gpu_on", pxpSwitchData.PersistenceData.GPU)
         end
      end

      --Default Lighting
      if (XPLMFindDataRef("sim/cockpit2/switches/navigation_lights_on") ~= nil) then
         if pxpSwitchData.PersistenceData.Nav_LT ~= nil then
            set("sim/cockpit2/switches/navigation_lights_on", pxpSwitchData.PersistenceData.Nav_LT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/beacon_on") ~= nil) then
         if pxpSwitchData.PersistenceData.BCN ~= nil then
            set("sim/cockpit2/switches/beacon_on", pxpSwitchData.PersistenceData.BCN)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/strobe_lights_on") ~= nil) then
         if pxpSwitchData.PersistenceData.STROBE ~= nil then
            set("sim/cockpit2/switches/strobe_lights_on", pxpSwitchData.PersistenceData.STROBE)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_on", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_on", 0, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_on", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_on", 1, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_on", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_on", 2, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_on", 3) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_on", 3, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_switch", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_switch", 0, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_switch", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_switch", 1, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/landing_lights_switch", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.LNDLIGHT ~= nil then
            set_array("sim/cockpit2/switches/landing_lights_switch", 2, pxpSwitchData.PersistenceData.LNDLIGHT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/taxi_light_on") ~= nil) then
         if pxpSwitchData.PersistenceData.TAXILIGHT ~= nil then
            set("sim/cockpit2/switches/taxi_light_on", pxpSwitchData.PersistenceData.TAXILIGHT)
         end
      end

      --Doors
      if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.DOOR0 ~= nil then
            set_array("sim/cockpit2/switches/door_open", 0, pxpSwitchData.PersistenceData.DOOR0) -- 0 Main, 1 Left Bag, 2 Right Bag
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.DOOR1 ~= nil then
            set_array("sim/cockpit2/switches/door_open", 1, pxpSwitchData.PersistenceData.DOOR1) -- 0 Main, 1 Left Bag, 2 Right Bag
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/door_open", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.DOOR2 ~= nil then
            set_array("sim/cockpit2/switches/door_open", 2, pxpSwitchData.PersistenceData.DOOR2) -- 0 Main, 1 Left Bag, 2 Right Bag
         end
      end





      -- Engines
      if (XPLMFindDataRef("sim/cockpit/engine/igniters_on", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.IGN1 ~= nil then
            set_array("sim/cockpit/engine/igniters_on", 0, pxpSwitchData.PersistenceData.IGN1) -- Ignition 0 Left 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit/engine/igniters_on", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.IGN2 ~= nil then
            set_array("sim/cockpit/engine/igniters_on", 1, pxpSwitchData.PersistenceData.IGN2)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/engine/ignition_on", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.MAG1 ~= nil then
            set_array("sim/cockpit/engine/ignition_on", 0, pxpSwitchData.PersistenceData.MAG1) -- Ignition 0 Left 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit/engine/ignition_on", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.MAG2 ~= nil then
            set_array("sim/cockpit/engine/ignition_on", 1, pxpSwitchData.PersistenceData.MAG2)
         end
      end

      -- Fuel
      if (XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.BOOST_PMP1 ~= nil then
            set_array("sim/cockpit/engine/fuel_pump_on", 0, pxpSwitchData.PersistenceData.BOOST_PMP1) -- Fuel Pumps, 0 Left, 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.BOOST_PMP2 ~= nil then
            set_array("sim/cockpit/engine/fuel_pump_on", 1, pxpSwitchData.PersistenceData.BOOST_PMP2)
         end
      end
      if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL0 ~= nil then
            set_array("sim/flightmodel/weight/m_fuel", 0, pxpSwitchData.PersistenceData.FUEL0)
         end
      end
      if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL1 ~= nil then
            set_array("sim/flightmodel/weight/m_fuel", 1, pxpSwitchData.PersistenceData.FUEL1)
         end
      end
      if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL2 ~= nil then
            set_array("sim/flightmodel/weight/m_fuel", 2, pxpSwitchData.PersistenceData.FUEL2)
         end
      end
      if (XPLMFindDataRef("sim/flightmodel/weight/m_fuel", 3) ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL3 ~= nil then
            set_array("sim/flightmodel/weight/m_fuel", 3, pxpSwitchData.PersistenceData.FUEL3)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/fuel/fuel_totalizer_sum_kg") ~= nil) then
         if pxpSwitchData.PersistenceData.FUEL_TTL ~= nil then
            set("sim/cockpit2/fuel/fuel_totalizer_sum_kg", pxpSwitchData.PersistenceData.FUEL_TTL)
         end
      end


      print("PersistenceXP Defaults Panel State Loaded")
   end
end