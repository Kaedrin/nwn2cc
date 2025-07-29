// called from the kemo_storage GUI

string GetPCID(object oPC)
{
	return GetSubString(GetPCPlayerName(oPC), 0, 12)
				+ "_" + GetSubString(GetFirstName(oPC), 0, 6)
				+ "_" + GetSubString(GetLastName(oPC), 0, 9);
}

void main(string sItemNumber)
{
	object oPC = OBJECT_SELF;
	string sDB = GetPCID(oPC) + "_storage";
	location lPC = GetLocation(oPC);
	
	//Get the storage slot
	string sKey = "StorageParameters" + sItemNumber;
	string sKeyObject = "StorageObject" + sItemNumber;
	string sStorageItem = GetCampaignString(sDB,sKey);	

	object oStorageItem = RetrieveCampaignObject(sDB,sKeyObject,lPC);
	object oStorageCopy = CopyItem(oStorageItem,oPC,1);
	DestroyObject(oStorageItem);
		
	WriteTimestampedLogEntry(GetName(oPC) + " is retrieving " + GetName(oStorageCopy) + " at the storage banker.");

	//Remove the stored item from the slot
	DeleteCampaignVariable(sDB,sKey);
	DeleteCampaignVariable(sDB,sKeyObject);
	
	//Save this player
	ExportSingleCharacter(oPC);

	ExecuteScript("gui_kemo_storage_list",oPC);
}