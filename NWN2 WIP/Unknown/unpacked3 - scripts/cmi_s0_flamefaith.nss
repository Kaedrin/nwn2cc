//::///////////////////////////////////////////////
//:: Flame of Faith
//:: cmi_s0_flamefaith
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
//:://////////////////////////////////////////////

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
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
	
   	if(GetIsObjectValid(oMyWeapon) )
	{
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		IPSafeAddItemProperty(oMyWeapon, ItemPropertyEnhancementBonus(1), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE );
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration);
	   	return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }	
		
}      