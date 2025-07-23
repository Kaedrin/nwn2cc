//::///////////////////////////////////////////////
//:: Repellant Flesh
//:: cmi_s2_repelflesh
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 17, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "x2_inc_itemprop"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SACREDFIST_CODE_OF_CONDUCT;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	object oWpn1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
	object oWpn2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
	
	if (GetIsObjectValid(oWpn1) || (GetIsObjectValid(oWpn2)))
	{
		//Rut roh shaggy, you have something in your hands
		effect eAB =  EffectAttackDecrease(8);
		eAB = SetEffectSpellId(eAB,nSpellId);
		eAB = SupernaturalEffect(eAB);
		
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, HoursToSeconds(48)));
			
	}
	
	
	
}      