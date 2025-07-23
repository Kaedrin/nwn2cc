//::///////////////////////////////////////////////
//:: Rally the Crew
//:: cmi_s2_rallycrew
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
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
	
	if (GetHasSpellEffect(SPELLABILITY_SONG_INSPIRE_COURAGE,OBJECT_SELF))
	{
		SendMessageToPC(OBJECT_SELF, "You may not use Rally the Crew while under the effect of Inspire Courage");
		IncrementRemainingFeatUses(OBJECT_SELF, FEAT_DRPIRATE_RALLY_THE_CREW_1);
		return;
	}
	
	int nSpellId = SPELLABILITY_DRPIRATE_RALLY_THE_CREW;
	int nCasterLvl = GetLevelByClass(CLASS_DREAD_PIRATE, OBJECT_SELF);
	
	float fDuration = TurnsToSeconds( nCasterLvl );
	int nBonus = 1;
	if (nCasterLvl > 6)
		nBonus = 2;
		
	effect eAB = EffectAttackIncrease(nBonus);	
	effect eDmgBonus = EffectDamageIncrease(nBonus, DAMAGE_TYPE_MAGICAL);	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
	effect eLink = EffectLinkEffects(eDmgBonus,eVis);
	eLink = EffectLinkEffects(eLink, eAB);
	eLink = SetEffectSpellId(eLink, nSpellId);
    eLink = SupernaturalEffect(eLink);			
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {		
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));		
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
		
	//DecrementRemainingFeatUses(OBJECT_SELF, FEAT_DRPIRATE_RALLY_THE_CREW_1);	
}      