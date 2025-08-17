//::///////////////////////////////////////////////
//:: Mordenkainen's Disjunction
//:: NW_S0_MordDisj.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Massive Dispel Magic and Spell Breach rolled into one
    If the target is a general area of effect they lose
    6 spell protections.  If it is an area of effect everyone
    in the area loses 2 spells protections.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:: Updated On: Oct 20, 2003, Georg Zoeller
//:://////////////////////////////////////////////
void StripEffects(int nNumber, object oTarget);
#include "X0_I0_SPELLS"

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

     effect  eVis        = EffectVisualEffect(VFX_HIT_SPELL_ABJURATION);
	effect eImpact; // Now handled by ImpactSEF column in spells.2da, but req'd for DispelMagic function
    object   oTarget     = GetSpellTargetObject();
    location lLocal      = GetSpellTargetLocation();
    int      nCasterLevel= GetCasterLevel(OBJECT_SELF);
	
	if (nCasterLevel > 30)
		nCasterLevel = 30;
	int nHD = GetHitDice(OBJECT_SELF);
	if (nCasterLevel > nHD)
		nCasterLevel = nHD;
		
	
	int nSpellId = GetSpellId();
	
	if (nSpellId == SPELLABILITY_DISCHORD_DISJUNCT)
	{
		nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD);
		nSpellId = SPELL_MORDENKAINENS_DISJUNCTION;
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
	}

    //--------------------------------------------------------------------------
    // Mord's is not capped anymore as we can go past level 20 now
    //--------------------------------------------------------------------------
    /*
        if(nCasterLevel > 20)
        {
            nCasterLevel = 20;
        }
    */

    if (GetIsObjectValid(oTarget))
    {
        //----------------------------------------------------------------------
        // Targeted Dispel - Dispel all
        //----------------------------------------------------------------------
		if (IsTgtPalRngFullCaster(oTarget))
			nCasterLevel = nCasterLevel/2;		
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact,TRUE,TRUE);
    }
    else
    {
        //----------------------------------------------------------------------
        // Area of Effect - Only dispel best effect
        //----------------------------------------------------------------------

        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE );
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                //--------------------------------------------------------------
                // Handle Area of Effects
                //--------------------------------------------------------------
                spellsDispelAoE(oTarget, OBJECT_SELF,nCasterLevel);

            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId));
            }
            else
            {
				if (IsTgtPalRngFullCaster(oTarget))
					nCasterLevel = nCasterLevel/2;			
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE,TRUE);
            }

           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }
}