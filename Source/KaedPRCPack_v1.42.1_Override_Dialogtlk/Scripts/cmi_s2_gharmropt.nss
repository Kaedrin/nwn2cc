//::///////////////////////////////////////////////
//:: Greater Heavy Armor Optimization
//:: cmi_s2_gharmropt
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_GREATER_HEAVY_ARMOR_OPTIMIZATION;
	int bHasHArmorOpt = GetHasSpellEffect(nSpellId,oPC);
		
	RemoveSpellEffects(SPELLABILITY_HEAVY_ARMOR_OPTIMIZATION, oPC, oPC);
	RemoveSpellEffects(SPELLABILITY_GREATER_HEAVY_ARMOR_OPTIMIZATION, oPC, oPC);
	
	int nVal = 2;
	string Enable = "Greater Heavy Armor Optimization bonus enabled.";
	string Disable = "Greater Heavy Armor Optimization requires heavy armor.";	
	
	if (GetHasFeat(FEAT_EPIC_HEAVY_ARMOR_OPTIMIZATION,oPC))
	{
		nVal = 3;
		Enable = "Epic Heavy Armor Optimization bonus enabled.";
		Disable = "Epic Heavy Armor Optimization requires heavy armor.";	
	}
	
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	if (oArmor != OBJECT_INVALID && GetArmorRank(oArmor) == ARMOR_RANK_HEAVY )
	{
		effect eSkillBoostHide = EffectSkillIncrease(SKILL_HIDE,nVal);
		effect eSkillBoostMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nVal);
		effect eSkillBoostTumble = EffectSkillIncrease(SKILL_TUMBLE,nVal);
		effect eSkillBoostSoH = EffectSkillIncrease(SKILL_SLEIGHT_OF_HAND,nVal);	
		//effect eSkillBoostOL = EffectSkillIncrease(SKILL_OPEN_LOCK,2);
		effect eSkillBoostParry = EffectSkillIncrease(SKILL_PARRY,nVal);
		effect eSkillBoostST = EffectSkillIncrease(SKILL_SET_TRAP,nVal);
					
		effect eAC = EffectACIncrease(nVal);
		effect eLink = EffectLinkEffects(eSkillBoostHide,eSkillBoostMoveSilent);
		eLink = EffectLinkEffects(eLink, eSkillBoostTumble);
		eLink = EffectLinkEffects(eLink, eSkillBoostST);	
		eLink = EffectLinkEffects(eLink, eSkillBoostSoH);
		//eLink = EffectLinkEffects(eLink, eSkillBoostOL);
		eLink = EffectLinkEffects(eLink, eSkillBoostParry);		
		eLink = EffectLinkEffects(eLink, eAC);			
		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
		if (!bHasHArmorOpt)	
			SendMessageToPC(oPC,Enable);					
			
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));			
	}
	else
	{
		if (bHasHArmorOpt)
		{
				SendMessageToPC(oPC,Disable);					
		}
	}
		
}