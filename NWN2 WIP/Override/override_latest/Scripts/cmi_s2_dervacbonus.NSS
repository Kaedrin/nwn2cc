//::///////////////////////////////////////////////
//:: Dervish, AC Bonus
//:: cmi_s2_dervacbonus
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 3, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	if (IsLightArmorValid())
	{
		object oPC = OBJECT_SELF;
		int nSpellId = SPELLABILITY_DERVISH_AC_BONUS;
		
		if (GetHasSpellEffect(nSpellId,oPC))
			RemoveSpellEffects(nSpellId, oPC, oPC);	
				
		//1,5,9					
		int nLevel = GetLevelByClass(CLASS_DERVISH, oPC) + 3;	
		nLevel = nLevel/4;		
		
		effect eLink = EffectACIncrease(nLevel);		
		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
							
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));
	}
	else
		SendMessageToPC(OBJECT_SELF, "Dervish only gain an AC bonus when wearing no armor or light armor.");
				
}