//::///////////////////////////////////////////////
//:: Bladesinger's Armored Caster
//:: cmi_s2_bsarmrcast
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 17, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	EvaluateArmoredCaster();	
}      