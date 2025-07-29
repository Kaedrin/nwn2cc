//::///////////////////////////////////////////////
//:: Minor Shapechange
//:: cmi_s2_mnrshape
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 22, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_includes"

int GetPolyReserveLevel()
{

	if (GetHasSpell(161)) //Level 9
		return 9;
	if (GetHasSpell(184)) //Level 6
		return 6;	
	if (GetHasSpell(130)) //Level 4
		return 4;
	if (GetHasFeat(305))
		return 9;		
		
	if (GetHasFeat(FEAT_HEXBOOK_L4_1))
		return 4;	
																		
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	int nReserveLevel = 0;	
	int nSpellId = GetSpellId();
	
	nReserveLevel = GetPolyReserveLevel() * 3;
	
	if (GetHasFeat(FEAT_HEXBOOK_L4_1))
	{
		nReserveLevel = GetHexbladeCasterLevel();
	}
		 
	if (nReserveLevel == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	{
		
		if (GetHasSpellEffect(SPELLABILITY_Minor_Shapeshift))
			RemoveEffectsFromSpell(OBJECT_SELF, SPELLABILITY_Minor_Shapeshift);
						
	
		if (nSpellId == SPELLABILITY_Minor_Shapeshift || nSpellId == SPELLABILITY_Minor_Shapeshift_Might)
		{
			effect eMight = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_MAGICAL);
			eMight = SetEffectSpellId(eMight, SPELLABILITY_Minor_Shapeshift);
			eMight = SupernaturalEffect(eMight);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMight, OBJECT_SELF, RoundsToSeconds(nReserveLevel));		
		}
		else
		if (nSpellId == SPELLABILITY_Minor_Shapeshift_Speed)
		{
			effect eSpeed = EffectMovementSpeedIncrease(125);
			eSpeed = SetEffectSpellId(eSpeed, SPELLABILITY_Minor_Shapeshift);
			eSpeed = SupernaturalEffect(eSpeed);			
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, OBJECT_SELF, RoundsToSeconds(nReserveLevel));			
		}		
		else
		if (nSpellId == SPELLABILITY_Minor_Shapeshift_Vigor)
		{
			effect eVigor = EffectTemporaryHitpoints(GetHitDice(OBJECT_SELF));
			eVigor = SetEffectSpellId(eVigor, SPELLABILITY_Minor_Shapeshift);
			eVigor = SupernaturalEffect(eVigor);			
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVigor, OBJECT_SELF, RoundsToSeconds(nReserveLevel));			
		}
		
		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_HOLY);
	
		//Fire cast spell at event for the specified target
		SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));			

		//Apply the effects
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
		
	}			



}