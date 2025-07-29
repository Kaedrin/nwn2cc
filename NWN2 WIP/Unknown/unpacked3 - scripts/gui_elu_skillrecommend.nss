#include "elu_functions_i"

void main()
{
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);			
	int bCancelLevelUpFlag = GetLocalInt(oControlledChar, CANCELLEVELUP_FLAG);
	if (bCancelLevelUpFlag)	
		ExecuteScript("gui_elu_prelevelup_e", OBJECT_SELF);		
	
	int nClass = GetLocalInt(oControlledChar, LAST_SELECTED_CLASS);				
	string packageline = Get2DAString("classes", "Package", nClass);
	if (packageline != "****" && packageline != "")
	{
		string skillpackage = Get2DAString("packages", "SkillPref2DA", StringToInt(packageline));
		if (skillpackage != "****" && skillpackage != "")
		{
			AllocateSkillPointsByPackage(oControlledChar, skillpackage, nClass);
			return;
		}			
	}
	SendMessageToPC(oControlledChar, "WARNING: There is no skill package associated with ClassID:" + IntToString(nClass));
	AllocateSkillPoints(oControlledChar, nClass);	
}