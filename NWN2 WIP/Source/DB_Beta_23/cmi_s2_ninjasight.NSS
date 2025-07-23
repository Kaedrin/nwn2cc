//::///////////////////////////////////////////////
//:: Ninja - AC Bonus
//:: cmi_s2_ninjaac
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_NINJA_GHOST_SIGHT;

	RemoveSpellEffects(nSpellId, oPC, oPC);	
	effect eLink;

	eLink = EffectTrueSeeing();
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);

	DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
				
}