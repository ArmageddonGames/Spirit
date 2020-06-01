# SPIRIT WEAPON FOR ZELDA QUEST AETERNAL CHANGELOG


### Alpha 3 Build 1. ZC Version: 2.55 Alpha 67+. June 1st 2020. 

- Implemented basic sideview physics; which run on weapons that obey gravity.
- Changed `Spirit_Move_Bounce` to run off engine vertical movement.
- Rewrote `Spirit_Waitframe` to have the memory values stored in the weapon script itself. Also added handling for engine gravity
- Culled redundant `CONFIG`s from `SpiritWeapon.zh` and `spirit1_common.zh`


### Alpha 2 Build 2. ZC Version: 2.55 Alpha 66+. April 27th 2020.

- Fixed a couple of small errors
- Fixed up some formatting in the To Do List
- Removed a trace used for debugging in `Spirit_Waitframe` and commented the other. Another trace in `Spirit_Move_Bounce` has been removed too


### Alpha 2 Build 1. ZC Version: 2.55 Alpha 66+. April 27th 2020.

- Introduced the Changelog and the To Do List
- Amended the advice on quest rules and settings within the readme to now specify the correct rule to turn off in 2.55 and mandates the addition of the script setting that enables objects to use floating point positions
- Rewrote the movement types so they no longer utulize work values with the new floating point positions LWeapons get
- Fixed a bug where suspending the header culls weapon step speed, leaving them not having engine movement even after the header is re-enabled.