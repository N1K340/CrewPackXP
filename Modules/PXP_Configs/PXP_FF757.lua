--[[
PersistenceXP data file for Flight Factor 757
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")

local LARM = nil
local RARM = nil
local pxpSwitchData = {}


function pxpCompile()
   if (XPLMFindDataRef("anim/armCapt/1") ~= nil) then
      LARM = get("anim/armCapt/1")
   end
   if (XPLMFindDataRef("anim/armFO/1") ~= nil) then
      RARM = get("anim/armFO/1")
   end

   pxpSwitchData = {
      PersistenceData = {
         LARM = LARM;
         RARM = RARM;
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistence757.ini", pxpSwitchData)
   print("PersistenceXP 757 Panel State Saved")
end

function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistence757.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistence757.ini")

      if (XPLMFindDataRef("anim/armCapt/1") ~= nil) then
         if pxpSwitchData.PersistenceData.LARM ~= nil then
            set("anim/armCapt/1", pxpSwitchData.PersistenceData.LARM)
         end
      end
      if (XPLMFindDataRef("anim/armFO/1") ~= nil) then
         if pxpSwitchData.PersistenceData.RARM ~= nil then
            set("anim/armFO/1", pxpSwitchData.PersistenceData.RARM)
         end
      end
      print("PersistenceXP 757 Panel State Loaded")
   end
end

