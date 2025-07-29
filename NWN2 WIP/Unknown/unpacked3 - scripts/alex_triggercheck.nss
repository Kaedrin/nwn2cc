#include "NW_I0_GENERIC"

void main()
{
	int attribute = GetLocalInt(OBJECT_SELF, "Attr");
	int skill = GetLocalInt(OBJECT_SELF, "Skill");
	int attributeCheck = GetLocalInt(OBJECT_SELF, "AttrDC");
	int skillCheck = GetLocalInt(OBJECT_SELF, "SkillDC");
	

	object oPC = GetEnteringObject();
	
	int PCattribute = GetAbilityModifier(attribute, oPC);
	int PCskill = GetSkillRank(skill, oPC);
		
	
	if((PCattribute + Random(5)) > attributeCheck)
		SetLocalInt(oPC, "AttrCheck", 1);
	else
		SetLocalInt(oPC, "AttrCheck", 0);
		
	if((PCskill + Random(20)) > skillCheck)
		SetLocalInt(oPC, "SkillCheck", 1);
	else
		SetLocalInt(oPC, "SkillCheck", 0);
	
	
	
	
	
	/*
	switch(attribute)
	{
		case 1:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 2:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 3:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 4:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 5:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 6:
			if((PCattribute + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
	}
	
	
	switch(attribute)
	{
		case 1:
			if((GetAbilityModifier(attribute, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 2:
			if((GetAbilityModifier(ABILITY_DEXTERITY, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		
		case 3:
			if((GetAbilityModifier(ABILITY_CONSTITUTION, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 4:
			if((GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 5:
			if((GetAbilityModifier(ABILITY_WISDOM, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case 6:
			if((GetAbilityModifier(ABILITY_CHARISMA, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
	}
	*/
	
	
	
	
	/*
	
	
	
	
	switch(attribute)
	{
		case "str":
			if((GetAbilityModifier(ABILITY_STRENGTH, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case "dex":
			if((GetAbilityModifier(ABILITY_DEXTERITY, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		
		case "con":
			if((GetAbilityModifier(ABILITY_CONSTITUTION, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case "int":
			if((GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case "wis":
			if((GetAbilityModifier(ABILITY_WISDOM, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
		case "cha":
			if((GetAbilityModifier(ABILITY_CHARISMA, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
		break;
		
	}
	
	
	
	if(attribute == "str")
	{
		if((GetAbilityModifier(ABILITY_STRENGTH, oPC) + Random(5)) > attributeCheck)
			SetLocalInt(oPC, "AttrCheck", 1);
		else
			SetLocalInt(oPC, "AttrCheck", 0)
	}
	else if(attribute == "dex")
	{
		if((GetAbilityModifier(ABILITY_DEXTERITY, oPC) + Random(5)) > attributeCheck)
			SetLocalInt(oPC, "AttrCheck", 1);
		else
			SetLocalInt(oPC, "AttrCheck", 0);
	}
	else if(attribute == "con")
	{
		if((GetAbilityModifier(ABILITY_CONSTITUTION, oPC) + Random(5)) > attributeCheck)
			SetLocalInt(oPC, "AttrCheck", 1);
		else
			SetLocalInt(oPC, "AttrCheck", 0);
	}
	else if(attribute == "int")
	{
				if((GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
	}
	else if(attribute == "wis")
	{
				if((GetAbilityModifier(ABILITY_WISDOM, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
	}
	else if(attribute == "cha")
	{
				if((GetAbilityModifier(ABILITY_CHARISMA, oPC) + Random(5)) > attributeCheck)
				SetLocalInt(oPC, "AttrCheck", 1);
			else
				SetLocalInt(oPC, "AttrCheck", 0);
	}
	*/
}