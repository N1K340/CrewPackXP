--[[
Crew Pack Script for Non Assigned Aircraft

Changelog:
v1.0 - Main loader
v1.1 - Enable all 757/767 variants
v1.1.1 - Changed method for determining if aircraft is known

--]]

local coded_aircraft = {
   ["757-200_xp11"] = true,
   ["757-300_xp11.acf"] = true,
   ["757-c32_xp11.acf"] = true,
   ["757-RF_xp11.acf"] = true,
   ["767-200ER_xp11.acf"] = true,
   ["767-300ER_xp11.acf"] = true,
   ["767-F_xp11.acf"] = true,
   ["CL650.acf"] = true
}

if not coded_aircraft[AIRCRAFT_FILENAME] then 
   
   --------
   -- Initialisation Variables
   local cpxpVersion = "CPXP_UKN: v1.1.1"
  
  
   require "graphics"
   
   print("CrewPackXP: Initialising version " .. cpxpVersion)
   print("CrewPackXP: Unsupported Aircraft Type " .. AIRCRAFT_FILENAME)
   
   if not SUPPORTS_FLOATING_WINDOWS then
      -- to make sure the script doesn't stop old FlyWithLua versions
      print("imgui not supported by your FlyWithLua version, please update to latest version")
   end

   -- Create Settings window
   function ShowCrewPackXPSettings_wnd()
      CrewPackXPSettings_wnd = float_wnd_create(500, 450, 0, true)
      float_wnd_set_title(CrewPackXPSettings_wnd, "CrewPackXP Settings")
      float_wnd_set_imgui_builder(CrewPackXPSettings_wnd, "CrewPackXPSettings_contents")
      float_wnd_set_onclose(CrewPackXPSettings_wnd, "CloseCrewPackXPSettings_wnd")
   end

   function CrewPackXPSettings_contents(CrewPackXPSettings_wnd, x, y)
      local winWidth = imgui.GetWindowWidth()
      local winHeight = imgui.GetWindowHeight()
      local titleText = "CrewPackXP " .. cpxpVersion
      local titleTextWidth, titileTextHeight = imgui.CalcTextSize(titleText)

      imgui.SetCursorPos(winWidth / 2 - titleTextWidth / 2, imgui.GetCursorPosY())
      imgui.TextUnformatted(titleText)

      imgui.Separator()
      imgui.TextUnformatted("")
      imgui.TextUnformatted("CrewPackXP has not recognised the loaded aircraft " .. AIRCRAFT_FILENAME)
      imgui.TextUnformatted("Callout functions are not available.")
      imgui.TextUnformatted("Aircraft compatible with CrewPackXP:")
      imgui.TextUnformatted("- Flight Factor Boeing 757-200 / 300")
      imgui.TextUnformatted("- Hot Start Challenger 650")
      imgui.Separator()
      imgui.TextUnformatted("")
      imgui.TextUnformatted("If you believe the aircraft should have been recognised,")
      imgui.TextUnformatted("attempt to reload FlyWithLUA script files from the XP menu.")
      imgui.Separator()
      imgui.TextUnformatted("")
      imgui.SetCursorPos(200, imgui.GetCursorPosY())
      if imgui.Button("CLOSE") then
         CloseCrewPackXPSettings_wnd()
      end
   end

   function CloseCrewPackXPSettings_wnd()
      if CrewPackXPSettings_wnd then
         float_wnd_destroy(CrewPackXPSettings_wnd)
      end
   end

   function ToggleCrewPackXPSettings()
      if not cpxpShowSettingsWindow then
         ShowCrewPackXPSettings_wnd()
         cpxpShowSettingsWindow = true
      elseif cpxpShowSettingsWindow then
         CloseCrewPackXPSettings_wnd()
         cpxpShowSettingsWindow = false
      end
   end

   add_macro("CrewPackXP Settings", "ShowCrewPackXPSettings_wnd()", "CloseCrewPackXPSettings_wnd()", "deactivate")
   create_command(
   "FlyWithLua/CrewPackXP/toggle_settings",
   "Toggle CrewPackXP Settings",
   "ToggleCrewPackXPSettings()",
   "",
   ""
   )
end -- Master End