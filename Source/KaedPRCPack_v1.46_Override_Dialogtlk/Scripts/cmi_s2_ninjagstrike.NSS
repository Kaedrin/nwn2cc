//::///////////////////////////////////////////////
//:: Ninja - Ghost Strike
//:: cmi_s2_ninjagstrike
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
	
	if (IsNoArmorValid())
	{
		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		float fDuration = RoundsToSeconds(3);	
		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration);	
		
		itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_GHOST_WARRIOR);	//Uncanny Dodge
	    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
		if (oArmorNew == OBJECT_INVALID)
		{
			oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
			AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
			DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
			ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);		
		}
		else
		{
	        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
		}	
		
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_NINJA_KI_POWER_1);
	}					
	else
		SendMessageToPC(OBJECT_SELF, "You may not use this ability while wearing armor.");		
}