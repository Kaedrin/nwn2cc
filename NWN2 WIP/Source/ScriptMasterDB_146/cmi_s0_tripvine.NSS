//::///////////////////////////////////////////////
//:: Trip Vine
//:: cmi_s0_tripvine
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
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
    effect eAOE = EffectAreaOfEffect(VFX_PER_TRIP_VINE);

    location lTarget = GetSpellTargetLocation();

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, TurnsToSeconds(3));
	SetLocalInt(OBJECT_SELF, "DC2102", GetSpellSaveDC());	
}