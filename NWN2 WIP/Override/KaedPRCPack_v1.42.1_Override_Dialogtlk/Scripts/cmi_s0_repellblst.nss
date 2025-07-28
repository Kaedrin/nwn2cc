
//::///////////////////////////////////////////////
//:: Repelling Blast
//:: cmi_s0_repellblst
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////


#include "nw_i0_invocatns"
#include "x2_inc_spellhook" 


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


	DoShapeMetaDoom(METAMAGIC_INVOC_REPELL_BLAST);	
	
}