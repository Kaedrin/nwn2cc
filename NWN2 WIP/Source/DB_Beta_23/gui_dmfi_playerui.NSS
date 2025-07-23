////////////////////////////////////////////////////////////////////////////////
// gui_dmfi_playerui - DM Friendly Initiative - GUI script for Player UI
// Original Scripter:  Demetrious      Design: DMFI Design Team
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           12/4/6	qk 10/07/07
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

// This script routes or executes all Player UI input.

#include "dmfi_inc_const"
#include "dmfi_inc_tool"
#include "dmfi_inc_command"
#include "nwnx_sql"
#include "hcr2_debug_i"

// Update DB tables with new pc name
void UpdateDB(object oPC, string sNewFirstName, string sNewLastName);

// Replace name on PC's items' mule variable to new one
void SetNewItemsMuleVar(object oPC);

void main(string sInput, string sInput2)
{
	object oPC = OBJECT_SELF;
	object oRename, oTest, oTarget, oRef;
	object oTool = DMFI_GetTool(oPC);
	string sText;
	
	int n=1;
	
	// RENAMING FUNCTIONS	
	if (GetStringLeft(sInput, 1)!=".")
	{  // ONLY options for players are code to run commands OR change names
	   // so if we aren't running a command, we are changing a name.
		object oRename = GetLocalObject(oTool, DMFI_TARGET);
		
		if (GetObjectType(oRename)==OBJECT_TYPE_CREATURE)
		{
			// No DM rename for now
			/*if ((GetIsDM(oRename)) || (GetIsDM(GetMaster(oRename)))) {
				SendMessageToPC(OBJECT_SELF, "DM renaming disabled.");
				return;
			}*/
		
			// if it's a PC - update database tables
			if ((GetIsPC(oRename)) && (!GetIsDM(oRename)) && (!GetIsDMPossessed(oRename)))
				UpdateDB(oRename, sInput, sInput2);
			
			SetFirstName(oRename, sInput);
			SetLastName(oRename, sInput2);
			
			// After rename, set new name on items
			// for anti-mule script
			if ((GetIsPC(oRename)) && (!GetIsDM(oRename)) && (!GetIsDMPossessed(oRename)))
				SetNewItemsMuleVar(oPC);
			
			SendText(oPC, TXT_RENAME_OBJ_SUCCESS, TRUE, COLOR_GREEN);	
			CloseGUIScreen(OBJECT_SELF, SCREEN_DMFI_CHGNAME);
		}
		else
		{
			oRef = GetLocalObject(oRename, DMFI_INVENTORY_TARGET);
			if(GetTag(oRef)!="hcr2_corpsetoken")
			{
				SetFirstName(oRef, sInput);
				SetFirstName(oRename, sInput);
				SendText(oPC, TXT_RENAME_ITM_SUCCESS, TRUE, COLOR_GREEN);	
				CloseGUIScreen(OBJECT_SELF, SCREEN_DMFI_CHGITEM);
			}
		}
	}
	else if(sInput == ".follow_on")
	{
		DisplayGuiScreen(oPC, "lustabel_follow", FALSE, "lust_follow.xml");
	}	
	
	// ALL OTHER FUNCTIONS
	else
	{
		sInput = GetStringRight(sInput, GetStringLength(sInput)-1);
		sInput = DMFI_UnderscoreToSpace(sInput);	
		
		if (sInput==DMFI_UI_ABILITY)
		{		
			SetLocalInt(oPC, DMFI_LIST_PRIOR, DMFI_LIST_ABILITY);
			DisplayGuiScreen(oPC, SCREEN_DMFI_LIST, TRUE, "dmfilist.xml");
			SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LISTTITLE, -1, TXT_CHOOSE_ABILITY);
			n=0;
			while (n<10)
			{
				sText = GetLocalString(oTool, LIST_PREFIX + PG_LIST_ABILITY + "." + IntToString(n));
				SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LIST + IntToString(n+1), -1, sText);
				n++;
			}		
		}	
       	else if (sInput==DMFI_UI_SKILL)
		{		
		    DisplayGuiScreen(oPC, SCREEN_DMFI_SKILLS, TRUE, "dmfiskillsui.xml");
			SetGUIObjectText(oPC, SCREEN_DMFI_SKILLS, DMFI_UI_SKILLTITLE, -1, TXT_CHOOSE_SKILL);
			n = 0;
			while (n<28)
			{
				sText = GetLocalString(oTool, LIST_PREFIX + PG_LIST_SKILL + "." + IntToString(n));
				SetGUIObjectText(oPC, SCREEN_DMFI_SKILLS, "skill"+IntToString(n+1), -1, sText);				
				n++;
			}
			
			SetGUIObjectHidden(oPC, SCREEN_DMFI_SKILLS, "btn29", TRUE);
			SetGUIObjectHidden(oPC, SCREEN_DMFI_SKILLS, "btn30", TRUE);	
		}
		else if (sInput==DMFI_UI_LANGUAGE)	
		{		
			SetLocalInt(oPC, DMFI_LIST_PRIOR, DMFI_LIST_LANG);
			DeleteList(PG_LIST_LANGUAGE, oTool);
            DMFI_BuildLanguageList(oTool, oPC);
		
			DisplayGuiScreen(oPC, SCREEN_DMFI_LIST, TRUE, "dmfilist.xml");
			SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LISTTITLE, -1, TXT_CHOOSE_LANGUAGE);
			n=0;
			while (n<10)
			{
				sText = GetLocalString(oTool, LIST_PREFIX + PG_LIST_LANGUAGE + "." + IntToString(n));
				if (sText!="") 
					SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LIST  +IntToString(n+1), -1, sText);
				else
					SetGUIObjectHidden(oPC, SCREEN_DMFI_LIST, "btn" +IntToString(n+1), TRUE);	
				n++;
			}		
		}
		else if (sInput==DMFI_UI_DICE)
		{
			SetLocalInt(oPC, DMFI_LIST_PRIOR, DMFI_LIST_NUMBER);	
			DisplayGuiScreen(oPC, SCREEN_DMFI_LIST, TRUE, "dmfilist.xml");
			SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LISTTITLE, -1, TXT_CHOOSE_NUMBER);
			n=1;
			while (n<10)
			{
				SetGUIObjectText(oPC, SCREEN_DMFI_LIST, DMFI_UI_LIST + IntToString(n), -1, IntToString(n));
				n++;
			}			
		}
		else
		{
			DMFI_UITarget(oPC, oTool);	
			DMFI_DefineStructure(oPC, sInput);
			DMFI_RunCommandCode(oTool, oPC, sInput);
		}		
	}
}			

void UpdateDB(object oPC, string sNewFirstName, string sNewLastName)
{
	string 	sCDKey		= GetLocalString(oPC, H2_PC_CD_KEY);
	string 	sPlayer		= SQLEncodeSpecialChars(GetLocalString(oPC, H2_PC_PLAYER_NAME));
	string 	sFirstName 	= SQLEncodeSpecialChars(GetFirstName(oPC));
	string 	sLastName	= SQLEncodeSpecialChars(GetLastName(oPC));
	string  sName       = sFirstName;
	if (sLastName != "")
		sName += " " + sLastName;
	//sName = SQLEncodeSpecialChars(sName);
	
	sNewFirstName = SQLEncodeSpecialChars(sNewFirstName);
	sNewLastName = SQLEncodeSpecialChars(sNewLastName);
	string sNewName = sNewFirstName;
	if (sNewLastName != "")
		sNewName += " " + sNewLastName;
	//sNewName = SQLEncodeSpecialChars(sNewName);
	
	// Debug
	/*SendMessageToPC(oPC, "First Name: " + sFirstName);
	SendMessageToPC(oPC, "Last Name: " + sLastName);
	SendMessageToPC(oPC, "Name: " + sName);
	SendMessageToPC(oPC, "New First Name: " + sNewFirstName);
	SendMessageToPC(oPC, "New Last Name: " + sNewLastName);
	SendMessageToPC(oPC, "New Name: " + sNewName);*/
	
	// Update DB Tables
	string 	sSQL = "UPDATE CHARACTERS SET FirstName='"+sNewFirstName+"',LastName='"+sNewLastName+"' WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"' AND CDKey='"+sCDKey+"'";	
	SQLExecDirect(sSQL);

	sSQL = "UPDATE pwdata SET tag='"+sNewName+"' WHERE tag='"+sName+"' AND player='"+sPlayer+"'";	
	SQLExecDirect(sSQL);
	
	sSQL = "UPDATE rptokens SET tag='"+sNewName+"' WHERE tag='"+sName+"' AND player='"+sPlayer+"'";	
	SQLExecDirect(sSQL);
	
	sSQL = "UPDATE recipestorage SET tag='"+sNewName+"' WHERE tag='"+sName+"' AND player='"+sPlayer+"'";	
	SQLExecDirect(sSQL);
	
	sSQL = "UPDATE playerinfo SET FirstName='"+sNewFirstName+"',LastName='"+sNewLastName+"' WHERE FirstName='"+sFirstName+"' AND LastName='"+sLastName+"' AND Player='"+sPlayer+"'";	
	SQLExecDirect(sSQL);
	
	sSQL = "UPDATE playernotes SET tag='"+sNewName+"' WHERE tag='"+sName+"' AND player='"+sPlayer+"'";	
	SQLExecDirect(sSQL);
}		

// Replace name on PC's items' mule variable to new one
void SetNewItemsMuleVar(object oPC)
{
	// Loop on all items
	object oItem = GetFirstItemInInventory(oPC);
	
	// Get PC details
	string sPCCDKey = GetPCPublicCDKey(oPC);
	string sPCName = GetName(oPC);
	
	while (GetIsObjectValid(oItem)) {
		
		// Update to new name if needed
		if (GetLocalString(oItem, sPCCDKey) != "")
			SetLocalString(oItem, sPCCDKey, sPCName);
			
		oItem = GetNextItemInInventory(oPC);
	}
}