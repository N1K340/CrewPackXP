--[[
PersistenceXP data file for Default Nav / Radio Datarefs
]]

module(..., package.seeall)

--Modules
local LIP = require("LIP")
local pxpSwitchData = {}

--Com Select
local NAV1_PWR = nil
local NAV2_PWR = nil
local COM1_PWR = nil
local COM2_PWR = nil
local ADF1_PWR = nil
local ADF2_PWR = nil
local GPS1_PWR = nil
local GPS2_PWR = nil
local DME_PWR = nil
local XMT = nil
local C1_RCV = nil
local C2_RCV = nil
local ADF1_RCV = nil
local ADF2_RCV = nil
local NAV1_RCV = nil
local NAV2_RCV = nil
local DME1_RCV = nil
local MRKR_RCV = nil
local NAV1_ACT = nil
local NAV1_STB = nil
local NAV2_ACT = nil
local NAV2_STB = nil
local COM1_ACT = nil
local COM1_STB = nil
local COM2_ACT = nil
local COM2_STB = nil
local ADF1_ACT = nil
local ADF1_STB = nil
local ADF2_ACT = nil
local ADF2_STB = nil
local XPDR_COD = nil
local XPDR_MODE = nil
local CLK_MODE = nil
-- Nav Related
local HDG = nil
local VS = nil
local APA = nil
local SPD_BG = nil
local RMI_L = nil
local RMI_R = nil
local DME_CH = nil
local DME_SEL = nil
local DH = nil
local CRS1 = nil
local CRS2 = nil
local GYROSL = nil
local GYROSR = nil

function pxpCompile()
   --Com Select

   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/nav1_power") ~= nil) then
      NAV1_PWR = get("sim/cockpit2/radios/actuators/nav1_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/nav2_power") ~= nil) then
      NAV2_PWR = get("sim/cockpit2/radios/actuators/nav2_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/com1_power") ~= nil) then
      COM1_PWR = get("sim/cockpit2/radios/actuators/com1_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/com2_power") ~= nil) then
      COM2_PWR = get("sim/cockpit2/radios/actuators/com2_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/adf1_power") ~= nil) then
      ADF1_PWR = get("sim/cockpit2/radios/actuators/adf1_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/adf2_power") ~= nil) then
      ADF2_PWR = get("sim/cockpit2/radios/actuators/adf2_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/gps_power") ~= nil) then
      GPS1_PWR = get("sim/cockpit2/radios/actuators/gps_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/gps2_power") ~= nil) then
      GPS2_PWR = get("sim/cockpit2/radios/actuators/gps2_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/dme_power") ~= nil) then
      DME_PWR = get("sim/cockpit2/radios/actuators/dme_power")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_com_selection_man") ~= nil) then
      XMT = get("sim/cockpit2/radios/actuators/audio_com_selection_man")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_com1") ~= nil) then
      C1_RCV = get("sim/cockpit2/radios/actuators/audio_selection_com1")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_com2") ~= nil) then
      C2_RCV = get("sim/cockpit2/radios/actuators/audio_selection_com2")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_adf1") ~= nil) then
      ADF1_RCV = get("sim/cockpit2/radios/actuators/audio_selection_adf1")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_adf2") ~= nil) then
      ADF2_RCV = get("sim/cockpit2/radios/actuators/audio_selection_adf2")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_nav1") ~= nil) then
      NAV1_RCV = get("sim/cockpit2/radios/actuators/audio_selection_nav1")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_nav2") ~= nil) then
      NAV2_RCV = get("sim/cockpit2/radios/actuators/audio_selection_nav2")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_dme_enabled") ~= nil) then
      DME1_RCV = get("sim/cockpit2/radios/actuators/audio_dme_enabled")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_marker_enabled") ~= nil) then
      MRKR_RCV = get("sim/cockpit2/radios/actuators/audio_marker_enabled")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav1_freq_hz") ~= nil) then
      NAV1_ACT = get("sim/cockpit/radios/nav1_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav1_stdby_freq_hz") ~= nil) then
      NAV1_STB = get("sim/cockpit/radios/nav1_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav2_freq_hz") ~= nil) then
      NAV2_ACT = get("sim/cockpit/radios/nav2_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav2_stdby_freq_hz") ~= nil) then
      NAV2_STB = get("sim/cockpit/radios/nav2_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/com1_freq_hz") ~= nil) then
      COM1_ACT = get("sim/cockpit/radios/com1_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/com1_stdby_freq_hz") ~= nil) then
      COM1_STB = get("sim/cockpit/radios/com1_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/com2_freq_hz") ~= nil) then
      COM2_ACT = get("sim/cockpit/radios/com2_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/com2_stdby_freq_hz") ~= nil) then
      COM2_STB = get("sim/cockpit/radios/com2_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/adf1_freq_hz") ~= nil) then
      ADF1_ACT = get("sim/cockpit/radios/adf1_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/adf1_stdby_freq_hz") ~= nil) then
      ADF1_STB = get("sim/cockpit/radios/adf1_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/adf2_freq_hz") ~= nil) then
      ADF2_ACT = get("sim/cockpit/radios/adf2_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/adf2_stdby_freq_hz") ~= nil) then
      ADF2_STB = get("sim/cockpit/radios/adf2_stdby_freq_hz")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/transponder_code") ~= nil) then
      XPDR_COD = get("sim/cockpit/radios/transponder_code")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/transponder_mode") ~= nil) then
      XPDR_MODE = get("sim/cockpit2/radios/actuators/transponder_mode")
   end
   if (XPLMFindDataRef("sim/cockpit2/clock_timer/timer_mode") ~= nil) then
      CLK_MODE = get("sim/cockpit2/clock_timer/timer_mode")
   end
   -- Nav Related

   if (XPLMFindDataRef("sim/cockpit/gyros/gyr_free_slaved", 0) ~= nil) then
      GYRSL = get("sim/cockpit/gyros/gyr_free_slaved", 0)
   end
   if (XPLMFindDataRef("sim/cockpit/gyros/gyr_free_slaved", 1) ~= nil) then
      GYROSR = get("sim/cockpit/gyros/gyr_free_slaved", 1)
   end

   if (XPLMFindDataRef("sim/cockpit/autopilot/heading_mag") ~= nil) then
      HDG = get("sim/cockpit/autopilot/heading_mag")
   end
   if (XPLMFindDataRef("sim/cockpit2/autopilot/vvi_dial_fpm") ~= nil) then
      VS = get("sim/cockpit2/autopilot/vvi_dial_fpm")
   end
   if (XPLMFindDataRef("sim/cockpit2/autopilot/altitude_dial_ft") ~= nil) then
      APA = get("sim/cockpit2/autopilot/altitude_dial_ft")
   end
   if (XPLMFindDataRef("sim/cockpit/autopilot/airspeed") ~= nil) then
      SPD_BG = get("sim/cockpit/autopilot/airspeed")
   end
   if (XPLMFindDataRef("sim/cockpit/switches/RMI_l_vor_adf_selector") ~= nil) then
      RMI_L = get("sim/cockpit/switches/RMI_l_vor_adf_selector")
   end
   if (XPLMFindDataRef("sim/cockpit/switches/RMI_r_vor_adf_selector") ~= nil) then
      RMI_R = get("sim/cockpit/switches/RMI_r_vor_adf_selector")
   end
   if (XPLMFindDataRef("sim/cockpit2/radios/actuators/DME_mode") ~= nil) then
      DME_CH = get("sim/cockpit2/radios/actuators/DME_mode")
   end
   if (XPLMFindDataRef("sim/cockpit/switches/DME_distance_or_time") ~= nil) then
      DME_SEL = get("sim/cockpit/switches/DME_distance_or_time")
   end
   if (XPLMFindDataRef("sim/cockpit/misc/radio_altimeter_minimum") ~= nil) then
      DH = get("sim/cockpit/misc/radio_altimeter_minimum")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav1_obs_degm") ~= nil) then
      CRS1 = get("sim/cockpit/radios/nav1_obs_degm")
   end
   if (XPLMFindDataRef("sim/cockpit/radios/nav2_obs_degm") ~= nil) then
      CRS2 = get("sim/cockpit/radios/nav2_obs_degm")
   end

   pxpSwitchData = {
      PersistenceData = {
         --Coms
         NAV1_PWR = NAV1_PWR,
         NAV2_PWR = NAV2_PWR,
         COM1_PWR = COM1_PWR,
         COM2_PWR = COM2_PWR,
         ADF1_PWR = ADF1_PWR,
         ADF2_PWR = ADF2_PWR,
         GPS1_PWR = GPS1_PWR,
         GPS2_PWR = GPS2_PWR,
         DME_PWR = DME_PWR,

         XMT = XMT,
         C1_RCV = C1_RCV,
         C2_RCV = C2_RCV,
         ADF1_RCV = ADF1_RCV,
         ADF2_RCV = ADF2_RCV,
         NAV1_RCV = NAV1_RCV,
         NAV2_RCV = NAV2_RCV,
         DME1_RCV = DME1_RCV,
         MRKR_RCV = MRKR_RCV,

         COM1_ACT = COM1_ACT,
         COM1_STB = COM1_STB,
         COM2_ACT = COM2_ACT,
         COM2_STB = COM2_STB,
         NAV1_ACT = NAV1_ACT,
         NAV1_STB = NAV1_STB,
         NAV2_ACT = NAV2_ACT,
         NAV2_STB = NAV2_STB,
         ADF1_ACT = ADF1_ACT,
         ADF1_STB = ADF1_STB,
         ADF2_ACT = ADF2_ACT,
         ADF2_STB = ADF2_STB,
         XPDR_COD = XPDR_COD,
         XPDR_MODE = XPDR_MODE,

         CLK_MODE = CLK_MODE,

         -- Nav Related
         HDG = HDG,
         VS = VS,
         APA = APA,
         SPD_BG = SPD_BG,
         RMI_L = RMI_L,
         RMI_R = RMI_R,
         DME_CH = DME_CH,
         DME_SEL = DME_SEL,
         DH = DH,
         CRS1 = CRS1,
         CRS2 = CRS2,
         GYROSL = GYROSL,
         GYROSR = GYROSR,
      }
   }

   LIP.save(AIRCRAFT_PATH .. "/pxpPersistenceDefaultRadio.ini", pxpSwitchData)
   print("PersistenceXP Default Nav Radio State Saved")
end



function pxpRead()
   local f = io.open(AIRCRAFT_PATH .. "/pxpPersistenceDefaultRadio.ini","r")
   if f ~= nil then
      io.close(f)
      pxpSwitchData = LIP.load(AIRCRAFT_PATH .. "/pxpPersistenceDefaultRadio.ini")

      --Com Select
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/nav1_power") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV1_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/nav1_power", pxpSwitchData.PersistenceData.NAV1_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/nav2_power") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV2_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/nav2_power", pxpSwitchData.PersistenceData.NAV2_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/com1_power") ~= nil) then
         if pxpSwitchData.PersistenceData.COM1_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/com1_power", pxpSwitchData.PersistenceData.COM1_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/com2_power") ~= nil) then
         if pxpSwitchData.PersistenceData.COM2_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/com2_power", pxpSwitchData.PersistenceData.COM2_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/adf1_power") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF1_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/adf1_power", pxpSwitchData.PersistenceData.ADF1_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/adf2_power") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF2_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/adf2_power", pxpSwitchData.PersistenceData.ADF2_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/gps_power") ~= nil) then
         if pxpSwitchData.PersistenceData.GPS1_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/gps_power", pxpSwitchData.PersistenceData.GPS1_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/gps2_power") ~= nil) then
         if pxpSwitchData.PersistenceData.GPS2_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/gps2_power", pxpSwitchData.PersistenceData.GPS2_PWR)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/dme_power") ~= nil) then
         if pxpSwitchData.PersistenceData.DME_PWR ~= nil then
            set("sim/cockpit2/radios/actuators/dme_power", pxpSwitchData.PersistenceData.DME_PWR)
         end
      end


      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_com_selection_man") ~= nil) then
         if pxpSwitchData.PersistenceData.XMT ~= nil then
            set("sim/cockpit2/radios/actuators/audio_com_selection_man", pxpSwitchData.PersistenceData.XMT) -- Transmit Selector
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_com1") ~= nil) then
         if pxpSwitchData.PersistenceData.C1_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_com1", pxpSwitchData.PersistenceData.C1_RCV) -- Com 1 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_com2") ~= nil) then
         if pxpSwitchData.PersistenceData.C2_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_com2", pxpSwitchData.PersistenceData.C2_RCV) -- Com 2 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_adf1") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF1_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_adf1", pxpSwitchData.PersistenceData.ADF1_RCV) -- ADF 1 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_adf2") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF2_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_adf2", pxpSwitchData.PersistenceData.ADF2_RCV) -- ADF 2 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_nav1") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV1_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_nav1", pxpSwitchData.PersistenceData.NAV1_RCV) -- NAV 1 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_selection_nav2") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV2_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_selection_nav2", pxpSwitchData.PersistenceData.NAV2_RCV) -- NAV 2 Receives
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_dme_enabled") ~= nil) then
         if pxpSwitchData.PersistenceData.DME1_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_dme_enabled", pxpSwitchData.PersistenceData.DME1_RCV) -- DME Recieve
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/audio_marker_enabled") ~= nil) then
         if pxpSwitchData.PersistenceData.MRKR_RCV ~= nil then
            set("sim/cockpit2/radios/actuators/audio_marker_enabled", pxpSwitchData.PersistenceData.MRKR_RCV) -- Marker Recieve
         end
      end


      if (XPLMFindDataRef("sim/cockpit/radios/com1_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.COM1_ACT ~= nil then
            set("sim/cockpit/radios/com1_freq_hz", pxpSwitchData.PersistenceData.COM1_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/com1_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.COM1_STB ~= nil then
            set("sim/cockpit/radios/com1_stdby_freq_hz", pxpSwitchData.PersistenceData.COM1_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/com2_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.COM2_ACT ~= nil then
            set("sim/cockpit/radios/com2_freq_hz", pxpSwitchData.PersistenceData.COM2_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/com2_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.COM2_STB ~= nil then
            set("sim/cockpit/radios/com2_stdby_freq_hz", pxpSwitchData.PersistenceData.COM2_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav1_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV1_ACT ~= nil then
            set("sim/cockpit/radios/nav1_freq_hz", pxpSwitchData.PersistenceData.NAV1_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav1_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV1_STB ~= nil then
            set("sim/cockpit/radios/nav1_stdby_freq_hz", pxpSwitchData.PersistenceData.NAV1_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav2_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV2_ACT ~= nil then
            set("sim/cockpit/radios/nav2_freq_hz", pxpSwitchData.PersistenceData.NAV2_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav2_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.NAV2_STB ~= nil then
            set("sim/cockpit/radios/nav1_stdby_freq_hz", pxpSwitchData.PersistenceData.NAV2_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/adf1_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF1_ACT ~= nil then
            set("sim/cockpit/radios/adf1_freq_hz", pxpSwitchData.PersistenceData.ADF1_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/adf1_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF1_STB ~= nil then
            set("sim/cockpit/radios/adf1_stdby_freq_hz", pxpSwitchData.PersistenceData.ADF1_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/adf2_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF2_ACT ~= nil then
            set("sim/cockpit/radios/adf2_freq_hz", pxpSwitchData.PersistenceData.ADF2_ACT)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/adf2_stdby_freq_hz") ~= nil) then
         if pxpSwitchData.PersistenceData.ADF2_STB ~= nil then
            set("sim/cockpit/radios/adf2_stdby_freq_hz", pxpSwitchData.PersistenceData.ADF2_STB)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/transponder_code") ~= nil) then
         if pxpSwitchData.PersistenceData.XPDR_COD ~= nil then
            set("sim/cockpit/radios/transponder_code", pxpSwitchData.PersistenceData.XPDR_COD)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/transponder_mode") ~= nil) then
         if pxpSwitchData.PersistenceData.XPDR_MODE ~= nil then
            set("sim/cockpit2/radios/actuators/transponder_mode", pxpSwitchData.PersistenceData.XPDR_MODE)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/clock_timer/timer_mode") ~= nil) then
         if pxpSwitchData.PersistenceData.CLK_MODE ~= nil then
            set("sim/cockpit2/clock_timer/timer_mode", pxpSwitchData.PersistenceData.CLK_MODE)
         end
      end

      -- Nav Related
      if (XPLMFindDataRef("sim/cockpit/gyros/gyr_free_slaved", 0) ~= nil) then
         if pxpSwitchData.PersistenceData.GYROSL ~= nil then
            set_array("sim/cockpit/gyros/gyr_free_slaved", 0, pxpSwitchData.PersistenceData.GYROSL)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/gyros/gyr_free_slaved", 1) ~= nil) then
         if pxpSwitchData.PersistenceData.GYROSR ~= nil then
            set_array("sim/cockpit/gyros/gyr_free_slaved", 1, pxpSwitchData.PersistenceData.GYROSR)
         end
      end

      if (XPLMFindDataRef("sim/cockpit/autopilot/heading_mag") ~= nil) then
         if pxpSwitchData.PersistenceData.HDG ~= nil then
            set("sim/cockpit/autopilot/heading_mag", pxpSwitchData.PersistenceData.HDG)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/autopilot/vvi_dial_fpm") ~= nil) then
         if pxpSwitchData.PersistenceData.VS ~= nil then
            set("sim/cockpit2/autopilot/vvi_dial_fpm", pxpSwitchData.PersistenceData.VS)
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/autopilot/altitude_dial_ft") ~= nil) then
         if pxpSwitchData.PersistenceData.APA ~= nil then
            set("sim/cockpit2/autopilot/altitude_dial_ft", pxpSwitchData.PersistenceData.APA)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/autopilot/airspeed") ~= nil) then
         if pxpSwitchData.PersistenceData.SPD_BG ~= nil then
            set("sim/cockpit/autopilot/airspeed", pxpSwitchData.PersistenceData.SPD_BG) -- Speed Bug
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/RMI_l_vor_adf_selector") ~= nil) then
         if pxpSwitchData.PersistenceData.RMI_L ~= nil then
            set("sim/cockpit/switches/RMI_l_vor_adf_selector", pxpSwitchData.PersistenceData.RMI_L) -- Left RMI
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/RMI_r_vor_adf_selector") ~= nil) then
         if pxpSwitchData.PersistenceData.RMI_R ~= nil then
            set("sim/cockpit/switches/RMI_r_vor_adf_selector", pxpSwitchData.PersistenceData.RMI_R) -- Right RMI
         end
      end
      if (XPLMFindDataRef("sim/cockpit2/radios/actuators/DME_mode") ~= nil) then
         if pxpSwitchData.PersistenceData.DME_CH ~= nil then
            set("sim/cockpit2/radios/actuators/DME_mode", pxpSwitchData.PersistenceData.DME_CH)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/switches/DME_distance_or_time") ~= nil) then
         if pxpSwitchData.PersistenceData.DME_SEL ~= nil then
            set("sim/cockpit/switches/DME_distance_or_time", pxpSwitchData.PersistenceData.DME_SEL)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/misc/radio_altimeter_minimum") ~= nil) then
         if pxpSwitchData.PersistenceData.DH ~= nil then
            set("sim/cockpit/misc/radio_altimeter_minimum", pxpSwitchData.PersistenceData.DH)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav1_obs_degm") ~= nil) then
         if pxpSwitchData.PersistenceData.CRS1 ~= nil then
            set("sim/cockpit/radios/nav1_obs_degm", pxpSwitchData.PersistenceData.CRS1)
         end
      end
      if (XPLMFindDataRef("sim/cockpit/radios/nav2_obs_degm") ~= nil) then
         if pxpSwitchData.PersistenceData.CRS2 ~= nil then
            set("sim/cockpit/radios/nav2_obs_degm", pxpSwitchData.PersistenceData.CRS2)
         end
      end

      print("PersistenceXP Default Nav Radio State Loaded")
   end
end