#include "alg_tree_inc"
//this is a lateration of mining for wood harvest

int failAttemptRetryCounter=0;

// returns true (1) on successful havest, false (0) on failure
int Tree() 
{
 	int nSuccess = 0;
 
 // check if the right hand axe is used
 object oPC = GetLastAttacker();
 object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
 string sItemTag = GetTag(oItem);
 if (sItemTag != "alg_woodaxe") {
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

// function returns a tag for wood useless splinters.
string GetLootFromWood(string sWoodType)
{
	// check if PC succeeded harvest
	if (Tree() == 0)
	{
 		SpeakString("Harvest Failed.");
  		return "";
 	}
	 
	// get a random number from 1 to 100
	int nRandomNum = Random(100) + 1;
	
	// 45% - give PC useless spinters
	if (nRandomNum < 46)  
	{ // 1-45
		SpeakString("All you got was spinters.");
		return "";//spinters!!!
	}
	 
	// roll another number	
	nRandomNum = Random(100) + 1;
	  
	// for Ironwood
	if (sWoodType == "Yew")  
	 	return GetWoodType("Yew"); 
	else if (sWoodType == "zalantar")
	   	return GetWoodType("zalantar");
	else if (sWoodType == "razorvine")
	   	return GetWoodType("razorvine");
	else if (sWoodType == "duskwood")
	   	return GetWoodType("duskwood");
 	
	else
 		return "";

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
 else
  {  
  // retrieve vein's difficulty from its variable
  string sWoodType = GetLocalString(OBJECT_SELF, "sDifficulty");
  string sItemTag = GetLootFromWood(sWoodType);
  
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
  CreateItemOnObject(sItemTag, oPC);
  
  // decrement nItems (items left to mine on vein) by one
  nItemsToGive = nItemsToGive - 1;
  SetLocalInt(OBJECT_SELF, "nItems", nItemsToGive);
  
  //SendMessageToPC(oPC, IntToString(nItemsToGive) + " Remaining");
  
  // if nItems is now 0 (no more items to give),
  // set it back to 5 after random time, ranging from 30 to 120 minutes.
  if (nItemsToGive == 0) {
   int nWaitMinutes = Random(91) + 30;
   int nWaitSeconds = nWaitMinutes * 60;
   //SendMessageToPC(oPC, IntToString(nWaitSeconds) + " Seconds Till Next");
   //SetLocalInt(OBJECT_SELF, "nItems", 5); // FOR TESTING, REMOVE LATER!
   DelayCommand(IntToFloat(nWaitSeconds),AssignCommand(OBJECT_SELF, SetLocalInt(OBJECT_SELF, "nItems", 5)));
  }
 }
}