//:://///////////////////////////////////////////////
//:: Warlock Dark Invocation: Word of Changing
//:: nw_s0_iwordchng.nss
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//::////////////////////////////////////////////////
//:: Created By: Brock Heinz
//:: Created On: 12/08/05
//::////////////////////////////////////////////////
/*
        Word of Changing    Complete Arcane, pg. 136
        Spell Level:        2
        Class: 	            Misc

        This invocation is the equivalent of the 
        shapechange spell (9th level wizard).

        [Rules Note] In the rules this invocation is 
        the equivalent of the baleful polymorph spell. 
        That spell isn't in NWN2, so shapechange is used 
        instead.
*/


#include "x2_inc_spellhook"
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"

void main()
{


    if (!X2PreSpellCastCode())
    {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nArcaneShapesCanCast = GetLocalInt(GetModule(), "ArcaneShapesCanCast");
	int nHasGutturalInvoc = FALSE;
	
	if (GetHasFeat(FEAT_GUTTURAL_INVOCATIONS))
	{
		nArcaneShapesCanCast = TRUE;
		nHasGutturalInvoc = TRUE;
	}
		
    //Declare major variables
    int nSpell = GetSpellId();
	if (GetHasSpellEffect(nSpell,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpell, OBJECT_SELF, OBJECT_SELF);
	}			
	
    object oTarget = GetSpellTargetObject();
	float fDuration = TurnsToSeconds( GetWarlockCasterLevel(OBJECT_SELF ) );

    effect eVis = EffectVisualEffect(VFX_INVOCATION_WORD_OF_CHANGING);
	
    effect ePoly;
	
	if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
		ePoly = EffectPolymorph(WORD_OF_CHANGING_PIT_FIEND, FALSE, nArcaneShapesCanCast);	
	else
		ePoly = EffectPolymorph(POLYMORPH_TYPE_HORNED_DEVIL, FALSE, nArcaneShapesCanCast);	
	if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
		ePoly = EffectPolymorph(WORD_OF_CHANGING_HEZEBEL, FALSE, nArcaneShapesCanCast);	
		
	effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ALCHEMICAL_SILVER, 0, DR_TYPE_GMATERIAL);
    effect eLink = EffectLinkEffects(eDR, eVis);
	effect eSR = EffectSpellResistanceIncrease(28);
	eLink  = EffectLinkEffects(eLink, eSR);
	eLink = EffectLinkEffects(eLink, ePoly);
	
	if (!GetHasFeat(FEAT_GUTTURAL_INVOCATIONS))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}
	
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));

    //Apply the VFX impact and effects
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.4, AssignCommand(oTarget, ClearAllActions())); // prevents an exploit
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
	
	if (GetLocalInt(GetModule(), "UnarmedPolymorphFeatFix"))
		DelayCommand(2.0f, WildShape_Unarmed(oTarget, fDuration));		
	
	if (nHasGutturalInvoc)
	{
		//object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
		//itemproperty ipBonusFeat5 = ItemPropertyBonusFeat(125);  
		DelayCommand(2.0f, IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF), ItemPropertyBonusFeat(125),fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE));	
	}				
}