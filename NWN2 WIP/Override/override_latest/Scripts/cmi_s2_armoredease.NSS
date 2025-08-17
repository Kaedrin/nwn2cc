//::///////////////////////////////////////////////
//:: Armored Ease
//:: cmi_s2_armoredease
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Nov 7, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = DREADCOM_ARMORED_EASE;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	
	if (oArmor == OBJECT_INVALID)
		return;
	
	int nBonus = 0;
	if (GetLevelByClass(CLASS_DREAD_COMMANDO) > 3)
		nBonus = 4;
	else
		nBonus = 2; 
		
	effect eSkillBoostHide = EffectSkillIncrease(SKILL_HIDE,nBonus);
	effect eSkillBoostMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nBonus);
	effect eSkillBoostTumble = EffectSkillIncrease(SKILL_TUMBLE,nBonus);
	effect eLink = EffectLinkEffects(eSkillBoostHide,eSkillBoostMoveSilent);
	eLink = EffectLinkEffects(eLink, eSkillBoostTumble);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
	
	
}      