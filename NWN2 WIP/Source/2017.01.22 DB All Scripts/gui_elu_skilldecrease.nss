#include "elu_functions_i"

void main(int nSkillID, string sClassSkill, string sSkillName)
{
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);		
	int bCancelLevelUpFlag = GetLocalInt(oControlledChar, CANCELLEVELUP_FLAG);
	if (bCancelLevelUpFlag)
		ExecuteScript("gui_elu_prelevelup_e", OBJECT_SELF);		
	
	if (sClassSkill == "N")
		return;
	string sSkillID = IntToString(nSkillID);
	int nUnallocatedPoints = GetGUIAvailableSkillPoints(oControlledChar);
	int nSpentPoints = GetLocalInt(oControlledChar, SPENT_SKILL_POINTS);		
	if (nSpentPoints == 0)
		return;
	int nSkillLevelsBought = GetLocalInt(oControlledChar, SKILL_LEVELS_BOUGHT + sSkillID);
	if (nSkillLevelsBought == 0)
		return;
	int nPointCost = -1;
	int bHasAbleLearner = GetHasFeat(1774, oControlledChar);				
	if (sClassSkill == "0" && !bHasAbleLearner)
		nPointCost = -2;
	AdjustGUISkillRank(oControlledChar, nSkillID, nSkillLevelsBought, nSpentPoints, nPointCost);
	SetGUIUnAllocatedPoints(nUnallocatedPoints - nPointCost);
}