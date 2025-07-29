/*  
DMFI MANAGER TOOL
Qk library scripts for the DMFI Manager tool
It controls the vector positions too
10/07


*/

#include "dmfi_inc_tool"



void main(string sValue, int nObj, float nX, float nY, float nZ)
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oPC = OBJECT_SELF;
	string sDMKey = GetName(oPC) + "_" + GetPCPublicCDKey(OBJECT_SELF);
	object oArea = GetArea(oPC);
//	if (!GetIsDM(oPC)) return;
	object oTarget = GetPlayerCurrentTarget(oPC);
	if (!DMFI_GetIsDM(oPC)) return;
	int nString;
	
	if (GetStringLeft(sValue,6)=="SLOT2_")
		{
		sValue = GetSubString(sValue,6,2);
		//SendMessageToPC(oPC,sValue);
		SetLocalInt(oPC,"DMFI_MNGR_TOOL2",StringToInt(sValue));
		}
		
	else if (sValue == "BUT_STORE")
		{
		if ((GetObjectType(oTarget)!= 1) && (GetObjectType(oTarget)!=2))
			   {
			   SendMessageToPC(oPC,ONLY_ITEMCREAT);	
			   return;
			   }
	    nString=GetLocalInt(oPC,"DMFI_MNGR_TOOL2");
	    if (nString<1)
			{
			SendMessageToPC(oPC,"Must select a slot");
			return;
			}
			string sName = GetName(oTarget);
		StoreCampaignObject(DMFI_STORE_DB,"SLOT2_"+IntToString(nString) + "_" + sDMKey,oTarget,oPC);
		SetCampaignString(DMFI_STORE_DB,"NAME2_"+IntToString(nString),sName,oPC);
		SendMessageToPC(oPC,SUCCESS_ADD);
		SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "2","BUT_MNGR_"+IntToString(nString),0,sName);
			   
		}
		
	else if (sValue == "BUT_PICKUP")
		{
		 object oLoc = IntToObject(nObj);
         location lLoc = Location(oArea,Vector(nX,nY,nZ),GetFacing(oPC));
		 object oLod;
		 nString=GetLocalInt(oPC,"DMFI_MNGR_TOOL2");
		 
		 if(GetObjectType(oLoc)==1)
		 	 oLod = RetrieveCampaignObject(DMFI_STORE_DB,"SLOT2_"+IntToString(nString) + "_" + sDMKey,GetLocation(oLoc),oLoc);
			else
			 oLod = RetrieveCampaignObject(DMFI_STORE_DB,"SLOT2_"+IntToString(nString) + "_" + sDMKey,lLoc);
		// SendMessageToPC(oPC,"n"+IntToString(GetObjectType(oLod)));


		}
	else if (sValue=="READ_MNGR")
		{
		int i;
		string sNameB;
		
		for(i=1;i<21;i++)
			{
			string sSlot=IntToString(i);
			sNameB = GetCampaignString(DMFI_STORE_DB,"NAME2_"+sSlot,oPC);
			if (sNameB!="")
				SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "2","BUT_MNGR_"+sSlot,0,sNameB); 
			else
				SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "2","BUT_MNGR_"+sSlot,0,SLOT_EMPTY); 
			}
		}
		else
		SendMessageToPC(oPC, "nohayui2");
}