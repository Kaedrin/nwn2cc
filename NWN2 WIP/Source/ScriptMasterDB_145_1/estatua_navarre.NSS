//Edited from the original script "estatua", added the option to choose the animation before the "Freeze".
//Just create the string variable ANIMATION_NAME in the Creature with the name of the animation you want, if not the script will use as Default: "Flirt".
//Thanks HyperV for yor help.

#include "NW_I0_GENERIC"
#include "ginc_event_handlers"
void main()
{
	effect eFreeze 	= SupernaturalEffect(EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION));
	effect eStone	= SupernaturalEffect(EffectNWN2SpecialEffectFile("rh_fx_statue")); 
	int iRand		= d8(1);
	float fRand		= IntToFloat(iRand)/4; 
	ApplyEffectToObject( DURATION_TYPE_PERMANENT,eStone,OBJECT_SELF );
	string sAnimation = GetLocalString(OBJECT_SELF, "ANIMATION_NAME");
	string sAnimationDefault = "Worship";
	
	if (sAnimation == "")
		{
		sAnimation = sAnimationDefault;
		}	
	
	SetSoundSet(OBJECT_SELF,448);
	SetOrientOnDialog(OBJECT_SELF,FALSE);
	SetPlotFlag(OBJECT_SELF,TRUE);
	SetBumpState(OBJECT_SELF,BUMPSTATE_UNBUMPABLE);
	SetAllEventHandlers(OBJECT_SELF, SCRIPT_OBJECT_NOTHING);
	SetEventHandler(OBJECT_SELF, CREATURE_SCRIPT_ON_DIALOGUE, "gb_statue_conv");
	PlayCustomAnimation(OBJECT_SELF,sAnimation,1,2.0);
	DelayCommand(fRand,ApplyEffectToObject( DURATION_TYPE_PERMANENT,eFreeze,OBJECT_SELF ));
}