//::///////////////////////////////////////////////
//:: Divine Fortune
//:: cmi_s2_divfortune
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

	int nSpellID = SPELLABILITY_Divine_Fortune;
   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(STR_REF_FEEDBACK_NO_MORE_TURN_ATTEMPTS);
   }
   else
   {
        effect eVis = EffectVisualEffect( VFX_HIT_SPELL_EVOCATION );
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        if (nCharismaBonus>0)
        {
        

            effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4);
            effect eLink = EffectLinkEffects(eSave, eDur);
			eLink = SetEffectSpellId(eLink, nSpellID);
            eLink = SupernaturalEffect(eLink);

            RemoveEffectsFromSpell(OBJECT_SELF,nSpellID);
			
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCharismaBonus));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}