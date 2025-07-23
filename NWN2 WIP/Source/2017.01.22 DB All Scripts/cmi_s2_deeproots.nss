
#include "cmi_includes"
#include "nwn2_inc_spells"
#include "x2_inc_spellhook" 

void bDidYouMove(int nSpellId, location MyLoc)
{
	location CurrentLoc = GetLocation(OBJECT_SELF);
	float fDist = GetDistanceBetweenLocations(CurrentLoc, MyLoc);
	if (fDist > 1.0f)
	{
		if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
		{
			RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
		}	
	}
	else
		DelayCommand(2.0f, bDidYouMove(nSpellId, MyLoc));	

}

void main()
{

	int nSpellId = FOREST_MASTER_DEEP_ROOTS;
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}		
	
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
	
	int nDexPenalty = GetAbilityScore(OBJECT_SELF, ABILITY_DEXTERITY) - 1;
		
    effect eRegen = EffectRegenerate(5, 6.0);
    effect eDur = EffectVisualEffect(VFX_DUR_REGENERATE);
	effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, nDexPenalty);
    effect eLink = EffectLinkEffects(eRegen, eDur);
	eLink = EffectLinkEffects(eLink, eDex);
	
	location MyLoc = GetLocation(OBJECT_SELF);

    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
	
	DelayCommand(2.0f, bDidYouMove(nSpellId, MyLoc));
}