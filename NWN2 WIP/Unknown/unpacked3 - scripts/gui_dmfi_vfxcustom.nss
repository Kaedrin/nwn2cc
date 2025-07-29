/*  Qk 11/07
	- DMFI_CUSTOMVFX
	Controls the VFX custom input
	Added
	Controls destroy placeables, such as the main was ready for the
	UI_InputTarget function


*/

// 



#include "dmfi_inc_tool"

//Modified DMFI main vfx function to support custom nwn2 effects
void DMFI_CreateCustomVFX(object oTool, object oSpeaker, string sText, location lLoc);
//Function to destroy placeables in a given radius and center
void DestroyPlaceablesInRadius(location lCenter, float fRadius);

void RotatePlaceablesInRadius(location lCenter);

void DestroyPlacedEffectsInRadius(location lCenter);

void main(string sValue, string sInput, float nX, float nY, float nZ)
{
	object oPC = OBJECT_SELF;
	object oTool = DMFI_GetTool(oPC);
	if (!DMFI_GetIsDM(oPC)) return;
	location lLoc = Location(GetArea(oPC),Vector(nX,nY,nZ),GetFacing(oPC));
	
	if (sValue == "SETFACING") {
		RotatePlaceablesInRadius(lLoc);
		return;
	}
	
	if (sValue == "REMOVE_P_EFFECTS") {
		DestroyPlacedEffectsInRadius(lLoc);
		return;
	}
	
	if (sValue == "OPEN_UI_VFX")
		{
		DisplayGuiScreen(oPC,SCREEN_DMFI_VFXINPUT,FALSE,"dmfitextvfx.xml");
		return;
		}
	if (sValue == "DESTROY3FEET")
		{
		DestroyPlaceablesInRadius(lLoc,1.4);
		return;
		}
	if (sValue == "DESTROY6FEET")
		{
		DestroyPlaceablesInRadius(lLoc,3.0);
		return;
		}
	if (sValue == "DESTROY20FEET")
		{
		DestroyPlaceablesInRadius(lLoc,10.0);
		return;
		}
	else
		{
		 
		 DMFI_CreateCustomVFX(oTool,oPC,sValue,lLoc);
		}
	

}


void DMFI_CreateCustomVFX(object oTool, object oSpeaker, string sText, location lLoc)
{  //Purpose: Create a Visual effect according to preferences.  sText is the
   //Label for the VFX and sParam is the row of the 2da file.
   //Original Scripter: Demetrious
   //Last Modified By: Qk 10/07
    object oTarget;
    effect eVFX, eEffect;
	int nAppear;
    float fDur;
    object oEffect;
    string sDur;
    location lTargetLoc = lLoc;
	
	sDur = GetLocalString(oTool, DMFI_VFX_DURATION);
	fDur = StringToFloat(sDur);
	
	if (fDur<5.0) fDur=5.0;
    
	oTarget = GetPlayerCurrentTarget(oSpeaker);
	
	if (!GetIsObjectValid(oTarget))
    {  //Simply apply these to a location
	    eVFX = EffectNWN2SpecialEffectFile(sText);
		ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lLoc, fDur);
		return;
	}

    if (FindSubString(sText, "ray")!=-1)
        eVFX = EffectNWN2SpecialEffectFile(sText, oTarget);
    else
        eVFX = EffectNWN2SpecialEffectFile(sText);
    
    if (FindSubString(sText, "ray")!=-1)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oSpeaker, fDur);
    else
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, fDur);
}

void DestroyPlaceablesInRadius(location lCenter, float fRadius)
{
	object oPlac = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACEABLE);
	float f = 0.1;
	while (GetIsObjectValid(oPlac))
		{
		SetPlotFlag(oPlac,FALSE);
		DestroyObject(oPlac,0.1+f,TRUE);
		f = f +0.2;
		oPlac = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACEABLE);
		}
}

void DestroyPlacedEffectsInRadius(location lCenter)
{
	float fRadius = 3.0;
	object oPlac = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACED_EFFECT);
	float f = 0.1;
	while (GetIsObjectValid(oPlac))
		{
			DestroyObject(oPlac,0.1+f,TRUE);
			f = f +0.2;
			oPlac = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACED_EFFECT);
		}
}

// Calculate angle to rotate object
float GetAngle(float fCurrentAngle)
{
	float fNewAngle = fCurrentAngle;
	while (fNewAngle >= 45.0) {
		fNewAngle = fNewAngle - 45.0;
	}
	
	float fAngle = 45.0 - fNewAngle;
	fAngle = fCurrentAngle + fAngle;
	
	return fAngle;
}

void RotatePlaceablesInRadius(location lCenter)
{
	float fRadius = 1.4;
	object oPlac = GetFirstObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACEABLE);
	
	while (GetIsObjectValid(oPlac))
	{
		AssignCommand(oPlac, SetFacing(GetAngle(GetFacing(oPlac))));
		oPlac = GetNextObjectInShape(SHAPE_SPHERE,fRadius,lCenter,FALSE,OBJECT_TYPE_PLACEABLE);
	}
}