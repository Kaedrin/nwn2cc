//::///////////////////////////////////////////////
//:: Citadel Training
//:: cmi_s2_cittrain
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 26, 2008
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
	
	int nSpellId = SPELLABILITY_DARKLANT_CIT_TRAIN;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eDiplo = EffectSkillIncrease(SKILL_DIPLOMACY, 2);
	effect eSearch = EffectSkillIncrease(FEAT_SKILL_FOCUS_SEARCH, 2);
	effect eLink = EffectLinkEffects(eDiplo, eSearch);	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	float fDuration = HoursToSeconds(48);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));

	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_LOWLIGHTVISION);	
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);	
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);		
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);			
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
	}	
		
}      