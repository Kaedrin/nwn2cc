// Constants

// Boss visuals IDs
const int SHIELD_ID = -345;
const int RESCUE_ID = -346;

// Store target HD to tweak creatures for
const string TARGET_HD = "hv_cq_target_hd";

// Creatures
const string UNDEAD_HAG = "hv_cq_undead_hag";

// Heartbeat counter
const string HB_COUNT = "hv_cq_hb_count";

// Track if quest was setup
const string SETUP_COMPLETED = "hv_cq_setup_completed";

// Check if shield was removed already (stored on boss)
const string SHIELD_REMOVED = "hv_cq_shield_removed";

// Monster counter
const string MONSTER_COUNT = "hv_cq_monster_count";

// Special undead damage count to know how many hits
// it takes to kill them
const int SPECIAL_UNDEAD_STRENGTH = 5;
const string SPECIAL_UNDEAD_STATUS = "hv_cq_sp_un_stat";

// Set whether boss is vulnerable to magic missile
// which can break its shield (stored on boss)
const string BOSS_VULNERABLE = "hv_cq_boss_vulnerable";

// Run heartbeat functions every how many heartbeats?
const int HB_VAL = 3;

// var to track if guards saw a pc already (stored on guards)
const string PC_SEEN = "hv_pc_seen";
const string PC_SEEN_TIME = "hv_pc_seen_time";

// var to track if guard was attacked already (stored on guards)
const string ATTACKED = "hv_attacked";

// Creatures tags
const string GUARD_1 = "hv_cq_guard1";
const string GUARD_2 = "hv_cq_guard2";
const string GUARD_3 = "hv_cq_guard3";
const string BOSS    = "hv_cq_boss";
const string MUMMY = "hv_cq_mummy";
const string PRISONER = "hv_cq_prisoner";

// Waypoints tags
const string GUARD_1_WP = "hv_cq_guard1_wp";
const string GUARD_2_WP = "hv_cq_guard2_wp";
const string GUARD_3_WP = "hv_cq_guard3_wp";
const string BOSS_WP    = "hv_cq_boss_wp";
const string CRYSTAL_WP = "hv_cq_crystal_wp";
const string PRISONER_WP = "hv_cq_prisoner_wp";

// Door to lock tag
const string DOOR_TO_LOCK = "hv_cq_ent2";

// Number of prisoners
const int TOTAL_PRISONERS = 4;

// Mark battle as started or not
const string BATTLE_STARTED = "hv_cq_battle_started";

// Sounds tags
const string CRYSTAL_DESTROYED_SOUND = "hv_cq_crystal_deathsound";
const string UNDEAD_CRY = "hv_cq_undead_createsound";
const string UNDEAD_DEATH = "hv_cq_undead_deathsound";
const string SHIELD_DESTROYED = "hv_cq_shield_destroyed";
const string PRISONER_SPEAK = "hv_cq_prisoner_cry";
const string BOSS_SPEAK = "hv_cq_boss_speak";
const string BOSS_SPEAK_0 = "hv_cq_boss_speak_0";
const string BOSS_DEATH = "hv_cq_boss_death";

// How many crystals are there?
const int TOTAL_CRYSTALS = 10;

// Crystal tag and state (status stored on csystals)
const string CRYSTAL = "hv_cq_crystal";
const string CRYSTAL_STATE = "hv_cq_crystal_state";
const string CRYSTAL_COUNT = "hv_cq_crystal_count";
const string CRYSTAL_DESTROYED = "hv_cq_crystal_destroyed";

// How many hits it takes to destroy the crystal
const int CRYSTAL_STRENGTH = 10;

// Var to state if it's time to summon stuff
const string SUMMON_STUFF = "hv_cq_summon_stuff";

// Portal waypoints
const string PORTAL_WP = "hv_cq_portal_wp";

// Total portal waypoints
const int TOTAL_PORTAL_WP = 14;

// Functions declaration

// Make oPC kill oGuard
void PCKillGuard(object oPC, object oGuard);

// Create the 3 guards
void CreateGuards();

// Check if oPC has a weapon focus in
// ranged weapon
int GetHasRangedWeaponFocus(object oPC);

// Invalid crystal damage - heal crystal and give feedback
void InvalidCrystalDamage(object oPC, object oCrystal);

// The crystal was hit, announce when it will break
// and destroy it if needed
void HitCrystal(object oPC, object oCrystal);

// Destroy crystal
void DestroyCrystal(object oCrystal);

// Create the crystals
void CreateCrystals(object oBoss);

// Create the boss.
object CreateBoss();

// Open a portal and summon minions through it
void SummonMinions(object oArea);

// Get random location to open portal
location GetRandomPortalLocation();

// Create portal vfx in location
void CreateSummoningPortal(location lLoc);

// Create monsters at location
void CreateMonsters(location lLoc);

// When last crystal is destroyed
// mark to stop summoning and make boss hostile
void CheckLastCrystal(object oBoss);

// Create rescue effect from oBoss to oMonster
void CreateRescueEffect(object oBoss, object oMonster);

// Create evil beam effect from oCrystal to oBoss
void CreateEvilBeamEffect(object oCrystal, object oBoss);

// All the monsters are dead but the boss, 
// And all crystals are destroyed.
// Make boss vulnerable if it is hit by magic missile spell,
// used by arcane caster.
void MakeBossVulnerableToMagicMissile(object oArea);

// Return TRUE if oPC has a divine class
int GetHasDivineClass(object oPC);

// Kill special monster
void KillSpecialMonster(object oPC, object oMonster);

// Return TRUE if oPC has levels in arcane class
int GetHasArcaneClass(object oPC);

// Remove the boss' shield and make it vulnerable
void RemoveBossShield();

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel);

// Create psioners in cages
void CreatePrisoners();

// Clean previously-spawned setup
void CleanLeftovers(object oArea);

// Functions implementations

// Make oPC kill oGuard
void PCKillGuard(object oPC, object oGuard)
{
	AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE, TRUE), oGuard));
}

// Create the 3 guards
void CreateGuards()
{
	object oWP = GetObjectByTag(GUARD_1_WP);
	location lLoc = GetLocation(oWP);
	CreateObject(OBJECT_TYPE_CREATURE, GUARD_1, lLoc);
	
	oWP = GetObjectByTag(GUARD_2_WP);
	lLoc = GetLocation(oWP);
	CreateObject(OBJECT_TYPE_CREATURE, GUARD_2, lLoc);
	
	oWP = GetObjectByTag(GUARD_3_WP);
	lLoc = GetLocation(oWP);
	CreateObject(OBJECT_TYPE_CREATURE, GUARD_3, lLoc);
}

// Check if oPC has a weapon focus in
// ranged weapon
int GetHasRangedWeaponFocus(object oPC)
{
	// Check ranged weapon focus feats
	if ((GetHasFeat(FEAT_WEAPON_FOCUS_DART, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_SLING, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_THROWING_AXE, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW, oPC))
				||
		(GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN, oPC)))
	{
		return TRUE;
	}
	
	return FALSE;
}

// Invalid crystal damage - heal crystal and give feedback
void InvalidCrystalDamage(object oPC, object oCrystal)
{
	// Heal crystal
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1200), oCrystal);
	
	// Miss feedback
	SpeakString("<C=red>The attempt to damage the crystal was not accurate enough.");
}

// The crystal was hit, announce when it will break
// and destroy it if needed
void HitCrystal(object oPC, object oCrystal)
{
	int nStrength = GetLocalInt(oCrystal, CRYSTAL_STATE);
	// Check if it should be destroyed
	if (nStrength <= 0) {
		// Destroy crystal
		DestroyCrystal(oCrystal);
	}
	else {
		// Feedback
		SpeakString("<C=lightgreen>The crystal is weakened.");
		
		// Visual effect for the hit
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_HIT_AOE_MAGIC), oCrystal);
		
		// Decrease strength by 1
		SetLocalInt(oCrystal, CRYSTAL_STATE, nStrength - 1);
	}
}

// Destroy crystal
void DestroyCrystal(object oCrystal)
{
	// Check if crystal already marked for destruction
	if (GetLocalInt(oCrystal, CRYSTAL_DESTROYED) == TRUE)
		return;
	
	SetLocalInt(oCrystal, CRYSTAL_DESTROYED, TRUE);
	
	// Feedback
	SpeakString("<C=cyan>The crystal shatters to pieces.");
	
	// Boss screams angrily
	object oBoss = GetObjectByTag(BOSS);
	AssignCommand(oBoss, SpeakString("<C=lightgreen><i>Nooo! Protect the crystals fools!"));
	
	// Sound
	SoundObjectPlay(GetObjectByTag(CRYSTAL_DESTROYED_SOUND));
	
	// Visual
	effect eVis = EffectNWN2SpecialEffectFile("fx_kos_death");
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oCrystal));
	
	// Destroy crystal
	DestroyObject(oCrystal);
	
	// If it's the last crystal, stop summoning stuff
	// and make boss angry
	int nCCount = GetLocalInt(GetArea(oBoss), CRYSTAL_COUNT);
	nCCount--;
	if (nCCount <= 0)
		CheckLastCrystal(oBoss);
	else
		SetLocalInt(GetArea(oBoss), CRYSTAL_COUNT, nCCount);
}

// Create the boss and the crystals
void CreateCrystals(object oBoss)
{
	// Go through all the crystal waypoints 
	// and create a crystal on each
	int i = 0;
	object oWP;
	location lLoc;
	object oCrystal;	
	
	for (i = 0; i < TOTAL_CRYSTALS; i++) {
	
		// Get location to create crystal
		oWP = GetObjectByTag(CRYSTAL_WP, i);
		lLoc = GetLocation(oWP);
		
		// Create crystal
		oCrystal = CreateObject(OBJECT_TYPE_PLACEABLE, CRYSTAL, lLoc);
		
		// Visual from crystal to boss		
		AssignCommand(oBoss, CreateEvilBeamEffect(oCrystal, oBoss));
		
		// Set crystal's strength
		SetLocalInt(oCrystal, CRYSTAL_STATE, CRYSTAL_STRENGTH);
	}
	
	// Reset crystal counter
	SetLocalInt(GetArea(oCrystal), CRYSTAL_COUNT, TOTAL_CRYSTALS);
}

// Create the boss.
object CreateBoss()
{
	object oWP = GetObjectByTag(BOSS_WP);
	location lLoc = GetLocation(oWP);
	
	object oBoss = CreateObject(OBJECT_TYPE_CREATURE, BOSS, lLoc);
	
	// Visual
	effect eShield = SetEffectSpellId(SupernaturalEffect(EffectVisualEffect(VFX_DUR_SHINING_SHIELD)), SHIELD_ID);
	effect eRescue = SetEffectSpellId(SupernaturalEffect(EffectVisualEffect(VFX_DUR_RESCUER)), RESCUE_ID);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eShield, oBoss);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRescue, oBoss);
	
	// Set a random name for the boss
	SetFirstName(oBoss, RandomName());
	SetLastName(oBoss, RandomName());
	
	return oBoss;
}

// Open a portal and summon minions through it,
// every HB_VAL heartbeats
void SummonMinions(object oArea)
{
	// Check if it's time to summon
	if (GetLocalInt(oArea, SUMMON_STUFF) == TRUE) {
		// Debug
		//SendMessageToPC(GetFirstPC(), "Running HB. . .");
	
		// Progress or reset hb counter
		int nHBCounter = GetLocalInt(oArea, HB_COUNT);
		nHBCounter--;
		if (nHBCounter <= 0) {
			// Get random location to create portal
			location lLoc = GetRandomPortalLocation();
		
			// Create portal
			CreateSummoningPortal(lLoc);
		
			// Create monsters
			CreateMonsters(lLoc);
			
			nHBCounter = HB_VAL; // reset it
		}
		SetLocalInt(OBJECT_SELF, HB_COUNT, nHBCounter);
	}
}

// Get random location to open portal
location GetRandomPortalLocation()
{
	int nRand = Random(TOTAL_PORTAL_WP);
	object oWP = GetObjectByTag(PORTAL_WP, nRand);
	location lLoc = GetLocation(oWP);
	return lLoc;
}

// Create portal vfx in location
void CreateSummoningPortal(location lLoc)
{
	// Under portal effects
	effect eVisual = EffectVisualEffect(VFX_HIT_AOE_NECROMANCY);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lLoc);
	eVisual = EffectVisualEffect(VFX_DUR_GATE);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lLoc, 5.0);
	
	// Portal effect
	effect ePortal = EffectNWN2SpecialEffectFile("fx_kos_portal_large");
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePortal, lLoc, 5.0);	
}

// Create monsters at location
void CreateMonsters(location lLoc)
{
	// One special (undead that requires divine magic to slay)
	effect eVis = EffectNWN2SpecialEffectFile("fx_map_spawn_hostile");
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc);
	object oHag = CreateObject(OBJECT_TYPE_CREATURE, UNDEAD_HAG, lLoc);
	
	// Increase monster count
	SetLocalInt(GetArea(oHag), MONSTER_COUNT, GetLocalInt(GetArea(oHag), MONSTER_COUNT) + 1);
	
	// Special eyes
	eVis = SupernaturalEffect(EffectNWN2SpecialEffectFile("cmi_fx_redeyes"));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oHag);
	
	// Sound
	SoundObjectPlay(GetObjectByTag(UNDEAD_CRY));
	
	// Set hits to kill counter
	SetLocalInt(oHag, SPECIAL_UNDEAD_STATUS, SPECIAL_UNDEAD_STRENGTH);
	
	object oBoss = GetObjectByTag(BOSS);
	AssignCommand(oBoss, CreateRescueEffect(oBoss, oHag));
	
	// One mummy
	object oMummy = CreateObject(OBJECT_TYPE_CREATURE, MUMMY, lLoc);
	
	// Increase monster count
	SetLocalInt(GetArea(oMummy), MONSTER_COUNT, GetLocalInt(GetArea(oMummy), MONSTER_COUNT) + 1);
	
	// Level it up
	int nLevel = GetLocalInt(GetArea(oBoss), TARGET_HD);
	int nXP = GetXPForLevel(nLevel);
	ResetCreatureLevelForXP(oMummy, nXP, FALSE);
	ForceRest(oMummy);
	
	// Effect to Boss
	AssignCommand(oBoss, CreateRescueEffect(oBoss, oMummy));
}

// When last crystal is destroyed
// mark to stop summoning and make boss hostile
void CheckLastCrystal(object oBoss)
{	
	// Stop summoning stuff
	SetLocalInt(GetArea(oBoss), SUMMON_STUFF, FALSE);
	
	// Boss battlecry
	AssignCommand(oBoss, SpeakString("<C=lightgreen><i>Kill them. But try not to harm their bodies too much. I prefer their corpses... intact."));
	
	// Sound
	SoundObjectPlay(GetObjectByTag(BOSS_SPEAK));
	
	// Make boss hostile
	ChangeToStandardFaction(oBoss, STANDARD_FACTION_HOSTILE);
	
	// Check if there are no more monsters as well
	if (GetLocalInt(GetArea(oBoss), MONSTER_COUNT) == 0)
		MakeBossVulnerableToMagicMissile(GetArea(oBoss));
}

// Create rescue effect from oBoss to oMonster
void CreateRescueEffect(object oBoss, object oMonster)
{
	// VFX to boss
	effect eVis = SupernaturalEffect(EffectVisualEffect(VFX_BEAM_RESCUEE));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oMonster);
}

// Create evil beam effect from oCrystal to oBoss
void CreateEvilBeamEffect(object oCrystal, object oBoss)
{
	effect eVis = SupernaturalEffect(EffectVisualEffect(VFX_BEAM_NECROMANCY));	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oCrystal);
}

// All the monsters are dead but the boss, 
// And all crystals are destroyed.
// Make boss vulnerable if it is hit by magic missile spell,
// used by arcane caster.
void MakeBossVulnerableToMagicMissile(object oArea)
{
	object oBoss = GetObjectByTag(BOSS);
	AssignCommand(oBoss, SpeakString("<C=lightgreen>My minions...! My crystals...! This can't be happening! I shall crush you all!"));
	
	// Visuals + sound
	effect eVis = EffectNWN2SpecialEffectFile("fx_b_one_of_many_created01");
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oBoss, 5.0);
	effect eVis2 = EffectNWN2SpecialEffectFile("fx_b_uthraki_transform");
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oBoss);
	effect eVis3 = SupernaturalEffect(EffectNWN2SpecialEffectFile("fx_b_shadow_of_void"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oBoss);
	
	// Give him a rest
	ForceRest(oBoss);
	
	SetLocalInt(oArea, BOSS_VULNERABLE, TRUE);
}

// Return TRUE if oPC has a divine class
int GetHasDivineClass(object oPC)
{
	if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0) return TRUE;
	if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0) return TRUE;
	if (GetLevelByClass(CLASS_TYPE_FAVORED_SOUL, oPC) > 0) return TRUE;
	
	return FALSE;
}

// Kill special monster
void KillSpecialMonster(object oPC, object oMonster)
{
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, TRUE, TRUE), oMonster);
}

// Return TRUE if oPC has levels in arcane class
int GetHasArcaneClass(object oPC)
{
	if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) > 0) return TRUE;
	if (GetLevelByClass(CLASS_TYPE_SORCERER, oPC) > 0) return TRUE;
	
	return FALSE;
}

// Remove the boss' shield and make it vulnerable
void RemoveBossShield()
{
	// Remove visuals
	object oBoss = GetObjectByTag(BOSS);
	effect eVis = GetFirstEffect(oBoss);
	while (GetIsEffectValid(eVis)) {
		if ((GetEffectSpellId(eVis) == SHIELD_ID) || (GetEffectSpellId(eVis) == RESCUE_ID))
			RemoveEffect(oBoss, eVis);
		eVis = GetNextEffect(oBoss);
	}
	
	// Feedback
	AssignCommand(oBoss, SpeakString("<C=Cyan><i>*The magical shield that surrounds it disappears, leaving it vulnerable.*"));
	
	// Visuals + sound
	eVis = EffectNWN2SpecialEffectFile("fx_air_elemental_death");
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oBoss);
	SoundObjectPlay(GetObjectByTag(SHIELD_DESTROYED));
	
	// Set mortal
	SetPlotFlag(oBoss, FALSE);
}

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel)
{
	int nXP = (nLevel * (nLevel - 1) / 2) * 1000;
	return nXP;
}

// Create psioners in cages
void CreatePrisoners()
{
	object oWP;
	location lLoc;
	int i = 0;
	for (i = 0; i < TOTAL_PRISONERS; i++) {
	
		// Get location to create prisoner
		oWP = GetObjectByTag(PRISONER_WP, i);
		lLoc = GetLocation(oWP);
		
		CreateObject(OBJECT_TYPE_CREATURE, PRISONER, lLoc);
	}	
}

// Clean previously-spawned setup
void CleanLeftovers(object oArea)
{
	// Go over all objects in the area
	object oObj = GetFirstObjectInArea(oArea);
	string sTag = "";
	while (GetIsObjectValid(oObj)) {
		sTag = GetTag(oObj);
		if ((sTag == BOSS) || (sTag == UNDEAD_HAG) || (sTag == GUARD_1)
			||
			(sTag == GUARD_2) || (sTag == GUARD_3) || (sTag == MUMMY)
			||
			(sTag == PRISONER) || (sTag == CRYSTAL))
		{
			DestroyObject(oObj);
			//SendMessageToPC(GetFirstPC(), "Destryoing object " +sTag);
		}
		oObj = GetNextObjectInArea(oArea);
	}
	
	// Close and lock door
	object oDoor = GetObjectByTag(DOOR_TO_LOCK);
	AssignCommand(oDoor, ActionCloseDoor(oDoor));
	AssignCommand(oDoor, SetLocked(oDoor, TRUE));
	
	// Reset vars
	SetLocalInt(oArea, SETUP_COMPLETED, FALSE);
	SetLocalInt(oArea, TARGET_HD, 1);
	SetLocalInt(oArea, HB_COUNT, HB_VAL);
	SetLocalInt(oArea, MONSTER_COUNT, 0);
	SetLocalInt(oArea, BATTLE_STARTED, FALSE);
	SetLocalInt(oArea, SUMMON_STUFF, FALSE);	
}