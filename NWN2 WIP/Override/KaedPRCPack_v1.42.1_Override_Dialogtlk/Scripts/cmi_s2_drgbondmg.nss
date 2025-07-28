//::///////////////////////////////////////////////
//:: Dragonslayer Bonus Damage
//:: cmi_s2_drgbondmg
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Feb 1, 2009
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_DRSLR_DMG_BONUS;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nBonus = GetLevelByClass(CLASS_DRAGONSLAYER);
	if (GetHasFeat(1714, OBJECT_SELF))
		nBonus+=5;
	
	int nDR = 0;
	int nRes = 0;	
	
	effect eDmg = EffectDamageIncrease(GetDamageBonusByValue(nBonus));
	eDmg = VersusRacialTypeEffect(eDmg, RACIAL_TYPE_DRAGON);
	effect eLink = eDmg;
	
	if (nBonus > 9)
	{
		nRes = 10;
		nDR = 3;
	}
	else
	if (nBonus > 8)
	{
		nRes = 5;
		nDR = 3;	
	}
	else
	if (nBonus > 5)
	{
		nRes = 5;
		nDR = 2;	
	}	
	else
	if (nBonus > 4)
	{
		nRes = 5;
		nDR = 1;	
	}		
	else
	if (nBonus > 2)
	{
		nDR = 1;	
	}
	
	if (nDR > 0)
	{
		if (GetHasFeat(494))
		{
			nDR += 9;
		}
		else
		if (GetHasFeat(493))
		{
			nDR += 6;
		}	
		else
		if (GetHasFeat(492))
		{
			nDR += 3;
		}
		
		if (GetHasFeat(1253))
			nDR++;		
				
		effect eDR = EffectDamageReduction(nDR, DR_TYPE_NONE, 0, DR_TYPE_NONE);	
		eLink = EffectLinkEffects(eLink, eDR);
	}
	
	if (nRes > 0)
	{	
		effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID , nRes);
		effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD , nRes);
		effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL , nRes);
		effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE , nRes);
		effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC , nRes);								
		eLink = EffectLinkEffects(eAcid, eLink);
		eLink = EffectLinkEffects(eCold, eLink);
		eLink = EffectLinkEffects(eElec, eLink);
		eLink = EffectLinkEffects(eFire, eLink);
		eLink = EffectLinkEffects(eSonic, eLink);									
	}
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	
}      