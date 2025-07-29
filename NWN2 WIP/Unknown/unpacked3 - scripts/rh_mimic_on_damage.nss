/*
Mimic on damage

written by shaughn

Checks a relfex dave to see if weapon stgicks to adhesive.
If it sticks then 8d(1)+4 bludgeon damage'
Checks str save to free weapon else weapon moves to mimic inventory

*/

#include "ginc_item"

void main()
{
	object oAttacker	=	GetLastDamager();
	object oWeapon		=	GetLastWeaponUsed(oAttacker);
	int nSlot			=	GetSlotOfEquippedItem(oWeapon,oAttacker);
	
	//check if melee weapon and not spell damage
	if(GetWeaponRanged(oWeapon) || (oWeapon == OBJECT_INVALID && GetLastSpellHarmful() == TRUE))
	{
		ExecuteScript("nw_c2_default6",OBJECT_SELF);
		return;
	}
	
	
	int nReflex		=	ReflexSave(oAttacker,16);
	int nStr		=	GetAbilityModifier(ABILITY_STRENGTH,oAttacker);
	int nStrCheck	=	d20(1)+nStr;
	
	int nDamage		=	d8(1)+4;
	effect eDamage	=	EffectDamage(nDamage,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL,FALSE);
	
	if (nReflex == SAVING_THROW_CHECK_FAILED)
	{
		SendMessageToPC(oAttacker,"You stick to the mimic's adhesive slime and it attacks you.");
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oAttacker);
		
		if(nStrCheck > 16 || oWeapon == OBJECT_INVALID)//able to free weapon from mimic or no weapon
		{
			ExecuteScript("nw_c2_default6",OBJECT_SELF);
			return;
		}
		
		GiveEquippedItem(oAttacker,OBJECT_SELF,nSlot,FALSE);
		AssignCommand(oAttacker,ActionSpeakString("The mimic has stolen my weapon"));
		PlayVoiceChat(VOICE_CHAT_WEAPONSUCKS,oAttacker);	
	}
	
	ExecuteScript("nw_c2_default6",OBJECT_SELF);
}