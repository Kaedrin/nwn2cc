//Put this script OnEnter
#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	object oPC = GetEnteringObject();
	object oArea = GetArea(oPC);
	if(GetLocalInt(oArea,"alg_jailor")!=1 && GetObjectByTag("sd_jailor")==OBJECT_INVALID)
	{
		string sTemplate = "sd_jailor";
		object oLocation = GetObjectByTag("wp_jailor");
    	location lLocation = GetLocation(oLocation);
		int iObjType = GetObjectTypes("C");
		SendMessageToPC(oPC, "Perhaps upsetting the guards was not a good idea, hopefully a jailor will come by soon.");
		DelayCommand(300.0, ActionCreateObject(iObjType, sTemplate, lLocation));
		SetLocalInt(oArea, "alg_jailor", 1);
	}	


}
 