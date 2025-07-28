//::///////////////////////////////////////////////
//:: Righteous Fury
//:: cmi_s0_rightfury
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
	    
	RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	RemoveEffectsFromSpell(OBJECT_SELF, SPELL_Strength_Stone);	
	
	int nHPBonus;	
	int nCasterLvl = GetPalRngCasterLevel();
	
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
		
	if (nCasterLvl >= 10)
	{
		nHPBonus = 50;
	}
	else
	{
		nHPBonus = nCasterLvl * 5;
	}	
			
	int nStrMod;
	int nBaseNum = GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH, TRUE);
	int nModNum = GetAbilityScore(OBJECT_SELF,ABILITY_STRENGTH,FALSE);
	int nSubRace = GetSubRace(OBJECT_SELF);
	string sVal = Get2DAString("racialsubtypes","StrAdjust",nSubRace);		
	nBaseNum = nBaseNum + StringToInt(sVal);
	
	nStrMod = (nModNum - nBaseNum);
	nStrMod = nStrMod + 4;
	if (nStrMod > 12)
		nStrMod = 12;

	effect eStrBonus = EffectAbilityIncrease(ABILITY_STRENGTH, nStrMod);	


	//effect eAB = EffectAttackIncrease(2);
	//effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_DIVINE);
	effect eHPBonus = EffectTemporaryHitpoints(nHPBonus);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	//effect eLink = EffectLinkEffects(eVis, eAB);
	//eLink = EffectLinkEffects(eLink, eDmg);
	effect eLink = EffectLinkEffects(eVis, eStrBonus);

	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHPBonus, OBJECT_SELF, HoursToSeconds(1));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
		
}      