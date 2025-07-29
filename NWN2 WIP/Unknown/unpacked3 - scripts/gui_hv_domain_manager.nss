// Populate GUI buttons text with domains.
// Domains that are present on the PC will be colored green.
void ArrangeDomainButtons(object oPC);

// Add or remove a domain to/from PC.
// If PC has domain, it will be removed, if she doesn't have it,
// it will be added.
void AddRemoveDomain(object oPC, int nDomain);

// Add or remove given feat
// nBonusFeat only if we're adding/removing domain
void AddRemoveFeat(object oPC, int nFeat, int nBonusFeat = -1, int nOldFeat = -1);

// Return the feat number of the pc's deity
// favored weapon
int GetDeityWeaponFeat(object oPC);

// sAction - Add, Remove or organize domains
// sDomain - int of the domain feat
void main(string sAction, string sDomain)
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	// Get our PC target
	object oPC = GetPlayerCurrentTarget(OBJECT_SELF);
		
	// Make sure it's a PC
	if ((!GetIsPC(oPC)) && (!GetIsDM(oPC))) {
		SendMessageToPC(OBJECT_SELF, "Invalid target.");
		return;
	}

	// display GUI
	if (sAction == "0") {
		DisplayGuiScreen(OBJECT_SELF, "hv_domain_manager", FALSE, "hv_domain_manager.xml"); 
	}
	
	// Arrange buttons
	if (sAction == "1") {
		ArrangeDomainButtons(oPC);
	}
	else if (sAction == "2") { // Add/Remove domain
		AddRemoveDomain(oPC, StringToInt(sDomain));
	}
	else if (sAction == "3") { // Add/Remove Feat ID GUI
		DisplayGuiScreen(OBJECT_SELF, "hv_addremove_feat", FALSE, "hv_addremove_feat.xml"); 
	}
	else if (sAction == "4") { // Add/Remove Feat action
		if (sDomain == "")
			return;
		int nFeat = StringToInt(sDomain);
		AddRemoveFeat(oPC, nFeat);		
	}
}

void ArrangeDomainButtons(object oPC)
{
	string sColor = "";
	if ((GetHasFeat(1834, oPC, TRUE)) || (GetHasFeat(311, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "air", -1, sColor + "Air");
	
	if ((GetHasFeat(1835, oPC, TRUE)) || (GetHasFeat(312, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "animal", -1, sColor + "Animal");
	
	if (GetHasFeat(3058, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "celerity", -1, sColor + "Celerity");
	
	if (GetHasFeat(2094, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "chaos", -1, sColor + "Chaos");
	
	if (GetHasFeat(2093, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "cold", -1, sColor + "Cold");
	
	if (GetHasFeat(2092, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "darkness", -1, sColor + "Darkness");
	
	if (GetHasFeat(310, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "death", -1, sColor + "Death");
	
	if ((GetHasFeat(1837, oPC, TRUE))  || (GetHasFeat(313, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "destruction", -1, sColor + "Destruction");
	
	if (GetHasFeat(2095, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "dream", -1, sColor + "Dream");
	
	if (GetHasFeat(3059, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "dwarf", -1, sColor + "Dwarf");
	
	if ((GetHasFeat(1838, oPC, TRUE)) || (GetHasFeat(314, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "earth", -1, sColor + "Earth");
	
	if (GetHasFeat(3060, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "elf", -1, sColor + "Elf");
	
	if (GetHasFeat(315, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "evil", -1, sColor + "Evil");
	
	if (GetHasFeat(3061, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "fate", -1, sColor + "Fate");
	
	if ((GetHasFeat(1840, oPC, TRUE)) || (GetHasFeat(316, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "fire", -1, sColor + "Fire");
	
	if (GetHasFeat(306, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "fury", -1, sColor + "Fury");
	
	if ((GetHasFeat(1841, oPC, TRUE)) || (GetHasFeat(317, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "good", -1, sColor + "Good");
	
	if (GetHasFeat(3062, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "hatred", -1, sColor + "Hatred");
	
	if (GetHasFeat(318, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "healing", -1, sColor + "Healing");
	
	if (GetHasFeat(3190, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "illusion", -1, sColor + "Illusion");
	
	if ((GetHasFeat(1843, oPC, TRUE)) || (GetHasFeat(319, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "knowledge", -1, sColor + "Knowledge");
	
	if (GetHasFeat(2096, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "law", -1, sColor + "Law");
	
	if ((GetHasFeat(2097, oPC, TRUE)) || (GetHasFeat(309, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "luck", -1, sColor + "Luck");
	
	if ((GetHasFeat(1844, oPC, TRUE)) || (GetHasFeat(320, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "magic", -1, sColor + "Magic");
	
	if (GetHasFeat(3063, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "mysticism", -1, sColor + "Mysticism");
	
	if (GetHasFeat(3064, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "pestilence", -1, sColor + "Pestilence");
	
	if ((GetHasFeat(1845, oPC, TRUE)) || (GetHasFeat(321, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "plant", -1, sColor + "Plant");
	
	if (GetHasFeat(3191, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "pride", -1, sColor + "Pride");
	
	if (GetHasFeat(308, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "protection", -1, sColor + "Protection");
	
	if (GetHasFeat(3068, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "repose", -1, sColor + "Repose");
	
	if (GetHasFeat(3065, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "storm", -1, sColor + "Storm");
	
	if (GetHasFeat(307, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "strength", -1, sColor + "Strength");
	
	if (GetHasFeat(3066, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "suffering", -1, sColor + "Suffering");
	
	if (GetHasFeat(322, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "sun", -1, sColor + "Sun");
	
	if (GetHasFeat(2098, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "time", -1, sColor + "Time");
	
	if ((GetHasFeat(1849, oPC, TRUE)) || (GetHasFeat(323, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "travel", -1, sColor + "Travel");
	
	if ((GetHasFeat(1850, oPC, TRUE)) || (GetHasFeat(324, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "trickery", -1, sColor + "Trickery");
	
	if (GetHasFeat(3067, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "tyranny", -1, sColor + "Tyranny");
	
	if (GetHasFeat(2099, oPC, TRUE))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "undeath", -1, sColor + "Undeath");
	
	if ((GetHasFeat(2100, oPC, TRUE)) || (GetHasFeat(306, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "war", -1, sColor + "War");
	
	if ((GetHasFeat(1852, oPC, TRUE)) || (GetHasFeat(325, oPC, TRUE)))
		sColor = "<C=orange>";
	else
		sColor = "";	
	SetGUIObjectText(OBJECT_SELF, "hv_domain_manager", "water", -1, sColor + "Water");
}

void AddRemoveDomain(object oPC, int nDomain)
{
	if (nDomain == 1834) {
		AddRemoveFeat(oPC, nDomain, 195, 311);
		//AddRemoveFeat(oPC, 195);
	}
	else if (nDomain == 1835) {
		AddRemoveFeat(oPC, nDomain, 199, 312);
		//AddRemoveFeat(oPC, 199);
	}
	else if (nDomain == 3058) {
		AddRemoveFeat(oPC, nDomain, 1337);
		//AddRemoveFeat(oPC, 1337);
	}
	else if (nDomain == 2094) {
		AddRemoveFeat(oPC, nDomain, 259);
		//AddRemoveFeat(oPC, 259);
	}
	else if (nDomain == 2093) {
		AddRemoveFeat(oPC, nDomain, 427);
		//AddRemoveFeat(oPC, 427);
	}
	else if (nDomain == 2092) {
		AddRemoveFeat(oPC, nDomain, 408);
		//AddRemoveFeat(oPC, 408);
	}
	else if (nDomain == 310) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 1837) {
		AddRemoveFeat(oPC, nDomain, 1761, 313);
		//AddRemoveFeat(oPC, 1761);
	}
	else if (nDomain == 2095) {
		AddRemoveFeat(oPC, nDomain, 235);
		//AddRemoveFeat(oPC, 235);
	}
	else if (nDomain == 3059) {
		AddRemoveFeat(oPC, nDomain, 14);
		//AddRemoveFeat(oPC, 14);
	}
	else if (nDomain == 1838) {
		AddRemoveFeat(oPC, nDomain, 40, 314);
		//AddRemoveFeat(oPC, 40);
	}
	else if (nDomain == 3060) {
		AddRemoveFeat(oPC, nDomain, 27);
		//AddRemoveFeat(oPC, 27);
	}
	else if (nDomain == 315) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 3061) {
		AddRemoveFeat(oPC, nDomain, 195);
		//AddRemoveFeat(oPC, 195);
	}
	else if (nDomain == 1840) {
		AddRemoveFeat(oPC, nDomain, 429, 316);
		//AddRemoveFeat(oPC, 429);
	}
	else if (nDomain == 306) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 1841) {
		AddRemoveFeat(oPC, nDomain, 300, 317);
		//AddRemoveFeat(oPC, 300);
	}
	else if (nDomain == 3062) {
		AddRemoveFeat(oPC, nDomain, 3073);
		//AddRemoveFeat(oPC, 3073);
	}
	else if (nDomain == 318) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 3190) {
		AddRemoveFeat(oPC, nDomain, 170);
		//AddRemoveFeat(oPC, 170);
	}
	else if (nDomain == 1843) {
		AddRemoveFeat(oPC, nDomain, -1, 319);
	}
	else if (nDomain == 2096) {
		AddRemoveFeat(oPC, nDomain, 22);
		//AddRemoveFeat(oPC, 22);
	}
	else if (nDomain == 2097) {
		AddRemoveFeat(oPC, nDomain, 382, 309);
		//AddRemoveFeat(oPC, 382);
	}
	else if (nDomain == 1844) {
		AddRemoveFeat(oPC, nDomain, -1, 320);
	}
	else if (nDomain == 3063) {
		AddRemoveFeat(oPC, nDomain, 3074);
	//	AddRemoveFeat(oPC, 3074);
	}
	else if (nDomain == 3064) {
		AddRemoveFeat(oPC, nDomain, 219);
	//	AddRemoveFeat(oPC, 219);
	}
	else if (nDomain == 1845) {
		AddRemoveFeat(oPC, nDomain, 200, 321);
	//	AddRemoveFeat(oPC, 200);
	}
	else if (nDomain == 3191) {
		AddRemoveFeat(oPC, nDomain, 1987);
	//	AddRemoveFeat(oPC, 1987);
	}
	else if (nDomain == 308) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 3068) {
		AddRemoveFeat(oPC, nDomain, 3076);
	//	AddRemoveFeat(oPC, 3076);
	}
	else if (nDomain == 3065) {
		AddRemoveFeat(oPC, nDomain, 430);
	//	AddRemoveFeat(oPC, 430);
	}
	else if (nDomain == 307) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 3066) {
		AddRemoveFeat(oPC, nDomain, 3075);
	//	AddRemoveFeat(oPC, 3075);
	}
	else if (nDomain == 322) {
		AddRemoveFeat(oPC, nDomain);
	}
	else if (nDomain == 2098) {
		AddRemoveFeat(oPC, nDomain, 377);
	//	AddRemoveFeat(oPC, 377);
	}
	else if (nDomain == 1849) {
		AddRemoveFeat(oPC, nDomain, 194, 323);
	//	AddRemoveFeat(oPC, 194);
	}
	else if (nDomain == 1850) {
		AddRemoveFeat(oPC, nDomain, 1098, 324);
	//	AddRemoveFeat(oPC, 1098);
	}
	else if (nDomain == 3067) {
		AddRemoveFeat(oPC, nDomain, 168);
	//	AddRemoveFeat(oPC, 168);
	}
	else if (nDomain == 2099) {
		AddRemoveFeat(oPC, nDomain, 13);
	//	AddRemoveFeat(oPC, 13);
	}
	else if (nDomain == 2100) {
	//	AddRemoveFeat(oPC, nDomain);
		int nWFocus = GetDeityWeaponFeat(oPC);
		if (nWFocus > 0)
			AddRemoveFeat(oPC, nDomain, nWFocus, 306);
		else
			AddRemoveFeat(oPC, nDomain, -1, 306);
	}
	else if (nDomain == 1852) {
		AddRemoveFeat(oPC, nDomain, 206, 325);
		//AddRemoveFeat(oPC, 206);
	}
	
	ArrangeDomainButtons(oPC);
}

void AddRemoveFeat(object oPC, int nFeat, int nBonusFeat = -1, int nOldFeat = -1)
{
	string sFeatName = Get2DAString("feat", "LABEL", nFeat);
	string sBonusFeatName;
	string sOldFeatName;
	if (nBonusFeat != -1) {
		sBonusFeatName = Get2DAString("feat", "LABEL", nBonusFeat);
	}
	if (nOldFeat != -1) {
		sOldFeatName = Get2DAString("feat", "LABEL", nOldFeat);
	}
	
	if (sFeatName == "") {
		SendMessageToPC(OBJECT_SELF, "Feat not found.");
		return;
	}
	
	if (GetHasFeat(nFeat, oPC, TRUE)) {
		FeatRemove(oPC, nFeat);
		SendMessageToPC(OBJECT_SELF, "Removed " + sFeatName + " (" + IntToString(nFeat) + ")");
		
		// Domain bonus feat
		if (nBonusFeat != -1) {
			if (GetHasFeat(nBonusFeat, oPC, TRUE)) {
				FeatRemove(oPC, nBonusFeat);
				SendMessageToPC(OBJECT_SELF, "Removed " + sBonusFeatName + " (" + IntToString(nBonusFeat) + ")");
			}
		}
		
		// old domain feats
		if (nOldFeat != -1) {
			if (GetHasFeat(nOldFeat, oPC, TRUE)) {
				FeatRemove(oPC, nOldFeat);
				SendMessageToPC(OBJECT_SELF, "Removed " + sOldFeatName + " (" + IntToString(nOldFeat) + ")");
			}
		}
	}
	else { // No feat - add it
		FeatAdd(oPC, nFeat, FALSE);
		SendMessageToPC(OBJECT_SELF, "Added " + sFeatName + " (" + IntToString(nFeat) + ")");
		
		// Domain bonus feat
		if (nBonusFeat != -1) {
			if (!GetHasFeat(nBonusFeat, oPC, TRUE)) {
				FeatAdd(oPC, nBonusFeat, FALSE);
				SendMessageToPC(OBJECT_SELF, "Added " + sBonusFeatName + " (" + IntToString(nBonusFeat) + ")");
			}
		}
	}	
}

int GetDeityWeaponFeat(object oPC)
{
	int nRows = GetNum2DARows("nwn2_deities");
	int i;
	string sDeity;
	string sLastName;
	string sPCDeity = GetDeity(oPC);
	for (i = 0; i < nRows; i++) {
		sDeity = Get2DAString("nwn2_deities", "FirstName", i);
		sLastName = Get2DAString("nwn2_deities", "LastName", i);
		if ((sLastName != "****") && (sLastName != "padding") && (sLastName != ""))
			sDeity += " " + sLastName;
		
		if (sDeity == sPCDeity) {
			return StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponFocus", i));
		}
	}
	return 0;
}