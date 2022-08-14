# Changelog 

### v1.5 - TBA
###### Bug Fixes:
- FF767 ACP radio selection was set with Com 1 and 2 muted, will now be on full volume.

###### Enhancements:



### v1.4 - 01/04/2022
###### Bug Fixes:  
- FF767 757-200 not loading CrewPackXP aircraft module.    
- FF767 FO Preflight: HSI modes corrected; Addition of - EEC Switches, Engine Limiter Switches, Radar Tilt FUll Up, Left ACP COM 1 & 2 on for Vatsim. [#31](https://github.com/N1K340/CrewPackXP/issues/31)  
- HS650 Wouldn't engage climb thrust on subseqent departures.  [#19](https://github.com/N1K340/CrewPackXP/issues/19)  

###### Enhancements:
- ALL Status HUD been added to the left side of the screen for ease of access to settings and FO commands. [#18](https://github.com/N1K340/CrewPackXP/issues/18)    
- ALL CrewPackXP Sounds will be muted in external view. [#21](https://github.com/N1K340/CrewPackXP/issues/21)  
- ALL First officer termination checks has been added to bring aircraft to 'cold and dark' state. [#22](https://github.com/N1K340/CrewPackXP/issues/22)  
- FF767 PA volume increases when the cockpit door is open. [#21](https://github.com/N1K340/CrewPackXP/issues/21)  
- FF767 FO after landing flow expanded to include FO items on afterlanding checklist. [#46](https://github.com/N1K340/CrewPackXP/issues/46)  

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
