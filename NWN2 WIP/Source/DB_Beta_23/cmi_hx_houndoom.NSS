//::///////////////////////////////////////////////
//:: Hound of Doom
//:: cmi_hx_houndoom
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"

void main()
{
	
	string sBlueprint = "cmi_ancom_dhound";
	//int nCL = GetHexbladeCasterLevel();
	int nCL  = GetLevelByClass(CLASS_HEXBLADE, OBJECT_SELF) - 3;  // Only actual Hexblade CLs count.
	
	int nSuffix;
	
	if (nCL < 11)
		nSuffix = 0;	
	else
		nSuffix = (nCL - 10)/2;
		
	sBlueprint += IntToString(nSuffix);
	
	SummonAnimalCompanion(OBJECT_SELF, sBlueprint); 
	
	SetFirstName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF), GetName(OBJECT_SELF) + "'s");
	SetLastName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF), "Hound of Doom");

	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	if (nCha > 0)
	{
		object oMyPet = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
		effect eLink = EffectACIncrease(nCha, AC_DEFLECTION_BONUS);
		eLink = SupernaturalEffect(eLink);
		
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oMyPet));		
	}
}