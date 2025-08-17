//::///////////////////////////////////////////////
//:: Dervish, Dervish Dance
//:: cmi_s2_dervdance
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2009
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{	
	//Safe to leave as normal int since it doesn't scale past 5
	//Otherwise DAMAGE_BONUS needs to be set using GetDamageBonusByValue(x)
	int nLevel = GetLevelByClass(CLASS_DERVISH, OBJECT_SELF);
	int nBonus = (nLevel +1) / 2;
		
	int	nPerform = GetSkillRank(SKILL_PERFORM) / 2;
	float fDuration = RoundsToSeconds(nPerform);
	
	//Snowflake has the same rules as Dervish Dance
	int bValid = IsSnowflakeValid(OBJECT_SELF, TRUE);	
	if (bValid)
	{
		effect eAB = EffectAttackIncrease(nBonus);
		effect eSlash = EffectDamageIncrease(nBonus, DAMAGE_TYPE_SLASHING);
		effect eLink = EffectLinkEffects(eAB, eSlash);
		eLink = SupernaturalEffect(eLink);
		eLink = SetEffectSpellId(eLink, SPELLABILITY_DERVISH_DANCE );
		
    	RemoveEffectsFromSpell(OBJECT_SELF, SPELLABILITY_DERVISH_DANCE);	
	
		//Dance of Death
    	object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);				
		if (nLevel > 9)
		{
			itemproperty iBonusFeat1 = ItemPropertyBonusFeat(IP_CONST_FEAT_CLEAVE);  //Cleave
			itemproperty iBonusFeat2 = ItemPropertyBonusFeat(45);	//Great Cleave
			if (oArmorNew == OBJECT_INVALID)
			{
				oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
				AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat1,oArmorNew,fDuration);
				AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat2,oArmorNew,fDuration);
				DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
				ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);		
			}
			else
			{
		        IPSafeAddItemProperty(oArmorNew, iBonusFeat1, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
		        IPSafeAddItemProperty(oArmorNew, iBonusFeat2, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
			}		
		}
		else
		if (nLevel > 3)
		{
			itemproperty iBonusFeat1 = ItemPropertyBonusFeat(IP_CONST_FEAT_CLEAVE);  //Cleave
			if (oArmorNew == OBJECT_INVALID)
			{
				oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
				AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat1,oArmorNew,fDuration);
				DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
				ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);		
			}
			else
			{
		        IPSafeAddItemProperty(oArmorNew, iBonusFeat1, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
			}		
		}
		
		if (nLevel < 9)	
		{	
			if (!GetHasFeat(FEAT_TIRELESS))				
				ApplyCMIFatigue(OBJECT_SELF, RoundsToSeconds(10), fDuration);
		}
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));		
	}
	else
	{
		SendMessageToPC(OBJECT_SELF, "You must be wearing light or no armor and wielding a slashing weapon (both must be slashing if two weapons are used).");
	}
}