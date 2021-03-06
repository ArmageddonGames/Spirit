# SPIRIT WEAPON FOR ZELDA QUEST AETERNAL READ ME

## HEADER INFORMATION
**NAME:** *Spirit Weapon*

**AUTHOR:** *Orithan Fox*

**VERSION:** Alpha 4, Build 1

**ZELDA QUEST VERSION:** *Zelda Quest AEternal* (v2.55) Alpha 92 and up


***WARNING! THIS IS IN ALPHA STATE. FEATURES MAY BE CHANGED OR REMOVED WITHOUT PRIOR WARNING. SOME FEATURES ARE INCOMPLETE OR NONFUNCTIONAL. YOU HAVE BEEN WARNED.***



## OVERVIEW 

The header is planned to sport a number of special features which aid inexperienced scripters in the creation of custom weapons and items generated and used by the player. The header automatically handles many of the tedious tasks which must be done when handling weapons including updating stuff like collision data and pausing the weapons while the header is paused. Packaged with the header is a variety of commonly-used movement functions.

Any functions, constants, etc that are included in the namespace `Spirit::Internal` are reserved for internal use.

It is also important that, if using this header and are using the Explode death type, that you turn off the quest rule `Scripted Bomb LWeapons Hurt Link` under `Quest->Rules->Items` due to a quirk in how blast damage from explosions generated via script is calculated. When you set the Damage of a Bomb Blast LWeapon generated via script; the bomb blast now hits the Player for *whole* hearts equal to the weapon's Damage (eg. You set a Bomb Blast's Damage to 8 via script. Instead of dealing 2 Hearts of damage like what most weapons do, it deals 8 Hearts of damage to the Player).
Another setting you should check before setting up this header is `Sprite Coordinates are Float` in the `objects` tab under `ZScript->Quest Script Settings`.



## SPECIAL FEATURES 

There are planned to be many different movement types. Eventually, I may add full compatibility between all different movement types but that will be far into the future if that ever happens

The header planned to be include a buffer system. Using a large array, the end user can store the data for a number of weapons and then generate copies of them later when needed.

On addition to the basic animation weapons have, it is planned for you to be able to create animation rules for a weapon when you call the SpiritLW_Animate() function using specially designed arrays.
The arrays should be formatted like this when called:
`int AnimationArray[] = {tile1, tile2, tile3...};`
They can also be defined in the function as array literals.

For more advanced scripters who might be more comfortable with how ZScript works, there is plenty of space for expanding the header's features by adding more movement types, lifepsan types, etc. The header is also designed in a way in which slotting them in is quick and easy and even accessible to inexperienced scripters.



## ANATOMY OF A SPIRIT WEAPON SCRIPT

A Spirit Weapon script has a basic anatomy which clearly outlines where to slot the components of your script into. There are four clearly defined components of the script weapon anatomy, defined in the following example.

The following example script is a fully functional Spirit Weapon script, stripped down to its bare bones. The comment blocks detail each component of the script
Example script:
```
lweapon script ExampleWeapon{
	void run()
	{ 
		/*
		START
		At the beginning of the script, after void run() and before the body of the script. Declare your working variables here as well as any counters you need to use and anything else that happens when the script is assigned.
		*/
		while(Spirit_IsAlive(this))
		{
			/*
			BODY
			Run the stuff the weapon does during the time the script runs. This includes stuff that is run in loops, which you will always need when running a Spirit Weapon script.
			The condition in the loop can be anything. You can make it so the loop ends after 120 frames. However, it is highly advisable that the script checks for if the LWeapon is alive in any given loop.
			*/
		
			/*
			UPDATE
			Directly before Spirit_Waitframe in any given loop that is needed to run for more than a frame, you put stuff that needs to be updated every frame of the loop
			"Spirit_Waitframe(this)" can be replaced with a custom Waitframe function that also calls Spirit_Waitframe at the end if necessary. Remember to also pass the weapon's pointer through as well!
			*/
			Spirit_Waitframe(this);
		}
		/*
		Note:
		You can run several different loops in a spirit LWeapon script before the weapon is to die. If they are to persist more than a frame, they also need Spirit_Waitframe and, if necessary, other updates to be run
		*/
		
		if(!Spirit_IsAlive(this))
		{
			/*
			DEATH
			Run effects that occur after the weapon is set to die. This can occur without having flagged the weapon as dead (or having used Spirit_Kill()) if omit the conditional but it is highly recommended that you use it because it allows for other scripts to detect that the weapon has died.
			In order for these to come into effect, the weapon must also still be valid after death.
			*/
		}
	}
}
```


## IMPORTANT CONCEPTS

This header has a number of important concepts and processes planned to be in this header. It is important to understand these

#### Namespaces:
Namespaces are a scripting feature added in _ZC_ _v2.55_ which allows scripters to set scripts, global functions, global variables, etc. into an arbitary scope which can be invoked at any time, including across files. Multiple declarations of the same namespace also share their scope and contents between each other.
Spirit.zh makes extensive usage of namespaces to allow for simple, succinct setup of script, variable, function, etc. names and allows for you to call them in a more shortform matter when your scripts are set up appropriately.

In order to invoke something set into a namespace, you can do the following:
A) Declare the namespace
Example:
```
namespace Spirit
{
	//Stuff goes here. Anything that is declared in other instances of the namespace are in scope.
}
```

B) Invoke the Namespace using `[namespace]::` for a single call
Example:
```
lweapon spirit = Spirit::CreateLWeapon(type, wscript, weaponD, parent, x, y, damage, step, angle, sprite, sfx, flags);
```

C) Invoke the Namespace for a given scope by calling `using namespace [namespace];`. This does not carry over across multiple files if declared at a global scope.
```
using namespace Spirit;
bool collision = SolidRectCollisionSides(spirit->X, spirit->Y, spirit->X+spirit->HitWidth, spirit->Y+spirit->HitHeight); //Spirit:: is in scope
Trace(collision);
```
If you wish to make a given namespace permanently in scope, you may instead call `always using namespace [namespace]` but this is not done in this header.
A limitation to the `using namespace` token is that two objects using the same name at the same scope will confuse the compiler and give you a compile error.
Example:
```
CONFIG SP_BLANK = 43;
using namespace Spirit;
Trace(SP_BLANK); //ERROR. Compiler cannot tell between the SP_BLANK object declared outside of the namespace and the one declared in the header.
//You may get around this limitation by specifying which namespace to choose. This will be covered in more detail later.
Trace(::SP_BLANK); //Will trace 43
Trace(Spirit::SP_BLANK); //Will trace whatever it is set in the header
```

In order to invoke a namespace of a namespace which is nested within another, you must first invoke the parent namespace first.
Example:
```
namespace Spirit
{
	namespace Misc
	{
		//Spirit::Misc:: are now in scope
	}
	//Misc:: leaves scope
	void foo()
	{
		lweapon spirit = CreateLWeapon(type, wscript, weaponD, parent, x, y, damage, step, angle, sprite, sfx, flags);
		Trace(Misc::GetDirAngle(spirit, true)); //Spirit:: is already in scope, no need to call that preceeding Misc::.
	}
	using namespace Misc;
	//Spirit::Misc:: are now in scope whenever you declare the Spirit namespace.
}
namespace Misc
{
	//ERROR. You will have declared different Misc::, one which is not parented by Spirit::
}
```

You can specify which scope you can call an object at regardless of what namespaces are in scope.
In order to specify an object at the global scope, append `::` to the start of the function call.
Example:
```
CONFIG SP_BLANK = 43;
namespace Spirit
{
	void foo()
	{
		Trace(SP_BLANK); //Will trace whatever it is set in the header
		Trace(Spirit::SP_BLANK); //Will trace whatever it is set in the header regardless of which scope it is in
		Trace(::SP_BLANK); //Will trace 43
	}
}
```

The namespaces of each function included in the header's documentation are denoted at the top of the section the function is in as `[namespace]::`.

For more information on namespaces, please consult `ZScript_Additions.txt`, located in `[ZC/ZQ directory]\docs` by default.

#### Slot:
A chunk of data corresponding to one whole entity in any of the Spirit Weapon arrays.
	In `SpiritWeaponBuffer[];`:
		Functionality has not been implemented yet

#### Death:
The spirited LWeapon's script is set to end. This does not mean it is removed, nor does removing it automatically causes any of its death effects to occur.
	Spirited LWeapons die when they are set to die; usually when Spirit_Kill() is called. This usually ends the script afterwards and triggers death effects, but...
	Spirited LWeapons can be revived; through calling Spirit_Revive(). This can be done to give the weapon an illusion of "lives", requiring several Spirit_Kill() calls to finally kill it or it can be done to cause it to do different things after killing it. There is no limit to the number of times you revive a spirited LWeapon, as long as it is not after all loops that require it to be alive.

	

## DEMO QUEST

The quest file packaged with this header will be small demo quest designed to explore the usage of the header. When completed; this demo quest will contain all of the prepackaged weapons for the player to see in action for the player to obtain.
The demo quest will contain a dungeon, complete with a boss at the end, and an overworld area to explore. While the overall difficulty will be tuned down, you can adjust it by enabling/disabling defensive upgrades, increasing or decreasing maximum Hearts and/or magic and increasing or decreasing damage on stuff.

Currently the demo quest is very barren and in a pre-alpha state. It currently only exists to test the current movement types.



## CREDITS

###### Creator
**Orithan Fox**

###### Spirit ZH credits:
**ZoriaRPG:** Providing support

**Emily:** Providing support and some code

###### Demo Quest credits:
**Raiden:** Assembling the Dance of Remembrance Tileset