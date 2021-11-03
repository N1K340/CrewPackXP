--[[
PersistenceXP data file for Carenado Saab 340
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")

local pxpSwitchData = {}

local LYOKE = nil
local RYOKE = nil
local LARM = nil
local RARM = nil
local IGNL_CVR = nil
local IGNR_CVR = nil
local IGN1 = nil
local IGN2 = nil
local DCAMP = nil
local EMG_CVR = nil
local EMG = nil
local CAB_PRESS_CTL = nil
local CTOT_PWR = nil
local CTOT = nil

function pxpCompile()
   if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeL") ~= nil) then
      LYOKE = get("thranda/cockpit/actuators/HideYokeL")
   end
   if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeR") ~= nil) then
      RYOKE = get("thranda/cockpit/actuators/HideYokeR")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestLR") ~= nil) then
      LARM = get("thranda/cockpit/animations/ArmRestLR")
   end
   if (XPLMFindDataRef("thranda/cockpit/animations/ArmRestRL") ~= nil) then
      RARM = get("thranda/cockpit/animations/ArmRestRL")
   end
   if (XPLMFindDataRef("thranda/BT", 9) ~= nil) then
      IGNL_CVR = get("thranda/BT", 9)
   end
   if (XPLMFindDataRef("thranda/BT", 10) ~= nil) then
      IGNR_CVR = get("thranda/BT", 10)
   end
   if (XPLMFindDataRef("thranda/BT", 107) ~= nil) then
      IGN1 = get("thranda/BT", 107)
   end
   if (XPLMFindDataRef("thranda/BT", 108) ~= nil) then
      IGN2 = get("thranda/BT", 108)
   end
   if (XPLMFindDataRef("thranda/actuators/VoltSelAct") ~= nil) then
      DCAMP = get("thranda/actuators/VoltSelAct")
   end
   if (XPLMFindDataRef("thranda/BT", 27) ~= nil) then
      EMG_CVR = get("thranda/BT", 27)
   end
   if (XPLMFindDataRef("thranda/BT", 93) ~= nil) then
      EMG = get("thranda/BT", 93)
   end
   if (XPLMFindDataRef("thranda/cockpit/ManualOverride") ~= nil) then
      CAB_PRESS_CTL = get("thranda/cockpit/ManualOverride")
   end
   if (XPLMFindDataRef("thranda/engine/TorqueLimit") ~= nil) then
      CTOT_PWR = get("thranda/engine/TorqueLimit")
   end
   if (XPLMFindDataRef("thranda/engine/CTOT") ~= nil) then
      CTOT = get("thranda/engine/CTOT")
   end

   pxpSwitchData = {
      PersistenceData = {
         LYOKE = LYOKE,
         RYOKE = RYOKE,
         LARM = LARM,
         RARM = RARM,
         IGNL_CVR = IGNL_CVR,
         IGNR_CVR = IGNR_CVR,
         IGN1 = IGN1,
         IGN2 = IGN2,
         DCAMP = DCAMP,
         EMG_CVR = EMG_CVR,
         EMG = EMG,
         CAB_PRESS_CTL = CAB_PRESS_CTL,
         CTOT_PWR = CTOT_PWR,
         CTOT = CTOT,
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceLES340.ini", pxpSwitchData)
   print("PersistenceXP 757 Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceLES340.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceLES340.ini")

      if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeL") ~= nil) then
         if pxpSwitchData.PersistenceData.LYOKE ~= nil then
            set("thranda/cockpit/actuators/HideYokeL", pxpSwitchData.PersistenceData.LYOKE)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/actuators/HideYokeR") ~= nil) then
         if pxpSwitchData.PersistenceData.RYOKE ~= nil then
            set("thranda/cockpit/actuators/HideYokeR", pxpSwitchData.PersistenceData.RYOKE)
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
      if (XPLMFindDataRef("thranda/BT", 9) ~= nil) then
         if pxpSwitchData.PersistenceData.IGNL_CVR ~= nil then
            set_array("thranda/BT", 9, pxpSwitchData.PersistenceData.IGNL_CVR)
         end
      end
      if (XPLMFindDataRef("thranda/BT", 10) ~= nil) then
         if pxpSwitchData.PersistenceData.IGNR_CVR ~= nil then
            set_array("thranda/BT", 10, pxpSwitchData.PersistenceData.IGNR_CVR)
         end
      end
      if (XPLMFindDataRef("thranda/BT", 107) ~= nil) then
         if pxpSwitchData.PersistenceData.IGN1 ~= nil then
            set_array("thranda/BT", 107, pxpSwitchData.PersistenceData.IGN1)
         end
      end
      if (XPLMFindDataRef("thranda/BT", 108) ~= nil) then
         if pxpSwitchData.PersistenceData.IGN2 ~= nil then
            set_array("thranda/BT", 108, pxpSwitchData.PersistenceData.IGN2)
         end
      end
      if (XPLMFindDataRef("thranda/actuators/VoltSelAct") ~= nil) then
         if pxpSwitchData.PersistenceData.DCAMP ~= nil then
            set("thranda/actuators/VoltSelAct", pxpSwitchData.PersistenceData.DCAMP)
         end
      end
      if (XPLMFindDataRef("thranda/BT", 27) ~= nil) then
         if pxpSwitchData.PersistenceData.EMG_CVR ~= nil then
            set_array("thranda/BT", 27, pxpSwitchData.PersistenceData.EMG_CVR)
         end
      end
      if (XPLMFindDataRef("thranda/BT", 93) ~= nil) then
         if pxpSwitchData.PersistenceData.EMG ~= nil then
            set_array("thranda/BT", 93, pxpSwitchData.PersistenceData.EMG)
         end
      end
      if (XPLMFindDataRef("thranda/cockpit/ManualOverride") ~= nil) then
         if pxpSwitchData.PersistenceData.CAB_PRESS_CTL ~= nil then
            set("thranda/cockpit/ManualOverride", pxpSwitchData.PersistenceData.CAB_PRESS_CTL)
         end
      end
      if (XPLMFindDataRef("thranda/engine/TorqueLimit") ~= nil) then
         if pxpSwitchData.PersistenceData.CTOT_PWR ~= nil then
            set("thranda/engine/TorqueLimit", pxpSwitchData.PersistenceData.CTOT_PWR)
         end
      end
      if (XPLMFindDataRef("thranda/engine/CTOT") ~= nil) then
         if pxpSwitchData.PersistenceData.CTOT ~= nil then
            set("thranda/engine/CTOT", pxpSwitchData.PersistenceData.CTOT)
         end
      end
      print("PersistenceXP 757 Panel State Loaded")
   end
end

