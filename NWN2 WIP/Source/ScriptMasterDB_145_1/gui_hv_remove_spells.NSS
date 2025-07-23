#include "nw_i0_spells"
void main()
{
    // This is the Object to apply the effect to.
    object oPC = OBJECT_SELF;

	effect eInvis = GetFirstEffect(oPC);
	
	// First loop: if invisibility effect found remove only it and return.
	while (GetIsEffectValid(eInvis)) {
		if ((GetEffectCreator(eInvis) == oPC) && (GetEffectType(eInvis) == EFFECT_TYPE_INVISIBILITY)) {
				RemoveEffect(oPC, eInvis);
				return;
		}
		eInvis = GetNextEffect(oPC);
	}
	
	// Second loop: no invis found - remove everything
    //Remove effects which were created by the PC
	effect eLoop = GetFirstEffect(oPC);

	while (GetIsEffectValid(eLoop)) {
		if ((GetEffectCreator(eLoop) == oPC) && (GetEffectType(eLoop) != EFFECT_TYPE_ABILITY_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_AC_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_ATTACK_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_DAMAGE_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_SAVING_THROW_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_SKILL_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_SPELL_RESISTANCE_DECREASE) && (GetEffectType(eLoop) != EFFECT_TYPE_TURN_RESISTANCE_DECREASE)) 
		
			// Make sure it's not supernatural
			if (GetEffectSubType(eLoop) == SUBTYPE_MAGICAL)
				RemoveEffect(oPC, eLoop);

  		eLoop=GetNextEffect(oPC);
   	}
}