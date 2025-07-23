//::///////////////////////////////////////////////
//:: Eldritch Disciple, Wild Frenzy
//:: cmi_s2_giftwf
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 2, 2009
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	  
	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_ELDDISC_WF;	
	
	if (GetHasSpellEffect(nSpellId,oPC))
		RemoveSpellEffects(nSpellId, oPC, oPC);	

	int nHP = GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oPC) * 2;		
	effect eTempHP = EffectTemporaryHitpoints(nHP);
		
	effect eAB = EffectAttackIncrease(2);
	effect eDmg = EffectDamageIncrease(2);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
	effect eLink = EffectLinkEffects(eAB, eDmg);
	eLink = EffectLinkEffects(eLink, eVis);
		
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
		
	int nDuration = 3 + GetAbilityModifier(ABILITY_CHARISMA);
	if (nDuration <=0)
		nDuration = 1;
	float fDuration = RoundsToSeconds( nDuration );
			
	SignalEvent(oPC, EventSpellCastAt(oPC, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, fDuration);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTempHP, oPC, fDuration);	
	DecrementRemainingFeatUses(oPC, 294);
}      