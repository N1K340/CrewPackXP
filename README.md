<p align="center"> 
    <img src="https://github.com/N1K340/CrewPackXP/blob/main/docs/imgs/CrewPack_XP.png"/> <br>
    <br>
    <img src="https://img.shields.io/badge/X--Plane-11.50%2B-blue"/> <img src="https://img.shields.io/badge/FlyWithLUA-2.7%2B-blue" /> <br> 
    <img src="https://img.shields.io/badge/Aircraft-Flight%20Factor%20757-blue" /> <img src="https://img.shields.io/badge/Aircraft-Flight%20Factor%20767-blue" /> <img src="https://img.shields.io/badge/Aircraft-Hot%20Start%20Challenger-blue" />
</p>
<br>
FlyWithLUA utility to add crew voices for aircraft in X-Plane 11. 
This includes basic call outs and in some cases automated assistance from the PNF. 
Settings can be adjusted to enable or dissable the whole plugin, or just certain features of each aircraft. 


## Installation

Copy the Scripts and Modules folders into the main folder of FlyWithLUA: 
X-Plane 11 > Resources > plugins > FlyWithLua

If sucesfull the First Officer should announce his entery the cockpit roughly 15 seconds after loading in.

Settings can be accessed within the sim by navigating too:
Plugins > FlyWithLua > FlyWithLua Macros > Crew Pack Settings

## Prerequisite

This plugin uses the FlyWithLUA plugin to interface with X-Plane.
It is available freely from [X-Plane.org](https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/)

Luna INI Parser (LIP) is included as an additional plugin module for use with FlyWithLua. This module allows for the saving and reading of settings data within LUA. It has been included in this package under the MIT Licence offered by creater Carreras Nicholas.

This is a common plugin, it may already exist in your modules folder causing a prompt to overwrite.

## Aircraft Config notes:

Flight Factor 757:
* Automatically selects the EHSI to map mode and displays 10 nm range with TFC on initialisaiton. If engines are shutdown the GPU will be brought online.
* Full takeoff calls by both crew, based on the FMS speed entreies, automatic VNAV engagement if not already armed at the acceleration height in FMS takeoff ref page 2.
* Automatic selection of transponder to TA/RA when passing 80kts, if not already turned on.
* Localiser and glide slope calls, which will reset once the loc signal has full scale deflection. Some nusiance calls may be made if the ILS frequency is left tuned in other stages of flight.
* Landing speedbrake calls.
* Go around calls with PNF actively managing aircraft configuration. When pressing the TOGA clickspot on the MCP, the PNF will select flaps 20, select the gear up,   attempt to engage LNAV at 400ft AGL, select climb thrust at the acceleration height, attempt to engage VNAV or FLCH at Flap 0 speed if there is no valid VNAV path.
* After shutdown, the ground crew will connect the GPU, open L1, fwd/aft cargo doors and bring the belt loaders to the aircraft.

Hot Start Challenger 650:
* Takeoff calls by both crew based on the Speed entries on the EFIS with automatic engagement of FLCH at 1,000 ft AGL. 
Important to Note:
    - Thurst values require CDU 3 to be on the thrust ref page for departure, the script will make an attempt to select
      the page during takeoff or default to 90% N1.
    - Flex takeoff is only supported if full thrust takeoff is armed first with 'N1 TO' shown on the ATS screen. This
      is required for the script to determine it is taking off and not landing as it is the only engine mode that can be read by dataref. Flex takeoff 'thrust set' call will then be based on 85% N1. A pop up will appear in top left of screen to confirm Takeoff has been armed once 'N1 TO' has occoured.
    - Calls can be reset after a rejected takeoff by coming to a stop and setting the park brake.
    ![alt text](https://github.com/N1K340/CrewPackXP/blob/main/src/Screenshots/CL650_TON1.jpg?raw=true)
* Localiser and Glide Slope Calls if the APPR mode is armed.
* Landing reverse calls
* 1'000 ft to go on altitude captures.
* FO can now preflight the aircraft if selected in the settings. All pins, covers and main gear chocks will be removed, door opened and interior lights turned on. The FO will attempt to start the APU and perform the flight compartment checks. APU faults will require manual intervention to clear.

## Disclaimer / Feedback

This package is to be distributed as Freeware only.
Installation and use of this package is at your own risk. 

This is the first time I have coded a plugin, any feedback is welcome.
Bug reports, please include the x-plane log.txt file in the main x-plane folder for the flight in question. 

Use of this code is approved for repurposing into other freeware projects, please acknowledge credits for the adaptation.

## Acknowledgements
Carreras Nicholas - [Luna INI Parser (LIP)](https://github.com/Dynodzzo/Lua_INI_Parser)  
'Togfox' - [FSE HUD](https://forums.x-plane.org/index.php?/files/file/53617-fse-hud/)

## Current Script Versions
- Flight Factor 767 - v1.0.1  
- Hot Start CL650 - v1.1

## Alternate Sources
[X-Plane.org](https://forums.x-plane.org/index.php?/files/file/79042-crewpackxp-crew-callouts/)  
[X-Pilot.com](https://forums.x-pilot.com/files/file/1404-crewpackxp-crew-callouts/)
