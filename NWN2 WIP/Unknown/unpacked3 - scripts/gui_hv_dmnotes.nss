#include "nwnx_sql"

// Get categories from database and put on listbox
void PopulatePersonalCategories(object oPC);

// Get the notes from specified category.
void GetCategoryNotes(object oPC, string sCategory, string sCDKey);

// Create a new category.
void CreateNewCategory(object oPC);

// Actually create it...
void CreateCategory(object oPC, string sCategory);

// Initiate renaming
void InitiateRenaming(object oPC, string sCurrentName);

// Rename category
void RenameCategory(object oPC, string sCategory);

// Delete category
void DeleteCategory(object oPC, string sCategory);

// Toggle category private
void TogglePrivate(object oPC, string sCategory);

// Get whether the category is public or not.
// return "1" for public, "0" for private.
string GetPublicStatus(object oPC, string sCategory);

// List all public notes.
void ViewPublicNotes(object oPC);

// Save notes
void SaveNotes(object oPC,string sCategory, string sContent, string sCDKey);

void main(string sCommand = "", string sData1 = "", string sData2 = "", string sData3 = "")
{
	object oPC = OBJECT_SELF;
	
	// Make sure it's a dm
	if (GetIsDM(oPC) == FALSE) return;
	
	// Populate categories
	if (sCommand == "ppc")
		PopulatePersonalCategories(oPC);
	
	// Get notes from selected category.
	else if (sCommand == "getnotes")
		GetCategoryNotes(oPC, sData1, sData2);
		
	// Create a new category
	else if (sCommand == "create")
		CreateNewCategory(oPC);
	
	// Actually create it now
	else if (sCommand == "cnc")
		CreateCategory(oPC, sData1);
		
	// Initiat renaming
	else if (sCommand == "rename")
		InitiateRenaming(oPC, sData1);
	
	// The actual renaming
	else if (sCommand == "rnm")
		RenameCategory(oPC, sData1);
		
	// Delete category
	else if (sCommand == "delete")
		DeleteCategory(oPC, sData1);
		
	// Toggle category private/public
	else if (sCommand == "toggle_prv")
		TogglePrivate(oPC, sData1);
		
	// View public notes
	else if (sCommand == "view_public")
		ViewPublicNotes(oPC);
		
	// View personal notes
	else if (sCommand == "view_personal")
		PopulatePersonalCategories(oPC);
		
	// Save notes
	else if (sCommand == "save")
		SaveNotes(oPC, sData1, sData2, sData3);
		
	// Clear the text box
	else if (sCommand == "clear")
		SetGUIObjectText(oPC, "hv_dm_notes", "INPUT_BOX_TEXT", -1, "");
		
}

// Get categories from database and put on listbox
void PopulatePersonalCategories(object oPC)
{
	ClearListBox(oPC, "hv_dm_notes", "CATEGORIES_LISTBOX");

	string sCDKey = GetPCPublicCDKey(oPC);
	string sSQL = "SELECT Category,Public FROM dmnotes WHERE CDKey='"+sCDKey+"'";
	SQLExecDirect(sSQL);
	
	// Loop on all stored categories
	string sCategory = "";
	string sPublic = "";
	string sName = "";
	string sRow = "";
	int i = 1;
	while (SQLFetch() == SQL_SUCCESS) {
		
		// Get data
		sCategory = SQLGetData(1);
		sPublic = SQLGetData(2);
		
		// Mark as public if needed.
		if (sPublic == "1")		
			sName = "CATEGORY=<C=lightgreen>" + sCategory;
		else
			sName = "CATEGORY=" + sCategory;
			
		sRow = "Row" + IntToString(i);
		AddListBoxRow(oPC,"hv_dm_notes","CATEGORIES_LISTBOX",sRow,sName,"","0="+sCategory+";1="+sCDKey,"");
		i++;
	}
	
	// Show relevant buttons
	SetGUIObjectHidden(oPC, "hv_dm_notes", "create_category", FALSE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "rename_category", FALSE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "delete_category", FALSE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "toggle_public", FALSE);
	//SetGUIObjectHidden(oPC, "hv_dm_notes", "save_notes", FALSE);
	//SetGUIObjectHidden(oPC, "hv_dm_notes", "clear_text", FALSE);
}

// Get the notes from specified category.
void GetCategoryNotes(object oPC, string sCategory, string sCDKey)
{
	//string sCDKey = GetPCPublicCDKey(oPC);
	string sSQL = "SELECT Contents,Timestamp,CharName FROM dmnotes WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	SQLExecDirect(sSQL);
	
	string sNotes = "";
	string sLastChange = "";
	string sOwner = "";
	if (SQLFetch() == SQL_SUCCESS) {
		sNotes = SQLGetData(1);
		sLastChange = SQLGetData(2);
		sOwner = SQLGetData(3);
		if (sNotes == "") sNotes = "There is no content in this category yet.";
		SetGUIObjectText(oPC, "hv_dm_notes", "INPUT_BOX_TEXT", -1, sNotes);
		SetGUIObjectText(oPC, "hv_dm_notes", "dmnotes_title", -1, "<C=pink>This category was last modified at: " + sLastChange + " ~ Category owner: " + sOwner);
	}
	else
		SetGUIObjectText(oPC, "hv_dm_notes", "INPUT_BOX_TEXT", -1, "Failed to retrieve notes.");
}

// Create a new category.
void CreateNewCategory(object oPC)
{
	DisplayGuiScreen(oPC, "hv_dmnotes_cnc", FALSE, "hv_dmnotes_cnc.xml");
}

// Actually create it...
void CreateCategory(object oPC, string sCategory)
{
	if (sCategory == "") return;
	string sCDKey = GetPCPublicCDKey(oPC);
	string sLoginName = GetPCPlayerName(oPC);
	string sCharName = GetName(oPC);
	
	// Insert to db	
    string sSQL = "INSERT INTO dmnotes (CDKey,LoginName,CharName,Category,Contents,Public) VALUES "+
				  "('"+sCDKey+"','"+sLoginName+"','"+sCharName+"','"+sCategory+"','','0')";
    SQLExecDirect(sSQL);
	
	// Update ui
	PopulatePersonalCategories(oPC);
}

// Initiate renaming
void InitiateRenaming(object oPC, string sCurrentName)
{
	DisplayGuiScreen(oPC, "hv_dmnotes_rnm", FALSE, "hv_dmnotes_rnm.xml");
	SetLocalString(oPC, "hv_dmnotes_cc", sCurrentName);
}

// Rename category
void RenameCategory(object oPC, string sCategory)
{
	if (sCategory == "") return;
	string sOldName = GetLocalString(oPC, "hv_dmnotes_cc");
	string sSQL = "UPDATE dmnotes SET Category='"+sCategory+"' WHERE CDKey='"+GetPCPublicCDKey(oPC)+"' AND Category='"+sOldName+"'";
	SQLExecDirect(sSQL);
	
	// Update ui
	PopulatePersonalCategories(oPC);
}

void DeleteCategory(object oPC, string sCategory)
{
	if (sCategory == "") return;
	string sCDKey = GetPCPublicCDKey(oPC);	
	
	string sSQL = "DELETE FROM dmnotes WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	SQLExecDirect(sSQL);
	
	// Update ui
	PopulatePersonalCategories(oPC);
}

// Toggle category private
void TogglePrivate(object oPC, string sCategory)
{
	if (sCategory == "") return;
	string sCDKey = GetPCPublicCDKey(oPC);
	
	string sPublicStatus = GetPublicStatus(oPC, sCategory);
	string sSQL = "";
	if (sPublicStatus == "0")
		sSQL = "UPDATE dmnotes SET Public='1' WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	else if (sPublicStatus == "1")
		sSQL = "UPDATE dmnotes SET Public='0' WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	
	SQLExecDirect(sSQL);	
	
	// Update ui
	PopulatePersonalCategories(oPC);
}

// Get whether the category is public or not.
// return "1" for public, "0" for private. "-1" otherwise.
string GetPublicStatus(object oPC, string sCategory)
{
	if (sCategory == "") return "-1";
	string sCDKey = GetPCPublicCDKey(oPC);
	string sSQL = "SELECT Public FROM dmnotes WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS)
		return SQLGetData(1); 
	else
		return "-1";
}

// List all public notes.
void ViewPublicNotes(object oPC)
{
	ClearListBox(oPC, "hv_dm_notes", "CATEGORIES_LISTBOX");

	// Hide irrelevant buttons
	SetGUIObjectHidden(oPC, "hv_dm_notes", "create_category", TRUE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "rename_category", TRUE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "delete_category", TRUE);
	SetGUIObjectHidden(oPC, "hv_dm_notes", "toggle_public", TRUE);
	//SetGUIObjectHidden(oPC, "hv_dm_notes", "save_notes", TRUE);
	//SetGUIObjectHidden(oPC, "hv_dm_notes", "clear_text", TRUE);
	
	string sSQL = "SELECT Category,CDKey FROM dmnotes WHERE Public='1'";
	SQLExecDirect(sSQL);
	
	// Loop on all stored categories
	string sCategory = "";
	string sCDKey = "";
	string sName = "";
	string sRow = "";
	int i = 1;
	while (SQLFetch() == SQL_SUCCESS) {
		
		// Get data
		sCategory = SQLGetData(1);
		sCDKey = SQLGetData(2);
			
		sName = "CATEGORY=<C=lightgreen>" + sCategory;
			
		sRow = "Row" + IntToString(i);
		AddListBoxRow(oPC,"hv_dm_notes","CATEGORIES_LISTBOX",sRow,sName,"","0="+sCategory+";1="+sCDKey,"");
		i++;
	}
}

// Save notes
void SaveNotes(object oPC, string sCategory, string sContent, string sCDKey)
{
	if (sCategory == "") return;
	//string sCDKey = GetPCPublicCDKey(oPC);
	string sSQL = "UPDATE dmnotes SET Contents='"+sContent+"' WHERE CDKey='"+sCDKey+"' AND Category='"+sCategory+"'";
	SQLExecDirect(sSQL);
	
	if (SQLGetAffectedRows() == 1)
		DisplayMessageBox(oPC, -1, "Notes saved.");
	else
		DisplayMessageBox(oPC, -1, "There was a problem saving the notes. Make sure you have selected a category. If its contents has not been modified, there is nothing to save!");
}