//::///////////////////////////////////////////////
//:: Agility Training
//:: cmi_s2_agiltrain
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Nov 7, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
		
	int nSpellId = SPELL_NIGHTSONGE_AGILITY_TRAINING;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	
	if (oArmor == OBJECT_INVALID)
		return;
	else
	if (GetArmorRank(oArmor) != ARMOR_RANK_LIGHT)
		return;
	 
	effect eSkillBoostHide = EffectSkillIncrease(SKILL_HIDE,2);
	effect eSkillBoostMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,2);
	effect eSkillBoostTumble = EffectSkillIncrease(SKILL_TUMBLE,2);
	effect eLink = EffectLinkEffects(eSkillBoostHide,eSkillBoostMoveSilent);
	eLink = EffectLinkEffects(eLink, eSkillBoostTumble);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
	
	
}      