
#include "ginc_cutscene"

// Clear effects on oCreature
void RemoveAllNonSupernaturalEffects(object oCreature, int bBadOnly)
{
	// Check if oCreature is valid
	if (GetIsObjectValid(oCreature) == FALSE) return;
	
	effect eEffect = GetFirstEffect(oCreature);
	int nEffectType;
	int nEffectDuration;

	// For each effect
	while (GetIsEffectValid(eEffect) == TRUE)
	{
		if (GetEffectSubType(eEffect) != SUBTYPE_SUPERNATURAL)
		{
			if (bBadOnly == FALSE)
			{
				// Remove them all EXCEPT PERSISTENT AoE's!!! FOUND YOU YOU JERK (JWR-OEI)
			if (!(GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT && GetEffectType(eEffect) == EFFECT_TYPE_AREA_OF_EFFECT && GetEffectCreator(eEffect) == oCreature ) )
				{
					RemoveEffect(oCreature, eEffect);
				}
			}
			else
			{
				nEffectType = GetEffectType(eEffect);
				nEffectDuration = GetEffectDurationType(eEffect);
				
				// Remove if bad // Duration check may not need to be here?
				if (GetIsEffectTypeBad(nEffectType) == TRUE && nEffectDuration != DURATION_TYPE_PERMANENT)
				{
					RemoveEffect(oCreature, eEffect);
				}
			}
		}
		eEffect = GetNextEffect(oCreature);
	}
}
