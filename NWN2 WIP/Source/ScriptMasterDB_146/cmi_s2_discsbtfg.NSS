//::///////////////////////////////////////////////
//:: Discover Subterfuge
//:: cmi_s2_discsbtfg
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 22, 2008
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
	
	int nSpellId = SPELLABILITY_SHDWSTLKR_DISCOVER_SUBTERFUGE;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	 
	int nClass = GetLevelByClass(CLASS_SHADOWBANE_STALKER, OBJECT_SELF);
	int nBonus = 2;
	
	if (nClass > 7) //8th
		nBonus = 6;
	else if (nClass > 4) //5th
		nBonus = 4;
		
	effect eSkill = EffectSkillIncrease(SKILL_SEARCH, nBonus);
	eSkill = SetEffectSpellId(eSkill,nSpellId);
	eSkill = SupernaturalEffect(eSkill);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSkill, OBJECT_SELF));	
}      