//::///////////////////////////////////////////////
//:: Holy Warrior
//:: cmi_s2_holywarrior
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 22, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

int GetWarReserveLevel()
{
	// This actually returns the DAMAGE_BONUS_x value and not the spell level
	// Needed for EffectDamageIncrease
	if (GetHasSpell(131)) //Level 9
		return 9;
	if (GetHasSpell(132)) //Level 8
		return 8;		
	if (GetHasSpell(1011)) //Level 7
		return 7;	
	if (GetHasSpell(5)) //Level 6
		return 6;	
	if (GetHasSpell(61)) //Level 5
		return 5;	
	if (GetHasSpell(42)) //Level 4
		return 4;																				
		
	return 0;
}

void ApplyDamageBuff(int nSpellId)
{
	IsModuleSupported(FALSE);
	int bRepeatBuff = 1;
	
	int nReserveLevel = GetWarReserveLevel();
	
	int nCap = GetLocalInt(GetModule(), "HolyWarriorCap");
	if (nReserveLevel > nCap)
		nReserveLevel = nCap;
		
	if (GetHasFeat(FEAT_HOLY_ICON_WAR))
		nReserveLevel += 2;
	
	if (GetHasSpellEffect(nSpellId))
		RemoveEffectsFromSpell(OBJECT_SELF, nSpellId);
		
	if (nReserveLevel == 0)
	{
		bRepeatBuff = 0;
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	
	int nDamageAmount = GetDamageBonusByValue(nReserveLevel);
		
	if (bRepeatBuff)
	{
		effect eDmgBuff = EffectDamageIncrease(nDamageAmount, DAMAGE_TYPE_DIVINE);
		eDmgBuff = SetEffectSpellId(eDmgBuff,nSpellId);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmgBuff, OBJECT_SELF, 6.0f);
		DelayCommand(6.0f, ApplyDamageBuff(nSpellId));
	}
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
	nReserveLevel = GetWarReserveLevel();
	int nSpellId = GetSpellId();
		 
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



}