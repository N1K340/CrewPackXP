--[[
Crew Pack Script for Non Assigned Aircraft

Voices by https://www.naturalreaders.com/
Captn: Guy
FO: Ranald
Ground Crew: en-AU-B-Male (what a name...)
Safety: Leslie

Changelog:
V0.1 - Initial Test Beta
--]]
if AIRCRAFT_FILENAME ~= "757-200_xp11.acf" then
   --------
   -- Initialisation Variables
   local version = "CPXP_UKN: 0.1-beta"

   require "graphics"

   -- Local Variables

   print("CrewPackXP: Initialising version " .. version)
   print("CrewPackXP: Unsupported Aircraft Type " .. AIRCRAFT_FILENAME)
   -- Settings

   if not SUPPORTS_FLOATING_WINDOWS then
      -- to make sure the script doesn't stop old FlyWithLua versions
      print("imgui not supported by your FlyWithLua version, please update to latest version")
   end

   -- Create Settings window
   function ShowCrewPackXPSettings_wnd()
      CrewPackXPSettings_wnd = float_wnd_create(450, 450, 0, true)
      float_wnd_set_title(CrewPackXPSettings_wnd, "CrewPackXP Settings")
      float_wnd_set_imgui_builder(CrewPackXPSettings_wnd, "CrewPackXPSettings_contents")
      float_wnd_set_onclose(CrewPackXPSettings_wnd, "CloseCrewPackXPSettings_wnd")
   end

   function CrewPackXPSettings_contents(CrewPackXPSettings_wnd, x, y)
      local winWidth = imgui.GetWindowWidth()
      local winHeight = imgui.GetWindowHeight()
      local titleText = "CrewPackXP Settings"
      local titleTextWidth, titileTextHeight = imgui.CalcTextSize(titleText)

      imgui.SetCursorPos(winWidth / 2 - titleTextWidth / 2, imgui.GetCursorPosY())
      imgui.TextUnformatted(titleText)

      imgui.Separator()
      imgui.TextUnformatted("")
      imgui.TextUnformatted("CrewPackXP has not recognised the loaded aircraft,")
      imgui.TextUnformatted("Callout functions are not available.")
      imgui.TextUnformatted("Aircraft compatible with CrewPackXP:")
      imgui.TextUnformatted("- Flight Factor Boeing 757-200/-300")
      imgui.TextUnformatted("- Flight Factor Boeing 767-200/-300ER")
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