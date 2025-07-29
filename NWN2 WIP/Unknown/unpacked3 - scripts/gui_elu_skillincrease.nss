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
	if (nUnallocatedPoints == 0)
		return;
	int nSpentPoints = GetLocalInt(oControlledChar, SPENT_SKILL_POINTS);	
	int bHasAbleLearner = GetHasFeat(1774, oControlledChar);			
	int nSkillLevelsBought = GetLocalInt(oControlledChar, SKILL_LEVELS_BOUGHT + sSkillID);
	int nRank = GetSkillRank(nSkillID, oControlledChar, TRUE);
	int nLevel = GetHitDice(oControlledChar) + 1;
	if ((nRank + nSkillLevelsBought >= nLevel + 3 && sClassSkill == "1") ||
		(nRank + nSkillLevelsBought >= (nLevel + 3) / 2 && sClassSkill == "0") ||
		(nUnallocatedPoints == 1 && sClassSkill == "0" && !bHasAbleLearner))
		return;
	int nPointCost = 1;
	if (sClassSkill == "0" && !bHasAbleLearner)
		nPointCost = 2;
	AdjustGUISkillRank(oControlledChar, nSkillID, nSkillLevelsBought, nSpentPoints, nPointCost);
	SetGUIUnAllocatedPoints(nUnallocatedPoints - nPointCost);
}