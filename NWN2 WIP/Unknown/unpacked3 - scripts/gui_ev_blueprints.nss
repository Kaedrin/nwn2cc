#include "nwnx_sql"
#include "x0_i0_position"

// Maximum number of objects allowed to be created at once
const int MAX_QUANTITY = 30;

// Limit on number of results from SQL select query
const string SQL_SELECT_LIMIT = "50";


void SearchCreature(object oPC, string sSeachType, string sArg);

void SearchPlaceable(object oPC, string sSearchType, string sArg);

void SearchItem(object oPC, string sSearchType, string sArg);

void SearchPlacedEffect(object oPC, string sSearchType, string sArg);

void CreateFromBlueprint(object oPC, string sType, string sTag, location lLoc, string sOption1, string sOption2, string sOption3, string sOption4, string sOption5, string sOption6, string sOption7, string sOption8, string sOption9);

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel, object oNPC);

// Get ecl of creature
int GetECL(object oNPC);

// Get the location of the next object in the formation.
// n is the serial number of the current object
// nTotal is the total number of objects in the formation.
// sRadiusSpacing - radius to use on circle formation/spacing on line formation
location GetLocationInFormation(object oPC, string sFormation, int n, int nTotal, location lStartingLocation, string sRadiusSpacing);

// Undo function
void Undo(object oPC);

void JumpToSpawnLocation(object oPC, string sSpawnID);

void RemoveSpawnLocation(object oPC, string sSpawnID);

void ShowFormationList(object oPC);

void ShowFactionList(object oPC);

void SetOption(object oPC, string sOption, string sValue);

void SetFactionValue(object obj, string sFaction);

string GetFactionNameFromID(string sFactionID);

void ClearFields(object oPC);

void main(string sCommand, string sArg1 = "", string sArg2 = "", string sArg3 = "", float fX = 0.0, float fY = 0.0, float fZ = 0.0, string sOption1 = "", string sOption2 = "", string sOption3 = "", string sOption4 = "", string sOption5 = "", string sOption6 = "", string sOption7 = "", string sOption8 = "", string sOption9 = "")
{
	object oPC = OBJECT_SELF;
	if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC)) return;
	
	if (sCommand == "search") {
		switch (StringToInt(sArg3)) {
			case 1: SearchCreature(oPC, sArg1, sArg2); break;
			case 2: SearchItem(oPC, sArg1, sArg2); break;
			case 64: SearchPlaceable(oPC, sArg1, sArg2); break;
			case 1024: SearchPlacedEffect(oPC, sArg1, sArg2); break;
			default: break;
		}
	}
	else if (sCommand == "create") {		
		location lLoc = Location(GetArea(oPC),Vector(fX,fY,fZ),GetFacing(oPC));
		CreateFromBlueprint(oPC, sArg1, sArg2, lLoc, sOption1, sOption2, sOption3, sOption4, sOption5, sOption6, sOption7, sOption8, sOption9);
	}
	else if (sCommand == "undo") Undo(oPC);
	else if (sCommand == "jumptospawn") JumpToSpawnLocation(oPC, sArg1);
	else if (sCommand == "removespawn") RemoveSpawnLocation(oPC, sArg1);
	else if (sCommand == "selectedoption") { SetOption(oPC, sArg1,sArg2);  }
	else if (sCommand == "formation") { ShowFormationList(oPC); }
	else if (sCommand == "faction") { ShowFactionList(oPC); }
	else if (sCommand == "launchtool") { DisplayGuiScreen(oPC, "EV_BLUEPRINT_SEACH", FALSE, "ev_blueprint_search.xml"); }
	else if (sCommand == "clearfields") { ClearFields(oPC); }
}

void SearchCreature(object oPC, string sSearchType, string sArg)
{
	ClearListBox(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_CREATURES");
	
	sSearchType = SQLEncodeSpecialChars(sSearchType);
	sArg = SQLEncodeSpecialChars(sArg);	
		
	string sSQL = "SELECT * FROM b_creatures WHERE "+sSearchType+" LIKE '%"+sArg+"%' ORDER BY name LIMIT " + SQL_SELECT_LIMIT;
    SQLExecDirect(sSQL);

	string resref;
	string name;
	string faction;
	string cr;
	
    while (SQLFetch() == SQL_SUCCESS) {
        resref = SQLGetData(1);
		name = SQLGetData(2);
		cr = SQLGetData(3);
		faction = SQLGetData(4);
		
		// Don't show creatures from the arena
		if (faction != "Arena")
			AddListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_CREATURES", "n","NAME_B="+name+";FACTION_B="+faction+";CR_B="+cr,"", "0="+resref, "");
	}
}

void SearchPlaceable(object oPC, string sSearchType, string sArg)
{
	ClearListBox(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_PLACEABLES");	
	
	sSearchType = SQLEncodeSpecialChars(sSearchType);
	sArg = SQLEncodeSpecialChars(sArg);	
	
	string sSQL = "SELECT * FROM b_placeables WHERE "+sSearchType+" LIKE '%"+sArg+"%' ORDER BY name LIMIT " + SQL_SELECT_LIMIT;
    SQLExecDirect(sSQL);

	string resref;
	string name;
	
    while (SQLFetch() == SQL_SUCCESS) {
        resref = SQLGetData(1);
		name = SQLGetData(2);
		
		AddListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_PLACEABLES", "n","NAME_B="+name,"", "0="+resref, "");
	}
}

void SearchItem(object oPC, string sSearchType, string sArg)
{
	ClearListBox(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_ITEMS");
	
	sSearchType = SQLEncodeSpecialChars(sSearchType);
	sArg = SQLEncodeSpecialChars(sArg);
	
	string sSQL = "SELECT * FROM b_items WHERE "+sSearchType+" LIKE '%"+sArg+"%' ORDER BY name LIMIT " + SQL_SELECT_LIMIT;
    SQLExecDirect(sSQL);

	string resref;
	string name;
	string baseitem;
	
    while (SQLFetch() == SQL_SUCCESS) {
        resref = SQLGetData(1);
		name = SQLGetData(2);
		baseitem = SQLGetData(3);
		
		AddListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_ITEMS", "n","NAME_B="+name+";BASEITEM_B="+baseitem,"", "0="+resref, "");	
	}
}

void SearchPlacedEffect(object oPC, string sSearchType, string sArg)
{
	ClearListBox(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_P_EFFECTS");
	
	sSearchType = SQLEncodeSpecialChars(sSearchType);
	sArg = SQLEncodeSpecialChars(sArg);	
	
	string sSQL = "SELECT * FROM b_placedeffects WHERE "+sSearchType+" LIKE '%"+sArg+"%' ORDER BY name LIMIT " + SQL_SELECT_LIMIT;
    SQLExecDirect(sSQL);

	string resref;
	string name;
	
    while (SQLFetch() == SQL_SUCCESS) {
        resref = SQLGetData(1);
		name = SQLGetData(2);
		
		AddListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "RESULTS_LIST_P_EFFECTS", "n","NAME_B="+name,"", "0="+resref, "");		
	}
}

void CreateFromBlueprint(object oPC, string sType, string sTag, location lLoc, string sOption1, string sOption2, string sOption3, string sOption4, string sOption5, string sOption6, string sOption7, string sOption8, string sOption9)
{
	SendMessageToPC(oPC, "type: " + sType + ", tag: " + sTag);
	
	// Update counter
	int nCounter =  GetLocalInt(oPC, "ev_bpc_counter"+ObjectToString(oPC));	
	SetLocalInt(oPC, "ev_bpc_counter"+ObjectToString(oPC), nCounter + 1);
	nCounter = nCounter + 1;
	
	string sQ = sOption1; // quantity
	string sL = sOption2; // level
	string sN = sOption3; // name
	string sAL = sOption4; // auto-level
	string sRN = sOption5; // random-name
	string sF  = sOption6; // formation
	string sFactionID = sOption7; // faction...
	string sAS = sOption8; // auto-spawn
	string sRadiusSpacing = sOption9; // radius or spacing
	
	int nFaction = StringToInt(sFactionID);
	
	int nQ = StringToInt(sQ);
	
	// Quantity cap (1-MAX_QUANTITY)
	if (nQ <= 0) nQ = 1;
	if (nQ > MAX_QUANTITY) nQ = MAX_QUANTITY;
	
	// Level cap (1-30)
	int nL = StringToInt(sL);
	if (nL <= 0 || nL >=31) nL = -1;
	
	int i;
	object obj;
	location lStartingLocation = lLoc;
	int nASID = GetLocalInt(oPC, "ev_bpc_as") + 1;
	for (i = 0; i < nQ; i++) {		
	
		if (sF != "")
			lLoc = 	GetLocationInFormation(oPC, sF, i, nQ, lStartingLocation, sRadiusSpacing);
			
		obj = CreateObject(StringToInt(sType), sTag, lLoc);
		
		SetLocalInt(obj, "ev_bpc_counter"+ObjectToString(oPC), nCounter);
		
		// Random name
		if (sRN == "1") { SetFirstName(obj, RandomName()); SetLastName(obj, RandomName()); }
		
		// Name them
		else if (sN != "") SetFirstName(obj, sN);
		
		// Set faction
		if (sFactionID != "" && sFactionID != "256") SetFactionValue(obj, sFactionID);
		
		// Creatures only
		if (StringToInt(sType) == OBJECT_TYPE_CREATURE) {
		
			// Level them
			if (sAL == "1") SetLocalInt(obj, "ev_autolevel", TRUE);
			else if (nL != -1) {			
				ResetCreatureLevelForXP(obj, GetXPForLevel(nL, obj), FALSE);
				ForceRest(obj);
			}
			
			// Auto-spawn
			if (sAS == "1") {
				if (i == 0) // stuff to do only once!
				{				
					SetLocalLocation(oPC, "ev_bpc_as_loc"+IntToString(nASID), lStartingLocation);
					SetLocalInt(oPC, "ev_bpc_as"+IntToString(nASID), TRUE);
					SetLocalInt(oPC, "ev_bpc_as", nASID);
					AddListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "AS_LIST", IntToString(nASID),"AS_B=Spawn"+IntToString(nASID),"", "0="+IntToString(nASID), "");	
				}
				
				// stuff to do every time	
				SetLocalInt(obj, "ev_bpc_as", nASID);
				SetLocalObject(obj, "ev_master", oPC); 
				SetLocalLocation(obj, "ev_as_loc", lLoc);
				AssignCommand(obj, SetIsDestroyable(TRUE, TRUE, FALSE));
				DelayCommand(1.0, SetLootable(obj, FALSE));
			}
		}		
	}
}

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel, object oNPC)
{
	int nECL = GetECL(oNPC);
	nLevel = nLevel + nECL;
	int nXP = (nLevel * (nLevel - 1) / 2) * 1000;
	return nXP;
}

// Get ecl of creature
int GetECL(object oNPC)
{
	int iSubRace = GetSubRace(oNPC);
    int iLevelAdj = 0;
	
	// see what the level adjustment is for subrace type
    switch (iSubRace)
    {
       case RACIAL_SUBTYPE_AASIMAR: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_TIEFLING: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_AIR_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_EARTH_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_FIRE_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_WATER_GENASI: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_GRAY_DWARF: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_DROW: iLevelAdj = 2; break;
       case RACIAL_SUBTYPE_SVIRFNEBLIN: iLevelAdj = 3; break;
	   case RACIAL_SUBTYPE_YUANTI: iLevelAdj = 2; break;
	   case RACIAL_SUBTYPE_GRAYORC: iLevelAdj = 1; break;
       default:  iLevelAdj = 0; break;
    }
	
	return iLevelAdj;
}

location GetLocationInFormation(object oPC, string sFormation, int n, int nTotal, location lStartingLocation, string sRadiusSpacing)
{
	if (sFormation == "None") return lStartingLocation;
	
	float fDMAngle = GetFacing(oPC);
	
	float fR = 5.0;
	if (sRadiusSpacing != "") fR = StringToFloat(sRadiusSpacing);
	
	if (sFormation == "Line") {
		float fSpacing = 1.0;
		if (sRadiusSpacing != "") fSpacing = StringToFloat(sRadiusSpacing);
		float fLineAngle = fDMAngle + 90.0;
		
		if (n == 0) return lStartingLocation;
		else {
			float fDist;
			if (n % 2 == 0)
				fDist = n * fSpacing;
			else
				fDist = fSpacing * n * -1;
				
			return GenerateNewLocationFromLocation(lStartingLocation, fDist, fLineAngle, fDMAngle);
		}
	}	
	
	else if (sFormation == "Circle FF") {
		float fAngle = (360.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, fAngle, fDMAngle);
	}
	
	else if (sFormation == "Circle FI") {
		float fAngle = (360.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, fAngle, fAngle - 180.0);
	}
	
	else if (sFormation == "Circle FO") {
		float fAngle = (360.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, fAngle, fAngle);
	}
	
	else if (sFormation == "H. Circle FF") {
		float fAngle = (180.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, (fDMAngle - 90.0) + fAngle, fDMAngle);
	}
	
	else if (sFormation == "H. Circle FI") {
		float fAngle = (180.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, (fDMAngle - 90.0) + fAngle, (fDMAngle - 90.0) + fAngle - 180.0);
	}
	
	else if (sFormation == "H. Circle FO") {
		float fAngle = (180.0 / nTotal) * n;
		return GenerateNewLocationFromLocation(lStartingLocation, fR, (fDMAngle - 90.0) + fAngle, (fDMAngle - 90.0) + fAngle);
	}
	
	return lStartingLocation;
			
}

void Undo(object oPC)
{
	int nCounter = GetLocalInt(oPC, "ev_bpc_counter"+ObjectToString(oPC));
	
	if (nCounter == 0) return;	
	
	// Destroy all objects with matching count number
	object obj = GetFirstObjectInArea(GetArea(oPC));
	while (GetIsObjectValid(obj)) {
		if (GetLocalInt(obj, "ev_bpc_counter"+ObjectToString(oPC)) == nCounter) {
			DestroyObject(obj);
		}
		obj = GetNextObjectInArea(GetArea(oPC));
	}
	
	// Update counter
	SetLocalInt(oPC, "ev_bpc_counter"+ObjectToString(oPC), nCounter - 1);
}

void JumpToSpawnLocation(object oPC, string sSpawnID)
{
	ActionJumpToLocation(GetLocalLocation(oPC, "ev_bpc_as_loc"+sSpawnID));
}

void RemoveSpawnLocation(object oPC, string sSpawnID)
{
	RemoveListBoxRow(oPC, "EV_BLUEPRINT_SEACH", "AS_LIST", sSpawnID);
	SetLocalInt(oPC, "ev_bpc_as"+sSpawnID, FALSE);
	DeleteLocalLocation(oPC, "ev_bpc_as_loc"+sSpawnID);
	SendMessageToPC(oPC, "<C=cyan>Spawn point deleted.");
}

void ShowFormationList(object oPC)
{
	DisplayGuiScreen(oPC, "EV_BPC_LIST", FALSE, "ev_bpc_list.xml");
	ClearListBox(oPC, "EV_BPC_LIST", "GENERIC_LIST");
	
	SetGUIObjectText(oPC, "EV_BPC_LIST", "ListTitle", -1, "Select formation:");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Line","", "0=Line;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Circle FF","", "0=Circle FF;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Circle FI","", "0=Circle FI;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Circle FO","", "0=Circle FO;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=H. Circle FF","", "0=H. Circle FF;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=H. Circle FI","", "0=H. Circle FI;1=formation", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=H. Circle FO","", "0=H. Circle FO;1=formation", "");	
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=None","", "0=None;1=formation", "");	
}

void ShowFactionList(object oPC)
{
	DisplayGuiScreen(oPC, "EV_BPC_LIST", FALSE, "ev_bpc_list.xml");
	ClearListBox(oPC, "EV_BPC_LIST", "GENERIC_LIST");
	
	SetGUIObjectText(oPC, "EV_BPC_LIST", "ListTitle", -1, "Select faction:");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Default","", "0=256;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Hostile","", "0=0;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Commoner","", "0=1;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Merchant","", "0=2;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Defender","", "0=3;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=True Nuetral","", "0=5;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Hostile2","", "0=6;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Zhent","", "0=7;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Drow","", "0=8;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Myth Drannor","", "0=9;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Arena","", "0=10;1=faction", "");
	AddListBoxRow(oPC, "EV_BPC_LIST", "GENERIC_LIST", "n","LIST_T=Jaelre","", "0=11;1=faction", "");
}

void SetOption(object oPC, string sOption, string sValue)
{
	if (sOption == "formation") {
		SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "SELECTED_FORMATION", -1, sValue);
		SetLocalGUIVariable(oPC, "EV_BLUEPRINT_SEACH", 12, sValue);
	}
	else if (sOption == "faction") {
		string sFaction = "";
		
		switch (StringToInt(sValue)) {
			case 0: sFaction = "Hostile"; break;
			case 1: sFaction = "Commoner"; break;
			case 2: sFaction = "Merchant"; break;
			case 3: sFaction = "Defender"; break;
			case 5: sFaction = "True Nuetral"; break;
			case 6: sFaction = "Hostile2"; break;
			case 7: sFaction = "Zhent"; break;
			case 8: sFaction = "Drow"; break;
			case 9: sFaction = "Myth Drannor"; break;
			case 10: sFaction = "Arena"; break;
			case 11: sFaction = "Jaelre"; break;
			case 256: sFaction = "Default"; break;
			default: sFaction = "Default"; break;
		}
		
		SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "SELECTED_FACTION", -1, sFaction);
		SetLocalGUIVariable(oPC, "EV_BLUEPRINT_SEACH", 13, sValue);
	}
}

void SetFactionValue(object obj, string sFaction)
{
	string sFactionTag = "ev_faction_" + sFaction;
	object oPig = GetObjectByTag(sFactionTag);
	
	if (StringToInt(sFaction) <= 3) ChangeToStandardFaction(obj, StringToInt(sFaction));
	else ChangeFaction(obj, oPig);
}

string GetFactionNameFromID(string sFactionID)
{
	switch (StringToInt(sFactionID)) {
		case 0: return "Hostile"; break;
		case 1: return "Commoner"; break;
		case 2: return "Merchant"; break;
		case 3: return "Defender"; break;
		case 5: return "True Nuetral"; break;
		case 6: return "Hostile2"; break;
		case 7: return "Zhent"; break;
		case 8: return "Drow"; break;
		case 9: return "Myth Drannor"; break;
		case 10: return "Arena"; break;
		case 11: return "Jaelre"; break;
		case 256: return "Default"; break;
		default: return "unknown"; break;
	}
	
	return "unknown";
}

void ClearFields(object oPC)
{
	// Formation
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "SELECTED_FORMATION", -1, "None");
	SetLocalGUIVariable(oPC, "EV_BLUEPRINT_SEACH", 12, "");
	
	// Faction
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "SELECTED_FACTION", -1, "Default");
	SetLocalGUIVariable(oPC, "EV_BLUEPRINT_SEACH", 13, "256");
	
	// Quantity
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "QUANTITY", -1, "");
	
	// Level
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "LEVEL", -1, "");
	
	// Name
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "NAME", -1, "");
	
	// r/s
	SetGUIObjectText(oPC, "EV_BLUEPRINT_SEACH", "RS", -1, "");
}