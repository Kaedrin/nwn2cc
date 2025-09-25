//::///////////////////////////////////////////////
//:: Divine Cleansing
//:: cmi_s2_divcleanse
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 13, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

	int nSpellID = SPELLABILITY_Divine_Cleansing;
   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(STR_REF_FEEDBACK_NO_MORE_TURN_ATTEMPTS);
   }
   else
   {
        effect eVis = EffectVisualEffect( VFX_HIT_SPELL_EVOCATION );
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
		effect eSave = EffectSavingThrowIncrease(SAVING_THROW_FORT, 2);
        effect eLink = EffectLinkEffects(eSave, eDur);
		float fDelay;
		
        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        if (nCharismaBonus>0)
        {

			eLink = SetEffectSpellId(eLink, nSpellID);
            eLink = SupernaturalEffect(eLink);
		
		    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, GetLocation(OBJECT_SELF));
		    while(GetIsObjectValid(oTarget))
		    {
		        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
		        {
					fDelay = GetRandomDelay(0.4, 1.0);
		            RemoveEffectsFromSpell(OBJECT_SELF,nSpellID);
		            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, FALSE));			
		            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCharismaBonus)));
		            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));			
		        }
		        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, GetLocation(OBJECT_SELF));
		    }
		
		}	
		

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}