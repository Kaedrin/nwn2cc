//::///////////////////////////////////////////////
//:: Slow
//:: cmi_hx_slow
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //Declare major variables
    object oTarget;
    effect eSlow = EffectSlow();
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_SLOW);
	eSlow = EffectLinkEffects( eSlow, eVis );
    eSlow = SetEffectSpellId(eSlow, SPELL_SLOW);
	eSlow = SupernaturalEffect(eSlow);
	
    int nDuration = GetHexbladeCasterLevel();
	float fDuration = RoundsToSeconds(nDuration);
    int nCount = 0;
    location lSpell = GetSpellTargetLocation();

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    //Cycle through the targets within the spell shape until an invalid object is captured or the number of
    //targets affected is equal to the caster level.
    while(GetIsObjectValid(oTarget) && nCount < nDuration)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLOW));
            if (! MySavingThrow(SAVING_THROW_WILL, oTarget, GetHexbladeDC(3)))
            {
                //Apply the slow effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fDuration);
                nCount++;
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}