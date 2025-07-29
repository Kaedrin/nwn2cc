/*
Author: 		DM_Nocturne
Created: 		November 5, 2013
Last Modified:	November 5, 2013
Description:

Lyons Guild Item script - Turns the user into a Pixie for 20 minutes, as per Word of Changing.
*/


// #include "x2_inc_spellhook"
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"

void main()
{
	object oLyon = GetItemActivator();
	int nArcaneShapesCanCast = GetLocalInt(GetModule(), "ArcaneShapesCanCast");
	int nHasGutturalInvoc = FALSE;
	
	if (GetHasFeat(FEAT_GUTTURAL_INVOCATIONS,oLyon))
	{
		nArcaneShapesCanCast = TRUE;
		nHasGutturalInvoc = TRUE;
	}
		
    //Declare major variables
    int nSpell = SPELL_I_WORD_OF_CHANGING;
	if (GetHasSpellEffect(nSpell, oLyon))
	{
		RemoveSpellEffects(nSpell, oLyon, oLyon);
	}			
	
    object oTarget = GetSpellTargetObject();
	float fDuration = TurnsToSeconds(20);

    effect eVis = EffectVisualEffect(VFX_INVOCATION_WORD_OF_CHANGING);
	
	// Hyper-V's addition to pixie shape
	int nPoly;
	if (GetGender(oLyon) == GENDER_MALE)
		nPoly = 158; // Pixie male polymorph
	else
		nPoly = 159; // Pixie female polymorph
		
    effect ePoly = EffectPolymorph(nPoly, FALSE, nArcaneShapesCanCast);
	effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ALCHEMICAL_SILVER, 0, DR_TYPE_GMATERIAL);
    effect eLink = EffectLinkEffects(eDR, eVis);
	//eLink = EffectLinkEffects(eLink, ePoly);
	
	if (!GetHasFeat(FEAT_GUTTURAL_INVOCATIONS))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}
	
	eLink = EffectLinkEffects(eLink, ePoly);
    //Fire cast spell at event for the specified target - IS always self, shoudl not matter.
    //SignalEvent(oTarget, EventSpellCastAt(oLyon, nSpell, FALSE));

    //Apply the VFX impact and effects
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.4, AssignCommand(oLyon, ClearAllActions())); // prevents an exploit
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oLyon, fDuration));
	
	if (GetLocalInt(GetModule(), "UnarmedPolymorphFeatFix"))
		DelayCommand(2.0f, WildShape_Unarmed(oLyon, fDuration));		
	
	if (nHasGutturalInvoc)
	{
		//object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
		//itemproperty ipBonusFeat5 = ItemPropertyBonusFeat(125);  
		DelayCommand(2.0f, IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oLyon), ItemPropertyBonusFeat(125),fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE));	
	}				
}