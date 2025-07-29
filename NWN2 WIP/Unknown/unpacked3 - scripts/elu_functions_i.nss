/*

Revision v1.05b
Fixed issue with skill point asssignment not taking into account racial adjustments to the Intelligence score.
*/


const string SKILL_LEVELS_BOUGHT = "SKILL_LEVELS_BOUGHT";
const string SPENT_SKILL_POINTS = "SPENT_SKILL_POINTS";
const string BASE_SKILL_POINTS = "BASE_SKILL_POINTS";
const string LAST_SELECTED_CLASS = "LAST_SELECTED_CLASS";
const string SKILL_DATA_POINT = "SKILL_DATA_POINT";
const string CLASS_DATA_POINT = "CLASS_DATA_POINT";
const string PRELEVELUP_FLAG = "PRELEVELUP_FLAG";
const string CANCELLEVELUP_FLAG = "CANCELLEVELUP_FLAG";
const string LAST_HOTBARBUTTON_DROP = "LAST_HOTBARBUTTON_DROP";
const string DATA_HOTBARBUTTON = "DATA_HOTBARBUTTON";
const string HOTBAR_BUTTON_ID = "HOTBAR_BUTTON_ID";

//Returns the minimum XP required to attain nLevel
int GetMinimumXPRequiredForLevel(int nLevel)
{	
	return (nLevel - 1) * nLevel * 500;
}

int GetIntBonusPoints(object oChar)
{
	int nIntAdj = StringToInt(Get2DAString("racialsubtypes", "IntAdjust", GetSubRace(oChar)));	
	int nIntScore = GetAbilityScore(oChar, ABILITY_INTELLIGENCE, TRUE) + nIntAdj;
	int nBonusPoints = (nIntScore / 2) - 5;
	return nBonusPoints;
}

int GetGUIAvailableSkillPoints(object oChar)
{
	int nSpentPoints = GetLocalInt(oChar, SPENT_SKILL_POINTS);
	int nBaseSkillPoints = GetLocalInt(oChar, BASE_SKILL_POINTS);	
	int nBonusPoints = GetIntBonusPoints(oChar);
	int nPointsRemaining = GetSkillPointsRemaining(oChar);
	int bSkilled = GetHasFeat(1773, oChar);
	int nInitialPoints = nBaseSkillPoints + nBonusPoints + nPointsRemaining + bSkilled;	
	return nInitialPoints - nSpentPoints;	
}

void SetGUIUnAllocatedPoints(int nPoints)
{
	string sPointPool = IntToString(nPoints);
	SetGUIObjectText(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS", "POINT_POOL_TEXT", -1, sPointPool);
	int bDisabled = (nPoints > 5);
	SetGUIObjectDisabled(OBJECT_SELF, "SCREEN_LEVELUP_SKILLS","CHOICE_NEXT", bDisabled); 		
}

void AdjustGUISkillRank(object oChar, int nSkillID, int nCurSkillLevelsBought, int nCurSpentPoints, int nSkillLevelCost)
{
	nCurSpentPoints += nSkillLevelCost;
	nCurSkillLevelsBought += (nSkillLevelCost < 0 ? -1 : 1);
	SetLocalInt(oChar, SKILL_LEVELS_BOUGHT + IntToString(nSkillID), nCurSkillLevelsBought);	
	SetLocalInt(oChar, SPENT_SKILL_POINTS, nCurSpentPoints);
	int nRank = GetSkillRank(nSkillID, oChar, TRUE);	
	string sTextFields = "SKILL_RANK=" + IntToString(nRank + nCurSkillLevelsBought);
	ModifyListBoxRow(oChar, "SCREEN_LEVELUP_SKILLS", "CUSTOM_SKILLPANE_LIST",IntToString(nSkillID),sTextFields, "", "", "");
}

int SpendSkillPoints(int nPointsRemaining, object oChar, string sClassSkill, string sSkillID)
{
	int nSkillLevelsBought = GetLocalInt(oChar, SKILL_LEVELS_BOUGHT + sSkillID);
	int nRank = GetSkillRank(StringToInt(sSkillID), oChar, TRUE);
	int nLevel = GetHitDice(oChar) + 1;	
	int nSpentPoints = GetLocalInt(oChar, SPENT_SKILL_POINTS);			
	if (sClassSkill == "1")
	{
		if (nRank + nSkillLevelsBought < nLevel + 3)
		{
			int nLevelsToBuy = (nLevel + 3) - (nRank + nSkillLevelsBought);
			if (nLevelsToBuy > nPointsRemaining)
				nLevelsToBuy = nPointsRemaining;
			nPointsRemaining -= nLevelsToBuy;	
			SetLocalInt(oChar, SKILL_LEVELS_BOUGHT + sSkillID, nSkillLevelsBought + nLevelsToBuy);	
			SetLocalInt(oChar, SPENT_SKILL_POINTS, nSpentPoints + nLevelsToBuy);	
			string sTextFields = "SKILL_RANK=" + IntToString(nRank + nSkillLevelsBought + nLevelsToBuy);
			ModifyListBoxRow(oChar, "SCREEN_LEVELUP_SKILLS", "CUSTOM_SKILLPANE_LIST",sSkillID,sTextFields, "", "", "");
		}
	}
	else
	{
		if (nRank + nSkillLevelsBought < (nLevel + 3) / 2)
		{
			int bHasAbleLearner = GetHasFeat(1774, oChar);			
			int nLevelsToBuy = ((nLevel + 3) / 2) - (nRank + nSkillLevelsBought);
			int nCost = (bHasAbleLearner ? 1 : 2);
			if (nLevelsToBuy > (nPointsRemaining / nCost))
				nLevelsToBuy = (nPointsRemaining / nCost);
			nPointsRemaining -= (nLevelsToBuy * nCost);	
			SetLocalInt(oChar, SKILL_LEVELS_BOUGHT + sSkillID, nSkillLevelsBought + nLevelsToBuy);	
			SetLocalInt(oChar, SPENT_SKILL_POINTS, nSpentPoints + (nLevelsToBuy * nCost));	
			string sTextFields = "SKILL_RANK=" + IntToString(nRank + nSkillLevelsBought + nLevelsToBuy);
			ModifyListBoxRow(oChar, "SCREEN_LEVELUP_SKILLS", "CUSTOM_SKILLPANE_LIST",sSkillID,sTextFields, "", "", "");
		}
	}
	return nPointsRemaining;
}

void AssignPuchasedSkillLevels(object oChar)
{
	object oSDP =  GetObjectByTag(SKILL_DATA_POINT);		
	//for each skill in oSDP
	int i = 0;
	string sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	while (sSkillValues != "")
	{
		int n1 = FindSubString(sSkillValues, ":");
		int n2 = FindSubString(sSkillValues, ":", n1+1);
		string sSkillID = GetSubString(sSkillValues, n1+1, n2-(n1+1));
		int nSkillLevelsBought = GetLocalInt(oChar, SKILL_LEVELS_BOUGHT + sSkillID);		
		if (nSkillLevelsBought > 0)
		{
			int nRank = GetSkillRank(StringToInt(sSkillID), oChar, TRUE);
			SetBaseSkillRank(oChar, StringToInt(sSkillID), nRank + nSkillLevelsBought,TRUE);
		}
		i++;
		sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	}	
	//set skill points remaining
	int nSpentPoints = GetLocalInt(oChar, SPENT_SKILL_POINTS);	
	int nSkillPointsRemaining = GetSkillPointsRemaining(oChar);		
	SetSkillPointsRemaining(oChar, nSkillPointsRemaining - nSpentPoints);
}

string GetSkillsSummaryText()
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	object oSDP = GetObjectByTag(SKILL_DATA_POINT);
	int i = 0;
	string sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	string sText = "Skills:\n";
	int bFoundSkills = FALSE;
	while (sSkillValues != "")
	{
		int n1 = FindSubString(sSkillValues, ":");
		string sSkillName = GetStringLeft(sSkillValues, n1);
		int n2 = FindSubString(sSkillValues, ":", n1+1);
		string sSkillID = GetSubString(sSkillValues, n1+1, n2-(n1+1));
		int nSkillLevelsBought = GetLocalInt(oChar, SKILL_LEVELS_BOUGHT + sSkillID);		
		if (nSkillLevelsBought > 0)
		{
			sText += sSkillName + " + " + IntToString(nSkillLevelsBought) + "\n";
			bFoundSkills = TRUE;
		}
		i++;
		sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	}	
	if (!bFoundSkills)
		sText += "(none)\n";
	return sText;
}

void AllocateSkillPoints(object oChar, int nClass)
{	//there is no skill package to use as a guide
	int i = 0;
	int nPointsRemaining = GetGUIAvailableSkillPoints(oChar);
	object oSDP =  GetObjectByTag(SKILL_DATA_POINT);	
	string sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	while (nPointsRemaining > 0 || sSkillValues == "")
	{	//bump all class skills first
		string sSkill;
		int n = FindSubString(sSkillValues, ";" + IntToString(nClass) + ":");
		if (n != -1)
		{
			string cs = GetSubString(sSkillValues, n+2+GetStringLength(IntToString(nClass)),1);
			if (cs == "1")
				nPointsRemaining = SpendSkillPoints(nPointsRemaining, oChar, cs, sSkill); 
		}
		i++; 
		sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));		
	}
	i = 0;
	sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));	   
	while (nPointsRemaining > 0 || sSkillValues == "")
	{	//now bump cross class skills
		string sSkill;
		int n = FindSubString(sSkillValues, ";" + IntToString(nClass) + ":");
		if (n != -1)
		{
			string cs = GetSubString(sSkillValues, n+2+GetStringLength(IntToString(nClass)),1);
			int bHasAbleLearner = GetHasFeat(1774, oChar);						
			if (cs == "0" && nPointsRemaining > 1 || bHasAbleLearner)
				nPointsRemaining = SpendSkillPoints(nPointsRemaining, oChar, cs, sSkill); 
		}
		i++; 
		sSkillValues = GetLocalString(oSDP, "Skill" + IntToString(i));		
	}
}

void AllocateSkillPointsByPackage(object oChar, string skillpackage, int nClass)
{
	int i = 0;
	int nPointsRemaining = GetGUIAvailableSkillPoints(oChar);	
	int nSkillCount = GetNum2DARows(skillpackage);
	object oSDP =  GetObjectByTag(SKILL_DATA_POINT);	
	while (nPointsRemaining > 0 && i < nSkillCount)
	{
		string sSkill = Get2DAString(skillpackage, "SkillIndex", i);
		string sIndex = GetLocalString(oSDP, "SkillID" + sSkill);
		string sSkillValues = GetLocalString(oSDP, "Skill" + sIndex);
	    int n = FindSubString(sSkillValues, ";" + IntToString(nClass) + ":");
		if (n != -1)
		{
			string cs = GetSubString(sSkillValues, n+2+GetStringLength(IntToString(nClass)),1);
			int bHasAbleLearner = GetHasFeat(1774, oChar);						
			if (cs == "1" || nPointsRemaining > 1 || bHasAbleLearner)
				nPointsRemaining = SpendSkillPoints(nPointsRemaining, oChar, cs, sSkill); 
		}
		i++;
	}	
	SetGUIUnAllocatedPoints(nPointsRemaining);
}


//Function called by Sort, do not call directly
void Swap(object oObj, string sVarPrefix, string sDataType, int nIndex1, int nIndex2)
{
	string sVar1 = sVarPrefix + IntToString(nIndex1);
	string sVar2 = sVarPrefix + IntToString(nIndex2);
	if (sDataType == "string")
	{
		string s1 = GetLocalString(oObj, sVar1);
		string s2 = GetLocalString(oObj, sVar2); 
		SetLocalString(oObj, sVar1, s2);
		SetLocalString(oObj, sVar2, s1);			
	}
	else if (sDataType == "int")
	{
		int n1 = GetLocalInt(oObj, sVar1);
		int n2 = GetLocalInt(oObj, sVar2); 
		SetLocalInt(oObj, sVar1, n2);
		SetLocalInt(oObj, sVar2, n1);
	}
	else if (sDataType == "float")
	{
		float f1 = GetLocalFloat(oObj, sVar1);
		float f2 = GetLocalFloat(oObj, sVar2); 
		SetLocalFloat(oObj, sVar1, f2);
		SetLocalFloat(oObj, sVar2, f1);
	}
}

//Function called by Sort, do not call directly
int Compare(object oObj, string sPrefix, string sDataType, int nIndex1, int nIndex2)
{
	string sVar1 = sPrefix + IntToString(nIndex1);
	string sVar2 = sPrefix + IntToString(nIndex2);
	if (sDataType == "string")
	{
		string s1 = GetLocalString(oObj, sVar1);
		string s2 = GetLocalString(oObj, sVar2); 
		return (StringCompare(s1, s2) <= 0);			
	}
	else if (sDataType == "int")
	{
		int n1 = GetLocalInt(oObj, sVar1);
		int n2 = GetLocalInt(oObj, sVar2); 
		return (n1 <= n2);
	}
	else if (sDataType == "float")
	{
		float f1 = GetLocalFloat(oObj, sVar1);
		float f2 = GetLocalFloat(oObj, sVar2); 
		return (f1 <= f2);
	}
	return FALSE;
}

//Function called by Sort, do not call directly
void SiftDown(object oObj, string sPrefix, string sDataType, int nStart, int nEnd)
{
	int nRoot = nStart;
	while (nRoot * 2 + 1 <= nEnd)
	{
		int nChild = nRoot * 2 + 1;
		if (nChild + 1 <= nEnd && Compare(oObj, sPrefix, sDataType, nChild, nChild + 1))
			nChild = nChild + 1;
        if (Compare(oObj, sPrefix, sDataType, nRoot, nChild))
        {
		    Swap(oObj, sPrefix, sDataType, nRoot, nChild);
            nRoot = nChild;
        }
		else
        	return;
	}
}

//Function called by Sort, do not call directly
void Heapify(object oObj, string sPrefix, string sDataType, int nCount)
{
	int nStart = (nCount - 2) / 2;
	while (nStart >= 0)
	{
		SiftDown(oObj, sPrefix, sDataType, nStart, nCount - 1);
		nStart = nStart - 1;
	}
}

//Sorts a zero-based array like list where the values are retrived via:
//GetLocal[sDataType](oObjWithArrayVars, sVarPrefixX)
//where X is 0 to nLengthOfArray.
//sDataType can be "string", "int", or "float"
void Sort(object oObjWithArrayVars, string sVarPrefix, string sDataType, int nLengthOfArray)
{
	if (!GetIsObjectValid(oObjWithArrayVars) || 
		(sDataType != "int" && sDataType != "float" && sDataType != "string"))
		return;
	Heapify(oObjWithArrayVars, sVarPrefix, sDataType, nLengthOfArray);
	int nEnd = nLengthOfArray - 1;
	while (nEnd > 0)
	{
		Swap(oObjWithArrayVars, sVarPrefix, sDataType, 0, nEnd);
		SiftDown(oObjWithArrayVars, sVarPrefix, sDataType, 0, nEnd - 1);
		nEnd = nEnd - 1; 
	}
}

//Create a Waypoint with sDAtaPointTag for storing variables on instead of using
//the overused module object.
void CreateDataPoint(string sDataPointTag)
{
	object oDataPoint = GetObjectByTag(sDataPointTag);
	if (!GetIsObjectValid(oDataPoint))
	{
    	oDataPoint = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetStartingLocation());
		SetTag(oDataPoint, sDataPointTag);
	}
}

//The purpose of the function is to load soecific 2DA related data 
//onto a specific data point to avoid using Get2DAString calls from 
//gui script, which can cause slow GUIs.
void LoadClass2DAData()
{
	CreateDataPoint(CLASS_DATA_POINT);
	int nCount = GetNum2DARows("classes");
	int i;	
	object oDP = GetObjectByTag(CLASS_DATA_POINT);
	for (i = 0; i < nCount; i++)
	{
		string sPlayerClass = Get2DAString("classes", "PlayerClass", i);
		if (sPlayerClass == "1")
		{
			string sStrRefID = Get2DAString("classes", "Name", i);				
			string sRowName = GetStringByStrRef(StringToInt(sStrRefID));
			SetLocalString(oDP, IntToString(i), sRowName);						
		}
	}
}

//The purpose of the function is to load soecific 2DA related data 
//onto a specific data point to avoid using Get2DAString calls from 
//gui script, which can cause slow GUIs.
void LoadSkill2DAData()
{
	CreateDataPoint(SKILL_DATA_POINT);	
	int nCount = GetNum2DARows("skills");
	int j, k, nCounter = -1;	
	object oSDP = GetObjectByTag(SKILL_DATA_POINT);
	object oCDP = GetObjectByTag(CLASS_DATA_POINT);
	int nClassCount = GetVariableCount(oCDP);			
		
	//compile the class skill list
	//cXX:0|1;  XX = classID, 
	//0 = cross class, 1 = class skill
	for(j = 0; j < nClassCount; j++)
	{
		string sClassID = GetVariableName(oCDP, j);
		string sSkillsTable = Get2DAString("classes", "SkillsTable", StringToInt(sClassID));
		int nSkillTableCount = GetNum2DARows(sSkillsTable);
		for(k = 0; k < nSkillTableCount; k++)
		{
			string sSkill = Get2DAString(sSkillsTable, "SkillIndex", k);
			int nSkill =  StringToInt(sSkill);
			string sRemoved = Get2DAString("skills", "REMOVED", nSkill);
			if (sRemoved == "0")
			{
				string sIndex = GetLocalString(oSDP, "SkillID" + sSkill);
				string sSkillValue;
				if (sIndex == "")
				{
					nCounter++;
					sIndex = IntToString(nCounter);
					string sImage = Get2DAString("skills", "Icon", nSkill) + ".tga";
					string sRowName = GetStringByStrRef(StringToInt(Get2DAString("skills", "Name", nSkill)));
					string sDescription = GetStringByStrRef(StringToInt(Get2DAString("skills", "Description", nSkill)));
					sSkillValue = sRowName + ":" + sSkill + ":" + sImage + ";";
					SetLocalString(oSDP, "SkillID" + sSkill, sIndex);
					SetLocalString(oSDP, "SkillDesc" + sSkill, sDescription);
				}
				else
					sSkillValue = GetLocalString(oSDP, "Skill" + sIndex);
				
				string sClassSkill = Get2DAString(sSkillsTable, "ClassSkill", k);
				sSkillValue += sClassID + ":" + sClassSkill + ";";
				SetLocalString(oSDP, "Skill" + sIndex, sSkillValue);					
			}
		}
	}
	//sort the skill values.
	Sort(oSDP,"Skill","string",nCounter);
	//remap skillIDs to sorted index
	int i = 0;
	for(i = 0; i < nCounter; i++)
	{
	`	string sIndex = IntToString(i);
		string sSkillValue = GetLocalString(oSDP, "Skill" + sIndex);
		int n1 = FindSubString(sSkillValue, ":",0);
		int n2 = FindSubString(sSkillValue, ":",n1+1);
		string sSkill = GetSubString(sSkillValue, n1+1, n2 - (n1+1));
		SetLocalString(oSDP, "SkillID" + sSkill, sIndex);		
	}	
}

void ClearHotbarButtonItemData(object oChar, object oLostItem)
{
	string sObjectID = "I" + IntToString(ObjectToInt(oLostItem));
	int i = 0;
	object oSave = oChar;
	if (GetIsOwnedByPlayer(oChar))
		oSave = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oChar);
	//120 is the max count of hotbar buttons
	//ex there are 10 rows of 12 hotbar buttons.
	for(i = 0; i < 120; i++)
	{		
		string sButtonData = GetLocalString(oSave, DATA_HOTBARBUTTON + IntToString(i));
		if (sButtonData != "")
		{
			int nIndex = FindSubString(sButtonData, ":", 0);
			if (GetStringLeft(sButtonData, nIndex) == sObjectID)
				DeleteLocalString(oSave, DATA_HOTBARBUTTON + IntToString(i));			
		}		
	}
}

object GetHotBarButtonPresser()
{
	return GetControlledCharacter(OBJECT_SELF);
}

string GetHotBarButtonData()
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	string sButtonID = GetLocalString(oChar, HOTBAR_BUTTON_ID);
	object oSave = oChar;
	if (GetIsOwnedByPlayer(oChar))
		oSave = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oChar);	
	return GetLocalString(oSave, DATA_HOTBARBUTTON + sButtonID);
}

void SetHotBarButtonData(string sButtonData)
{
	object oChar = GetControlledCharacter(OBJECT_SELF);	
	string sButtonID = GetLocalString(oChar, LAST_HOTBARBUTTON_DROP);
	object oSave = oChar;
	if (GetIsOwnedByPlayer(oChar))
		oSave = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oChar);	
	SetLocalString(oSave, DATA_HOTBARBUTTON + sButtonID, sButtonData);
	DeleteLocalString(oChar, LAST_HOTBARBUTTON_DROP);
}

void RemoveHotBarButtonData(string sButtonID)
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	object oSave = oChar;
	if (GetIsOwnedByPlayer(oChar))
		oSave = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oChar);	
	DeleteLocalString(oSave, DATA_HOTBARBUTTON + sButtonID);
}

int GetIsHotBarButtonEmpty()
{
	string sButtonData = GetHotBarButtonData();		
	return (sButtonData == "");
}

int GetHotBarButtonSkillID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "S")
		return -1;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return StringToInt(sID);	
}

int GetHotBarButtonBardSongID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "B")
		return -1;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return StringToInt(sID);	
}

int GetHotBarButtonModeID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "M")
		return -1;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return StringToInt(sID);	
}

object GetHotBarButtonItem()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return OBJECT_INVALID;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "I")
		return OBJECT_INVALID;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return IntToObject(StringToInt(sID));	
}

int GetHotBarButtonSpellID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "P")
		return -1;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return StringToInt(sID);	
}

int GetHotBarButtonFeatID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "F")
		return -1;
	string sID = GetStringRight(sData, GetStringLength(sData) - 1);
	return StringToInt(sID);	
}

int GetHotBarButtonMetaMagicID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "P")
		return -1;
	sData = GetStringRight(sButtonData, GetStringLength(sButtonData) - (nIndex+1));
	nIndex = FindSubString(sData, ":", 0);
	string sMetaMagicID = GetStringRight(sData, GetStringLength(sData) - (nIndex+1));			
	return StringToInt(sMetaMagicID);	
}

int GetHotBarButtonSpellCasterClassID()
{
	string sButtonData = GetHotBarButtonData();
	if (sButtonData == "")
		return -1;
	int nIndex = FindSubString(sButtonData, ":", 0);
	string sData = GetStringLeft(sButtonData, nIndex);
	string sButtonType = GetStringLeft(sData, 1);
	if (sButtonType != "P")
		return -1;
	sData = GetStringRight(sButtonData, GetStringLength(sButtonData) - (nIndex+1));
	nIndex = FindSubString(sData, ":", 0);
	string sClassIndex = GetStringLeft(sData, nIndex);
	return StringToInt(sClassIndex);	
}