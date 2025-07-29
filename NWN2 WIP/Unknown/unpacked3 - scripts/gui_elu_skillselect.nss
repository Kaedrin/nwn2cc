#include "elu_functions_i"

void main(int nSkillID, string sClassSkill, string sSkillName)
{		
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);
	int nSelectedSkill = GetLocalInt(oControlledChar, "SELECTED_SKILL");
	if (nSelectedSkill == nSkillID)
		return;
	SetLocalInt(oControlledChar, "SELECTED_SKILL", nSkillID);
	string sSkillID = IntToString(nSkillID);
	object oSDP =  GetObjectByTag(SKILL_DATA_POINT);		
	string sIndex = GetLocalString(oSDP, "SkillID" + IntToString(nSkillID));
	string sSkillValues = GetLocalString(oSDP, "Skill" + sIndex);
	int n = FindSubString(sSkillValues, ":");
	n = FindSubString(sSkillValues, ":", n+1);		
	int n3 = FindSubString(sSkillValues, ";");		
	string sImage = GetSubString(sSkillValues, n+1, n3-(n+1));				
	string sDescription = GetLocalString(oSDP, "SkillDesc" + sSkillID);			
	SetGUITexture(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "INFOPANE_IMAGE", sImage);
	SetGUIObjectText(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "INFOPANE_TITLE", -1, sSkillName);
	SetGUIObjectText(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "INFOPANE_TEXT", -1, sDescription);
}	