#include "nwnx_sql"

// Arena HB counter
const string HB_COUNTER = "hv_arena_hb_counter";

// Is a challenge in progress?
const string CHALLENGE_RUNNING = "hv_arena_challenge_running";

// The variable that holds the current challenger object
const string CHALLENGER = "hv_arena_challenger";

// var to mark that pc is taking part in challenge
const string ARENA_CHALLENGE_VAR = "hv_arena_challenge";

// prefix of player objects to store on area
//const string PLAYER_OBJECT_VAR = "hv_arena_pc_";

// Var will hold how many players in the trigger
const string CHALLENGERS_COUNT = "hv_arena_challengers_count";

// var will hold how many players started the challenge
const string CHALLENGERS_START_NUM = "hv_arena_starting_challengers";

// Var to hold max HD player in arena
const string MAX_HD = "hv_arena_max_hd";

// Var will handle number of challengers during the challenge
const string CHALLENGERS_COUNTER = "hv_arena_challengers_counter";

// Tag of the announcer
const string ARENA_ANNOUNCER = "hv_arena_announcer";

// How many announcers are there?
const int ANNOUNCERS = 2;

// Variable that holds how many monsters there are in the round
const string ROUND_MONSTERS = "hv_arena_round_monsters";

// Var to count total monsters slain in challenge
const string TOTAL_MONSTERS_KILLED = "hv_arena_total_kills";

// Var to hold number of rounds
const string NUM_OF_ROUNDS = "hv_arena_round_number";

// Constants of monsters that will be used in arena
const string MONSTERS_TAG = "hv_arena_monster";

// Constant to tell how many monsters we have
const int TOTAL_MONSTERS = 134;

// The monster waypoints tag
const string MONSTER_WP_TAG = "hv_arena_wp_monster";

// Constant to tell how many monster spawn
// waypoints there are
const int TOTAL_MONSTER_WP = 7;

// the variable that will handle round difficulty - 
// increase difficulty as player advances
const string ROUND_DIFFICULTY = "hv_arena_round_difficulty";

// name of variable to hold top results - most rounds survived
const string MOST_ROUNDS_VAR = "mostrounds";

// number of top results to keep
const int TOP_RESULTS_NUM = 5;

// name of variables to hold top PC names of most rounds survived
const string MOST_ROUNDS_PC = "mostroundspc";

// var to hold top results - monsters killed
const string MOST_MONSTERS_KILLED = "mostmonsters";

// var to hold PC names of most monsters killed
const string MOST_MONSTERS_PC = "mostmonsterspc";

// Function returns random location
// from the monster waypoints
location GetRandomArenaLocation();

// Function returns random monster tag
string GetRandomArenaMonsterTag();

// Creates random monster in random location
void CreateArenaMonster();

// Get the challenger's party size
int GetChallengerPartySize();

// Set Variable on challenger to indicate
// she is taking part in the challenge
//void SetChallengeVarOnPC(object oArea);

// Teleport dead challenger out of the arena
void RemoveChallengerFromArena(object oPC);

// Destroy all monsters in arena
void CleanArena();

// Announce challenge results
void AnnounceResults();

// Make announcer say string
void Announce(string sMessage);

// Register top results
void RegisterRecords(string sIntVar, string sStringVar,int nResultToCheck);

// Update board description
void UpdateRecords();

// Check if challenger succeeded in a survival quest
void CheckArenaSurvivalQuest(object oPC, string sQuestTag, int nQuestEntry, int nNextQuestEntry, int nRoundsNeeded, int nRoundsSurvived);

// Determine starting difficulty based on player Hit Dice
int GetStartDifficulty(int nHD);

// Create another monster 3 minutes into a round
void CreateAdditionalMonster(object oArea);

// Function returns random location
// from the monster waypoints
location GetRandomArenaLocation()
{
	// Get random waypoint location
	int nRand = Random(TOTAL_MONSTER_WP);
	object oWP = GetObjectByTag(MONSTER_WP_TAG, nRand);
	location lLocation = GetLocation(oWP);
	return lLocation;
}

// Function returns random monster tag
string GetRandomArenaMonsterTag()
{
	string sMonster = "";
	int nDifficulty = GetLocalInt(OBJECT_SELF, ROUND_DIFFICULTY);
	int nRand = Random(nDifficulty) + 1;
	if (nRand > TOTAL_MONSTERS) // pick one of the top nine
		nRand = Random(TOTAL_MONSTERS - (TOTAL_MONSTERS - 10)) + TOTAL_MONSTERS - 9;
		
	if (nRand > TOTAL_MONSTERS)
		nRand = TOTAL_MONSTERS;
		
	sMonster = MONSTERS_TAG + IntToString(nRand);
	return sMonster;
}

// Creates randmo monster in random location
void CreateArenaMonster()
{
	// Get location to create monster
	location lLocation = GetRandomArenaLocation();
	
	// Get monster to create
	string sMonster = GetRandomArenaMonsterTag();
	
	effect eEffect2 = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
	DelayCommand(0.3f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect2, lLocation));
	
	// Make crystal cast random spell
	//object oCrystal = GetObjectByTag("hv_arena_crystal");
	//SetLocalLocation(oCrystal, "hv_location", lLocation);
	//ExecuteScript("hv_arena_magical_crystal", oCrystal);
	
	// Create monster at location!
	CreateObject(OBJECT_TYPE_CREATURE, sMonster, lLocation);
}

// Set variable on challenger to mark she is 
// taking part in the challenge
/*
void SetChallengeVarOnPC(object oArea)
{
	// Loop through the area's variables
	int nNumOfVars = GetVariableCount(oArea);
	int nPrefixLength = GetStringLength(PLAYER_OBJECT_VAR);
	int i;
	object oPC;
	string nVarName;
	for (i = 0; i < nNumOfVars; i++) {
		nVarName = GetVariableName(oArea, i);
		if (GetSubString(nVarName, 0, nPrefixLength) == PLAYER_OBJECT_VAR) {
			oPC = GetLocalObject(oArea, nVarName);
			if (GetIsObjectValid(oPC))
				SetLocalInt(oPC, ARENA_CHALLENGE_VAR, 1);
		}
	}
}
*/

// Handle player's death in arena area
void HandlePlayerDeath(object oPC)
{
	// If it's not a challenger - do nothing.
	if (GetLocalInt(oPC, ARENA_CHALLENGE_VAR) == FALSE)
		return;
	
	object oArea = GetArea(oPC);
	
	// Decrement remaining challengers
	int nChallengersLeft = GetLocalInt(oArea, CHALLENGERS_COUNTER);
	nChallengersLeft--;
	SetLocalInt(oArea, CHALLENGERS_COUNTER, nChallengersLeft);
	
	// Check quests completion
	int nRoundsLasted = GetLocalInt(OBJECT_SELF, NUM_OF_ROUNDS) - 1;
	CheckArenaSurvivalQuest(oPC, "hv_arena_survival_5", 600, 601, 5, nRoundsLasted);
	CheckArenaSurvivalQuest(oPC, "hv_arena_survival_10", 603, 604, 10, nRoundsLasted);
	CheckArenaSurvivalQuest(oPC, "hv_arena_survival_15", 606, 607, 15, nRoundsLasted);
	CheckArenaSurvivalQuest(oPC, "hv_arena_survival_20", 609, 610, 20, nRoundsLasted);
	CheckArenaSurvivalQuest(oPC, "xenq_arena30", 861220, 861221, 30, nRoundsLasted);
	
	// If it was the last one, announce results
	if (nChallengersLeft == 0) {
		AnnounceResults();
		int nMonstersKilled = GetLocalInt(OBJECT_SELF, TOTAL_MONSTERS_KILLED);
		RegisterRecords(MOST_ROUNDS_VAR, MOST_ROUNDS_PC, nRoundsLasted);
		RegisterRecords(MOST_MONSTERS_KILLED, MOST_MONSTERS_PC, nMonstersKilled);
	}
}

// Teleport dead challenger out of the arena
void RemoveChallengerFromArena(object oPC)
{
	AssignCommand(oPC, ClearAllActions(TRUE));
	
	HandlePlayerDeath(oPC);
	
	// Mark as non-challenger
	SetLocalInt(oPC, ARENA_CHALLENGE_VAR, 0);
	
	// Teleport to waypoint outside of arena
	object oWP = GetObjectByTag("hv_arena_playerdeath_wp");
	location lLocation = GetLocation(oWP);
	AssignCommand(oPC, JumpToLocation(lLocation));
	
	// Heal her and remove all effects
	effect eEffect = GetFirstEffect(oPC);
	while (GetIsEffectValid(eEffect)) {
		RemoveEffect(oPC, eEffect);
		eEffect = GetNextEffect(oPC);
	}
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
	DelayCommand(2.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC));
	DelayCommand(2.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC));
}

// Destroy all monsters in arena
void CleanArena()
{
	int nMonsterTagPrefixLength = GetStringLength(MONSTERS_TAG);
	string sMonsterTag;
	object oMonster = GetFirstObjectInArea();
	while (GetIsObjectValid(oMonster)) {
		sMonsterTag = GetTag(oMonster);
		if (GetSubString(sMonsterTag, 0, nMonsterTagPrefixLength) == MONSTERS_TAG)
			DestroyObject(oMonster);
		
		oMonster = GetNextObjectInArea();
	}
	
	// Unlock doors
	object oDoor = GetObjectByTag("hv_arena_door_1");
	SetLocked(oDoor, FALSE);
	oDoor = GetObjectByTag("hv_arena_door_2");
	SetLocked(oDoor, FALSE);
}

// Make announcers say string
void Announce(string sMessage)
{
	object oAnnouncer;
	int i;
	for (i = 0; i < ANNOUNCERS; i++) {
		oAnnouncer = GetObjectByTag(ARENA_ANNOUNCER, i);
		AssignCommand(oAnnouncer, SpeakString(sMessage));
	}
}

// Announce challenge results
void AnnounceResults()
{
	int nRoundsLasted = GetLocalInt(OBJECT_SELF, NUM_OF_ROUNDS) - 1;
	int nMonstersKilled = GetLocalInt(OBJECT_SELF, TOTAL_MONSTERS_KILLED);
	int nNumberOfChallengers = GetLocalInt(OBJECT_SELF, CHALLENGERS_START_NUM);
	
	Announce("<C=green>The challenge is over! Rounds lasted: " + IntToString(nRoundsLasted) + ". Monsters killed: " + IntToString(nMonstersKilled) + ". Number of challengers: " + IntToString(nNumberOfChallengers) + ". Well done!");
}

// Register top results
void RegisterRecords(string sIntVar, string sStringVar, int nResultToCheck)
{	
	object oBoard = GetObjectByTag("hv_arena_top_scores");
	// Check if new record has been set
	int i;
	int n;
	int nTemp;
	int nTemp2;
	string nTempName;
	string nTempName2;
	int nTopScore;
	string sPartySize = IntToString(GetLocalInt(OBJECT_SELF, CHALLENGERS_START_NUM) - 1);
	string sPCName = GetName(GetLocalObject(OBJECT_SELF, CHALLENGER)) + " (with " + sPartySize + " other challengers).";
	int nChangeFlag = FALSE;
	int nRecordsToKeep = TOP_RESULTS_NUM;
	for (i = 1; i <= nRecordsToKeep; i++) {
		nTopScore = GetPersistentInt(oBoard, sIntVar + IntToString(i));
		if (nResultToCheck > nTopScore) { // New record!
			nTemp = nTopScore;
			nTempName = GetPersistentString(oBoard, sStringVar + IntToString(i));
			SetPersistentInt(oBoard, sIntVar + IntToString(i), nResultToCheck);
			SetPersistentString(oBoard, sStringVar + IntToString(i), sPCName);
			n = i + 1;
			nChangeFlag = TRUE;
			DelayCommand(5.0f, Announce("<C=yellow>A new record! Check the record board to see your rank."));
			break;
		}
	}
	
	if (!nChangeFlag)
		return;
		
	// Update the rest of the table
	for (i = n; i <= nRecordsToKeep; i++) {
		nTemp2 = GetPersistentInt(oBoard, sIntVar + IntToString(i));
		nTempName2 = GetPersistentString(oBoard, sStringVar + IntToString(i));
		SetPersistentInt(oBoard, sIntVar + IntToString(i), nTemp);
		SetPersistentString(oBoard, sStringVar + IntToString(i), nTempName);
		nTemp = nTemp2;
		nTempName = nTempName2;
	}
	
	UpdateRecords();
}

// Update board description
void UpdateRecords()
{
	object oBoard = GetObjectByTag("hv_arena_top_scores");
	// Update results description
	string sResults = "<b>Top Scores</b>\n===========\n\n";
	string sRounds;
	string sName;
	int i;
	
	// Most Rounds
	sResults = sResults + "<b>Survived most round</b>\n====================\n";
	for (i = 1; i <= TOP_RESULTS_NUM; i++) {
		sRounds = IntToString(GetPersistentInt(oBoard, MOST_ROUNDS_VAR + IntToString(i)));
		sName = GetPersistentString(oBoard, MOST_ROUNDS_PC + IntToString(i));
		sResults = sResults + IntToString(i) + ") " + sRounds + " rounds - " + sName + "\n";
	}
	
	// Most monsters killed
	sResults = sResults + "\n<b>Killed most monsters</b>\n====================\n";
	for (i = 1; i <= TOP_RESULTS_NUM; i++) {
		sRounds = IntToString(GetPersistentInt(oBoard, MOST_MONSTERS_KILLED + IntToString(i)));
		sName = GetPersistentString(oBoard, MOST_MONSTERS_PC + IntToString(i));
		sResults = sResults + IntToString(i) + ") " + sRounds + " monsters - " + sName + "\n";
	}
	SetDescription(oBoard, sResults);
}

// Check if challenger succeeded in a survival quest
void CheckArenaSurvivalQuest(object oPC, string sQuestTag, int nQuestEntry, int nNextQuestEntry, int nRoundsNeeded, int nRoundsSurvived)
{
	if ((GetJournalEntry(sQuestTag, oPC) == nQuestEntry) && (nRoundsSurvived >= nRoundsNeeded)) {
		AddJournalQuestEntry(sQuestTag, nNextQuestEntry, oPC, FALSE);
		object oPassport = GetItemPossessedBy(oPC,"pc_tracker");
        SetPersistentInt(oPC, sQuestTag, nNextQuestEntry);
        SetLocalInt(oPassport,sQuestTag, nNextQuestEntry);
		int nCurrentRank = GetPersistentInt(oPC, "RANK", "RP_Rank"); 
        SetPersistentInt(oPC, "RANK", (nCurrentRank + 1), 0, "RP_Rank");  
	}
}

// Determine starting difficulty based on player Hit Dice
int GetStartDifficulty(int nHD)
{
	int nDifficulty = 1;
	if (nHD <= 3)
		nDifficulty = 10;
	else if (nHD <= 7)
		nDifficulty = 40;
	else if (nHD <= 11)
		nDifficulty = 60;
	else if (nHD <= 15)
		nDifficulty = 80;
	else if (nHD <= 20)
		nDifficulty = 100;
	else if (nHD <= 24)
		nDifficulty = 110;
	else if (nHD <= 27)
		nDifficulty = 120;
	else
		nDifficulty = 134;
	
	return nDifficulty;
}

// Determine starting difficulty based on player Hit Dice
int GetStartDifficultyV2(int nHD)
{
	int nDifficulty = 1;
	if (nHD <= 3)
		nDifficulty = 1;
	else if (nHD <= 7)
		nDifficulty = 1;
	else if (nHD <= 11)
		nDifficulty = 1;
	else if (nHD <= 15)
		nDifficulty = 2;
	else if (nHD <= 20)
		nDifficulty = 3;
	else if (nHD <= 24)
		nDifficulty = 4;
	else if (nHD <= 27)
		nDifficulty = 5;
	else
		nDifficulty = 6;
	
	return nDifficulty;
}

// level from 1 to 8, 65% to get nDifficulty.
int GetMonsterLevel(int nDifficulty)
{
	int nLevel = nDifficulty;
	int nRand;
	int i;
	for (i = 1; i < 9; i++) {
		 nRand = Random(100) +1;
		if ((i == nDifficulty) && (nRand <= 65)) {
			nLevel = nDifficulty;
			break;
		}
		else if (nRand <= 5) {
			nLevel = i;
			break;
		}
	}
	return nLevel;
}

// Function returns random monster tag (difficulty 1-8)
string GetRandomArenaMonsterTagByLevel(int nDifficulty)
{
	string sMonster = "";
	int nMonsterNumber = 1;
	int nLevel = GetMonsterLevel(nDifficulty);
	
	if (nDifficulty > 8)
		nDifficulty = 8;
	
	if (nDifficulty < 1)
		nDifficulty = 1;
	
	switch (nLevel) {
		case 1: // 1-15
			nMonsterNumber = Random(15) + 1;
			break;
		case 2: // 16-30
			nMonsterNumber = Random(15) + 16;
			break;
		case 3: // 31-50
			nMonsterNumber = Random(20) + 31;
			break;
		case 4: // 51-75
			nMonsterNumber = Random(25) + 51;
			break;
		case 5: // 76-100
			nMonsterNumber = Random(25) + 76;
			break;
		case 6: // 101-114
			nMonsterNumber = Random(14) + 101;
			break;
		case 7: // 115-125
			nMonsterNumber = Random(11) + 115;
			break;
		case 8: // 126-134
			nMonsterNumber = Random(10) + 125;
			break;
	}
	
	// Debug
	object oPC = GetLocalObject(OBJECT_SELF, CHALLENGER);
	SendMessageToPC(oPC, "Monster: " + IntToString(nMonsterNumber));
	
	sMonster = MONSTERS_TAG + IntToString(nMonsterNumber);
	return sMonster;
}

// Creates randmo monster in random location
void CreateArenaMonsterV2(int nDifficulty)
{
	// Get location to create monster
	location lLocation = GetRandomArenaLocation();
	
	// Get monster to create
	string sMonster = GetRandomArenaMonsterTagByLevel(nDifficulty);
	
	effect eEffect2 = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
	DelayCommand(0.3f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect2, lLocation));
	
	// Make crystal cast random spell
	//object oCrystal = GetObjectByTag("hv_arena_crystal");
	//SetLocalLocation(oCrystal, "hv_location", lLocation);
	//ExecuteScript("hv_arena_magical_crystal", oCrystal);
	
	// Create monster at location!
	CreateObject(OBJECT_TYPE_CREATURE, sMonster, lLocation);
}

// Create another monster 3 minutes into a round
void CreateAdditionalMonster(object oArea)
{
	// check if challenge is running
	if (GetLocalInt(oArea, CHALLENGE_RUNNING)) {
		// increment counter
		int nHBCounter = GetLocalInt(oArea, HB_COUNTER);
		nHBCounter++;
		SetLocalInt(oArea, HB_COUNTER, nHBCounter);
		
		// if we reached 3 minutes
		// spawn another monster
		if (nHBCounter == 30) {
			// increase monster cound in round
			SetLocalInt(oArea, ROUND_MONSTERS, GetLocalInt(oArea, ROUND_MONSTERS) + 1);
			// spawn another
			int nDifficulty = GetLocalInt(OBJECT_SELF, ROUND_DIFFICULTY);
			CreateArenaMonsterV2(nDifficulty);
			// reset counter
			SetLocalInt(oArea, HB_COUNTER, 0);
			
			Announce("<C=cyan>Round is taking too long! More monsters please!");
		}
	}
}