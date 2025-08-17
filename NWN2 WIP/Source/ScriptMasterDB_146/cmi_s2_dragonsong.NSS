//::///////////////////////////////////////////////
//:: Dragonsong
//:: cmi_s2_dragonsong
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 17, 2009
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
	
	int nSpellId = SPELLABILITY_DRAGONSONG;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	 
	effect ePerform = EffectSkillIncrease(SKILL_PERFORM, 2);
	ePerform = SetEffectSpellId(ePerform,nSpellId);
	ePerform = SupernaturalEffect(ePerform);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePerform, OBJECT_SELF, HoursToSeconds(72)));	
		
}      