<p align="center"> 
    <img src="docs/imgs/CrewPack_XP.png"/> <br>
    <br>
    <img src="https://img.shields.io/badge/X--Plane-11.50%2B-blue"/> <img src="https://img.shields.io/badge/FlyWithLUA-2.7%2B-blue" /> <br> 
    <img src="https://img.shields.io/badge/Aircraft-Flight%20Factor%20757-blue" /> <img src="https://img.shields.io/badge/Aircraft-Flight%20Factor%20767-blue" /> <img src="https://img.shields.io/badge/Aircraft-Hot%20Start%20Challenger-blue" />
</p>

Updated 26/03/2022

CrewPackXP is a FlyWithLUA utility designed to add some crew communications for aircraft in X-Plane 11. This includes basic call outs, and in some cases assistance from the PNF in high workload phases of flight. Settings can be adjusted to enable or disable the whole plugin, or just certain features of each aircraft.

Flight Factor 757 / 767:
    - Virtual FO to preflight aircraft
    - Takeoff and Landing calls by both crew members
    - Flight Attendant PA's
    - Ground Crew positioning of equipment
    - Virtual FO assistance with go-around procedure

Hot Start Challenger 650:
    - Virtual FO to preflight aircraft
    - Takeoff and Landing calls by both crew members

## Source Code  
<https://github.com/N1K340/CrewPackXP/tree/main/src>

## Documentation  
<http://crewpackxp.readthedocs.io/>

## Changelog  
New features and bug fixes listed in [change log](changelog.md).

## Installation

Copy the Scripts and Modules folders into the main folder of FlyWithLUA: 
X-Plane 11 > Resources > plugins > FlyWithLua

Once enabled, the First Officer should announce his entry to the cockpit roughly 15 seconds after loading in.

Settings can be accessed within the sim by navigating too:
    > Plugins > FlyWithLua > FlyWithLua Macros > Crew Pack Settings


## Prerequisite

This plugin uses the FlyWithLUA plugin to interface with X-Plane.
It is available freely from [X-Plane.org](https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/)

Luna INI Parser (LIP) is included as an additional plugin module for use with FlyWithLua. This module allows for the saving and reading of settings data within LUA. It has been included in this package under the MIT Licence offered by creater Carreras Nicholas.

This is a common plugin, it may already exist in your modules folder causing a prompt to overwrite.

## Useage
The CrewPackXP functions operate autonomously based on in sim events, provided the aircraft is enabled within the CrewPackXP settings. Refer to each aircraft's entry in the manual for details on settings and features available.

## Disclaimer / Feedback

This package is to be distributed as Freeware only under the GPL v3 license.

This is the first time I have coded a plugin, any feedback is welcome.
Bug reports, please include the x-plane log.txt file in the main x-plane folder for the flight in question. 

## Acknowledgements
Carreras Nicholas - [Luna INI Parser (LIP)](https://github.com/Dynodzzo/Lua_INI_Parser)  
'Togfox' - [FSE HUD](https://forums.x-plane.org/index.php?/files/file/53617-fse-hud/)  
'X-Friese' - [FlyWithLUA Plugin](https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/)

## Current Script Versions
- Flight Factor 767 - dev  
- Hot Start CL650 - dev

## Alternate Sources
[X-Plane.org](https://forums.x-plane.org/index.php?/files/file/79042-crewpackxp-crew-callouts/)  
[X-Pilot.com](https://forums.x-pilot.com/files/file/1404-crewpackxp-crew-callouts/)