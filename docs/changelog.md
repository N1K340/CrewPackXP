# Changelog

## v1.__

### v1.4 - March 2022
**Bug Fixes:
- FF757 bug preventing 757-200 from loading in CPXP

**Features:
- Status HUD been added to the left side of the screen for ease of access to settings and FO commands
- CL650 wouldn't engage climb thrust on subseqent departures

### v1.3
- Update for HS650 to restore functions after aircraft 1.4.1 changed thrust ref page and added flex to. Different technique to initialise scripts

### v1.2.1
- Enabled all 757/767 variants

### v1.2
- Added missing sounds to HS650 Reverse, tweaked FLCH logic

### v1.1
- Corrected error in HS650 script resulting in LUA stopping

### v1.0
- Rewritten core components to make it expandable for other aircraft. Initial release of Flight Factor 757 and Hot Start Challenger 650

***
## v0.__

### v0.6
- Added settings window accesible via: plugins > FlyWithLua > Macros > 767 Crew Pack Settings.

### v0.5.1
- Finally found chocks dataref. Adjust doors logic per frame. Added beacon on to remove all GSE. Cockpit Setup expanded to FO preflight and Baro sync.

### v0.5
- Added logic to cockpit setup / shutdown to connect the GPU (setup brings online), open L1, fwd/aft cargo and brings in belt loaders. N.B. Attempting to disconnect the GPU whilst it is on bus will cause the GPU circuit of the aircraft to fail.

### v0.4
- VNAV on Takeoff and LOC intercept right of localiser issues fixed

### v0.3
- Complete crosscheck and tweak of local variables.

### v0.2
- local variable corrections to TOGA, Speedbrakes and Horseplay

### v0.1
- Initial testing release
