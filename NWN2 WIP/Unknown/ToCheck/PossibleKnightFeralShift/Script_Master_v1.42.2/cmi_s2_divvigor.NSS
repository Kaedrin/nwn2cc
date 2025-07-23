//::///////////////////////////////////////////////
//:: Divine Vigor
//:: cmi_s2_divvigor
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

	int nSpellID = SPELLABILITY_Divine_Vigor;
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
        
			effect eMove = EffectMovementSpeedIncrease(133);
			effect eHP = EffectTemporaryHitpoints(GetHitDice(OBJECT_SELF)*2);
            effect eLink = EffectLinkEffects(eMove, eDur);
			//eLink = EffectLinkEffects(eHP,eLink);
			eLink = SetEffectSpellId(eLink, nSpellID);
            eLink = SupernaturalEffect(eLink);
			eHP = SetEffectSpellId(eHP, nSpellID);
            eHP = SupernaturalEffect(eHP);			

            RemoveEffectsFromSpell(OBJECT_SELF,nSpellID);
			
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(nCharismaBonus));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, TurnsToSeconds(nCharismaBonus));			
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }
		else
			SendMessageToPC(OBJECT_SELF, "You are so uninspiring that Divine Vigor has failed. You must have a Charisma higher than 11 to gain any use from this ability.");

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}