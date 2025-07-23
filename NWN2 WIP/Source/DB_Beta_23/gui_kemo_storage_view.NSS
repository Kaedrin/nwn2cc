string GetPCID(object oPC)
{
	return GetSubString(GetPCPlayerName(oPC), 0, 12)
				+ "_" + GetSubString(GetFirstName(oPC), 0, 6)
				+ "_" + GetSubString(GetLastName(oPC), 0, 9);
}

void main(string sItemNumber)
{
	object oPC = OBJECT_SELF;
	object oStorageTable = GetNearestObjectByTag("kemo_storage_viewpoint");
	object oItem; object oCopy;
	
	string sDB = GetPCID(oPC) + "_storage";
	//Get the sale item slot
	string sKey = "StorageObject" + sItemNumber;
	WriteTimestampedLogEntry(GetName(oPC) + " is viewing an item at the storage banker.");
	oItem = RetrieveCampaignObject(sDB,sKey,GetLocation(oStorageTable));
	DelayCommand(1.0f,ActionExamine(oItem));
	DelayCommand(3.0f,DestroyObject(oItem));
}