# 767CrewPack
Crew Pack for the Flight Factor 757 / 767 in X-Plane 11

This plugin adds basic crew calls to the FF 757 and 767 aircraft, along with some procedural PNF help.

Includes:
* Automatically selects the EHSI to map mode and displays 10 nm range with TFC on initialisaiton. If engines are shutdown the GPU will be brought online.
* Full takeoff calls by both crew, based on the FMS speed entreies, automatic VNAV engagement if not already armed at the acceleration height in FMS takeoff ref page 2.
* Automatic selection of transponder to TA/RA when passing 80kts, if not already turned on.
* Localiser and glide slope calls, which will reset once the loc signal has full scale deflection. Some nusiance calls may be made if the ILS frequency is left tuned in other stages of flight.
* Landing speedbrake calls.
* Go around calls with PNF actively managing aircraft configuration. When pressing the TOGA clickspot on the MCP, the PNF will select flaps 20, select the gear up,   attempt to engage LNAV at 400ft AGL, select climb thrust at the acceleration height, attempt to engage VNAV or FLCH at Flap 0 speed if there is no valid VNAV path.
* After shutdown, the ground crew will connect the GPU, open L1, fwd/aft cargo doors and bring the belt loaders to the aircraft.

Prerequisite
============
This plugin uses the FlyWithLUA plugin to interface with X-Plane.
It is available freely from the .org 

https://forums.x-plane.org/index.php?/files/file/38445-flywithlua-ng-next-generation-edition-for-x-plane-11-win-lin-mac/

Installation
============

Copy the 767Callouts folder and the 767CrewPack.lua file into the X-Plane 11 > Resources > plugins > FlyWithLua > Scripts folder.
If sucesfull the First Officer should announce his entery the cockpit roughly 15 seconds after loading in.


Disclaimer / Feedback
=====================

This package is to be distributed as Freeware only.
Installation and use of this package is at your own risk. 

This is the first time I have coded a plugin, any feedback is welcome.
Bug reports, please include the x-plane log.txt file in the main x-plane folder for the flight in question. 

This plugin is still a work in progress, to be considered as public beta. Errors may exist.




Change Log
==========
* V0.1 - Initial Beta Release.
* v0.2 - local variable corrections to TOGA, Speedbrakes and Horseplay.
* v0.3 - Complete crosscheck and tweak of local variables.
* v0.4 - VNAV on Takeoff and LOC intercept right of localiser issues fixed.
* v0.5 - Added logic to cockpit setup / shutdown to connect the GPU (setup brings online), open L1, fwd/aft cargo and brings in belt loaders.
            N.B. Attempting to disconnect the GPU whilst it is on bus will cause the GPU circuit of the aircraft to fail.
v0.5.1 - Finally found chocks dataref. Adjust doors logic per frame. Added beacon on to remove all GSE. Cockpit Setup expanded to FO preflight and  Baro sync.
