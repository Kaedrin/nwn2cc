//::///////////////////////////////////////////////
//:: Deafening Clang
//:: cmi_s0_deafclang
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
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	// DC = 10 + Spelll Level (1) + cha mod
	int nDC = 0;
	int nCha = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA);
	
	if (nCha < 17)  // Up to 17 Cha
		nDC = 0; // DC = 14
	else if (nCha < 21) // Up to 21 Cha
		nDC = 1; // DC = 16
	else if (nCha < 25) // Up to 25 Cha
		nDC = 2; // DC = 18
	else if (nCha < 29) // Up to 29 Cha
		nDC = 3; // DC = 20
	else if (nCha < 33) // Up to 33 Cha
		nDC = 4; // DC = 22
	else if (nCha < 37) // Up to 37 Cha
		nDC = 5; // DC = 24
	 
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
	
   	if(GetIsObjectValid(oMyWeapon) )
	{
        IPSafeAddItemProperty(oMyWeapon, ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS, nDC), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE,FALSE );
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING,FALSE,TRUE );
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration);
	   	return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }	
		
}      