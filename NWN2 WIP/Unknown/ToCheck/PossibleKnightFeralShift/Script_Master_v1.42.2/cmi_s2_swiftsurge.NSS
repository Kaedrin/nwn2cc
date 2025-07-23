//::///////////////////////////////////////////////
//:: Swiftsurge
//:: cmi_s2_swiftsurge
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 23, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"

#include "cmi_includes"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SWIFTBLADE_SWIFTSURGE;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	effect eLink = GetSwiftbladeSurgeEffect(OBJECT_SELF);
	
	
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
	
}      