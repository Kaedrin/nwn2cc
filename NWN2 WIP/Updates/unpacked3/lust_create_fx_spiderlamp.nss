string sObjectType="V";
string sTemplate=GetLocalString(OBJECT_SELF, "FXNameClass");
string sLocationTag1=GetLocalString(OBJECT_SELF, "Waypoint1");
string sLocationTag2=GetLocalString(OBJECT_SELF, "Waypoint2");
string sLocationTag3=GetLocalString(OBJECT_SELF, "Waypoint3");
string sLocationTag4=GetLocalString(OBJECT_SELF, "Waypoint4");
string sLocationTag5=GetLocalString(OBJECT_SELF, "Waypoint5");
string sLocationTag6=GetLocalString(OBJECT_SELF, "Waypoint6");
string sLocationTag7=GetLocalString(OBJECT_SELF, "Waypoint7");
string sLocationTag8=GetLocalString(OBJECT_SELF, "Waypoint8");
string sNewTag=GetLocalString(OBJECT_SELF, "NewFX");

#include "ginc_param_const"
#include "ginc_actions"

void main(int bUseAppearAnimation, float fDelay)
{
	object oLocation = GetNearestObjectByTag(sLocationTag1);
    location lLocation = GetLocation(oLocation);
    int iObjType = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType, sTemplate, lLocation, bUseAppearAnimation, sNewTag+"_1"));
	
	object oLocation2 = GetNearestObjectByTag(sLocationTag2);
    location lLocation2 = GetLocation(oLocation2);
    int iObjType2 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType2, sTemplate, lLocation2, bUseAppearAnimation, sNewTag+"_2"));
	
	object oLocation3 = GetNearestObjectByTag(sLocationTag3);
    location lLocation3 = GetLocation(oLocation3);
    int iObjType3 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType3, sTemplate, lLocation3, bUseAppearAnimation, sNewTag+"_3"));
	
	object oLocation4 = GetNearestObjectByTag(sLocationTag4);
    location lLocation4 = GetLocation(oLocation4);
    int iObjType4 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType4, sTemplate, lLocation4, bUseAppearAnimation, sNewTag+"_4"));
	
	object oLocation5 = GetNearestObjectByTag(sLocationTag5);
    location lLocation5 = GetLocation(oLocation5);
    int iObjType5 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType5, sTemplate, lLocation5, bUseAppearAnimation, sNewTag+"_5"));
	
	object oLocation6 = GetNearestObjectByTag(sLocationTag6);
    location lLocation6 = GetLocation(oLocation6);
    int iObjType6 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType6, sTemplate, lLocation6, bUseAppearAnimation, sNewTag+"_6"));
	
	object oLocation7 = GetNearestObjectByTag(sLocationTag7);
    location lLocation7 = GetLocation(oLocation7);
    int iObjType7 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType7, sTemplate, lLocation7, bUseAppearAnimation, sNewTag+"_7"));
	
	object oLocation8 = GetNearestObjectByTag(sLocationTag8);
    location lLocation8 = GetLocation(oLocation8);
    int iObjType8 = GetObjectTypes(sObjectType);
    DelayCommand(fDelay, ActionCreateObject(iObjType8, sTemplate, lLocation8, bUseAppearAnimation, sNewTag+"_8"));
}