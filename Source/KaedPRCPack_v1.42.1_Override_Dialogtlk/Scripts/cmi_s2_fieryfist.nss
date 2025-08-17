//::///////////////////////////////////////////////
//:: Fiery Fist
//:: cmi_s2_fieryfist
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

   int nSpellID = SPELLABILITY_FIERY_FIST;
   
   if (!GetHasFeat(39, OBJECT_SELF))
   {
        SpeakString("This ability is tied to your stunning fist ability, which has no more uses for today.");

   }
   else
   {
		if (GetHasSpellEffect(nSpellID))
			RemoveEffectsFromSpell(OBJECT_SELF, nSpellID);
			
		int nWis = (GetLevelByClass(CLASS_TYPE_MONK)/2) + (GetAbilityModifier(ABILITY_WISDOM));
		if (nWis < 1)
			nWis = 1;
		float fDuration = RoundsToSeconds( nWis );
		
	    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
		effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
		effect eLink = EffectLinkEffects(eVis,eDmg);
		eLink = SupernaturalEffect(eLink);
	    eLink = SetEffectSpellId(eLink, nSpellID); 
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
        DecrementRemainingFeatUses(OBJECT_SELF, 39);
    }
}