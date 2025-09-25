//::///////////////////////////////////////////////
//:: Elemental Essence
//:: cmi_s2_elemessence
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 12, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"

void main()
{

   int nEffectSpellID = SPELLABILITY_ELEMENTAL_ESSENCE;
   int nSpellID = GetSpellId();
   
   int nWildShapeFeat = GetCurrentWildShapeFeat(OBJECT_SELF);

   if (nWildShapeFeat == -1)
   {
        SpeakString("This ability is tied to your wildshape ability, which has no more uses for today.");
   }
   else
   {
   		if (GetHasSpellEffect(nEffectSpellID, OBJECT_SELF))
			RemoveEffectsFromSpell(OBJECT_SELF, nEffectSpellID);
   
		float fDuration = RoundsToSeconds( 20 );
		effect eLink;
		
		if (nSpellID == SPELLABILITY_ELEMENTAL_ESSENCE || nSpellID == SPELLABILITY_ELEMENTAL_ESSENCE_A)
		{
		    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
			effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
			effect eDmgRes = EffectDamageResistance(DAMAGE_TYPE_ACID, 5);
			eLink = EffectLinkEffects(eVis,eDmg);
			eLink = EffectLinkEffects(eDmgRes,eLink);
		}
		else
		if (nSpellID == SPELLABILITY_ELEMENTAL_ESSENCE_C)
		{
		    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
			effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_COLD);
			effect eDmgRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 5);
			eLink = EffectLinkEffects(eVis,eDmg);
			eLink = EffectLinkEffects(eDmgRes,eLink);
		}
		else
		if (nSpellID == SPELLABILITY_ELEMENTAL_ESSENCE_E)
		{
		    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
			effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_ELECTRICAL);
			effect eDmgRes = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 5);
			eLink = EffectLinkEffects(eVis,eDmg);
			eLink = EffectLinkEffects(eDmgRes,eLink);
		}
		else
		{
		    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
			effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
			effect eDmgRes = EffectDamageResistance(DAMAGE_TYPE_FIRE, 5);
			eLink = EffectLinkEffects(eVis,eDmg);
			eLink = EffectLinkEffects(eDmgRes,eLink);
		}					
		
		eLink = SupernaturalEffect(eLink);		
	    eLink = SetEffectSpellId(eLink, SPELLABILITY_ELEMENTAL_ESSENCE); 
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
        DecrementRemainingFeatUses(OBJECT_SELF, nWildShapeFeat);
    }
}