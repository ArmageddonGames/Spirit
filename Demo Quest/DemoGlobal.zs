#option HEADER_GUARD on
#include "std.zh"
#include "SpiritWeapon.zh"

global script Active{
	void run(){
		while(true){
			Waitdraw();
			Waitframe();
		}
	}
}

global script OnExit{
	void run(){
	}
}

global script OnSaveLoad{
	void run(){
	}
}