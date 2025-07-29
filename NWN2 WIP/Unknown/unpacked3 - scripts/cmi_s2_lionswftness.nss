//::///////////////////////////////////////////////
//:: Lion's Swiftness
//:: cmi_s2_lionswftness
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 22, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"


void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = LION_TALISID_LIONS_SWIFTNESS;
	int nClassLevel = GetLevelByClass(CLASS_LION_TALISID, OBJECT_SELF);	
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	effect eHaste =  EffectHaste();
	eHaste = SetEffectSpellId(eHaste,nSpellId);
		//eLink = SupernaturalEffect(eLink);
		
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHaste, OBJECT_SELF,  RoundsToSeconds(nClassLevel));
}      