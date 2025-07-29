#include "nwnx_sql"

void main()
{
	object oPC = GetLastUsedBy();
	string sPC = GetFirstName(oPC); //To compare is used the first Name!!
	
	if ((sPC == "Fohgar")||(sPC == "Grendel")||(sPC == "Valtore")
	||(GetPCPublicCDKey(oPC)=="KA4NG9WC")) // <- Allows EsteveCS85 to manage the door's owner, modify this key to do not allow him!
	{									   //    Keep the key if you think he could be needed in a future. 
		SendMessageToPC(oPC, "The door <C=Orange>"+GetTag(OBJECT_SELF)+"</C> has been oppened as <C=Orange>Room's Manager</C> .");
		SetLocked(OBJECT_SELF,0);
		DelayCommand(7.5,SetLocked(OBJECT_SELF,1));
	}
	
	string sDoorOwner = GetPersistentString(GetModule(),GetTag(OBJECT_SELF));
	if (sPC == sDoorOwner)
	{
		SendMessageToPC(oPC, "The door <C=Orange>"+GetTag(OBJECT_SELF)+"</C> has been oppened as <C=Orange>"+sDoorOwner+"</C> .");
		SetLocked(OBJECT_SELF,0);
		DelayCommand(7.5,SetLocked(OBJECT_SELF,1));
	}
}