//::///////////////////////////////////////////////
//:: Empty Body
//:: NW_S2_Empty.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature can attack and cast spells while
    invisible
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.28
- was not a supernatual effect
*/

#include "cmi_includes"

void main()
{
    if(!GetHasFeatEffect(FEAT_EMPTY_BODY))
    {
        //Declare major variables
        object oTarget = OBJECT_SELF;
        effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
        effect eCover = EffectConcealment(50);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eCover, eVis);
        eLink = EffectLinkEffects(eLink, eDur);
        eLink = SupernaturalEffect(eLink);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_EMPTY_BODY, FALSE));
        int nDuration = GetLevelByClass(CLASS_TYPE_MONK);
		
		if (GetHasFeat(FEAT_EPIC_EMPTY_BODY))		
		{
			nDuration += GetAbilityModifier(ABILITY_WISDOM, OBJECT_SELF);
			nDuration += GetLevelByClass(CLASS_TYPE_SACREDFIST);
		    effect eHaste = EffectHaste();
		    effect eDur2 = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
		    effect eLink2 = EffectLinkEffects(eHaste, eDur2);	
			eLink2 = SetEffectSpellId(eLink2, SPELL_HASTE);
        	eLink2 = SupernaturalEffect(eLink2);								
        	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));			
		}

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }
}