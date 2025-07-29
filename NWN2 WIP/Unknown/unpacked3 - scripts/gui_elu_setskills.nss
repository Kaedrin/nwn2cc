/*

Revision v1.05b
Fixed issue with skill point asssignment not taking into account racial adjustments to the Intelligence score.
*/

#include "elu_functions_i"

void main()
{
	int i = 0;
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);
	SetLocalInt(oControlledChar, "SELECTED_SKILL", -1);	
	int nClass = GetLocalInt(oControlledChar, LAST_SELECTED_CLASS);	
	object oSDP =  GetObjectByTag(SKILL_DATA_POINT);
	int nBaseSkillPoints = StringToInt(Get2DAString("classes", "SkillPointBase", nClass));
	SetLocalInt(oControlledChar, BASE_SKILL_POINTS, nBaseSkillPoints);
	
	int nBonusPoints = GetIntBonusPoints(oControlledChar);	
	int nPointsRemaining = GetSkillPointsRemaining(oControlledChar);
	int bSkilled = GetHasFeat(1773, oControlledChar); //Feat 1773 is the human 'skilled' feat. (extra skill pt per level)
	int nSkillPoints = nBaseSkillPoints + nBonusPoints + nPointsRemaining + bSkilled;
	
	string sSkillPoints = IntToString(nSkillPoints);
	SetGUIObjectText(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "POINT_POOL_TEXT", -1, sSkillPoints);
	int bDisabled = (nSkillPoints > 5);
	SetGUIObjectDisabled(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS","CHOICE_NEXT", bDisabled);
	DeleteLocalInt(oControlledChar, SPENT_SKILL_POINTS);	
	string sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));
	while (sSkillValues != "")	
	{
		int n1 = FindSubString(sSkillValues, ":");
		string sSkillName = GetStringLeft(sSkillValues, n1);
		int n2 = FindSubString(sSkillValues, ":", n1+1);
		string sSkillID = GetSubString(sSkillValues, n1+1, n2-(n1+1));
		int n3 = FindSubString(sSkillValues, ";");		
		string sImage = GetSubString(sSkillValues, n2+1, n3-(n2+1));				
		string sSkillRank = IntToString(GetSkillRank(StringToInt(sSkillID), oControlledChar, TRUE));
		int n = FindSubString(sSkillValues, ";" + IntToString(nClass) + ":");
		string sTextFields;
		string sHideUnhide;
		string cs = "N";
		if (n == -1)
		{
			sTextFields = "SKILL_TEXT_NA=" + sSkillName + ";SKILL_RANK=" + sSkillRank;
			sHideUnhide ="SKILL_TEXT_CS=hide;SKILL_TEXT_CC=hide;SKILL_TEXT_NA=unhide";	
		}
		else
		{
			cs = GetSubString(sSkillValues, n+2+GetStringLength(IntToString(nClass)),1);
			if (cs == "1")
			{
				sTextFields = "SKILL_TEXT_CS=" + sSkillName + ";SKILL_RANK=" + sSkillRank;
				sHideUnhide ="SKILL_TEXT_CS=unhide;SKILL_TEXT_CC=hide;SKILL_TEXT_NA=hide";	
			} 
			else
			{
				sTextFields = "SKILL_TEXT_CC=" + sSkillName + ";SKILL_RANK=" + sSkillRank;
				sHideUnhide ="SKILL_TEXT_CS=hide;SKILL_TEXT_CC=unhide;SKILL_TEXT_NA=hide";	
			}
		}		
		string sVariables = "0=" + sSkillID + ";1=" + cs + ";2=" + sSkillName;
		string sTextures = "SKILL_IMAGE=" + sImage;		
		DeleteLocalInt(oControlledChar,SKILL_LEVELS_BOUGHT + sSkillID);		
		AddListBoxRow(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "CUSTOM_SKILLPANE_LIST", sSkillID, sTextFields, sTextures, sVariables, sHideUnhide);
		i++;
		sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));		
	}	
}