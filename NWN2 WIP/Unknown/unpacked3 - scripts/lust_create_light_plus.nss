string sObjectType="L";
string sTemplate=GetLocalString(OBJECT_SELF, "LightNameClass");
string sLocationTag=GetLocalString(OBJECT_SELF, "Waypoint");
string sNewTag=GetLocalString(OBJECT_SELF, "NewLight");

#include "ginc_param_const"
#include "ginc_actions"

void main(int bUseAppearAnimation, float fDelay)
{
	object oLocation = GetNearestObjectByTag(sLocationTag);
	if (!GetIsObjectValid(oLocation))
		oLocation = OBJECT_SELF;
    location lLocation = GetLocation(oLocation);
    int iObjType = GetObjectTypes(sObjectType);
	string sTemplate=GetLocalString(OBJECT_SELF, "LightNameClass")+"_plus";
    DelayCommand(fDelay, ActionCreateObject(iObjType, sTemplate, lLocation, bUseAppearAnimation, sNewTag));
}