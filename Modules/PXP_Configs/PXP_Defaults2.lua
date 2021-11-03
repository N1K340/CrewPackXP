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
-- Ice Protection
local PIT1_HT = nil
local STAT1_HT = nil
local AOA1_HT = nil
local PIT2_HT = nil
local STAT2_HT = nil
local AOA2_HT = nil
local WS_BLD = nil
local INLET1_AI = nil
local INLET2_AI = nil
local ENG_AI1 = nil
local ENG_AI2 = nil
local WING_BOOT = nil
local WING_HEAT = nil
local PROP_HEAT = nil
-- Controls
local TRIM = nil
local SPD_BRK = nil
local FLP_HNDL = nil
local FAN_SYNC = nil
local PROP_SYNC = nil
local THRTL = nil
local PROP = nil
local MIX = nil
local CARB1 = nil
local CARB2 = nil
local COWL1 = nil
local COWL2 = nil
local CAB_ALT = nil
local CAB_RATE = nil

function pxpCompile()
   -- Ice Protection

   if (XPLMFindDataRef("sim/cockpit2/ice/ice_pitot_heat_on_pilot") ~= nil) then
      PIT1_HT = get("sim/cockpit2/ice/ice_pitot_heat_on_pilot")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_static_heat_on_pilot") ~= nil) then
      STAT1_HT = get("sim/cockpit2/ice/ice_static_heat_on_pilot")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_AOA_heat_on") ~= nil) then
      AOA1_HT = get("sim/cockpit2/ice/ice_AOA_heat_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_pitot_heat_on_copilot") ~= nil) then
      PIT2_HT = get("sim/cockpit2/ice/ice_pitot_heat_on_copilot")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_static_heat_on_copilot") ~= nil) then
      STAT2_HT = get("sim/cockpit2/ice/ice_static_heat_on_copilot")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_AOA_heat_on_copilot") ~= nil) then
      AOA2_HT = get("sim/cockpit2/ice/ice_AOA_heat_on_copilot")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_window_heat_on") ~= nil) then
      WS_BLD = get("sim/cockpit2/ice/ice_window_heat_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 0) ~= nil) then
      INLET1_AI = get("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 0)
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 1) ~= nil) then
      INLET2_AI = get("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 1)
   end
   if (XPLMFindDataRef("sim/cockpit/switches/anti_ice_engine_air", 0) ~= nil) then
      ENG_AI1 = get("sim/cockpit/switches/anti_ice_engine_air", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/switches/anti_ice_engine_air", 1) ~= nil) then
      ENG_AI2 = get("sim/cockpit/switches/anti_ice_engine_air", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_surface_boot_on") ~= nil) then
      WING_BOOT = get("sim/cockpit2/ice/ice_surface_boot_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_surfce_heat_on") ~= nil) then
      WING_HEAT = get("sim/cockpit2/ice/ice_surfce_heat_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/ice/ice_prop_heat_on") ~= nil) then
      PROP_HEAT = get("sim/cockpit2/ice/ice_prop_heat_on")
   end


   -- Controls


   if (XPLMFindDataRef("sim/cockpit2/controls/elevator_trim") ~= nil) then
      TRIM = get("sim/cockpit2/controls/elevator_trim")
   end
   if (XPLMFindDataRef("sim/cockpit2/controls/speedbrake_ratio") ~= nil) then
      SPD_BRK = get("sim/cockpit2/controls/speedbrake_ratio")
   end
   if (XPLMFindDataRef("sim/cockpit2/controls/flap_ratio") ~= nil) then
      FLP_HNDL = get("sim/cockpit2/controls/flap_ratio")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/jet_sync_mode") ~= nil) then
      FAN_SYNC = get("sim/cockpit2/switches/jet_sync_mode")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/prop_sync_on") ~= nil) then
      PROP_SYNC = get("sim/cockpit2/switches/prop_sync_on")
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio_all") ~= nil) then
      THRTL = get("sim/cockpit2/engine/actuators/throttle_ratio_all")
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/prop_ratio_all") ~= nil) then
      PROP = get("sim/cockpit2/engine/actuators/prop_ratio_all")
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/mixture_ratio_all") ~= nil) then
      MIX = get("sim/cockpit2/engine/actuators/mixture_ratio_all")
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/carb_heat_ratio", 0) ~= nil) then
      CARB1 = get("sim/cockpit2/engine/actuators/carb_heat_ratio", 0)
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/carb_heat_ratio", 1) ~= nil) then
      CARB2 = get("sim/cockpit2/engine/actuators/carb_heat_ratio", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/cowl_flap_ratio", 0) ~= nil) then
      COWL1 = get("sim/cockpit2/engine/actuators/cowl_flap_ratio", 0)
   end
   if (XPLMFindDataRef("sim/cockpit2/engine/actuators/cowl_flap_ratio", 1) ~= nil) then
      COWL2 = get("sim/cockpit2/engine/actuators/cowl_flap_ratio", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/pressurization/actuators/cabin_altitude_ft") ~= nil) then
      CAB_ALT = get("sim/cockpit2/pressurization/actuators/cabin_altitude_ft")
   end
   if (XPLMFindDataRef("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm") ~= nil) then
      CAB_RATE = get("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm")
   end

   -- Internal Lighting

   if (XPLMFindDataRef("sim/cockpit/switches/fasten_seat_belts") ~= nil) then
      ST_BLT = get("sim/cockpit/switches/fasten_seat_belts")
   end
   if (XPLMFindDataRef("sim/cockpit/switches/no_smoking") ~= nil) then
      NO_SMK = get("sim/cockpit/switches/no_smoking")
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 0) ~= nil) then
      PNL_LT0 = get("sim/cockpit2/switches/panel_brightness_ratio", 0)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 1) ~= nil) then
      PNL_LT1 = get("sim/cockpit2/switches/panel_brightness_ratio", 1)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 2) ~= nil) then
      PNL_LT2 = get("sim/cockpit2/switches/panel_brightness_ratio", 2)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 3) ~= nil) then
      PNL_LT3 = get("sim/cockpit2/switches/panel_brightness_ratio", 3)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 4) ~= nil) then
      PNL_LT4 = get("sim/cockpit2/switches/panel_brightness_ratio", 4)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 5) ~= nil) then
      PNL_LT5 = get("sim/cockpit2/switches/panel_brightness_ratio", 5)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 6) ~= nil) then
      PNL_LT6 = get("sim/cockpit2/switches/panel_brightness_ratio", 6)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 7) ~= nil) then
      PNL_LT7 = get("sim/cockpit2/switches/panel_brightness_ratio", 7)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 8) ~= nil) then
      PNL_LT8 = get("sim/cockpit2/switches/panel_brightness_ratio", 8)
   end
   if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 9) ~= nil) then
      PNL_LT9 = get("sim/cockpit2/switches/panel_brightness_ratio", 9)
   end

   pxpSwitchData = {
      PersistenceData = {
         -- Ice Protection
         PIT1_HT = PIT1_HT,
         STAT1_HT = STAT1_HT,
         AOA1_HT = AOA1_HT,
         PIT2_HT = PIT2_HT,
         STAT2_HT = STAT2_HT,
         AOA2_HT = AOA2_HT,
         WS_BLD = WS_BLD,
         INLET1_AI = INLET1_AI,
         INLET2_AI = INLET2_AI,
         ENG_AI1 = ENG_AI1,
         ENG_AI2 = ENG_AI2,
         WING_BOOT = WING_BOOT,
         WING_HEAT = WING_HEAT,
         PROP_HEAT = PROP_HEAT,

         -- Controls
         TRIM = TRIM,
         SPD_BRK = SPD_BRK,
         FLP_HNDL = FLP_HNDL,
         FAN_SYNC = FAN_SYNC,
         PROP_SYNC = PROP_SYNC,
         THRTL = THRTL,
         PROP = PROP,
         MIX = MIX,
         CARB1 = CARB1,
         CARB2 = CARB2,
         COWL1 = COWL1,
         COWL2 = COWL2,
         CAB_ALT = CAB_ALT,
         CAB_RATE = CAB_RATE,

         -- Internal Lights
         ST_BLT = ST_BLT,
         NO_SMK = NO_SMK,
         PNL_LT0 = PNL_LT0,
         PNL_LT1 = PNL_LT1,
         PNL_LT2 = PNL_LT2,
         PNL_LT3 = PNL_LT3,
         PNL_LT4 = PNL_LT4,
         PNL_LT5 = PNL_LT5,
         PNL_LT6 = PNL_LT6,
         PNL_LT7 = PNL_LT7,
         PNL_LT8 = PNL_LT8,
         PNL_LT9 = PNL_LT9,
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceDefaults2.ini", pxpSwitchData)
   print("PersistenceXP Defaults2 Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceDefaults2.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceDefaults2.ini")


      -- Ice Protection
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_pitot_heat_on_pilot") ~= nil) then
         if pxpSwitchData.PersistenceData.PIT1_HT ~= nil then
            set("sim/cockpit2/ice/ice_pitot_heat_on_pilot", pxpSwitchData.PersistenceData.PIT1_HT) -- Pitot Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_static_heat_on_pilot") ~= nil) then
         if pxpSwitchData.PersistenceData.STAT1_HT ~= nil then
            set("sim/cockpit2/ice/ice_static_heat_on_pilot", pxpSwitchData.PersistenceData.STAT1_HT) -- Static Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_AOA_heat_on") ~= nil) then
         if pxpSwitchData.PersistenceData.AOA1_HT ~= nil then
            set("sim/cockpit2/ice/ice_AOA_heat_on", pxpSwitchData.PersistenceData.AOA1_HT) -- AOA Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_pitot_heat_on_copilot") ~= nil) then
         if pxpSwitchData.PersistenceData.PIT2_HT ~= nil then
            set("sim/cockpit2/ice/ice_pitot_heat_on_copilot", pxpSwitchData.PersistenceData.PIT2_HT) -- Pitot Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_static_heat_on_copilot") ~= nil) then
         if pxpSwitchData.PersistenceData.STAT2_HT ~= nil then
            set("sim/cockpit2/ice/ice_static_heat_on_copilot", pxpSwitchData.PersistenceData.STAT2_HT) -- Static Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_AOA_heat_on_copilot") ~= nil) then
         if pxpSwitchData.PersistenceData.AOA2_HT ~= nil then
            set("sim/cockpit2/ice/ice_AOA_heat_on_copilot", pxpSwitchData.PersistenceData.AOA2_HT) -- AOA Heat
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_window_heat_on") ~= nil) then
         if pxpSwitchData.PersistenceData.WS_BLD ~= nil then
            set("sim/cockpit2/ice/ice_window_heat_on", pxpSwitchData.PersistenceData.WS_BLD) -- Window Bleed
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.INLET1_AI ~= nil then
            set_array("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 0, pxpSwitchData.PersistenceData.INLET1_AI) -- 0 Left 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.INLET2_AI ~= nil then
            set_array("sim/cockpit2/ice/ice_inlet_heat_on_per_engine", 1, pxpSwitchData.PersistenceData.INLET2_AI)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/anti_ice_engine_air", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.ENG_AI1 ~= nil then
            set_array("sim/cockpit/switches/anti_ice_engine_air", 0, pxpSwitchData.PersistenceData.ENG_AI1) -- 0 Left 1 Right
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/anti_ice_engine_air", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.ENG_AI2 ~= nil then
            set_array("sim/cockpit/switches/anti_ice_engine_air", 1, pxpSwitchData.PersistenceData.ENG_AI2)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_surface_boot_on") ~= nil) then
         if pxpSwitchData.PersistenceData.WING_BOOT ~= nil then
            set("sim/cockpit2/ice/ice_surface_boot_on", pxpSwitchData.PersistenceData.WING_BOOT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_surfce_heat_on") ~= nil) then
         if pxpSwitchData.PersistenceData.WING_HEAT ~= nil then
            set("sim/cockpit2/ice/ice_surfce_heat_on", pxpSwitchData.PersistenceData.WING_HEAT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/ice/ice_prop_heat_on") ~= nil) then
         if pxpSwitchData.PersistenceData.PROP_HEAT ~= nil then
            set("sim/cockpit2/ice/ice_prop_heat_on", pxpSwitchData.PersistenceData.PROP_HEAT)
         end
      end

      -- Controls
      if (XPLMFindDataRef("sim/cockpit2/controls/elevator_trim") ~= nil) then
         if pxpSwitchData.PersistenceData.TRIM ~= nil then
            set("sim/cockpit2/controls/elevator_trim", pxpSwitchData.PersistenceData.TRIM)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/controls/speedbrake_ratio") ~= nil) then
         if pxpSwitchData.PersistenceData.SPD_BRK ~= nil then
            set("sim/cockpit2/controls/speedbrake_ratio", pxpSwitchData.PersistenceData.SPD_BRK)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/controls/flap_ratio") ~= nil) then
         if pxpSwitchData.PersistenceData.FLP_HNDL ~= nil then
            set("sim/cockpit2/controls/flap_ratio", pxpSwitchData.PersistenceData.FLP_HNDL)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/jet_sync_mode") ~= nil) then
         if pxpSwitchData.PersistenceData.FAN_SYNC ~= nil then
            set("sim/cockpit2/switches/jet_sync_mode", pxpSwitchData.PersistenceData.FAN_SYNC)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/prop_sync_on") ~= nil) then
         if pxpSwitchData.PersistenceData.PROP_SYNC ~= nil then
            set("sim/cockpit2/switches/prop_sync_on", pxpSwitchData.PersistenceData.PROP_SYNC)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio_all") ~= nil) then
         if pxpSwitchData.PersistenceData.THRTL ~= nil then
            set("sim/cockpit2/engine/actuators/throttle_ratio_all", pxpSwitchData.PersistenceData.THRTL)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/prop_ratio_all") ~= nil) then
         if pxpSwitchData.PersistenceData.PROP ~= nil then
            set("sim/cockpit2/engine/actuators/prop_ratio_all", pxpSwitchData.PersistenceData.PROP)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/mixture_ratio_all") ~= nil) then
         if pxpSwitchData.PersistenceData.MIX ~= nil then
            set("sim/cockpit2/engine/actuators/mixture_ratio_all", pxpSwitchData.PersistenceData.MIX)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/carb_heat_ratio", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.CARB1 ~= nil then
            set_array("sim/cockpit2/engine/actuators/carb_heat_ratio", 0, pxpSwitchData.PersistenceData.CARB1)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/carb_heat_ratio", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.CARB2 ~= nil then
            set_array("sim/cockpit2/engine/actuators/carb_heat_ratio", 1, pxpSwitchData.PersistenceData.CARB2)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/cowl_flap_ratio", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.COWL1 ~= nil then
            set_array("sim/cockpit2/engine/actuators/cowl_flap_ratio", 0, pxpSwitchData.PersistenceData.COWL1)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/engine/actuators/cowl_flap_ratio", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.COWL2 ~= nil then
            set_array("sim/cockpit2/engine/actuators/cowl_flap_ratio", 1, pxpSwitchData.PersistenceData.COWL2)
         end
      end

      if (XPLMFindDataRef("sim/cockpit2/pressurization/actuators/cabin_altitude_ft") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_ALT ~= nil then
            set("sim/cockpit2/pressurization/actuators/cabin_altitude_ft", pxpSwitchData.PersistenceData.CAB_ALT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_RATE ~= nil then
            set("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm", pxpSwitchData.PersistenceData.CAB_RATE)
         end
      end

      -- Internal Lights

      if (XPLMFindDataRef("sim/cockpit/switches/fasten_seat_belts") ~= nil) then
         if pxpSwitchData.PersistenceData.ST_BLT ~= nil then
            set("sim/cockpit/switches/fasten_seat_belts", pxpSwitchData.PersistenceData.ST_BLT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/no_smoking") ~= nil) then
         if pxpSwitchData.PersistenceData.NO_SMK ~= nil then
            set("sim/cockpit/switches/no_smoking", pxpSwitchData.PersistenceData.NO_SMK)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT0 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 0, pxpSwitchData.PersistenceData.PNL_LT0)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT1 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 1, pxpSwitchData.PersistenceData.PNL_LT1)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 2) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT2 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 2, pxpSwitchData.PersistenceData.PNL_LT2)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 3) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT3 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 3, pxpSwitchData.PersistenceData.PNL_LT3)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 4) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT4 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 4, pxpSwitchData.PersistenceData.PNL_LT4)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 5) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT5 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 5, pxpSwitchData.PersistenceData.PNL_LT5)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 6) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT6 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 6, pxpSwitchData.PersistenceData.PNL_LT6)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 7) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT7 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 7, pxpSwitchData.PersistenceData.PNL_LT7)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 8) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT8 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 8, pxpSwitchData.PersistenceData.PNL_LT8)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/switches/panel_brightness_ratio", 9) ~= nil) then
         if pxpSwitchData.PersistenceData.PNL_LT9 ~= nil then
            set_array("sim/cockpit2/switches/panel_brightness_ratio", 9, pxpSwitchData.PersistenceData.PNL_LT9)
         end
      end
      print("PersistenceXP Defaults2 Panel State Loaded")
   end
end