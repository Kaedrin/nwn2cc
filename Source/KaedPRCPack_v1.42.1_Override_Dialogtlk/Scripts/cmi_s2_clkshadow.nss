//::///////////////////////////////////////////////
//:: Child of Night, Cloak of Shadows
//:: cmi_s2_clkshadow
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

	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_CHLDNIGHT_CLOAK_SHADOWS;
	
	if (GetHasSpellEffect(nSpellId,oPC))
		RemoveSpellEffects(nSpellId, oPC, oPC);	
				
	int nLevel = GetLevelByClass(CLASS_CHILD_NIGHT, oPC);
	
	effect eLink = EffectSkillIncrease(SKILL_HIDE,nLevel);
	effect eColdRes;
	if (nLevel > 8)
	{
		effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
		effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);	
		effect eConceal = EffectConcealment(20);
		eColdRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 15);
		eLink = EffectLinkEffects(eLink, ePoison);	
		eLink = EffectLinkEffects(eLink, eDisease);
		eLink = EffectLinkEffects(eLink, eConceal);
		eLink = EffectLinkEffects(eLink, eColdRes);			
	}
	else
	if (nLevel > 7)
	{
		effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
		effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);	
		effect eConceal = EffectConcealment(20);
		eColdRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);
		eLink = EffectLinkEffects(eLink, ePoison);	
		eLink = EffectLinkEffects(eLink, eDisease);
		eLink = EffectLinkEffects(eLink, eConceal);
		eLink = EffectLinkEffects(eLink, eColdRes);				
	}
	else
	if (nLevel > 5)
	{
		effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
		effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);
		eColdRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);
		eLink = EffectLinkEffects(eLink, ePoison);	
		eLink = EffectLinkEffects(eLink, eDisease);
		eLink = EffectLinkEffects(eLink, eColdRes);		
	}
	else
	if (nLevel > 4)
	{
		eColdRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);
		eLink = EffectLinkEffects(eLink, eColdRes);	
	}
	else
	{
		eColdRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 5);
		eLink = EffectLinkEffects(eLink, eColdRes);			
	}
				
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
						
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));

				
}