//::///////////////////////////////////////////////
//:: Way of the Kinslayer
//:: cmi_s2_charnag
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 1st, 2010
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_CHARNAG_WAY_KINSLAYER;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nCharnag = GetLevelByClass(CLASS_UNDERDARK_MARAUDER, OBJECT_SELF);
	
	effect eAC = EffectACIncrease(1);
	effect eAB = EffectAttackIncrease(1);
	effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2);
	
	if (nCharnag > 2)
		eAC = EffectLinkEffects(eAC, eAB);
	if (nCharnag > 4)
		eAC = EffectLinkEffects(eAC, eDmg);
	
	eAC = SetEffectSpellId(eAC,nSpellId);
	eAC = SupernaturalEffect(eAC);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, HoursToSeconds(72)));	
	
}      