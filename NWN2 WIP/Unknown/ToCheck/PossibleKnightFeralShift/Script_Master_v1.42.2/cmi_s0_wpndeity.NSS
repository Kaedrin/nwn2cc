//::///////////////////////////////////////////////
//:: Weapon of the Deity
//:: cmi_s0_wpnDeity
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
//:://////////////////////////////////////////////

//x2_inc_itemprop for item properties, reference marker.
// 2/26/2011 - Changed Keep Existing to Replace

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
	

	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration;
	
	if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
		fDuration = TurnsToSeconds( nCasterLvl );
	else
		fDuration = RoundsToSeconds( nCasterLvl );
		
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
	
	int nEnhanceBonus = (nCasterLvl / 3) - 1;
	if (nEnhanceBonus > 5)
	{
		nEnhanceBonus = 5;
	}
	else if (nEnhanceBonus < 1)
	{
		nEnhanceBonus = 1;
	}
	
   	if(GetIsObjectValid(oMyWeapon) )
	{
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		IPSafeAddItemProperty(oMyWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyEnhancementBonus(nEnhanceBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration);
	   	return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }	
		
}      