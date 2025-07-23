//::///////////////////////////////////////////////
//:: Fighter Passive
//:: cmi_s2_figpassive
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August  13, 2013
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_FIGHTER_PASSIVE;
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	

	int nFig = GetLevelByClass(CLASS_TYPE_FIGHTER, OBJECT_SELF);
	
	if (IsFighterPassiveValid(OBJECT_SELF, nFig))
	{
		int nBonus = (nFig - 1)/4; //5,9,13,17
		
		if (nBonus > 4)
			nBonus = 4;
			
		if (nFig > 19) //and 20
			nBonus++;
	
		int nDamage = IPGetDamageBonusConstantFromNumber(nBonus); 
			
		effect eAttack = EffectAttackIncrease(nBonus);
		effect eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_MAGICAL);
		effect eLink   = EffectLinkEffects(eAttack, eDamage);
	
		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));	
	}
}      