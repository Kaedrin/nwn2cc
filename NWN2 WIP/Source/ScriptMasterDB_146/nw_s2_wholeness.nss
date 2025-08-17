//::///////////////////////////////////////////////
//:: Wholeness of Body
//:: NW_S2_Wholeness
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The monk is able to heal twice his level in HP
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF);
	int nHD = GetHitDice(OBJECT_SELF);
	int nHeal = nLevel*2;
	
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_WHOLENESS_OF_BODY, FALSE));
    //Apply the VFX impact and effects
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));
	
	if (nLevel == nHD)
	{
		effect eRegen = EffectRegenerate(1, 6.0f);
		DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, TurnsToSeconds(3)));
	}	
}