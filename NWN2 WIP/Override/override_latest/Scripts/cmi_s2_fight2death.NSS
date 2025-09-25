//::///////////////////////////////////////////////
//:: Fight to the Death
//:: cmi_s2_fight2death
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 29, 2010
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
	
	int nSpellId = SPELLABILITY_DRPIRATE_FIGHT2DEATH;
	int nCasterLvl = GetLevelByClass(CLASS_DREAD_PIRATE, OBJECT_SELF);

    RemoveEffectsFromSpell(OBJECT_SELF, SPELLABILITY_DRPIRATE_FIGHT2DEATH);	
		
	float fDuration = RoundsToSeconds( nCasterLvl );
	
	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	if (nCha < 1)
		nCha = 1;
		
	effect eAC = EffectACIncrease(nCha);
	effect eBonusHP = EffectBonusHitpoints(GetHitDice(OBJECT_SELF));
	effect eFightToDeath = EffectLinkEffects(eAC, eBonusHP);
	effect eTempHP = EffectTemporaryHitpoints(10 + nCha);
	eFightToDeath = SetEffectSpellId(eFightToDeath, nSpellId);
    eFightToDeath = SupernaturalEffect(eFightToDeath);
	eTempHP = SetEffectSpellId(eTempHP, nSpellId);
    eTempHP = SupernaturalEffect(eTempHP);				
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
			
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));		

			RemoveEffectsFromSpell(oTarget, SPELLABILITY_DRPIRATE_FIGHT2DEATH);	
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFightToDeath, oTarget, RoundsToSeconds(nCasterLvl));
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTempHP, oTarget, RoundsToSeconds(nCasterLvl));			
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}      