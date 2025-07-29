string GetStorageItemIcon(object oItem)
{
	string sIcon = Get2DAString("nwn2_icons","ICON",GetItemIcon(oItem));
	return sIcon == "" ? "temp0.tga" : sIcon + ".tga";
}

void main()
{
	object oPC = OBJECT_SELF;
	
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","KEMO_STORAGE_RETRIEVE",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","DepositLabelPane",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","RetrieveLabelPane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","KEMO_STORAGE_DEPOSIT",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","ViewButton",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","ListButton",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","RetrieveButton",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","DepositButtonA",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","DepositButtonB",FALSE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","FilterPane",TRUE);
	SetGUIObjectHidden(oPC,"KEMO_STORAGE","PagePane",FALSE);
	
	ClearListBox(oPC,"KEMO_STORAGE","KEMO_STORAGE_DEPOSIT");

	if ( GetLocalString(oPC, "kemo_storage_mode") != "deposit" )
	{
		SetLocalInt(oPC, "kemo_storage_page", 1);
		SetLocalString(oPC, "kemo_storage_mode", "deposit");
	}

	object oItem = GetFirstItemInInventory(oPC);
	string sIcon; string sName;
	string sVariables;
	string sStorageVar;
	int iCounter = 0; string sCounter;

	if (GetDistanceToObject(GetNearestObjectByTag("kemo_storage_teller")) > 3.0f)
	{	SendMessageToPC(oPC,"You are too far away from teller.");
		return;
	}

	int page = GetLocalInt(oPC, "kemo_storage_page");
	if (page < 1) page = 1;
	
	int resultCount = 0;

	int lastItem = page * 25; // last item in current page
	int firstItem = lastItem - 25; // first item in current page

	while (oItem != OBJECT_INVALID)
	{
		//Quick check for curse and bags. More extensive check done when trying to add item.
		if (!GetItemCursedFlag(oItem) && GetBaseItemType(oItem) != BASE_ITEM_LARGEBOX)
		{
			if (resultCount >= firstItem && resultCount < lastItem)
			{
				iCounter++; sCounter = IntToString(iCounter);
				sStorageVar = "TempStorageObject" + sCounter;
				sIcon = "DepositPaneIcon=" + GetStorageItemIcon(oItem);
				sName = "DepositPaneName=     " + GetName(oItem) + " (" + IntToString(GetNumStackedItems(oItem)) + ")";
				sVariables = "7="+sCounter;

				AddListBoxRow(oPC,"KEMO_STORAGE","KEMO_STORAGE_DEPOSIT","Row"+sCounter,sName,sIcon,sVariables,"");
				SetLocalObject(oPC,sStorageVar,oItem);
			}
			resultCount++;
		}
		oItem = GetNextItemInInventory(oPC);
	}
	string sItemOfTotal = "Showing item " + IntToString(firstItem + 1) + " to " + IntToString(firstItem + iCounter) + " of " + IntToString(resultCount) + " items";
	
	if (iCounter == 0 && page == 1) SetGUIObjectHidden(oPC,"KEMO_STORAGE","PagePane",TRUE);
	else SetGUIObjectText(oPC,"KEMO_STORAGE","ItemsOfTotal",-1,sItemOfTotal);
	
	SetLocalInt(oPC, "kemo_storage_list_size", resultCount);
}