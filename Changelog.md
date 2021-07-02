# SPIRIT WEAPON FOR ZELDA QUEST AETERNAL CHANGELOG

### Alpha 5 Build 1. ZC Version: 2.55 Alpha 92+. July 2nd 2021.

- Removed several unused settings and variables.
- `ENABLE_LOGGING` is renamed to `SETTING_LOGGING` to be consistent style-wise with other settings.
- Renamed `SPT_BLANK` to `SP_BLANK` to match the style used by the Sprite constants (`SP_*`) in `std.zh`
- Renamed the following files
- - `spirit1_common.zh` -> `Common.zh`
- - `spirit1_playerAnimation.zh` -> `Animate.zh`
- - `spirit1_internal.zh` -> `Internal.zh`
- - `spirit1_scripts.zh` -> `Scripts.zh`
- Removed the `Spirit_` prefixes from the following in `Common.zh`
- -	`Spirit_CreateWeapon`. Renamed to `CreateLWeapon`
- -	`Spirit_Waitframe`
- -	`Spirit_Suspend`
- -	`Spirit_Resume`
- -	`Spirit_ToggleSuspend`
- -	`Spirit_IsSuspend`
- - `Spirit_IsSpiritLW`
- - `Spirit_IsAlive`
- - `Spirit_Kill`
- - `Spirit_Revive`
- Migrated the movement functions into `Move.zh` and under the `Spirit::Move` namespace. Removed `Spirit_Move` prefixes. Also moved `Spirit_AirAdjust()` there and renamed it to `AirAdjust`
- Moved the following into `Misc.zh` and under the `Spirit::Misc` namespace:
- - `Spirit_Update_SetDirAngle()`, renamed to `SetDirAngle`
- - `Spirit_Update_GetDirAngle()`, renamed to `GetDirAngle`
- - `FixedCollision()`
- - `EffectiveX()` and `EffectiveY()`
- - Replaced the "Spiriting" section under "Important Concepts" in the readme with a "Namespaces" section, which explains the concept of namespaces and gives a quick tutorial on how to use them with this header.
- - Corrected Emily's credits listing in the readme.
- - Added a separate documentation file for internal functions.
- - Updated the documentation to give file locations for each of the sections.
- - Added `Hit.zh`, `Death.zh` and `Status.zh` files. These are imported but do nothing at the moment.

### Alpha 4 Build 1. ZC Version: 2.55 Alpha 92+. July 2nd 2021.
 
- Removed `LWFI_AIRBORNE` and `LWFI_BOUNCY` out of redundancy. Replaced `LWFI_AIRBORNE` with `LWFI_STATUSEFFECT` (all spirit1_internal)
- Changed the `LWF_*` (spirit1_common) to group the movement flags together and the piercing and unblockable flags together.
- Added `CONFIG SETTING_ACCURATE_SOLIDITY` (spirit)
- Set up definitions for six more namespaces: `Spirit::Move`, `Spirit::Animate`, `Spirit::Hit`, `Spirit::Death`, `Spirit::Status`, `Spirit::Misc`. These are currently not used.
- Added `EffectiveX()` and `EffectiveY()` for spirit weapons.
- Imported changes and additions from _Ryuu_ and _24th_ _Hour_ _Heroes_:
- - Fixed the bug in `Spirit_CreateLWeapon()` (spirit1_common) where the SFX would not be played properly.
- - Added `Spirit_Move_Increment()` (spirit1_common). This makes the weapon moves in increments as opposed to moving smoothly.
- - Added `Spirit_CanMove()` (spirit1_common). Checks to see if the weapon can move onto a given pixel, similar to its NPC complement in `Ghost.zh`. Right now it just checks for combo solidity on weapons that obey combo solidity.
- - Added `SolidCollision()` (spirit1_common). Checks the weapon's hitbox collision with solid combos.
- - Added `SolidCollisionFull()` (spirit1_common). Checks the weapon's hitbox collision with fully solid combos.
- - Overloaded `Spirit_CreateLWeapon()` (spirit1_common) to give it the ability to read from script name as opposed to script number.
- - Overloaded `RunLWeaponScript()` (spirit1_common) to give it the ability to read from script name as opposed to script number.
- - Added `CONFIG ENABLE_LOGGING` (spirit1_common). Enable the user to enable or disable the header's traces.
- - Added `Spirit_Update_SetDirAngle()` (spirit1_common). Sets a weapon's direction based off its angle.
- - Added `Spirit_Update_GetDirAngle()` (spirit1_common). Gets what a weapon's direction would become if the above function is called.
- - Changed `Spirit_CreateLWeapon()` (spirit1_common) so the internal direction of the weapon is set based off its angle on creation.
- - Removed `CONFIG LWF_NOFALL` (spirit1_common). With `lweapon->Gravity`, this is not needed.
- - Changed `CONFIG LWF_JUMPPHYSICS` (spirit1_common) from `0x0010` to `0x0008`, taking `CONFIG LWF_NOFALL`'s old place

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