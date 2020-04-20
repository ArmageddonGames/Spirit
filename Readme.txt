SPIRIT WEAPON FOR ZELDA QUEST AETERNAL
READ ME

=================== HEADER INFORMATION ===================
NAME: Spirit Weapon
AUTHOR: Orithan Fox
VERSION: Alpha 1, Build 0.1
ZELDA QUEST VERSION: Zelda Quest AEternal (v2.55) Alpha 29 and up

WARNING! THIS IS IN ALPHA STATE. FEATURES MAY BE CHANGED OR REMOVED WITHOUT PRIOR WARNING. SOME FEATURES ARE INCOMPLETE OR NONFUNCTIONAL. YOU HAVE BEEN WARNED.


=================== OVERVIEW ===================

The header is planned to sport a number of special features which aid inexperienced scripters in the creation of custom weapons and items generated and used by the player. The header automatically handles many of the tedious tasks which must be done when handling weapons including updating stuff like collision data and pausing the weapons while the header is paused. Packaged with the header is a variety of commonly-used movement functions.

Any functions, constants, etc whose names are marked with __ at the start are reserved for internal use. They may change or be removed in future versions without warning.

It is also important that, if using this header and are using the Explode death type, that you turn off the quest rule "Own Bombs Hurt Link" due to a quirk in how blast damage from explosions generated via script is calculated. When you set the Damage of a Bomb Blast LWeapon generated via script; the bomb blast now hits Link for *whole* hearts equal to the weapon's Damage (eg. You set a Bomb Blast's Damage to 8 via script. Instead of dealing 2 Hearts of damage like what most weapons do, it deals 8 Hearts of damage to Link).



=================== SPECIAL FEATURES ===================

There are planned to be many different movement types. Eventually, I may add full compatibility between all different movement types but that will be far into the future if that ever happens

The header planned to be include a buffer system. Using a large array, the end user can store the data for a number of weapons and then generate copies of them later when needed.

On addition to the basic animation weapons have, it is planned for you to be able to define animation rules for a weapon when you call the SpiritLW_Animate() function using specially designed arrays.
The arrays should be formatted like this when called:
int AnimationArray[] = {tile1, tile2, tile3...};
They can also be defined in the function as array literals.

For more advanced scripters who might be more comfortable with how ZScript works, there is plenty of space for expanding the header's features by adding more movement types, lifepsan types, etc. The header is also designed in a way in which slotting them in is quick and easy and even accessible to inexperienced scripters.



=================== ANATOMY OF A SPIRIT WEAPON SCRIPT ===================


A Spirit Weapon script has a basic anatomy which clearly outlines where to slot the components of your script into. There are four clearly defined components of the script weapon anatomy, defined in the following example.

The following example script is a fully functional Spirit Weapon script, stripped down to its bare bones. The comment blocks detail each component of the script
Example script:
lweapon script ExampleWeapon{
	void run(){ 
		/*
		START
		At the beginning of the script, after void run() and before the body of the script. Declare your working variables here as well as any counters you need to use and anything else that happens when the script is assigned.
		*/
		while(Spirit_IsAlive(this)){
			/*
			BODY
			Run the stuff the weapon does during the time the script runs. This includes stuff that is run in loops, which you will always need when running a Spirit Weapon script.
			The condition in the loop can be anything. You can make it so the loop ends after 120 frames. However, it is highly advisable that 
			*/
		
			/*
			UPDATE
			Directly before Spirit_Waitframe in any given loop that is needed to run for more than a frame, you put stuff that needs to be updated every frame of the loop
			"Spirit_Waitframe(this)" can be replaced with a custom Waitframe function that also calls Spirit_Waitframe at the end if necessary. Remember to also pass this weapon's pointer through as well!
			*/
			Spirit_Waitframe(this);
		}
		/*
		Note:
		You can run several different loops in a spirit LWeapon script before the weapon is to die. If they are to persist more than a frame, they also need Spirit_Waitframe and, if necessary, other updates to be run
		*/
		
		if(!Spirit_IsAlive(this)){
			/*
			DEATH
			Run effects that occur after the weapon is set to die. This can occur without having flagged the weapon as dead (or having used Spirit_Kill()) if omit the conditional but it is highly recommended that you use it because it allows for other scripts to detect that the weapon has died.
			In order for these to come into effect, the weapon must also still be valid after death.
			*/
		}
	}
}



=================== IMPORTANT CONCEPTS ===================

This header has a number of important concepts and processes planned to be in this header. It is important to understand these

Spiriting: The act of using a weapon as a "puppet" of sorts.
	LWeapons created with this header have no collision detection - they rely on "hitting" LWeapons that they spawn when colliding with enemies to do damage. This makes it so they don't instantly die when they hit enemies and don't require constant DeadState setting to penetrate enemies. It also makes things like damage handling easier. Currently they don't collide with anything as of yet - it is still being worked on.
	To stop Spirited weapons from breaking if their Collision detection is set to true, all Spirited weapons have their Collision Detection set to false every frame if set true by something. Another notable feature is that all Spirited weapons move based off angles rather than directions - Their Direction is normally set based off their angle.
	On addition, all Spirited LWeapons have a cooldown variable. This is done to slow down the production of excessive blocking sounds on NPCs that are shielded or blocked them.

Slot: A chunk of data corresponding to one whole entity in any of the Spirit Weapon arrays.
	In SpiritWeaponBuffer[]:
		Functionality has not been implemented yet

Death: The spirited LWeapon's script is set to end. This does not mean it is removed, nor does removing it automatically causes any of its death effects to occur.
	Spirited LWeapons die when they are set to die; usually when Spirit_Kill() is called. This usually ends the script afterwards and triggers death effects, but...
	Spirited LWeapons can be revived; through calling Spirit_Revive(). This can be done to give the weapon an illusion of "lives", requiring several Spirit_Kill() calls to finally kill it or it can be done to cause it to do different things after killing it. There is no limit to the number of times you revive a spirited LWeapon, as long as it is not after all loops that require it to be alive.

	

=================== DEMO QUEST ===================

The quest file packaged with this header will be small demo quest designed to explore the usage of the header. When completed; this demo quest will contain all of the prepackaged weapons for the player to see in action for the player to obtain.
The demo quest will contain a dungeon, complete with a boss at the end, and an overworld area to explore. While the overall difficulty will be tuned down, you can adjust it by enabling/disabling defensive upgrades, increasing or decreasing maximum Hearts and/or magic and increasing or decreasing damage on stuff.

Currently the demo quest is very barren and in a pre-alpha state. It currently only exists to test the current movement types.



=================== CREDITS ===================

Creator:
Orithan Fox

Spirit ZH credits:
ZoriaRPG: Providing support
Venrob: Providing support and some code

Demo Quest credits:
Raiden: Assembling the Dance of Remembrance Tileset