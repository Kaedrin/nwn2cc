//::///////////////////////////////////////////////
//:: Fist of the Forest - AC Bonus
//:: cmi_s2_fotfacbonus
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_FOTF_AC_BONUS;

	int bHasFOTFacbonus = GetHasSpellEffect(nSpellId,oPC);	
	RemoveSpellEffects(nSpellId, oPC, oPC);
	
    if (GetHasEffect( EFFECT_TYPE_POLYMORPH, oPC))
	{
		SendMessageToPC(oPC,"Fist of the Forest AC Bonus may not be used while under the effects of any kind of polymorph ability.");
		return;						
	}	
	
	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
	if ((oArmor != OBJECT_INVALID && GetArmorRank(oArmor) == ARMOR_RANK_NONE) ||  oArmor == OBJECT_INVALID)
	{
			int nSubrace = GetSubRace(OBJECT_SELF);
			int	nBonus = StringToInt(Get2DAString("racialsubtypes.2da", "ConAdjust", nSubrace));
			
			nBonus += GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION, TRUE);
			nBonus = (nBonus - 10) / 2;
			
			if (nBonus > 0)
			{
			
				effect eLink = EffectACIncrease(nBonus);			
				eLink = SetEffectSpellId(eLink,nSpellId);
				eLink = SupernaturalEffect(eLink);
			
				if (!bHasFOTFacbonus)
					SendMessageToPC(oPC,"Fist of the Forest AC Bonus is now active.");					
				
				DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));

			}			
	}
	else
	{
		if (bHasFOTFacbonus)
		{
				SendMessageToPC(oPC,"Fist of the Forest AC Bonus requires the user to wear no armor.");					
		}
	}				
}