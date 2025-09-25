//::///////////////////////////////////////////////
//:: Sacred Stealth
//:: cmi_s2_scrdstlth
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

	int nSpellId = SPELLABILITY_SHDWSTLKR_SACRED_STEALTH;
	
   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(STR_REF_FEEDBACK_NO_MORE_TURN_ATTEMPTS);
   }
   else
   {
      if(GetHasSpellEffect(nSpellId,OBJECT_SELF))
	  	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);

		int nClass = GetLevelByClass(CLASS_SHADOWBANE_STALKER, OBJECT_SELF);
		int nBonus = 4;
		if (nClass > 6) //7th
			nBonus = 8;
						
        effect eVis = EffectVisualEffect( VFX_HIT_SPELL_EVOCATION );
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        if (nCharismaBonus>0)
        {


			effect eSkill1 = EffectSkillIncrease(SKILL_HIDE, nBonus);
			effect eSkill2 = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nBonus);
			effect eLink = EffectLinkEffects(eSkill1, eSkill2);
			eLink = SetEffectSpellId(eLink,nSpellId);
			eLink = SupernaturalEffect(eLink);			

            //Fire cast spell at event for the specified target
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));

            //Apply Link and VFX effects to the target
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nCharismaBonus));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}