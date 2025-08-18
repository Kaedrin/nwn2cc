//::///////////////////////////////////////////////
//:: Citadel Training
//:: cmi_s2_heartpass
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
	
	int nSpellId = SPELLABILITY_HEARTWARD_HEART_PASSION;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eDiplo = EffectSkillIncrease(SKILL_DIPLOMACY, 2);
	effect eBluff = EffectSkillIncrease(SKILL_BLUFF, 2);
	effect eIntim = EffectSkillIncrease(SKILL_INTIMIDATE, 2);
	effect ePerform = EffectSkillIncrease(SKILL_PERFORM, 2);
	effect eUMD = EffectSkillIncrease(SKILL_USE_MAGIC_DEVICE, 2);
			
	effect eLink = EffectLinkEffects(eDiplo, eBluff);
	eLink = EffectLinkEffects(eLink, eIntim);
	eLink = EffectLinkEffects(eLink, ePerform);
	eLink = EffectLinkEffects(eLink, eUMD);	
	
	if (GetLevelByClass(CLASS_HEARTWARDER) == 10)
	{
		effect eLowLight = EffectLowLightVision();
		effect eCharm = EffectImmunity(IMMUNITY_TYPE_CHARM);
		effect eDomin = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
		eLink = EffectLinkEffects(eLink, eLowLight);	
		eLink = EffectLinkEffects(eLink, eCharm);	
		eLink = EffectLinkEffects(eLink, eDomin);					
	}
		
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	
}      