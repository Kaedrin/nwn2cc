// Various functions and constants for the puzzle house!

// Number of rows and columns in trigger puzzle
// (must be the same)
const int T_P_SIZE = 8;

const string TRIGGER_PREFIX = "hv_p_h_trigger";
const string TRIGGER_ARMED  = "hv_p_h_armed";

// ///////////////////////
// Function declaration //
// //////////////////////

// Get a random number to arm next trigger
int GetNextTriggerNumber(int nMin, int nMax, string sOptions, int nRow, int nLast = -1);

// Check if a trigger is armed
// TRUE if armed, FALSE if not
int GetIsTriggerArmed(string sTag);

// Arm the triggers based on random path
void DisarmPuzzleTriggersRandomly(object oArea);

// Clear previous saved armed triggers
void ClearArmedTriggers(object oArea);

// Mark the trigger as inactive
void DisarmPuzzleTrigger(string sTag);

// Create object with no return value
void VoidCreateObject(int nObjectType, string sTemplate, location lLocation);

// //////////////////////////
// Function implementation //
// //////////////////////////

// Get a random number to arm next trigger
int GetNextTriggerNumber(int nMin, int nMax, string sOptions, int nRow, int nLast = -1)
{
	// No Last number
	if (nLast == -1) {
	 	// Get string length
		int nLength = GetStringLength(sOptions);
	 
	 	// Pick a random number
	 	int nRand = Random(nLength);
	 
	 	// Retrieve the chosen number from the string
	 	int nPossibleNum = StringToInt(GetSubString(sOptions, nRand, 1));
		
		// Return number
		return nPossibleNum + (T_P_SIZE * (nRow - 1));
	}
	// There is a last number, pick a following one or nothing
	else {
		int nPossibleNum = 0;
		int nRand = Random(2);
		switch (nRand) {
			case 0: nPossibleNum = nLast + 1; break;
			case 1: nPossibleNum = nLast - 1; break;
			case 2: nPossibleNum = -1;
		}
		
		// Check against min/max
		nMin = nMin + (T_P_SIZE * (nRow - 1));
		nMax = nMax + (T_P_SIZE * (nRow - 1));
		if ((nPossibleNum < nMin || (nPossibleNum > nMax)))
			return -1;
			
		// Make sure the trigger beneath it
		// is armed
		if (GetIsTriggerArmed(TRIGGER_PREFIX + IntToString(nPossibleNum - T_P_SIZE)) == FALSE)
			return -1;
		
		// Passed all checks - return it
		return nPossibleNum;
	}
	return -1;
}

// Check if a trigger is armed
// TRUE if armed, FALSE if not
int GetIsTriggerArmed(string sTag)
{
	object oTrigger = GetObjectByTag(sTag);
	
	if (GetIsObjectValid(oTrigger) == FALSE)
		return FALSE;
			
	if (GetLocalInt(oTrigger, TRIGGER_ARMED) == 0)
		return FALSE;
	
	return TRUE;
}

// Arm the triggers based on random path
void DisarmPuzzleTriggersRandomly(object oArea)
{
	string sPath = "";
	string sOptions = "12345678";
	int nMin = 1;
	int nMax = T_P_SIZE;
	int nRow = 1;
	
	// Clear previous saved armed triggers
	ClearArmedTriggers(oArea);
	
	int nChosenNum = -1;
	int tmp = 0;
	// 1st iteration
	while (nRow <=  T_P_SIZE) {
		nChosenNum = GetNextTriggerNumber(nMin, nMax, sOptions, nRow, nChosenNum);
		
		// Check if trap has already been chosen
		if ((GetLocalInt(oArea, "hv_p_h_trigger_" + IntToString(nChosenNum)) == 1)
			||
			(nChosenNum == -1)) {
			
			nRow++;
			if (nRow > T_P_SIZE)
				break;
				
			// next number will be the trigger right above the previous
			nChosenNum = tmp + T_P_SIZE;				
		}
		
		DisarmPuzzleTrigger(TRIGGER_PREFIX + IntToString(nChosenNum));
					
		//AssignCommand(oPC, SpeakString(IntToString(nChosenNum)));
		SetLocalInt(oArea, "hv_p_h_trigger_" + IntToString(nChosenNum), 1);
		tmp = nChosenNum;
	}
}

// Clear previous saved armed triggers
void ClearArmedTriggers(object oArea)
{
	int i = 0;
	object oTrigger;
	for (i = 1; i <= T_P_SIZE * T_P_SIZE; i++) {
		SetLocalInt(oArea, "hv_p_h_trigger_" + IntToString(i), 0);
		oTrigger = GetObjectByTag("hv_p_h_trigger" + IntToString(i));
		SetLocalInt(oTrigger, "hv_p_h_armed", 1);	
	}	
}

// Mark the trigger as active
void DisarmPuzzleTrigger(string sTag)
{
	SetLocalInt(GetObjectByTag(sTag), TRIGGER_ARMED, 0);
}

// Create object with no return value
void VoidCreateObject(int nObjectType, string sTemplate, location lLocation)
{
	CreateObject(nObjectType, sTemplate, lLocation);
}