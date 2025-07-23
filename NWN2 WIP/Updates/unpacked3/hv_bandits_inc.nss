// All Ella's bandit hideout functions go here

// ///////////////////////////
// Constants and variables //
// //////////////////////////

// Variable to indicate if statues were reset already
const string STATUES_RESET = "hv_bandits_statues_reset";

// Trap statues
const string TRAP_STATUE1 = "hv_bandits_trapstatue_1";
const string TRAP_STATUE2 = "hv_bandits_trapstatue_2";

// Number of statues (fixed number for performance enhancement)
const int TOTAL_STATUES = 68;

// Trap triggers
const string TRAP_TRIGGER1 = "hv_bandits_traptrigger_1";
const string TRAP_TRIGGER2 = "hv_bandits_traptrigger_2";

// Set trap waypoints
const string SET_TRAP_WP = "hv_bandits_settrap_wp";

// Number of trap waypoint
const int TOTAL_TRAPS_WP = 26;

// Local variable on statue to mark if it's armed or not
const string STATUE_ARMED = "hv_armed_statue";

// Variables to hold current password
const string DIGIT_1 = "hv_bandits_pass1";
const string DIGIT_2 = "hv_bandits_pass2";
const string DIGIT_3 = "hv_bandits_pass3";
const string DIGIT_4 = "hv_bandits_pass4";

// Securtiy books tags
const string S_BOOK_1 = "hv_bandits_book1";
const string S_BOOK_2 = "hv_bandits_book2";
const string S_BOOK_3 = "hv_bandits_book3";
const string S_BOOK_4 = "hv_bandits_book4";

// Security door tag
const string S_DOOR = "hv_bandits_s_door";


// ///////////////////////
// Function Delcaration //
// ///////////////////////

// Reset all traps in area when a PC enters it
// if there is no other PC in already
void ResetTraps(object oArea);

// When lever is pulled, move traps to other statues
void MoveTraps(object oLever);

// Toggle statue armed state
void ToggleStatueArmed(object oStatue);

// Mark statue as armed
void MarkStatueArmed(object oStatue);

// Mark statue as not armed
void MarkStatueUnarmed(object oStatue);

// Mark trigger armed
void MarkTriggerArmed(object oTrigger);

// Mark trugger unarmed
void MarkTriggerUnarmed(object oTrigger);

// When player enters trap trigger,
// activate if it's armed
void ActivateStatueTrap(object oTrigger, object oPC);

// Toggle trigger armed state
void ToggleTriggerArmed(object oTrigger);

// Make oStatue apply a beam on nearest statue of its kind
void DoStatueTrapVisual(object oStatue);

// Do random effect when trap is activated
void DoRandomTrapEffect(object oPC);

// Do a poison effect on PC
void DoPoisonEffect(object oPC);

// Petrify effect
void DoPetrifyEffect(object oPC);

// Do blindness effet on PC
void DoBlindnessEffect(object oPC);

// Do dispell effet on PC
void DoDispelEffect(object oPC);

// Do elemntal damage effect
void DoElementalDamageEffect(object oPC, int nVisual, int nDamageType);

// Set random trap at oObject's location
void SetRandomTrap(object oObject, int nNum);

// Store password on player using 4 variables
void GeneratePassword(object oPC);

// Update password on security books
void UpdateSecurityBooks(object oBook, object oPC);

// Check if password that is stored on oPC is correct.
// Return TRUE if it's good, FALSE otherwise.
int CheckPassword(string sPass, object oPC);

// ///////////////////////////
// Functions Implementation //
// ///////////////////////////

// Reset all traps in area when a PC enters it
// if there is no other PC in already
void ResetTraps(object oArea)
{
	// Create trap triggers on waypoints
	int i = 0;
	for (i = 0; i < TOTAL_TRAPS_WP; i++) {
	
		SetRandomTrap(GetObjectByTag(SET_TRAP_WP, i), i);
	}
	
	if (GetLocalInt(oArea, STATUES_RESET) == 0) {
	
		// Mark staue_1 objects as unarmed
		for (i = 0; i < TOTAL_STATUES / 2; i++) {
	
			MarkStatueUnarmed(GetObjectByTag(TRAP_STATUE1, i));
		}
	
		// Mark staue_2 objects as armed
		for (i = 0; i < TOTAL_STATUES / 2; i++) {
	
			MarkStatueArmed(GetObjectByTag(TRAP_STATUE2, i));
		}
	
		// Mark trigger_1 objects unarmed
		for (i = 0; i < TOTAL_STATUES / 2; i++) {
	
			MarkTriggerUnarmed(GetObjectByTag(TRAP_TRIGGER1, i));
		}
	
		// Mark trigger_2 objects armed
		for (i = 0; i < TOTAL_STATUES / 2; i++) {
	
			MarkTriggerArmed(GetObjectByTag(TRAP_TRIGGER2, i));
		}
		
		SetLocalInt(oArea, STATUES_RESET, 1);
	}

	/*// Trap waypoints counter
	int nTrapWP = 0;
	
	// Go through all object in area
	object oObject = GetFirstObjectInArea(oArea);
	while (GetIsObjectValid(oObject)) {
		
		// If it's statue_2, arm
		if (GetTag(oObject) == TRAP_STATUE2)
			MarkStatueArmed(oObject);
		
		// If it's statue_1, disarm
		else if (GetTag(oObject) == TRAP_STATUE1)
			MarkStatueUnarmed(oObject);
			
		// If it's trigger_2, arm
		else if (GetTag(oObject) == TRAP_TRIGGER2)
			MarkTriggerArmed(oObject);
			
		// If it's trigger_1, disarm
		else if (GetTag(oObject) == TRAP_TRIGGER1)
			MarkTriggerUnarmed(oObject);
			
		// Count trap waypoint to set traps there later
		else if (GetTag(oObject) == SET_TRAP_WP)
			nTrapWP++;
		
		// Get next object
		oObject = GetNextObjectInArea(oArea);
	}
	
	// Create trap triggers on waypoints
	int i = 0;
	for (i = 0; i < nTrapWP; i++) {
	
		SetRandomTrap(GetObjectByTag(SET_TRAP_WP, i));
	}*/
}

// When lever is pulled, move traps to other statues
void MoveTraps(object oLever)
{
	// Get 1st statue
	object oObject = GetNearestObjectByTag(TRAP_STATUE1, oLever, 1);
	ToggleStatueArmed(oObject);
	
	// 2nd
	oObject = GetNearestObjectByTag(TRAP_STATUE1, oLever, 2);
	ToggleStatueArmed(oObject);
	
	// 3rd
	oObject = GetNearestObjectByTag(TRAP_STATUE2, oLever, 1);
	ToggleStatueArmed(oObject);
	
	// 4th
	oObject = GetNearestObjectByTag(TRAP_STATUE2, oLever, 2);
	ToggleStatueArmed(oObject);
	
	// Now triggers
	oObject = GetNearestObjectByTag(TRAP_TRIGGER1, oLever, 1);
	ToggleTriggerArmed(oObject);
	
	oObject = GetNearestObjectByTag(TRAP_TRIGGER2, oLever, 1);
	ToggleTriggerArmed(oObject);
	 
}

// Toggle statue armed state
void ToggleStatueArmed(object oStatue)
{
	effect eBlur = EffectVisualEffect(VFX_DUR_BLUR);	

	// Armed - disarm
	if (GetLocalInt(oStatue, STATUE_ARMED) == 1)
		MarkStatueUnarmed(oStatue);
	else 
		MarkStatueArmed(oStatue);		
}

// Mark statue as armed
void MarkStatueArmed(object oStatue)
{
	// Make blur effect for statues
	effect eBlur = EffectVisualEffect(VFX_DUR_BLUR);
	
	// Apply blur effect
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlur, oStatue);
	
	// Marked armed
	SetLocalInt(oStatue, STATUE_ARMED, 1);	
}

// Mark statue as not armed
void MarkStatueUnarmed(object oStatue)
{
	// Remove blur effect
	effect eVis = GetFirstEffect(oStatue);
	
	while (GetIsEffectValid(eVis)) {
	
		if (GetEffectInteger(eVis, 0) == 0) {
			RemoveEffect(oStatue, eVis);
		}
		eVis = GetNextEffect(oStatue);
	}

	// Marked unarmed
	SetLocalInt(oStatue, STATUE_ARMED, 0);	
}

// When player enters trap trigger,
// activate if it's armed
void ActivateStatueTrap(object oTrigger, object oPC)
{
	// Check it it's armed
	if (GetLocalInt(oTrigger, STATUE_ARMED) == 1) {
		
		// Check if it's pair 1 or 2 to do visual beam effect
		if (GetTag(oTrigger) == TRAP_TRIGGER1)
			DoStatueTrapVisual(GetNearestObjectByTag(TRAP_STATUE1, oTrigger));
		else
			DoStatueTrapVisual(GetNearestObjectByTag(TRAP_STATUE2, oTrigger));	
			
		// Do random effect on PC
		DoRandomTrapEffect(oPC);
	}
}

// Mark trigger armed
void MarkTriggerArmed(object oTrigger)
{
	SetLocalInt(oTrigger, STATUE_ARMED, 1);
}

// Mark trigger unarmed
void MarkTriggerUnarmed(object oTrigger)
{
	SetLocalInt(oTrigger, STATUE_ARMED, 0);
}

// Toggle trigger armed state
void ToggleTriggerArmed(object oTrigger)
{
	// Armed - disarm
	if (GetLocalInt(oTrigger, STATUE_ARMED) == 1)
		MarkTriggerUnarmed(oTrigger);
	else 
		MarkTriggerArmed(oTrigger);
}

// Make oStatue apply a beam on nearest statue of its kind
void DoStatueTrapVisual(object oStatue)
{
	ExecuteScript("hv_bandits_statue_visual", oStatue);
}

// Do random effect when trap is activated
void DoRandomTrapEffect(object oPC)
{
	// Select random number
	int nRand = Random(10);
	
	switch (nRand) {
	
		case 0:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_ACID, DAMAGE_TYPE_ACID);
			break;
	
		case 1:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_ICE, DAMAGE_TYPE_COLD);
			break;
		
		case 2:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_FIRE, DAMAGE_TYPE_FIRE);
			break;
			
		case 3:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_LIGHTNING, DAMAGE_TYPE_ELECTRICAL);
			break;
			
		case 4:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_HOLY, DAMAGE_TYPE_DIVINE);
			break;
			
		case 5:
			DoElementalDamageEffect(oPC, VFX_HIT_AOE_NECROMANCY, DAMAGE_TYPE_NEGATIVE);
			break;
		
		case 6:
			DoPoisonEffect(oPC);
			break;
			
		case 7:
			DoBlindnessEffect(oPC);
			break;
			
		case 8:
			DoDispelEffect(oPC);
			break;
			
		case 9:
			DoPetrifyEffect(oPC);
			break;
		
		default:
			DoPoisonEffect(oPC);
			break;		
	}
}

// Do a poison effect on PC
void DoPoisonEffect(object oPC)
{
	// Create the visual effects
	effect eVisual = EffectVisualEffect(VFX_DUR_SPELL_CLOUD_BEWILDERMENT);
		
	// Poison
	effect ePoison = EffectPoison(POISON_DRAGON_BILE);
	
	// Apply effects
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, 2.0f);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oPC);
}

// Do blindness effet on PC
void DoBlindnessEffect(object oPC)
{
	// Create the visual effects
	effect eVisual = EffectVisualEffect(VFX_DUR_DARKNESS);
		
	// Blindess
	effect eBlind = EffectBlindness();
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, 2.0f);
	
	// Apply effects if failed will save
	if (WillSave(oPC, 26) == 0) {
	
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 60.0);
	}
}

// Do dispell effet on PC (changed to spell failure)
void DoDispelEffect(object oPC)
{
	// Create the visual effects
	effect eVisual = EffectVisualEffect(VFX_HIT_AOE_ABJURATION);
		
	// Dispel
	effect eDispel = EffectSpellFailure();
	
	// Apply effects
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, GetLocation(oPC));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDispel, oPC, 60.0);
}

// Do elemntal damage effect
void DoElementalDamageEffect(object oPC, int nVisual, int nDamageType)
{
	// Create the visual effects
	effect eVisual = EffectVisualEffect(nVisual); 
	
	// Calculate % of damage to deal
	int nSave = ReflexSave(oPC, 28);
	int nMaxHP = GetMaxHitPoints(oPC);
	int nDamage = FloatToInt(nMaxHP * 0.25);
	
	// Half damage on successful save
	if (nSave == 1)
		nDamage = nDamage / 2;
	
	// Create damage effect
	effect eDamage = EffectDamage(nDamage, nDamageType);
	
	// Apply visual and damage
	if (nSave < 2) {
	
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, GetLocation(oPC));
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
	}
}

// Set random trap at oObject's location
void SetRandomTrap(object oObject, int nNum)
{
	// Make sure there isn't a trap there already
	object oTrap = GetNearestObjectByTag("hv_trap" + IntToString(nNum), oObject);
	
	if (GetIsObjectValid(oTrap))
		return;
	
	// Get random trap (there are 48 of them, 0 to 47)
	int nRand = Random(48);

	// Create trap
	CreateTrapAtLocation(nRand, GetLocation(oObject), 2.0, "hv_trap" + IntToString(nNum)); 
}

// Store password on player using 4 variables
void GeneratePassword(object oPC)
{
	// Get random digit (1-9) and store on variables
	SetLocalInt(oPC, DIGIT_1, Random(9) + 1);
	SetLocalInt(oPC, DIGIT_2, Random(9) + 1);
	SetLocalInt(oPC, DIGIT_3, Random(9) + 1);
	SetLocalInt(oPC, DIGIT_4, Random(9) + 1);
}

// Update password on security books
void UpdateSecurityBooks(object oBook, object oPC)
{
	// Check which book it is
	string sBookTag = GetTag(oBook);
	
	string sPCPass = "";
	
	// 1st book
	if (sBookTag ==  S_BOOK_1)
	 	sPCPass =  "First digit: " + IntToString(GetLocalInt(oPC, DIGIT_1));
	
	// 2nd book
	if (sBookTag ==  S_BOOK_2)
	 	sPCPass =  "Second digit: " + IntToString(GetLocalInt(oPC, DIGIT_2));
		
	// 3rd book
	if (sBookTag ==  S_BOOK_3)
	 	sPCPass =  "Third digit: " + IntToString(GetLocalInt(oPC, DIGIT_3));
		
	// 4th book
	if (sBookTag ==  S_BOOK_4)
	 	sPCPass =  "Fourth digit: " + IntToString(GetLocalInt(oPC, DIGIT_4));
		
	// Show player her password
	DisplayMessageBox(oPC, -1, sPCPass);
}

// Check if password that is stored on oPC is correct.
// Return TRUE if it's good, FALSE otherwise.
int CheckPassword(string sPass, object oPC)
{
	// If sPass is empty, return false
	if (sPass == "")
		return FALSE;
		
	// Get current pass
	string sCurrentPass = IntToString(GetLocalInt(oPC, DIGIT_1));
	sCurrentPass += IntToString(GetLocalInt(oPC, DIGIT_2));
	sCurrentPass += IntToString(GetLocalInt(oPC, DIGIT_3));
	sCurrentPass += IntToString(GetLocalInt(oPC, DIGIT_4));
	
	// Compare
	if (sCurrentPass == sPass)
		return TRUE;
		
	// Wrong pass
	return FALSE;
}

// Petrify effect
void DoPetrifyEffect(object oPC)
{
	// Create the visual effects
	effect eVisual = EffectVisualEffect(VFX_DUR_SPELL_STINKING_CLOUD);
		
	// Petrify
	effect ePet = EffectPetrify();
	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, 2.0f);
	
	// Apply effects if failed will save
	if (FortitudeSave(oPC, 28) == 0) {
	
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePet, oPC, 18.0);
	}
}