//::///////////////////////////////////////////////
//:: War Troll
//:: cmi_hx_wartroll
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


    effect eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
    effect ePoly;
    int nPoly = POLYMORPH_TYPE_WAR_TROLL;
    int nDuration = GetHexbladeCasterLevel();
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        nDuration = nDuration * 2;
    }	
	
    ePoly = EffectPolymorph(nPoly);
	ePoly = EffectLinkEffects( ePoly, eVis );
		
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_POLYMORPH_SELF, FALSE));

    //Apply the VFX impact and effects
    AssignCommand(OBJECT_SELF, ClearAllActions()); // prevents an exploit
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, TurnsToSeconds(nDuration));
}