//::///////////////////////////////////////////////
//:: Dissonant Chord - Break Concentration
//:: cmi_s2_brkconca
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2009
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()
{
	//SpeakString("nw_s2_auradespairA.nss: On Enter: function entry");

	object oTarget = GetEnteringObject();
	object oCaster = GetAreaOfEffectCreator();
	
	//SendMessageToPC(oCaster,GetName(oTarget));
	int nPenalty = GetLevelByClass(CLASS_DISSONANT_CHORD, oCaster);
	nPenalty += GetAbilityModifier(ABILITY_CHARISMA, oCaster);
	effect eConcPenalty = EffectSkillDecrease(SKILL_CONCENTRATION, nPenalty);
	eConcPenalty		= SupernaturalEffect(eConcPenalty);
	
	// Doesn't work on self
	if (oTarget != oCaster)
	{
		//SpeakString("nw_s2_auradespairA.nss: On Enter: target is not the same as the creator");

		SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELLABILITY_DISCHORD_BREAK_CONC, FALSE));		

	    //Faction Check
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
		{
			//SpeakString("nw_s2_auradespairA.ns: On Enter: target is enemy");
	        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConcPenalty, oTarget, HoursToSeconds(24));			
		}
	}
}