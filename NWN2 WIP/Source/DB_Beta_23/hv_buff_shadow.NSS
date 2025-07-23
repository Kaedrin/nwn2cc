#include "nwn2_inc_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    
	effect eConcealment = EffectConcealment(20);
	effect eImmunity = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_SHADOW_SIMULACRUM);
	
	effect eLink = EffectLinkEffects(eConcealment, eImmunity);
	eLink = EffectLinkEffects(eLink, eVis);
	eLink = ExtraordinaryEffect(eLink);
	
	//Apply the effects
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);	// Permanent duration is OK, since simulacrum will expire...

	TakeGoldFromCreature(GetGold(OBJECT_SELF), OBJECT_SELF, TRUE);
	SetXP(OBJECT_SELF, 0);
	SetBaseAbilityScore(OBJECT_SELF, 0, 10);
	SetBaseAbilityScore(OBJECT_SELF, 1, 10);
	SetBaseAbilityScore(OBJECT_SELF, 2, 10);
	SetBaseAbilityScore(OBJECT_SELF, 3, 10);
	SetBaseAbilityScore(OBJECT_SELF, 4, 10);
	SetBaseAbilityScore(OBJECT_SELF, 5, 10);
}