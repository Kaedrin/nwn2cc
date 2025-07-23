//::///////////////////////////////////////////////
//:: Invisibility Sphere
//:: NW_S0_InvSph.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within 15ft are rendered invisible.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "nw_i0_spells"
#include "x0_i0_SPELLS"



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


    //Declare major variables including Area of Effect Object
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
	   nDuration = nDuration *2;	//Duration is +100%
    }
	effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
	effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
	effect eLink2 = EffectLinkEffects( eInvis, eVis );
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, OBJECT_SELF, TurnsToSeconds(nDuration));
	
	//Declare major variables
	location lCenter = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lCenter );
	object oCaster = OBJECT_SELF;
	while(GetIsObjectValid(oTarget))
	{
		if ( spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster) && oTarget != oCaster )
		{ 	
      		SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_INVISIBILITY_SPHERE, FALSE));
      		ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eLink2, oTarget, TurnsToSeconds(nDuration) );		
		}
		oTarget = GetNextObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lCenter );
	}
}