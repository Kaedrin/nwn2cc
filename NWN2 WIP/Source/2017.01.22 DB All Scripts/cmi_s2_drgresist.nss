//::///////////////////////////////////////////////
//:: Dragon Warrior, Resist Energy
//:: cmi_s2_drgresist
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
	int nSpellId = SPELLABILITY_DRGWRR_RESIST_ENERGY;
	
	if (GetHasSpellEffect(nSpellId,oPC))
		RemoveSpellEffects(nSpellId, oPC, oPC);	
				
	int nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");
	if (nDragonDis == 0)
	{
		SetupDragonDis();
		nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");	
	}	
	
	int nDamageType = DAMAGE_TYPE_FIRE;	
	if (nDragonDis == 2)
		nDamageType = DAMAGE_TYPE_ACID;
	else
	if (nDragonDis == 3)
		nDamageType = DAMAGE_TYPE_ELECTRICAL;	
	else
	if (nDragonDis == 4)
		nDamageType = DAMAGE_TYPE_COLD;		
		
	int nLevel = GetLevelByClass(CLASS_DRAGON_WARRIOR, oPC);
	int nAmount;
	if (nLevel > 9)
	{
		nAmount = 20;	
	}
	else
	if (nLevel > 6)
	{
		nAmount = 15;		
	}
	else
	if (nLevel > 4)
	{
		nAmount = 10;		
	}
	else
	{
		nAmount = 5;		
	}
	
	effect eDmgRes = EffectDamageResistance(nDamageType, nAmount);		
	
	if (nLevel > 2)
	{
		effect eFearImm = EffectImmunity(IMMUNITY_TYPE_FEAR);	
		eDmgRes = EffectLinkEffects(eFearImm, eDmgRes);
	}
		
	eDmgRes = SetEffectSpellId(eDmgRes,nSpellId);
	eDmgRes = SupernaturalEffect(eDmgRes);
						
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmgRes, oPC, HoursToSeconds(48)));

				
}