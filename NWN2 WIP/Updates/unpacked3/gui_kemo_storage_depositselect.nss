string GetStorageItemIcon(object oItem)
{
	string sIcon = Get2DAString("nwn2_icons","ICON",GetItemIcon(oItem));
	return sIcon == "" ? "temp0.tga" : sIcon + ".tga";
}

string GetPCID(object oPC)
{
	return GetSubString(GetPCPlayerName(oPC), 0, 12)
				+ "_" + GetSubString(GetFirstName(oPC), 0, 6)
				+ "_" + GetSubString(GetLastName(oPC), 0, 9);
}

object GetItemFromList(object oPC, string sItemNumber)
{
	string sStorageVar = "TempStorageObject" + sItemNumber;
	return GetLocalObject(oPC,sStorageVar);
}

int CheckTag(object oItem)
{
	//prevents depositing certain items
	string sItemTag = GetTag(oItem);
	if (FindSubString(sItemTag,"i_consent") > -1 ||
		FindSubString(sItemTag,"it_slave") > -1 ||
		FindSubString(sItemTag,"slavepapers") > -1 ||
		FindSubString(sItemTag,"it_giftbox") > -1 ||
		FindSubString(sItemTag,"contain") > -1 ||
		FindSubString(sItemTag,"bag") > -1 ||
		FindSubString(sItemTag,"pouch") > -1 ||
		FindSubString(sItemTag,"i_slave") > -1 ||
		FindSubString(sItemTag,"i_elig_") > -1 ||
		FindSubString(sItemTag,"badge") > -1 ||
		FindSubString(sItemTag,"master") > -1 ||
		FindSubString(GetName(oItem),"Bag") > -1 ||
		FindSubString(GetName(oItem),"Pouch") > -1 ||
		FindSubString(GetName(oItem),"Box") > -1 ||
		FindSubString(GetName(oItem),"Ownership") > -1 ||
		FindSubString(GetName(oItem),"Spellsword") > -1 ||
		GetItemCursedFlag(oItem))
			return FALSE;
	else return TRUE;
}

void main (string sItemNumber)
{
	object oPC = OBJECT_SELF;

	WriteTimestampedLogEntry(GetName(oPC) + " is selecting an item to deposit at the storage banker.");

	object oItem = GetItemFromList(oPC, sItemNumber); //find the sale item from the list
	if (!GetIsObjectValid(oItem)) return;
	string sDB = GetPCID(oPC) + "_storage";
	string sKey = "StorageParameters1";
	string sItem = GetCampaignString(sDB,sKey);
	
	//find the first available sales slot
	int iCounter = 1;
	while (sItem != "")
	{
		iCounter++;
		sKey = "StorageParameters" + IntToString(iCounter);
		sItem = GetCampaignString(sDB,sKey);
	}

	//set key names based on slot number
	string sKeyObject = "StorageObject" + IntToString(iCounter);
	
	//set up the parameters for the sale item
	string sItemName = GetName(oItem);
	int iListTotal = GetCampaignInt(sDB,"StorageListTotal"); // length of sale item list

	if (FindSubString(sItemName,";") > -1)
	{
		DeleteLocalObject(oPC,"TempStorageObject" + sItemNumber);
		SendMessageToPC(oPC,"You may not deposit items with semicolons in their names.");
		return;		
	}
	else if (!CheckTag(oItem)) //checks for forbidden items, prevents listing
	{
		DeleteLocalObject(oPC,"TempStorageObject" + sItemNumber);
		SendMessageToPC(oPC,"You may not deposit this item.");
		return;		
	}
	else if (iCounter > 250) //checks if storage full
	{
		DeleteLocalObject(oPC,"TempStorageObject" + sItemNumber);
		SendMessageToPC(oPC,"Your storage is full. You can't store more.");
		return;		
	}
	else
	{

		string sStackSize = IntToString(GetNumStackedItems(oItem));
		string sIcon = GetStorageItemIcon(oItem);
		// for GetStringParam:
		// 0 = item name
		// 1 = stack size
		// 2 = icon
		SetCampaignString(sDB,sKey,sItemName + ";" + sStackSize + ";" + sIcon);

		StoreCampaignObject(sDB,sKeyObject,oItem);

		DestroyObject(oItem);
		
		//Save this player
		ExportSingleCharacter(oPC);
		
		// if a new last sales slot, add to the total number of sales slots
		if (GetCampaignInt(sDB,"StorageListTotal") < iCounter) SetCampaignInt(sDB,"StorageListTotal",iCounter);
		DelayCommand(1.0f,ExecuteScript("gui_kemo_storage_deposit",oPC));
	}
}	