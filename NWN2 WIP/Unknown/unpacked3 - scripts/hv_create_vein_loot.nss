#include "hv_ore_drop"
#include "nwnx_sql"

int failAttemptRetryCounter=0;

// returns true (1) on successful mining, false (0) on failure
int MineVein() 
{
	int nSuccess = 0;
	
	// check if the right mining axe is used
	object oPC = GetLastAttacker();
	object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
	string sItemTag = GetTag(oItem);
	if (sItemTag != "hv_pickaxe") {
		return 0;
	}
	
	// check if the PC did enough damage to find anything
	//int nStrength = GetAbilityModifier(ABILITY_STRENGTH, oPC) * 2;
	int nStrength = GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE) - 10;
	int nDice = d6();
	int nScore = nStrength + nDice;
	if (nScore >= 11) {
		return 1;
	}
	return nSuccess; 	
}

// function returns a random item tag of a gem, metal, or useless rock.
string GetLootFromVein(string sVeinDifficulty)
{
	// check if PC succeeded mining attempt
	if (MineVein() == 0) {
		SpeakString("Mining attempt failed.");
		return "";
	}
	
	// get a random number from 1 to 100
	int nRandomNum = Random(100) + 1;
	
	// 45% - give PC useless rock
	if (nRandomNum < 46)  { // 1-45
		SpeakString("Mining attempt yielded rocks.");
		return "";//ROCK;
	}
	
	// roll another number
	nRandomNum = Random(100) + 1;
	
	
	// for "easy" vein
	if (sVeinDifficulty == "easy") 
	{
		// 75% for common
		if (nRandomNum < 76) { // 1-75
			return GetRandomGemOrMetal("common");
		}
		// 20% for less common
		else if (nRandomNum < 96) { // 76-95
			return GetRandomGemOrMetal("less common");
		}
		// 5% for rare
		else { // 96-100
			return GetRandomGemOrMetal("rare");
		}
	}
	
	
	// for "medium" vein
	else if (sVeinDifficulty == "medium") 
	{
		// 65% for common
		if (nRandomNum < 66) { // 1-66
			return GetRandomGemOrMetal("common");
		}
		// 25% for less common
		else if (nRandomNum < 91) { // 66-91
			return GetRandomGemOrMetal("less common");
		}
		
		// 9.9% for rare
		else if (nRandomNum < 100) { // 91-99
			return GetRandomGemOrMetal("rare");
		}
		else {//0.05% for super rare
			int randomTwo = Random(20) + 1;
			if (randomTwo == 1) {
				return GetRandomGemOrMetal("super rare");
				}
			else {
				return GetRandomGemOrMetal("rare");
				}
			
		} 
	}
		
		

		
		//buce's changes for no super rare drop
		// 10% for rare
		//else { // 91-100
			//return GetRandomGemOrMetal("rare");
		//}
		
	//	else if (nRandomNum < 96) { // 81-95
		//	return GetRandomTag("rare");
	//	}
		// 5% for super rare
	//	else { // 96-100
			//return GetRandomTag("super rare");
	//	}

	
	
	
	// for "hard" vein -- Has no super are drops. MODIFY if 'hard' veins are added
	else if (sVeinDifficulty == "hard") 
	{
		// 55% for common
		if (nRandomNum < 56) { // 1-55
			return GetRandomGemOrMetal("common");
		}
		// 30% for less common
		else if (nRandomNum < 86) { // 56-86
			return GetRandomGemOrMetal("less common");
		}
		
		// 15% for rare
		else { // 86-100
			return GetRandomGemOrMetal("rare");
		}
	}
		
		//buce's changes for no super rare drop
		// 20% for rare
	
	/*	else if (nRandomNum < 91) { // 66-90
			return GetRandomTag("rare");
		}
		// 10% for super rare
		else { // 91-100
			return GetRandomTag("super rare");
		}
	}
	*/			



	// for metal "metal_easy" vein
	if (sVeinDifficulty == "metal_easy") {
		// 75% for common
		if (nRandomNum < 75) { // 1-75
			return GetRandomGemOrMetal("metal common");
		}
		// 25% for less common
		else if (nRandomNum < 96) { // 76-95
			return GetRandomGemOrMetal("metal less common");
		}
		// 5% for rare
		else { // 96-100
			return GetRandomGemOrMetal("metal rare");
		}
	}
	
	// for "metal_medium" vein
	else if (sVeinDifficulty == "metal_medium") 
	{
		// 60% for common
		if (nRandomNum < 61) { // 1-60
			return GetRandomGemOrMetal("metal common");
		}
		// 30% for less common
		else if (nRandomNum < 91) { // 61-91
			return GetRandomGemOrMetal("metal less common");
		}
		
			//buce's changes for no super rare drop
		// 10% for rare
		else { // 91-100
			return GetRandomGemOrMetal("metal rare");
		}
	}
	
	
	
	return "";
}

void log_mining(object pc, object vein, object item)
{
	// get pc data
    string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	// item data
	string item_name = GetName(item);
	
	// get vein data
	string area = GetName(GetArea(vein));
	string difficulty = GetLocalString(vein, "sDifficulty");
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	item_name = SQLEncodeSpecialChars(item_name);
	area = SQLEncodeSpecialChars(area);
	difficulty = SQLEncodeSpecialChars(difficulty);
	
	// get current vein value
    string sSQL = "SELECT val FROM mining "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND area='" + area 
				  +"' AND difficulty='" + difficulty
				  +"' AND item='" + item_name + "'";
    SQLExecDirect(sSQL);

	int val;
    if (SQLFetch() == SQL_SUCCESS)
         val = StringToInt(SQLGetData(1));
	else
		val = 0;
	

	// store data
    sSQL = "SELECT player FROM mining "
			+"WHERE toon='" + toon 
			+"' AND player='" + player 
			+"' AND area='" + area
			+"' AND difficulty='" + difficulty
			+"' AND item='" + item_name + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE mining SET val='" + IntToString(val + 1)
		 +"' WHERE toon='" + toon
         +"' AND player='" + player 
		 +"' AND area='" + area
		 +"' AND difficulty='" + difficulty
		 +"' AND item='" + item_name + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO mining (toon,player,area,difficulty,item,val) VALUES" +
            "('" + toon + "','" + player + "','" + area + "','" + difficulty + "','" +
            item_name + "'," + IntToString(val + 1) + ")";
        SQLExecDirect(sSQL);
    }
}

void main() 
{	
	// heal the vein so it won't be destroyed...
    effect eHeal = EffectHeal(1200);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);

	int nItemsToGive = GetLocalInt(OBJECT_SELF,"nItems");
	
	object oPC = GetLastAttacker();
	int nMisses = GetLocalInt(oPC,"nMisses");
	
	// Vein still hasn't "respawned", therefore contains nothing
	if (nItemsToGive == 0) {
		SpeakString("There is nothing special here...");
		return;
	}
	else {		
		// retrieve vein's difficulty from its variable
		string sVeinDifficulty = GetLocalString(OBJECT_SELF, "sDifficulty");
		string sItemTag = GetLootFromVein(sVeinDifficulty);
		
		// mining attempt failed - don't do anything
		if (sItemTag == "") {
		
			//Check added by Alex
			//If fail 3 times in a row, one less item.
			nMisses = nMisses + 1;
			
			if(nMisses==3)
			{
				nMisses=0;
				nItemsToGive = nItemsToGive - 1;
				SetLocalInt(OBJECT_SELF, "nItems", nItemsToGive);
			}
			SetLocalInt(oPC, "nMisses", nMisses);
			return;
		}
		
		// Give her random loot
		//object oPC = GetLastAttacker();
		//SendMessageToPC(oPC, IntToString(nItemsToGive) + " " + sVeinDifficulty + " " + sItemTag);
		object item = CreateItemOnObject(sItemTag, oPC);
		log_mining(oPC, OBJECT_SELF, item);
		
		// decrement nItems (items left to mine on vein) by one
		nItemsToGive = nItemsToGive - 1;
		SetLocalInt(OBJECT_SELF, "nItems", nItemsToGive);
		
		//SendMessageToPC(oPC, IntToString(nItemsToGive) + " Remaining");
		
		// if nItems is now 0 (no more items to give),
		// set it back to 5 after random time, ranging from 45 to 100 minutes.
		if (nItemsToGive == 0) {
			int nWaitMinutes = Random(71) + 45;
			int nWaitSeconds = nWaitMinutes * 60;
			//SendMessageToPC(oPC, IntToString(nWaitSeconds) + " Seconds Till Next");
			//SetLocalInt(OBJECT_SELF, "nItems", 5); // FOR TESTING, REMOVE LATER!
			DelayCommand(IntToFloat(nWaitSeconds),AssignCommand(OBJECT_SELF, SetLocalInt(OBJECT_SELF, "nItems", 5)));
		}
	}
}