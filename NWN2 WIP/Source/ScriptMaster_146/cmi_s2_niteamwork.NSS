//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Infiltrator)
//:: cmi_s2_niteamwork
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_includes"

void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oTarget = GetSpellTargetObject();
	
	if (!GetHasSpellEffect(SPELL_SPELLABILITY_AURA_NI_TEAMWORK, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(84);
	
		//Create an instance of the AOE Object using the Apply Effect function
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SPELLABILITY_AURA_NI_TEAMWORK, FALSE));
	    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget);
		
				int nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR, OBJECT_SELF);
				
				int nReflexBonus = 1;
				int nSkillBonus = 2;
				int nSneak = 1;
				
				switch (nClassLevel)
				{
					case 1:
					{
						nReflexBonus = 1;
						break;
					}
					case 2:
					{
						nReflexBonus = 1;
						break;
					}
					case 3:
					{
						nReflexBonus = 1;
						break;
					}
					case 4:
					{
						nReflexBonus = 2;
						break;
					}
					case 5:
					{
						nReflexBonus = 2;
						break;
					}
					case 6:
					{
						nReflexBonus = 2;
						break;
					}
					case 7:
					{
						nReflexBonus = 3;
						break;
					}
					case 8:
					{
						nReflexBonus = 3;
						nSkillBonus = 4;
						nSneak = 2;
						break;
					}
					case 9:
					{
						nReflexBonus = 3;
						nSkillBonus = 4;
						nSneak = 2;
						break;
					}														
					case 10:
					{
						nReflexBonus = 4;
						nSkillBonus = 4;
						nSneak = 2;
						break;
					}	
				}
						
				effect eSkillBonusDisable = EffectSkillIncrease(SKILL_DISABLE_TRAP,nSkillBonus);
				effect eSkillBonusHide = EffectSkillIncrease(SKILL_HIDE,nSkillBonus);
				effect eSkillBonusMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nSkillBonus);
				effect eSkillBonusOpenLock = EffectSkillIncrease(SKILL_OPEN_LOCK,nSkillBonus);
				effect eSkillBonusSearch = EffectSkillIncrease(SKILL_SEARCH,nSkillBonus);
				effect eSkillBonusTumble = EffectSkillIncrease(SKILL_TUMBLE,nSkillBonus);
				effect eReflexBonus = EffectSavingThrowIncrease(SAVING_THROW_REFLEX,nReflexBonus,SAVING_THROW_TYPE_TRAP);
				
				effect eLink = EffectLinkEffects(eSkillBonusDisable, eSkillBonusHide);
				eLink = EffectLinkEffects(eLink, eSkillBonusMoveSilent);
				eLink = EffectLinkEffects(eLink, eSkillBonusOpenLock);
				eLink = EffectLinkEffects(eLink, eSkillBonusSearch);
				eLink = EffectLinkEffects(eLink, eSkillBonusTumble);
				eLink = EffectLinkEffects(eLink, eReflexBonus);				
				eLink = SupernaturalEffect(eLink);
				eLink = SetEffectSpellId (eLink, -SPELL_SPELLABILITY_AURA_NI_TEAMWORK);

			    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
		
	}
}