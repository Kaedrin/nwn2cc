//::///////////////////////////////////////////////
//:: Righteous Glory
//:: cmi_s0_rightglory
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 5, 2007
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
	
	int nChaMod;
	int nBaseNum = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, TRUE);
	int nModNum = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA,FALSE);
	int nSubRace = GetSubRace(OBJECT_SELF);
	string sVal = Get2DAString("racialsubtypes","ChaAdjust",nSubRace);		
	nBaseNum = nBaseNum + StringToInt(sVal);
	
	nChaMod = (nModNum - nBaseNum);
	nChaMod = nChaMod + 4;
	if (nChaMod > 12)
		nChaMod = 12;	
	
	effect eChaBonus = EffectAbilityIncrease(ABILITY_CHARISMA, nChaMod);	
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_EAGLE_SPLENDOR );	
	effect eLink = EffectLinkEffects(eVis, eChaBonus);	
	
	int nCasterLevel = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLevel);
	fDuration = ApplyMetamagicDurationMods(fDuration);
			
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      