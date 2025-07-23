#include "nwnx_sql"

void main()
{
	object oPC = GetLastUsedBy();
	string sPC = GetFirstName(oPC); //To compare is used the first Name!!
	
	string sOwnerName = GetPersistentString(GetModule(),GetTag(OBJECT_SELF));
	if (sOwnerName!="")
	SetDescription(OBJECT_SELF,"The room's owner of <C=Purple>"+GetTag(OBJECT_SELF)+
	                            "</C> is our lovely <C=Purple>"+sOwnerName+
								"</C>, this owner and the Jarl are the only with a key.");
	else
	SetDescription(OBJECT_SELF,"There's no room's owner of <C=Purple>"+GetTag(OBJECT_SELF)+
	                            "</C> and nobody except the Jarl can enter here.");	
	
	if ((sPC == "Fohgar")||(sPC == "Grendel")||(sPC == "Valtore")
	||(GetPCPublicCDKey(oPC)=="KA4NG9WC")) // <- Allows EsteveCS85 to manage the door's owner, modify this key to do not allow him!
	{									   //    Keep the key if you think he could be needed in a future. 
		SetLocalString(oPC,"Lust_Iron_LastDoorDevice", GetTag(OBJECT_SELF));
		string sMessage = "Please to type the first name for the new owner or cancel to see the actual owner."+
						  " <C=Orange>*It's case sensitive*</C>";
		DisplayInputBox( oPC, 0, sMessage, "gui_ironhouse_asign_room", "", 1,
		"SCREEN_STRINGINPUT_MESSAGEBOX", 0, "OKAY", 0, "CANCEL", "", "VariableSTring" );
	}
	object oObjectToExamine = OBJECT_SELF;
	AssignCommand(oPC, ActionExamine(oObjectToExamine));
}