--[[
    Crew Pack Script for Hot Start Challenger 650

    Voices by https://www.naturalreaders.com/


    Changelog:
    v0.1 - Initial Release
]]

if AIRCRAFT_FILENAME == "CL650.acf" then
    
    -- Initiialisation Variables
    local cpxpVersion = "HS650: 0.1"
    local cpxpInitDelay = 20
    local cpxpStartTime = 0
    dataref("cpxp_SIM_TIME", "sim/time/total_running_time_sec")    

    -- dependencies
    local LIP = requrie("LIP")
    require "graphics"

    -- Var
    local cpxpBubbleTimer = 0
    local cpxpMsgStr = ""
    local cpxpReady = false
    local cpxpStartPlayed = false
    local cpxpSoundVol = 1.0


    -- Sounds
   local cpxpStart1 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_1.wav")
   local cpxpStart2 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_2.wav")
   local cpxpStart3 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_3.wav")
   local cpxpStart4 = load_WAV_file(SCRIPT_DIRECTORY .. "CrewPackXP/Sounds/HS650/start_4.wav")

    function cpxpSetGain()
        set_sound_gain(cpxpStart1, cpxpSoundVol)
        set_sound_gain(cpxpStart2, cpxpSoundVol)
        set_sound_gain(cpxpStart3, cpxpSoundVol)
        set_sound_gain(cpxpStart4, cpxpSoundVol)
    end


    -- Generic Datarefs
    dataref("cpxpAGL", "sim/flightmodel/position/y_agl")
    dataref("cpxpFLAP_LEVER", "sim/flightmodel/controls/flaprqst", "writeable")
    dataref("cpxpGEAR_HANDLE", "1-sim/cockpit/switches/gear_handle")
    dataref("cpxpSPEED_BRAKE", "sim/cockpit2/controls/speedbrake_ratio")
    dataref("cpxpWEIGHT_ON_WHEELS", "sim/cockpit2/tcas/targets/position/weight_on_wheels", "readonly", 0)
    dataref("cpxpPARK_BRAKE", "sim/cockpit2/controls/parking_brake_ratio")
    dataref("cpxpENG1_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 0)
    dataref("cpxpENG2_N2", "sim/flightmodel2/engines/N2_percent", "readonly", 1)
    dataref("cpxpLOC_DEVIATION", "sim/cockpit/radios/nav2_hdef_dot")
    dataref("cpxpLOC_RECEIVED", "1-sim/radios/isReceivingIlsLoc1")
    dataref("cpxpGS_DEVIATION", "sim/cockpit/radios/nav2_vdef_dot")
    dataref("cpxpGS_RECEIVED", "1-sim/radios/isReceivingIlsGs1")
    --  dataref("cpxpSTROBE_SWITCH", "sim/cockpit2/switches/strobe_lights_on")
    dataref("cpxpENGINE_MODE", "1-sim/eng/thrustRefMode") --TOGA 6 -- TO 1 / 11 / 12
    --  dataref("cpxpMCP_SPEED", "sim/cockpit/autopilot/airspeed", "writeable")
    dataref("cpxpFLCH_BUTTON", "1-sim/AP/flchButton", "writeable")
    dataref("cpxpVNAV_ENGAGED_LT", "1-sim/AP/lamp/4")
    dataref("cpxpVNAV_BUTTON", "1-sim/AP/vnavButton", "writeable")
    dataref("cpxpLNAV_BUTTON", "1-sim/AP/lnavButton", "writeable")
    --  dataref("cpxpAUTO_BRAKE", "1-sim/gauges/autoBrakeModeSwitcher", "writeable")
    dataref("cpxpTOGA_BUTTON", "1-sim/AP/togaButton")
    dataref("cpxpBEACON", "sim/cockpit2/switches/beacon_on")
    dataref("cpxpLEFT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 0)
    dataref("cpxpRIGHT_STARTER", "sim/flightmodel2/engines/starter_is_running", "readonly", 1)
    dataref("cpxpBELTS_SIGN", "sim/cockpit2/annunciators/fasten_seatbelt")

    print("CrewPackXP: Initialising cpxpVersion " .. cpxpVersion)
    print("CrewPackXP: Starting at sim time " .. math.floor(cpxp_SIM_TIME))

    -- Bubble for messages
    function CPXPDisplayMessage()
        bubble(20, get("sim/graphics/view/window_height") - 100, cpxpMsgStr)
    end

    function CPXPmsg()
        if cpxpBubbleTimer < 3 then
        CPXPDisplayMessage()
        else
        cpxpMsgStr = ""
        end
    end

    function CPXPBubbleTiming()
        if cpxpBubbleTimer < 3 then
        cpxpBubbleTimer = cpxpBubbleTimer + 1
        end
    end

    do_every_draw("CPXPmsg()")
    do_often("CPXPBubbleTiming()")

--	Delaying initialisation of datarefs till aircraft loaded
    function CPXPDelayedInit()
    -- Dealy based on time

    if cpxpStartTime == 0 then
       cpxpStartTime = (cpxp_SIM_TIME + cpxpInitDelay)
       cpxpBubbleTimer = 0 - cpxpInitDelay
       ParseCrewPackXPSettings()
    end
    if (cpxp_SIM_TIME < cpxpStartTime) then
       print(
       "CrewPackXP: Init Delay " .. math.floor(cpxp_SIM_TIME) .. " waiting for " .. math.floor(cpxpStartTime) .. " --"
       )
       cpxpMsgStr = "CrewPackXP Loading in " .. math.floor(cpxpStartTime - cpxp_SIM_TIME) .. " seconds"
       return
    end
    
    if not cpxpReady then
        print("CrewPackXP: Datarefs Initialised for " .. PLANE_ICAO .. " at time " .. math.floor(cpxp_SIM_TIME))
        cpxpMsgStr = "CrewPackXP Initialised for " .. PLANE_ICAO
        cpxpBubbleTimer = 0
        cpxpReady = true
     end
  end -- End of DelayedInit
  
  do_often("CPXPDelayedInit()")

  -- Start Up Sounds
  function CPXPStartSound()
    if not cpxpReady then
       return
    end
    if cpxpStartMsg and not cpxpStartPlayed then
       local soundFile = {
          cpxpStart1,
          cpxpStart2,
          cpxpStart3,
          cpxpStart4,
       }
       math.randomseed(os.time())
       play_sound(soundFile[math.random(1,4)])
       cpxpStartPlayed = true
    end
 end

 do_often("CPXPStartSound()")






end