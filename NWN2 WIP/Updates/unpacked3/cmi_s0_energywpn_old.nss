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
	int ipDamageType;
	//SendMessageToPC(OBJECT_SELF,IntToString(nSpellId));
	
	if (nSpellId == SPELL_Weapon_Energy || nSpellId == SPELL_Weapon_Energy_F)
		ipDamageType = IP_CONST_DAMAGETYPE_FIRE;
	else
	if (nSpellId == SPELL_Weapon_Energy_A)
		ipDamageType = IP_CONST_DAMAGETYPE_ACID;
	else
	if (nSpellId == SPELL_Weapon_Energy_C)
		ipDamageType = IP_CONST_DAMAGETYPE_COLD;
	else
	if (nSpellId == SPELL_Weapon_Energy_E)
		ipDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
						
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
    object oMyWeapon   =  IPGetTargetedOrEquippedWeapon();	
	
   	if(GetIsObjectValid(oMyWeapon) )
	{
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonus(ipDamageType, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
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