string sObjectType="V";
string sTemplate=GetLocalString(OBJECT_SELF, "FXNameClass");
string sLocationTag=GetLocalString(OBJECT_SELF, "Waypoint6");
string sNewTag=GetLocalString(OBJECT_SELF, "NewFX");

#include "ginc_param_const"
#include "ginc_actions"

void main(int bUseAppearAnimation, float fDelay)
{
	object oLocation = GetNearestObjectByTag(sLocationTag);
	if (!GetIsObjectValid(oLocation))
		oLocation = OBJECT_SELF;
    location lLocation = GetLocation(oLocation);
    int iObjType = GetObjectTypes(sObjectType);

    DelayCommand(fDelay, ActionCreateObject(iObjType, sTemplate, lLocation, bUseAppearAnimation, sNewTag));
}