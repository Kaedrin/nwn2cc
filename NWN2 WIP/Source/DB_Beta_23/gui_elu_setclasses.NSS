#include "elu_functions_i"

void main()
{
	object oDP = GetObjectByTag(CLASS_DATA_POINT);	
	int nCount = GetVariableCount(oDP);
	int i;	
	for (i = 0; i < nCount; i++)
	{				
		string sRowName = GetVariableValueString(oDP, i);
		string sClassID = GetVariableName(oDP, i);
		string sVariables = "0="+sClassID;
		ModifyListBoxRow(OBJECT_SELF, "SCREEN_LEVELUP_CLASS", "CLASS_LIST", sRowName,"","",sVariables,"");
	}
}