//::///////////////////////////////////////////////
//:: Maximize Eldritch Blast
//:: cmi_s2_maxeldblst
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

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
	
	effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
	//eVis = SetEffectSpellId(eVis,SPELLABILITY_EMPOWER_ELDBLAST);
	//eVis = SupernaturalEffect(eVis);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 1);	
	
}