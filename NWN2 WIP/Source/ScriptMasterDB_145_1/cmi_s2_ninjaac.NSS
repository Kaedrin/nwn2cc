//::///////////////////////////////////////////////
//:: Ninja - AC Bonus
//:: cmi_s2_ninjaac
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_NINJA_AC_BONUS;

	int bHasNinjaACbonus = GetHasSpellEffect(nSpellId,oPC);
	RemoveSpellEffects(nSpellId, oPC, oPC);	
		
	object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
	if (oLeftHand != OBJECT_INVALID)
	{
		if (
		(GetBaseItemType(oLeftHand) == BASE_ITEM_SMALLSHIELD)
		|| (GetBaseItemType(oLeftHand) == BASE_ITEM_TOWERSHIELD)
		|| (GetBaseItemType(oLeftHand) == BASE_ITEM_LARGESHIELD))
		{
				SendMessageToPC(oPC,"A ninja's AC bonus requires that user can not wear a shield.");		
				return;
		}
	}
	
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	if ((oArmor != OBJECT_INVALID && GetArmorRank(oArmor) == ARMOR_RANK_NONE) ||  oArmor == OBJECT_INVALID)
	{
		int nBonus;
		if (GetLevelByClass(CLASS_TYPE_MONK, oPC) == 0)
		{
			nBonus = GetAbilityModifier(ABILITY_WISDOM, oPC);
			if (nBonus < 0)
				nBonus = 0;
		}
		int nNinja = GetLevelByClass(CLASS_NINJA, oPC);
		int nCombined = nNinja;
		
		if (nBonus > nNinja)
			nBonus = nNinja;
		
		//AC bonus stacking for Thug/Fighter
		if (GetHasFeat(FEAT_MARTIAL_STALKER, oPC))
		{
			nCombined += GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
			nCombined += GetLevelByClass(CLASS_THUG, oPC);
		}
		
		nBonus += (nCombined / 5);
		
		if (nBonus > 0 || nNinja > 5)
		{
			effect eLink;
			if (nBonus > 0)
			{
				eLink = EffectACIncrease(nBonus);
				if (nNinja > 5)
					eLink = EffectLinkEffects(eLink, EffectSkillIncrease(SKILL_TUMBLE, (nNinja / 6 * 2)));
			}
			else
				eLink = EffectSkillIncrease(SKILL_TUMBLE, (nNinja / 6 * 2));	
				
			if (nNinja > 15)
			{
				eLink = EffectLinkEffects(eLink, EffectTrueSeeing());
			}	
							
			eLink = SetEffectSpellId(eLink,nSpellId);
			eLink = SupernaturalEffect(eLink);
				
			if (!bHasNinjaACbonus)
				SendMessageToPC(oPC,"Ninja's AC bonus is now active.");					
						
			DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
		}					
	}
	else
	{
		if (bHasNinjaACbonus)
		{
				SendMessageToPC(oPC,"A ninja's AC bonus requires that user can not wear armor.");					
		}
	}				
}