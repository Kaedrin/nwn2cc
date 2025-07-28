//::///////////////////////////////////////////////
//:: Greater Dispelling
//:: NW_S0_GrDispel.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:: Updated On: Oct 20, 2003, Georg Zoeller
//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{

    //--------------------------------------------------------------------------
    /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    effect   eVis         = EffectVisualEffect( VFX_HIT_SPELL_ABJURATION );
	effect   eImpact; // Now handled by spells.2da, the ImpactSEF column, but effect required for spellsDispelMagic
    int      nCasterLevel = GetCasterLevel( OBJECT_SELF );
    object   oTarget      = GetSpellTargetObject();
    location lLocal   =     GetSpellTargetLocation();

	int nCaster = GetLastSpellCastClass();
	if (nCaster == CLASS_TYPE_WARLOCK)
	{
		nCasterLevel = GetWarlockCasterLevel(OBJECT_SELF);
	}
	if (nCaster == CLASS_TYPE_RANGER || nCaster == CLASS_TYPE_PALADIN)
	{
		nCasterLevel = GetPalRngCasterLevel(OBJECT_SELF);
	}
	int nSpellId = GetSpellId();
	if (nSpellId == SPELL_I_CASTERS_LAMENT)
	{
		RemoveSpecificEffect(EFFECT_TYPE_CURSE, OBJECT_SELF);
		/*
	    effect eRemove = GetFirstEffect(OBJECT_SELF);
	    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
	    //Fire cast spell at event for the specified target
	    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_CURSE, FALSE));
	    //Get the first effect on the target
	    while(GetIsEffectValid(eRemove))
	    {
	        //Check if the current effect is of correct type
	        if (GetEffectType(eRemove) == EFFECT_TYPE_CURSE)
	        {
	            //Remove the effect and apply VFX impact
	            RemoveEffect(OBJECT_SELF, eRemove);
	            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
	        }
	        //Get the next effect on the target
	        eRemove = GetNextEffect(OBJECT_SELF);
	    }	
		*/
	}
	
    //--------------------------------------------------------------------------
    // Dispel Magic is capped at caster level 10
    //--------------------------------------------------------------------------
    if(nCasterLevel >20 )
    {
        nCasterLevel = 20;
    }
	int nHD = GetHitDice(OBJECT_SELF);
	if (nCasterLevel > nHD)
		nCasterLevel = nHD;	

    if (GetIsObjectValid(oTarget))
    {
        //----------------------------------------------------------------------
        // Targeted Dispel - Dispel all
        //----------------------------------------------------------------------
		if (IsTgtPalRngFullCaster(oTarget))
			nCasterLevel = nCasterLevel/2;
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact);
    }
    else
    {
        //----------------------------------------------------------------------
        // Area of Effect - Only dispel best effect
        //----------------------------------------------------------------------
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                //--------------------------------------------------------------
                // Handle Area of Effects
                //--------------------------------------------------------------
                spellsDispelAoE(oTarget, OBJECT_SELF, nCasterLevel);
            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId));
            }
            else
            {
				if (IsTgtPalRngFullCaster(oTarget))
					nCasterLevel = nCasterLevel/2;
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }

}