#include "ginc_param_const"

// 2da file with data on allowed domains
const string DOMAINS_2DA = "hv_domain_check";


// /////////////////////
// Declare Functions //
// ////////////////////

// Get the names of the domains the PC has
// in the format of Domain1;Domain2;(...)
string GetDomains(object oPC);

// Check if sDomain is allowed for sDeity.
// return TRUE if allowed, FALSE otherwise
int GetDomainAllowed(string sDeity, string sDomain);

// Return the row number of sDeity in the 2da.
// return -1 if no row was found.
int GetDeityRow(string sDeity);

// Return values:
// 1 - Cleric has right domains
// 2 - Cleric has wrong domains
// 3 - Cleric has more or less than 2 domains.
int CheckClericDomains(object oPC);


// ///////////////////////////
// Function implementation //
// ///////////////////////////

// Get the names of the domains the PC has
// in the format of Domain1;Domain2;(...)
string GetDomains(object oPC)
{
	string sDomains = "";

	if (GetHasFeat(1834, oPC, TRUE))
		sDomains += "air;";
	
	if (GetHasFeat(1835, oPC, TRUE))
		sDomains += "animal;";
	
	if (GetHasFeat(3058, oPC, TRUE))
		sDomains += "celerity;";
	
	if (GetHasFeat(2094, oPC, TRUE))
		sDomains += "chaos;";
	
	if (GetHasFeat(2093, oPC, TRUE))
		sDomains += "cold;";
	
	if (GetHasFeat(2092, oPC, TRUE))
		sDomains += "darkness;";
	
	if (GetHasFeat(310, oPC, TRUE))
		sDomains += "death;";
	
	if (GetHasFeat(1837, oPC, TRUE))
		sDomains += "destruction;";
	
	if (GetHasFeat(2095, oPC, TRUE))
		sDomains += "dream;";
	
	if (GetHasFeat(3059, oPC, TRUE))
		sDomains += "dwarf;";
	
	if (GetHasFeat(1838, oPC, TRUE))
		sDomains += "earth;";
	
	if (GetHasFeat(3060, oPC, TRUE))
		sDomains += "elf;";
	
	if (GetHasFeat(315, oPC, TRUE))
		sDomains += "evil;";
	
	if (GetHasFeat(3061, oPC, TRUE))
		sDomains += "fate;";
	
	if (GetHasFeat(1840, oPC, TRUE))
		sDomains += "fire;";
	
	if (GetHasFeat(306, oPC, TRUE))
		sDomains += "fury;";
	
	if (GetHasFeat(1841, oPC, TRUE))
		sDomains += "good;";
	
	if (GetHasFeat(3062, oPC, TRUE))
		sDomains += "hatred;";
	
	if (GetHasFeat(318, oPC, TRUE))
		sDomains += "healing;";
	
	if (GetHasFeat(3190, oPC, TRUE))
		sDomains += "illusion;";
	
	if (GetHasFeat(1843, oPC, TRUE))
		sDomains += "knowledge;";
	
	if (GetHasFeat(2096, oPC, TRUE))
		sDomains += "law;";
	
	if (GetHasFeat(2097, oPC, TRUE))
		sDomains += "luck;";
	
	if (GetHasFeat(1844, oPC, TRUE))
		sDomains += "magic;";
	
	if (GetHasFeat(3063, oPC, TRUE))
		sDomains += "mysticism;";
	
	if (GetHasFeat(3064, oPC, TRUE))
		sDomains += "pestilence;";
	
	if (GetHasFeat(1845, oPC, TRUE))
		sDomains += "plant;";
	
	if (GetHasFeat(3191, oPC, TRUE))
		sDomains += "pride;";
	
	if (GetHasFeat(308, oPC, TRUE))
		sDomains += "protection;";
	
	if (GetHasFeat(3068, oPC, TRUE))
		sDomains += "repose;";
	
	if (GetHasFeat(3065, oPC, TRUE))
		sDomains += "storm;";
	
	if (GetHasFeat(307, oPC, TRUE))
		sDomains += "strength;";
	
	if (GetHasFeat(3066, oPC, TRUE))
		sDomains += "suffering;";
	
	if (GetHasFeat(322, oPC, TRUE))
		sDomains += "sun;";
	
	if (GetHasFeat(2098, oPC, TRUE))
		sDomains += "time;";
	
	if (GetHasFeat(1849, oPC, TRUE))
		sDomains += "travel;";
	
	if (GetHasFeat(1850, oPC, TRUE))
		sDomains += "trickery;";
	
	if (GetHasFeat(3067, oPC, TRUE))
		sDomains += "tyranny;";
	
	if (GetHasFeat(2099, oPC, TRUE))
		sDomains += "undeath;";
	
	if (GetHasFeat(2100, oPC, TRUE))
		sDomains += "war;";
	
	if (GetHasFeat(1852, oPC, TRUE))
		sDomains += "water;";

	if (GetHasFeat(3920, oPC, TRUE))
		sDomains += "cavern;";

	if (GetHasFeat(3910, oPC, TRUE))
		sDomains += "charm;";

	if (GetHasFeat(3914, oPC, TRUE))
		sDomains += "craft;";

	if (GetHasFeat(3911, oPC, TRUE))
		sDomains += "drow;";

	if (GetHasFeat(1805, oPC, TRUE))
		sDomains += "family;";

	if (GetHasFeat(3928, oPC, TRUE))
		sDomains += "gnome;";

	if (GetHasFeat(3929, oPC, TRUE))
		sDomains += "halfling;";

	if (GetHasFeat(3927, oPC, TRUE))
		sDomains += "mentalism;";

	if (GetHasFeat(3915, oPC, TRUE))
		sDomains += "metal;";

	if (GetHasFeat(3912, oPC, TRUE))
		sDomains += "moon;";

	if (GetHasFeat(3917, oPC, TRUE))
		sDomains += "nobility;";

	if (GetHasFeat(3923, oPC, TRUE))
		sDomains += "ocean;";

	if (GetHasFeat(3930, oPC, TRUE))
		sDomains += "orc;";

	if (GetHasFeat(3916, oPC, TRUE))
		sDomains += "planning;";

	if (GetHasFeat(3913, oPC, TRUE))
		sDomains += "portal;";

	if (GetHasFeat(3909, oPC, TRUE))
		sDomains += "renewal;";

	if (GetHasFeat(3922, oPC, TRUE))
		sDomains += "retribution;";

	if (GetHasFeat(3919, oPC, TRUE))
		sDomains += "rune;";

	if (GetHasFeat(3925, oPC, TRUE))
		sDomains += "scalykind;";

	if (GetHasFeat(3926, oPC, TRUE))
		sDomains += "slime;";

	if (GetHasFeat(3908, oPC, TRUE))
		sDomains += "spell;";

	if (GetHasFeat(3918, oPC, TRUE))
		sDomains += "spider;";

	if (GetHasFeat(3921, oPC, TRUE))
		sDomains += "trade;";

		
	return sDomains;
}

// Check if sDomain is allowed for sDeity.
// return TRUE if allowed, FALSE otherwise
int GetDomainAllowed(string sDeity, string sDomain)
{
	// Get number of DomainX columns
	int nColumns = GetNum2DAColumns(DOMAINS_2DA) - 1; // -1 because of "Deity" column which we don't need
	
	// Loop through all columns to see if the sDomain
	// exists for sDeity
	int i = 1;
	string sDeityDomain = "";
	int nDeityRow = GetDeityRow(sDeity);
	
	// Deity was not found - return TRUE
	// and the benefit of the doubt
	if (nDeityRow == -1)
		return TRUE;
	
	for (i = 1; i <= nColumns; i++) {
	
		// Get domain
		sDeityDomain = Get2DAString(DOMAINS_2DA, "Domain" + IntToString(i), nDeityRow);
		
		// Make sure it ain't empty
		if (sDeityDomain != "") {
		
			// Compare
			if (sDeityDomain == sDomain) {
				
				// Domain allowed for sDeity
				return TRUE;
			}
		}
	}
		
	// Domain not allowed if we got here
	return FALSE;	
}

// Return the row number of sDeity in the 2da.
// return -1 if no row was found.
int GetDeityRow(string sDeity)
{
	// Get total number of rows
	int nRows = GetNum2DARows(DOMAINS_2DA);
	
	// Loop through them all until our deity is found
	int i = 0;
	string sDeityName = "";
	for (i = 0; i < nRows; i++) {
	
		// Get deity name
		sDeityName = Get2DAString(DOMAINS_2DA, "Deity", i);
		
		// Compare
		if (sDeityName == sDeity) {
			
			// return current row
			return i;
		}
	}
	
	// If we got here no row was found
	return -1;
}

// Return values:
// 1 - Cleric has right domains
// 2 - Cleric has wrong domains
// 3 - Cleric has more or less than 2 domains.
int CheckClericDomains(object oPC)
{
	// Flag to indicate if illegal domain was found
	int bWrongDomain = FALSE;

	// Get Cleric domains
	string sDomains = GetDomains(oPC);
	
	// Get Cleric Deity
	string sDeity = GetStringLowerCase(GetDeity(oPC));
	
	// If it has a last name, replace space character with an underscore
	if (FindSubString(sDeity, " ", 0) != -1) {
	
		sDeity = GetStringParam(sDeity, 0, " ") + "_" + GetStringParam(sDeity, 1, " ");
	}
	
	// Check domains one by one
	int i = 0;
	string sCurrentDomain = GetStringParam(sDomains, i, ";");
	while (sCurrentDomain != "") {
	
		if (!GetDomainAllowed(sDeity, sCurrentDomain)) {
		
			bWrongDomain = TRUE;
		}
		
		// Next domain
		i++;
		sCurrentDomain = GetStringParam(sDomains, i, ";");
	}
	
	// Not 2 domains
	if (i != 2)
		return 3;
	
	// Wrong domains found
	else if (bWrongDomain == TRUE)
		return 2;
		
	// If we got here, player has right domains and not too many
	return 1;
}