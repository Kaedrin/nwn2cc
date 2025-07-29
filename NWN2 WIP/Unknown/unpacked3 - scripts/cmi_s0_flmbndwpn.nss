//::///////////////////////////////////////////////
//:: Flamebound Weapon
//:: cmi_s0_flmbndwpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
//:://////////////////////////////////////////////

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
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
	
   	if(GetIsObjectValid(oMyWeapon) )
	{
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING,FALSE,TRUE );
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration);
	   	return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }	
		
}      