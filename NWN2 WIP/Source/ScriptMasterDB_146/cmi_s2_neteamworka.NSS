//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Enforcer)
//:: cmi_s2_neteamworka
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "cmi_includes"

//#include "cmi_ginc_spells"

void main()
{
	object oTarget = GetEnteringObject();
	object oCaster = GetAreaOfEffectCreator();
		
	if (oTarget != oCaster)
	{
	    if(spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster) || (oTarget == oCaster))
	    {
			if (!GetHasSpellEffect(SPELL_SPELLABILITY_AURA_NE_TEAMWORK, OBJECT_SELF))
			{
				int nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_ENFORCER, oCaster);
			
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
				//eLink = SetEffectSpellId (eLink, SPELL_SPELLABILITY_AURA_NE_TEAMWORK);
			
				SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELL_SPELLABILITY_AURA_NE_TEAMWORK, FALSE));	
			    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);			
			}
		}	
	}	
		
}