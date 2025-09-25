//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Enforcer)
//:: cmi_s2_neteamwork
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
		
	if (!GetHasSpellEffect(SPELL_SPELLABILITY_AURA_NE_TEAMWORK, OBJECT_SELF))
	{
		effect eAOE = EffectAreaOfEffect(VFX_PER_NE_TEAMWORK);
		//Create an instance of the AOE Object using the Apply Effect function
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SPELLABILITY_AURA_NE_TEAMWORK, FALSE));
	    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oTarget);
		
				int nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_ENFORCER, oTarget);
			
				int nSkillBonus = 2;
				if (nClassLevel > 6)
				{
					nSkillBonus = 4;
				}
						
				effect eSkillBonusListen = EffectSkillIncrease(SKILL_LISTEN,nSkillBonus);
				effect eSkillBonusHide = EffectSkillIncrease(SKILL_HIDE,nSkillBonus);
				effect eSkillBonusMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nSkillBonus);
				effect eSkillBonusSpot = EffectSkillIncrease(SKILL_SPOT,nSkillBonus);
				
				effect eLink = EffectLinkEffects(eSkillBonusListen, eSkillBonusHide);
				eLink = EffectLinkEffects(eLink, eSkillBonusMoveSilent);
				eLink = EffectLinkEffects(eLink, eSkillBonusSpot);			
				eLink = SupernaturalEffect(eLink);
				eLink = SetEffectSpellId (eLink, -SPELL_SPELLABILITY_AURA_NE_TEAMWORK);
			
			    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);	
						
	}
		
}