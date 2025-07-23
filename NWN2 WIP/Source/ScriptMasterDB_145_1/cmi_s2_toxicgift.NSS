//::///////////////////////////////////////////////
//:: Toxic Gift
//:: cmi_s2_toxicgift
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"

void main()
{

   int nSpellID = SPELLABILITY_TOXIC_GIFT;

   int nWildShapeFeat = GetCurrentWildShapeFeat(OBJECT_SELF);
   
   if (nWildShapeFeat == -1)
   {
        SpeakString("This ability is tied to your wildshape ability, which has no more uses for today.");
   }
   else
   {
		if (GetHasSpellEffect(nSpellID))
			RemoveEffectsFromSpell(OBJECT_SELF, nSpellID);
			
		float fDuration = RoundsToSeconds( 2*GetHitDice(OBJECT_SELF) );
		
	    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d4, DAMAGE_TYPE_ACID);
		effect eLink = EffectLinkEffects(eVis,eDmg);
		eLink = SupernaturalEffect(eLink);
	    eLink = SetEffectSpellId(eLink, nSpellID); 
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
        DecrementRemainingFeatUses(OBJECT_SELF, nWildShapeFeat);
    }
}