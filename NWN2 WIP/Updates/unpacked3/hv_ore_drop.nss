// set constants for gems and metals
string BLOODSTONE =	"cft_gem_01";
string ALEXANDRITE = "cft_gem_02";
string OBSIDIAN	= "cft_gem_03";
string AMETHYST	= "cft_gem_04";
string AVENTURINE = "cft_gem_05";
string DIAMOND = "cft_gem_06";
string EMERALD = "cft_gem_07";
string FIRE_AGATE = "cft_gem_08";
string CANNARY_DIAMOND = "cft_gem_09";
string STAR_SAPPHIRE = "cft_gem_10";
string JACINTH = "cft_gem_11";
string BLUE_DIAMOND = "cft_gem_12";
string ROGUE_STONE = "cft_gem_13";
string BELJURIL = "cft_gem_14";
string KINGS_TEAR = "cft_gem_15";
string FIRE_OPAL = "cft_gem_16";
string FLUORSPAR = "cft_gem_17";
string GARNET = "cft_gem_18";
string GREENSTONE = "cft_gem_19";
string MALACHITE = "cft_gem_20";
string PHENALOPE = "cft_gem_21";
string RUBY = "cft_gem_22";
string SAPPHIRE = "cft_gem_23";
string TOPAZ = "cft_gem_24";
string COLD_IRON = "n2_crft_ingcldiron";
string DARKSTEEL = "n2_crft_ingdrksteel";
string ADAMANTINE = "n2_crft_ingadamant";
string ALCHEMICAL_SILVER = "n2_crft_ingsilver";
string MITHRAL = "n2_crft_ingmithral";
string IRON = "n2_crft_ingiron";
string ROCK = "hv_rock";

// function returns random item tag from selected category
// (common,less common,rare,metal common,metal less common, metal rare)
string GetRandomGemOrMetal(string sCategory)
{	
	// "common" category
	if (sCategory == "common") {
		// we have 6 options, so choose one randomly
		int nRandom = Random(6) + 1;
		switch (nRandom) {
			case 1 : return BLOODSTONE;
			case 2 : return OBSIDIAN;
			case 3 : return AVENTURINE;
			case 4 : return FIRE_AGATE;
			case 5 : return FLUORSPAR;
			case 6 : return IRON;
		}
	}
	// "less common" category
	else if (sCategory == "less common") {
		// 6 options, choose one randomly
		int nRandom = Random(6) + 1;
		switch (nRandom) {
			case 1 : return AMETHYST;
			case 2 : return PHENALOPE;
			case 3 : return GARNET;
			case 4 : return GREENSTONE;
			case 5 : return MALACHITE;
			case 6 : return SAPPHIRE;
		}
	}
	// "rare" category
	else if (sCategory == "rare") {
		// 10 options this time...
		int nRandom = Random(10) + 1;
		switch (nRandom) {
			case 1 : return TOPAZ;
			case 2 : return ALEXANDRITE;
			case 3 : return FIRE_OPAL;
			case 4 : return RUBY;
			case 5 : return BELJURIL;
			case 6 : return JACINTH;
			case 7 : return DIAMOND;
			case 8 : return EMERALD;
			case 9 : return DARKSTEEL;
			case 10 : return MITHRAL;
		}
		
	}
	
	
	// "super rare" category
	else if (sCategory == "super rare") {
		// 6 options
		int nRandom = Random(6) + 1;
		switch (nRandom) {
			case 1 : return CANNARY_DIAMOND;
			case 2 : return STAR_SAPPHIRE;
			case 3 : return BLUE_DIAMOND;
			case 4 : return ROGUE_STONE;
			case 5 : return KINGS_TEAR;
			case 6 : return ADAMANTINE;
			
		}
		
	}
	
	
	// "metal common" category
	if (sCategory == "metal common") {
		// we have 6 options, so choose one randomly
		int nRandom = Random(6) + 1;
		switch (nRandom) {
			case 1 : return IRON;
			case 2 : return IRON;
			case 3 : return IRON;
			case 4 : return IRON;
			case 5 : return IRON;
			case 6 : return IRON;
		}
	}
	
	// "metal less common" category
	if (sCategory == "metal less common") {
		// we have 7 options, so choose one randomly
		int nRandom = Random(7) + 1;
		switch (nRandom) {
			case 1 : return IRON;
			case 2 : return IRON;
			case 3 : return IRON;
			case 4 : return IRON;
			case 5 : return COLD_IRON;
			case 6 : return DARKSTEEL;
			case 7 : return ALCHEMICAL_SILVER;
		}
	}
	
	// "metal rare" category
	if (sCategory == "metal rare") {
		// we have 11 options, so choose one randomly
		int nRandom = Random(11) + 1;
		switch (nRandom) {
			case 1 : return IRON;
			case 2 : return IRON;
			case 3 : return IRON;
			case 4 : return IRON;
			case 5 : return COLD_IRON;
			case 6 : return COLD_IRON;
			case 7 : return DARKSTEEL;
			case 8 : return DARKSTEEL;
			case 9 : return IRON;
			case 10: return MITHRAL;
			case 11: return ALCHEMICAL_SILVER;
		}
	}		
	return "";
}