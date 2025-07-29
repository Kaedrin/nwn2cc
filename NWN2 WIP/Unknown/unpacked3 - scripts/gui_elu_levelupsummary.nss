#include "elu_functions_i"

void main()
{
	string sText = GetSkillsSummaryText();
	if (sText != "")
		SetGUIObjectText(OBJECT_SELF, "SCREEN_LEVELUP_FINISH", "INFOPANE_SKILLTEXT", -1, sText);
}