//::///////////////////////////////////////////////
//:: Protective Ward
//:: cmi_s2_protward
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 5, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

/*
int GetProtReserveLevel()
{
	if (GetHasSpell(62)) //Level 4
		return 4;
	if (GetHasSpell(137)) //Level 2
		return 2;
	if (GetHasSpell(150)) //Level 2
		return 2;																						
		
	return 0;
}

void ApplyDamageBuff(int nSpellId)
{
	IsModuleSupported(FALSE);
	int bRepeatBuff = 1;
	
	int nReserveLevel = GetProtReserveLevel();		
	
	if (GetHasSpellEffect(nSpellId))
		RemoveEffectsFromSpell(OBJECT_SELF, nSpellId);
		
	if (nReserveLevel == 0)
	{
		bRepeatBuff = 0;
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
		
	if (bRepeatBuff)
	{
		effect eACBuff = EffectACIncrease(nReserveLevel);
		eACBuff = SetEffectSpellId(eACBuff,nSpellId);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACBuff, OBJECT_SELF, 12.0f);
		DelayCommand(12.0f, ApplyDamageBuff(nSpellId));
	}
}
*/

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELL_SPELLABILITY_Protective_Ward;
	int nRanger = 1;
	int nRangerLevel = GetLevelByClass(CLASS_TYPE_RANGER);
	if (nRangerLevel > 23)
		nRanger = 2;
		
	effect eACBuff;
	if (nRangerLevel == GetHitDice(OBJECT_SELF))
	{
		eACBuff = EffectACIncrease(nRanger * 2);
		effect eABBuff = EffectAttackIncrease(nRanger);
		eACBuff = EffectLinkEffects(eABBuff, eACBuff);
	}
	else
		eACBuff = EffectACIncrease(nRanger);
		
	eACBuff = SetEffectSpellId(eACBuff,nSpellId);
	eACBuff = SupernaturalEffect(eACBuff);	
	RemoveEffectsFromSpell(OBJECT_SELF, SPELL_SPELLABILITY_Protective_Ward);	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACBuff, OBJECT_SELF, HoursToSeconds(48));
			
	/*
	//Declare major variables
	int nReserveLevel = 0;
	nReserveLevel = GetProtReserveLevel();
	int nSpellId = SPELL_SPELLABILITY_Protective_Ward;
		 
	if (nReserveLevel == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	{
		
		effect eVis = EffectVisualEffect(VFX_HIT_SPELL_HOLY);
	
		//Fire cast spell at event for the specified target
		SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));	
		
		DelayCommand(0.1f,	ApplyDamageBuff(nSpellId)); 		

		//Apply the effects
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
		
	}			
	*/


}