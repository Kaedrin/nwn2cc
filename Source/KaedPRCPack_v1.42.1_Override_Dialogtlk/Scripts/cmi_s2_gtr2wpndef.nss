//::///////////////////////////////////////////////
//:: Greater Two Weapon Defense
//:: cmi_s2_gtr2wpndef
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 17, 2008
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
	
	int nSpellId = SPELLABILITY_Gtr_2Wpn_Defense;
	
	int bIsValid = IsTwoWeaponValid(OBJECT_SELF);
	
	if (bIsValid)
	{
		
		if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
		{
			return;
			//RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
		}	
		 
		effect eAC = EffectACIncrease(1);
		effect eParry = EffectSkillIncrease(SKILL_PARRY, 2);
		effect eLink = EffectLinkEffects(eAC, eParry);
		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
		
		DelayCommand(0.5f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	}
	else
	{
		if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
		{
			RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
			SendMessageToPC(OBJECT_SELF, "Greater Two-Weapon Defense disabled.");
		}		
	}
}      