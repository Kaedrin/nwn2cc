//::///////////////////////////////////////////////
//:: Hellspawned Grace
//:: cmi_s0_hellgrace
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"

void BuffHellhound(float fDuration, int nHasGutturalInvoc)
{	
	object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);	
	itemproperty ipBonusFeat1 = ItemPropertyBonusFeat(IP_CONST_FEAT_DODGE);  	
	itemproperty ipBonusFeat2 = ItemPropertyBonusFeat(IPRP_FEAT_DARKVISION);  
	itemproperty ipBonusFeat3 = ItemPropertyBonusFeat(84);  
	itemproperty ipBonusFeat4 = ItemPropertyBonusFeat(386);  	
	//itemproperty ipBonusFeat5 = ItemPropertyBonusFeat(38); 				  
	IPSafeAddItemProperty(oHide, ipBonusFeat1,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oHide, ipBonusFeat2,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oHide, ipBonusFeat3,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oHide, ipBonusFeat4,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	//IPSafeAddItemProperty(oHide, ipBonusFeat5,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
	
	if (nHasGutturalInvoc)
	{
		itemproperty ipBonusFeat5 = ItemPropertyBonusFeat(125);  
		IPSafeAddItemProperty(oHide, ipBonusFeat5,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	
	}
}

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
	
	//SendMessageToPC(OBJECT_SELF, "Test2");
	
    //Declare major variables
    int nSpell = GetSpellId();
	if (GetHasSpellEffect(nSpell,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpell, OBJECT_SELF, OBJECT_SELF);
	}			
	
    effect eVis = EffectVisualEffect(VFX_INVOCATION_WORD_OF_CHANGING);
    effect ePoly;
    int nPoly;
	float fDuration = TurnsToSeconds(GetCasterLevel(OBJECT_SELF));

    nPoly = POLYMORPH_TYPE_HELLCAT;

    ePoly = EffectPolymorph(nPoly, FALSE, nArcaneShapesCanCast);
    //ePoly = EffectLinkEffects(ePoly, eVis);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));
	
	effect eDR = EffectDamageReduction(5, DR_TYPE_NONE, 0, DR_TYPE_NONE);
	effect eSR =  EffectSpellResistanceIncrease(19);
    effect eInvis = EffectInvisibility( INVISIBILITY_TYPE_NORMAL );
    effect eCover = EffectConcealment(50);
	effect eDmgRes = EffectDamageResistance(DAMAGE_TYPE_FIRE, 10);
	
	effect eLink = EffectLinkEffects(eDR, eSR);	
	eLink = EffectLinkEffects(eLink, eVis);
	eLink = EffectLinkEffects(eLink, eCover);
	eLink = EffectLinkEffects(eLink, eDmgRes);	
	eLink = EffectLinkEffects(eLink, ePoly);
	
	if (!GetHasFeat(FEAT_GUTTURAL_INVOCATIONS))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}				

    //Apply the VFX impact and effects
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.4, AssignCommand(OBJECT_SELF, ClearAllActions())); // prevents an exploit
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, OBJECT_SELF, fDuration));
	
	if (GetLocalInt(GetModule(), "UnarmedPolymorphFeatFix"))
		DelayCommand(2.0f, WildShape_Unarmed(OBJECT_SELF, fDuration));	
			
    DelayCommand(2.0, BuffHellhound(fDuration, nHasGutturalInvoc));	
}