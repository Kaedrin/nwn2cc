//::///////////////////////////////////////////////
//:: Shield of Warding
//:: cmi_s0_shldward
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 5, 2007
//:://////////////////////////////////////////////

// Known issues: This should stack with vs Align, vs Damage, vs Racial, and vs Specific_Align as well.
//  Will need to redo the GetAC to account for it, wrapping it as a new function in the cmi_ginc_spells.
//  "StackShieldBonus(object oShield, int nBonus)" that checks all Item_Props listed above.

//x2_inc_itemprop for item properties, reference marker.

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	

	int nSpellID = SPELL_Shield_Warding;
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
	eVis = SetEffectSpellId(eVis, nSpellID);
    eVis = SupernaturalEffect(eVis);	
	
	
    object oShield   =  IPGetTargetedOrEquippedShield();
	object oHolder = GetItemPossessor(oShield);	
	
	if (GetHasSpellEffect(nSpellID, oHolder))
	{
		SendMessageToPC(OBJECT_SELF, "Shield of Warding is already active on the target. Wait for the spell to expire.");
	}	
	
	int nEnhanceBonus = 1 + (nCasterLvl/5);
	if (nEnhanceBonus > 5)
		nEnhanceBonus = 5;
			
	int nReflex = nEnhanceBonus;
	
   	if(GetIsObjectValid(oShield) )
	{
        SignalEvent(oShield, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		int nCurrent = IPGetWeaponEnhancementBonus(oShield,ITEM_PROPERTY_AC_BONUS);
		if (GetLastSpellCastClass() == 6)
			nEnhanceBonus = nEnhanceBonus + nCurrent;
		else
			nEnhanceBonus = nCurrent++;
		
		IPSafeAddItemProperty(oShield, ItemPropertyACBonus(nEnhanceBonus), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
		IPSafeAddItemProperty(oShield, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, nReflex), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oHolder , fDuration);
	   	return;
    }
    else
    {
    	FloatingTextStringOnCreature("*Spell Failed: Target must be a shield or creature with a shield equipped.*", OBJECT_SELF);
    	return;
    }	
		
}      