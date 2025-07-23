//::///////////////////////////////////////////////
//:: Shapechange
//:: NW_S0_ShapeChg.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////
// ChazM 1/18/07 - EvenFlw modifications

#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

	RemoveEffectsFromSpell(OBJECT_SELF, SPELL_SPIRIT_BEAR);	
	int nArcaneShapesCanCast = GetLocalInt(GetModule(), "ArcaneShapesCanCast");

	if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
		nArcaneShapesCanCast = TRUE;
	
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly;
    int nPoly=POLYMORPH_TYPE_HORNED_DEVIL;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

	// constrain to allowed values
	if(nSpell<392 || nSpell>396)
		nSpell=392+Random(5);
    //Determine Polymorph subradial type
    if(nSpell == 392)
    {
        //nPoly = POLYMORPH_TYPE_FROST_GIANT_MALE;
		nPoly = 155; // Phantom wolf
    }
    else if (nSpell == 393)
    {
        //nPoly = POLYMORPH_TYPE_FIRE_GIANT;
		nPoly = 157; // Celestial, female
		if (GetGender(oTarget) == GENDER_MALE)
			nPoly = 156;
		
    }
    else if (nSpell == 394)
    {
        nPoly = POLYMORPH_TYPE_HORNED_DEVIL;
    }
    else if (nSpell == 395)
    {
        nPoly = POLYMORPH_TYPE_NIGHTWALKER;
    }
    else if (nSpell == 396)
    {
        nPoly = POLYMORPH_TYPE_IRON_GOLEM;
    }
    ePoly = EffectPolymorph(nPoly, FALSE, nArcaneShapesCanCast);
    ePoly = EffectLinkEffects(ePoly, eVis);
	
	if (!nArcaneShapesCanCast && !GetHasFeat(FEAT_NATURAL_SPELL))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}	
	
	if(!GetIsPC(OBJECT_SELF)) 
		SetEffectSpellId(ePoly, SPELL_I_WORD_OF_CHANGING);
		
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHAPECHANGE, FALSE));

    //Apply the VFX impact and effects
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.4, AssignCommand(oTarget, ClearAllActions())); // prevents an exploit
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(nDuration)));

	if (GetLocalInt(GetModule(), "UnarmedPolymorphFeatFix"))
		DelayCommand(2.0f, WildShape_Unarmed(oTarget, TurnsToSeconds(nDuration)));	
}