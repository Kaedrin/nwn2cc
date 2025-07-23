/*  
DMFI MANAGER TOOL
Qk library scripts for the DMFI Manager tool
It controls the vector positions too
10/07


*/

#include "dmfi_inc_tool"

void main(string sValue, int nObj, float nX, float nY, float nZ)
{
	object oPC = OBJECT_SELF;
	object oArea = GetArea(oPC);
	object oTarget = GetPlayerCurrentTarget(oPC);
	if (!DMFI_GetIsDM(oPC)) return;
	string sDMKey = GetName(oPC) + "_" + GetPCPublicCDKey(OBJECT_SELF);
	int nString;
	int nPage;
	string sSlot;
	string sPage;
	
	if (FindSubString(sValue,"SLOT3") != -1)
		{
		//sValue = GetSubString(sValue,5,2);
		sSlot = GetSubString(sValue, 8, 2);
		sPage = GetSubString(sValue, 0, 1);
		//SendMessageToPC(oPC,sValue);
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3",StringToInt(sSlot));
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3_PAGE",StringToInt(sPage));
		}
		
	else if (sValue == "BUT_STORE")
		{
		if ((GetObjectType(oTarget)!= 1) && (GetObjectType(oTarget)!=2))
			   {
			   SendMessageToPC(oPC,ONLY_ITEMCREAT);	
			   return;
			   }
	    nString=GetLocalInt(oPC,"DMFI_MNGR_TOOL_3");
		nPage=GetLocalInt(oPC,"DMFI_MNGR_TOOL_3_PAGE");
	    if (nString<1)
			{
			SendMessageToPC(oPC,"Must select a slot");
			return;
			}
			string sName = GetName(oTarget);
		StoreCampaignObject(DMFI_STORE_DB,IntToString(nPage)+"_SLOT3_"+IntToString(nString) + "_" + sDMKey,oTarget,oPC);
		SetCampaignString(DMFI_STORE_DB,IntToString(nPage)+"_NAME_"+IntToString(nString)+ "_" + sDMKey,sName,oPC);
		SendMessageToPC(oPC,SUCCESS_ADD);
		SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "3",IntToString(nPage)+"_BUT_MNGR_"+IntToString(nString),0,sName);
			   
		}
		
	else if (sValue == "BUT_PICKUP")
		{
		 object oLoc = IntToObject(nObj);
         location lLoc = Location(oArea,Vector(nX,nY,nZ),GetFacing(oPC));
		 object oLod;
		 nString=GetLocalInt(oPC,"DMFI_MNGR_TOOL_3");
		 nPage=GetLocalInt(oPC,"DMFI_MNGR_TOOL_3_PAGE");
		 
		 if(GetObjectType(oLoc)==1)
		 	 oLod = RetrieveCampaignObject(DMFI_STORE_DB,IntToString(nPage)+"_SLOT3_"+IntToString(nString)+ "_" + sDMKey,GetLocation(oLoc),oLoc);
			else
			 oLod = RetrieveCampaignObject(DMFI_STORE_DB,IntToString(nPage)+"_SLOT3_"+IntToString(nString)+ "_" + sDMKey,lLoc);
		// SendMessageToPC(oPC,"n"+IntToString(GetObjectType(oLod)));


		}
	else if (sValue=="READ_MNGR")
	{
		int i;
		int j;
		string sNameB;
		
		for (j = 1; j < 6; j++) {
			sPage = IntToString(j);
			for(i=1;i<21;i++)
				{				
				sSlot=IntToString(i);
				sNameB = GetCampaignString(DMFI_STORE_DB,sPage+"_NAME_"+sSlot+ "_" + sDMKey,oPC);
				if (sNameB!="")
					SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "3",sPage+"_BUT_MNGR_"+sSlot,0,sNameB); 
				else
					SetGUIObjectText(oPC,SCREEN_DMFI_MNGRTOOL + "3",sPage+"_BUT_MNGR_"+sSlot,0,SLOT_EMPTY); 
				}
		}
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3",0);
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3_PAGE",0);
	}
	else if (sValue == "PAGE_CHANGE") {
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3",0);
		SetLocalInt(oPC,"DMFI_MNGR_TOOL_3_PAGE",0);
	}
	else
		SendMessageToPC(oPC, "nohayui2");
}