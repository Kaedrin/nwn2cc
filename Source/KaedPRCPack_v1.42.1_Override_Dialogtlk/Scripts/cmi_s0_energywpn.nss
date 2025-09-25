//::///////////////////////////////////////////////
//:: Energy Weapon
//:: cmi_s0_energywpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 25, 2007
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
	
	int nSpellId = GetSpellId();
	int DamageType;
	
	if (nSpellId == SPELL_Weapon_Energy || nSpellId == SPELL_Weapon_Energy_F)
		DamageType = DAMAGE_TYPE_FIRE;
	else
	if (nSpellId == SPELL_Weapon_Energy_A)
		DamageType = DAMAGE_TYPE_ACID;
	else
	if (nSpellId == SPELL_Weapon_Energy_C)
		DamageType = DAMAGE_TYPE_COLD;
	else
	if (nSpellId == SPELL_Weapon_Energy_E)
		DamageType = DAMAGE_TYPE_ELECTRICAL;
						

	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  IPGetTargetedOrEquippedWeapon();
		

		
   	if(GetIsObjectValid(oMyWeapon) )
	{
	
		if (GetHasSpellEffect(SPELL_Weapon_Energy,GetItemPossessor(oMyWeapon)))
		{
			RemoveAnySpellEffects(SPELL_Weapon_Energy, GetItemPossessor(oMyWeapon));
		}		
		
		effect DamageBonus = EffectDamageIncrease(DAMAGE_BONUS_1d6, DamageType);
		DamageBonus = SetEffectSpellId(DamageBonus, SPELL_Weapon_Energy);
		
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
		//IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonus(ipDamageType, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, DamageBonus, GetItemPossessor(oMyWeapon), fDuration);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }	
		
}      