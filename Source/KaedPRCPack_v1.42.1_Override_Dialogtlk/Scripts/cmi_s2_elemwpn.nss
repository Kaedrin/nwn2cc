//::///////////////////////////////////////////////
//:: Elemental Weapon
//:: cmi_s2_elemwpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 12, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"
#include "x2_inc_itemprop"

void main()
{

	int nSpellID = SPELLABILITY_ELEMWAR_WEAPON;
		
    RemoveSpellEffects(nSpellID, OBJECT_SELF, OBJECT_SELF);
	
	int DamageType;	
	int nItemVisual;
	
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_AIR))
	{	
		DamageType = DAMAGE_TYPE_ELECTRICAL;
		nItemVisual = ITEM_VISUAL_ELECTRICAL;
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_EARTH))
	{	
		DamageType = DAMAGE_TYPE_ACID;
		nItemVisual = ITEM_VISUAL_ACID;				
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_FIRE))
	{
		DamageType = DAMAGE_TYPE_FIRE;
		nItemVisual = ITEM_VISUAL_FIRE;			
	}
	else
	if (GetHasFeat(FEAT_ELEMWAR_AFFINITY_WATER))
	{
		DamageType = DAMAGE_TYPE_COLD;
		nItemVisual = ITEM_VISUAL_COLD;	
	}
	
	float fDuration =  RoundsToSeconds(10);
	
	int nElemWar = GetLevelByClass(CLASS_ELEMENTAL_WARRIOR);
	if (nElemWar == 5)
	{
		object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	    if (GetIsObjectValid(oWeapon1))
	    {
			IPSafeAddItemProperty(oWeapon1, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
		}	
		object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oWeapon2))
	    {
			if (IPGetIsMeleeWeapon(oWeapon2))
			{
				IPSafeAddItemProperty(oWeapon2, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4d6), fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);			
			}
		}
	}	
	
	effect eLink = EffectDamageIncrease(DAMAGE_BONUS_2d6, DamageType);			
		
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );		
	eLink = EffectLinkEffects(eDur, eLink);	
	eLink = SupernaturalEffect(eLink);
	eLink = SetEffectSpellId(eLink, nSpellID);
		
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
		
}