//::///////////////////////////////////////////////
//:: Jagged Tooth
//:: nw_s0_jagtooth.nss
//:: Copyright (c) 2006 Obsidian Entertainment
//:://////////////////////////////////////////////
/*
	This spell doubles the critical threat range of one natural weapon
	that deals either slashing or peircing damage.  Multiple spell effects
	that increase a weapon's threat range don't stack.  This spell is
	typically cast on animal companions.
*/
//:://////////////////////////////////////////////
//:: Created By: Patrick Mills
//:: Created On: Oct 19, 2006
//:://////////////////////////////////////////////


//#include "nw_i0_spells"
#include "x2_inc_spellhook" 
//#include "nwn2_inc_metmag"
//#include "x2_inc_itemprop"
#include "cmi_ginc_spells"

void main()
{
    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

//Declare major variables
	object oTarget = GetSpellTargetObject();
	itemproperty iKeen = ItemPropertyKeen();
	itemproperty iImpCritUnarm = ItemPropertyBonusFeat(IP_CONST_FEAT_IMPCRITUNARM);
	itemproperty iNatCritUnarm = ItemPropertyBonusFeat(IPRP_FEAT_IMPCRITCREATURE);	
	effect eVis = EffectVisualEffect(VFX_SPELL_DUR_JAGGED_TOOTH);
		
	float fDuration	= IntToFloat(600*GetPalRngCasterLevel());
	fDuration =	ApplyMetamagicDurationMods(fDuration);	
	if (GetIsObjectValid(oTarget))
	{
		object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget);
		if (GetIsObjectValid(oHide))	
		{			
			IPSafeAddItemProperty(oHide, iKeen, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oHide, iImpCritUnarm, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oHide, iNatCritUnarm, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);												
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
		}
		else
		{
			oHide = CreateItemOnObject("x2_it_emptyskin", oTarget, 1, "", FALSE);
			IPSafeAddItemProperty(oHide, iKeen, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oHide, iImpCritUnarm, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oHide, iNatCritUnarm, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);												
			DelayCommand(fDuration, DestroyObject(oHide,0.0f,FALSE));
			AssignCommand(oTarget, ClearAllActions());
			AssignCommand(oTarget, ActionEquipItem(oHide,INVENTORY_SLOT_CARMOUR));	
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);				
		}		
	}
}