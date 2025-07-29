//::///////////////////////////////////////////////
//:: [Shadow Daze]
//:: [x0_S2_Daze.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Shadow dancer.
//:: Will save or be dazed for 5 rounds.
//:: Can only daze humanoid-type creatures
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 23, 2002
//:://////////////////////////////////////////////
//:: Update Pass By:
//:: March 2003: Removed humanoid and level checks to
//:: make this a more powerful daze
#include "X0_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eMind = EffectVisualEffect( VFX_DUR_SPELL_DAZE );
    effect eDaze = EffectDazed();
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
	int nDC = 10 + GetAbilityModifier(ABILITY_DEXTERITY) + GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    effect eLink = EffectLinkEffects(eMind, eDaze);

    int nDuration = 5;
    int nRacial = GetRacialType(oTarget);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 475));
	
	if (GetHasFeat(FEAT_BLADE_OF_SHADOW))
		IncrementRemainingFeatUses(OBJECT_SELF, FEAT_SHADOW_EVADE);

    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
       //Make SR check
       if (!MyResistSpell(OBJECT_SELF, oTarget))
	   {
            //Make Will Save to negate effect
            if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                //Apply VFX Impact and daze effect
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
			else
				IncrementRemainingFeatUses(OBJECT_SELF, FEAT_SHADOW_DAZE);				
        }
		else
			IncrementRemainingFeatUses(OBJECT_SELF, FEAT_SHADOW_DAZE);		
    }
}