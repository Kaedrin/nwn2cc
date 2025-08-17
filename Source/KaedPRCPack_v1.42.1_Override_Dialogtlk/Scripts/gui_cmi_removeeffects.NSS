//::///////////////////////////////////////////////
//:: gui_cmi_removeeffects
//:: Purpose: Remove non-special effects
//:: Created By: Kaedrin
//:: Created On: November 29 , 2010
//:://////////////////////////////////////////////

int GetIsEffectTypeBad(int nEffectType)
{

return ((nEffectType == EFFECT_TYPE_ABILITY_DECREASE) ||
(nEffectType == EFFECT_TYPE_AC_DECREASE) ||
(nEffectType == EFFECT_TYPE_AMORPENALTYINC) ||
(nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE) ||
(nEffectType == EFFECT_TYPE_ATTACK_DECREASE) ||
(nEffectType == EFFECT_TYPE_BLINDNESS) ||
(nEffectType == EFFECT_TYPE_CHARMED) ||
(nEffectType == EFFECT_TYPE_CONCEALMENT_NEGATED) ||
(nEffectType == EFFECT_TYPE_CONFUSED) ||
(nEffectType == EFFECT_TYPE_CURSE) ||
(nEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE) ||
(nEffectType == EFFECT_TYPE_CUTSCENEGHOST) ||
(nEffectType == EFFECT_TYPE_CUTSCENEIMMOBILIZE) ||
(nEffectType == EFFECT_TYPE_DAMAGE_DECREASE) ||
(nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE) ||
(nEffectType == EFFECT_TYPE_DAMAGE_REDUCTION_NEGATED) ||
(nEffectType == EFFECT_TYPE_DAZED) ||
(nEffectType == EFFECT_TYPE_DEAF) ||
(nEffectType == EFFECT_TYPE_DISEASE) ||
(nEffectType == EFFECT_TYPE_DOMINATED) ||
(nEffectType == EFFECT_TYPE_ENEMY_ATTACK_BONUS) ||
(nEffectType == EFFECT_TYPE_ENTANGLE) ||
(nEffectType == EFFECT_TYPE_FRIGHTENED) ||
(nEffectType == EFFECT_TYPE_INSANE) ||
(nEffectType == EFFECT_TYPE_JARRING) ||
(nEffectType == EFFECT_TYPE_MESMERIZE) ||
(nEffectType == EFFECT_TYPE_MISS_CHANCE) ||
(nEffectType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) ||
(nEffectType == EFFECT_TYPE_NEGATIVELEVEL) ||
(nEffectType == EFFECT_TYPE_PARALYZE) ||
(nEffectType == EFFECT_TYPE_PETRIFY) ||
(nEffectType == EFFECT_TYPE_POISON) ||
(nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE) ||
(nEffectType == EFFECT_TYPE_SILENCE) ||
(nEffectType == EFFECT_TYPE_SKILL_DECREASE) ||
(nEffectType == EFFECT_TYPE_SLEEP) ||
(nEffectType == EFFECT_TYPE_SLOW) ||
(nEffectType == EFFECT_TYPE_SPELL_FAILURE) ||
(nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE) ||
(nEffectType == EFFECT_TYPE_STUNNED) ||
(nEffectType == EFFECT_TYPE_SWARM) ||	
(nEffectType == EFFECT_TYPE_WOUNDING)
);
}

void main()
{

	//OBJECT_SELF is the player that clicked a button
	
	// Check if OBJECT_SELF is valid
	if (GetIsObjectValid(OBJECT_SELF) == FALSE) return;
	
	effect eEffect = GetFirstEffect(OBJECT_SELF);
	int nEffectType;
	int nSubType;

	// For each effect
	while (GetIsEffectValid(eEffect) == TRUE)
	{
		nSubType = GetEffectSubType(eEffect);
		if (nSubType != SUBTYPE_SUPERNATURAL && nSubType != SUBTYPE_EXTRAORDINARY)
		{
			nEffectType = GetEffectType(eEffect);
			if (GetIsEffectTypeBad(nEffectType) != TRUE)
			{
				if (!(GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT && GetEffectType(eEffect) == EFFECT_TYPE_AREA_OF_EFFECT && GetEffectCreator(eEffect) == OBJECT_SELF ) )
				{
					RemoveEffect(OBJECT_SELF, eEffect);
				}
			}
		}
		eEffect = GetNextEffect(OBJECT_SELF);
	}
	
}