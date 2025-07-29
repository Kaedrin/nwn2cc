//
// NESS V2.2 for NWN2
// Spawn Functions
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

#include "spawn_timefuncs"
#include "spawn_flags"
#include "spawn_cfg_cusflg"
#include "x0_i0_corpses"

void InitFlags(object oSpawn, string sSpawnName, string sSpawnTag);
int SetSpawns(location lBase);
string PadIntToString(int nInt, int nDigits);

void ResetSpawn(object oSpawn, int nTimeNow);
int IsRestoreBlocked(object oSpawn, location lChildLoc, int iExpireTime,
   int nTimeNow);

void SetupSpawned(object oSpawn, object oSpawned, location lHome, int nTimeNow,
   int nWalkToHome = FALSE);

void SetupCampSpawned(object oSpawn, object oSpawned, vector vCampPosition,
   location lHome, string sFlags);

// Returns new nNextSpawnTime
int SetupSpawnDelay(int nSpawnDelay, int nDelayMinimum, int nDelayRandom,
   int nTimeNow);

// Writes all the necessary info onto a spawn and its child after spawning
void RecordSpawned(object oSpawn, object oSpawned, location lHome,
   location lEntranceExit, float fSpawnedFacing);

// Saves the state of one child onto the spawn (or a camp object) for respawning
void SaveStateOnDespawn(object oSpawned, object oSpawn, int nCamp=FALSE);

// Saves a camp object onto the spawn for respawning
void SaveCampStateOnDespawn(object oCamp, object oSpawn);

// Respawns all saved children/camps
void RestorePCDespawns(object oSpawn, int nTimeNow);

void ReturnHome(location lHome);
int FindNextEmptyChildSlot(object oSpawn);

//creates a Ness object by either copying or creating and copying
object CreateNessObject(object oSpawn, int nObjectType, string sTemplate, location lLocation
                        , int nCacheCondition = 0, int nCacheBucket = 0);

//creates a Ness trap
object CreateNessTrap(object oSpawn, int nObjectType, string sTemplate, location lLocation
                        , int nTrapType, int nTrapTypeMin, int nTrapSize, int nTrapFaction
						, int nTrapDisarmScript, int nTrapTriggerScript);
						
//creates a cached object from oSpawned
void CreateCachedObject(object oSpawn, object oSpawned, int nCacheBucket = 0, int nCachedCondtion = 0);

// refcounting support

const string REFCOUNT = "RefCount";
const int bUseRefCount = TRUE;

//adds to the refcount of oCachedSpawn if not already referencd by oCounter
int AddRef(object oCachedSpawn, object oCounter);

//Reduces the refcount of oCachedSpawn(if referenced by oCounter).
//If the count drops to zero the cached spawn is destroyed
int Release(object oCachedSpawn, object oCounter);

//returns the current count of oCachedSpawn
int RefCount(object oCachedSpawn);

//hard sets the refcount, should only be used to transfer reffed counts whe
//using forced caching.
void SetRefOverride(object oCachedSpawn, int nRefCount);

//adds to a running list of templates for caches the spawn point. This
//list is used to release cached spawns when no longer in use.
void AddRefCountList(object oCounter, string sTemplate);

//returns TRUE if the template is already in the refcountlist
int TemplateInRefCountList(object oCounter, string sTemplate);

//releases all refed objects in oCounter;
void ReleaseAll(object oCounter);

//calls releaseall on every spawn in oArea
void ReleaseAreaRefs(object oArea);

// Copies an object and all reference variables
object CopyObjectAndVars(object oSource, location lLocation);

//
// Pseudo-heartbeat support
//

const string SPAWN_INTERVAL = "Spawn_Interval";
const string SPAWN_PCS_IN_AREA = "Spawn_PCsInArea";
const string SPAWN_AREA_COUNT = "AreaSpawnCount";
const string SPAWN_HEARTBEAT_SCRIPT = "SpawnHeartbeatScript";
const string SPAWN_HEARTBEAT_SCHEDULED = "SpawnHeartbeatScheduled";

// This checks conditions to determine if a pseudo-heartbeat should be called
int NeedPseudoHeartbeat( object oArea );
// ... and if it should, this schedules it.
void ScheduleNextPseudoHeartbeat( object oArea );

// Pseudo-heartbeat area enter and exit functions
void Spawn_OnAreaEnter( string sHeartbeatScript = "spawn_sample_hb",
  float fHeartbeatInterval = 6.0, float fFirstDelay = 0.0 );
void Spawn_OnAreaExit();

// Externals
void LootTable(object oSpawn, object oSpawned, int nLootTable);
effect ObjectEffect(object oSpawn);



int SPAWN_DELAY_DEBUG = FALSE;
int SPAWN_COUNT_DEBUG = FALSE;
int CONSOLE_DEBUG = TRUE;

void SpawnDelayDebug(object oSpawn, string str)
{
    if (SPAWN_DELAY_DEBUG)
    {
        WriteTimestampedLogEntry("[sd " + GetName(GetArea(oSpawn)) + "] " +
           GetLocalString(oSpawn, "f_Template") + " (" + ObjectToString(oSpawn) + "): " + str);

        if (CONSOLE_DEBUG)
        {
            SendMessageToAllDMs("[sd " + GetName(GetArea(oSpawn)) + "] "
                + GetLocalString(oSpawn, "f_Template") + " (" + ObjectToString(oSpawn) + "): " + str);
        }
    /*
        object oPC = GetFirstPC();
        if (! GetIsDM(oPC))
           SendMessageToPC(oPC, str);
    */
    }
}

void SpawnCountDebug(object oSpawn, string str)
{
    if (SPAWN_COUNT_DEBUG)
    {
        WriteTimestampedLogEntry("[sc " + GetName(GetArea(oSpawn)) + "] " +
           GetLocalString(oSpawn, "f_Template") + " (" +ObjectToString(oSpawn) + "): " + str);

        if (CONSOLE_DEBUG)
        {
            SendMessageToAllDMs("[sc " + GetName(GetArea(oSpawn)) + "] "
               + GetLocalString(oSpawn, "f_Template") + " (" +ObjectToString(oSpawn) + "): " + str);
        }
    /*
        object oPC = GetFirstPC();
        if (! GetIsDM(oPC))
           SendMessageToPC(oPC, str);
    */
    }
}

//
// Custom Functions
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
void AddChild(object oSpawn, object oSpawned);
void ReportSpawns(int nAreaSpawns, int nModuleSpawns);
void TrackModuleSpawns(int nAreaSpawnCount, int nTrackModuleSpawns);
void DumpModuleSpawns();
void DumpModuleSpawns();

//
// PC and NPC Functions
//
int CountPCsInArea(object oArea = OBJECT_INVALID, int nDM = FALSE);
int CountPCsInRadius(location lCenter, float fRadius, int nDM = FALSE);
object GetRandomPCInArea(object oArea, object oSpawn);

// This struct is returned by TransferAllInventorySlots() to return back the
// object ids of the armor, right hand weapon, and left hand weapons (if any)
// both left on the (original) corpse and copied to the lootable corpse
struct NESS_CorpseInfo
{
  object origLftWpn;
  object origRgtWpn;
  object origArmor;
  object lootLftWpn;
  object lootRgtWpn;
  object lootArmor;
};

// This is equivalent to (and adapted from) the Bioware LootInventorySlots() function.
// However, it does not schedule deletions for a hardcoded
// corpse decay time later (the corpse decay script handles those).
struct NESS_CorpseInfo TransferAllInventorySlots(object oCreature, object oTarget,
    int bDropWielded=FALSE);

int IsCreatureItem(object oItem);
void RandomWalk(object oSpawn, float fWalkingRadius, int nRun);
void FindSeat(object oSpawn, object oSpawned);

void NESS_CleanInventory(object oSpawned);
// for back compatibility (grr) will remove at some point
void CleanInventory(object oSpawned)
{
    NESS_CleanInventory(oSpawned);
}
void NESS_CleanEquipped(object oSpawned);
void NESS_CleanCorpse(object oSpawned);
object NESS_CopyCorpseItem(object oSource, object oInventory);
void StripNonDroppables(object oSpawned);
void DestroyIfNonDrop(object oItem);

//
// Date and Time Functions
//
int IsBetweenDays(int nCheckDay, int nDayStart, int nDayEnd);
int IsBetweenHours(int nCheckHour, int nHourStart, int nHourEnd);
//
// Patrol Route Functions
//
void SetPatrolRoute(int nPatrolRoute, int nStartClosest=FALSE);
void DoPatrolRoute(int nPatrolRoute, int nRouteType);
void AddPatrolStop(int nPatrolRoute, int nStopNumber, int bJump=FALSE);
void CheckForStuckPatrol(object oCreature, int nPatrolRoute, int nRouteType);

//
// Camp Functions
//
int ProcessCamp(object oCamp);
void DestroyCamp(object oCamp, float fCampDecay, int nSaveState);
//
// Outside Functions
//
void SpawnFlags(object oSpawn, int nFlagTableNumber);
//
//

// Functions for External Use.
object NESS_GetSpawnByID(int nSpawnID, object oArea);
void NESS_ActivateSpawnByID(int nSpawnID, object oAreaD);
void NESS_DeactivateSpawnByID(int nSpawnID, object oArea);
void NESS_ActivateSpawn(object oSpawn);
void NESS_DeactivateSpawn(object oSpawn);
void NESS_ForceProcess(object oSpawn);
void NESS_TrackModuleSpawns(int flag=TRUE);
int NESS_IsModuleSpawnTracking();
void NESS_DumpModuleSpawns(int flag=TRUE);
int NESS_IsModuleSpawnDumping();
void NESS_ReturnHome(object oCreature, int bRun=FALSE);
void NESS_ProcessDeadCreature(object oCreature, object oSpawn=OBJECT_INVALID);

// This Function Initializes the Flags
void InitFlags(object oSpawn, string sSpawnName, string sSpawnTag)
{
    // These are true when certain flags are present, false otherwise

    // Retreive Defaults
    object oModule = GetModule();

    // These have values associated with them, although in some cases value
    // of 0 is treated as a non-existent flag
    int dfProcessFrequency = GetLocalInt(oModule, "df_processFrequency");
    int dfProcessOffset = GetLocalInt(oModule, "df_processOffest");
    int dfInitialState = GetLocalInt(oModule, "df_InitialState");
    int dfInitialDelay = GetLocalInt(oModule, "df_InitialDelay");
    int dfFlagTableNumber = GetLocalInt(oModule, "df_FlagTableNumber");
    int dfSpawnDelay = GetLocalInt(oModule, "df_SpawnDelay");
    int dfDelayMinimum = GetLocalInt(oModule, "df_DelayMinimum");
    int dfSpawnNumber = GetLocalInt(oModule, "df_SpawnNumber");
    int dfSpawnNumberMin = GetLocalInt(oModule, "df_SpawnNumberMin");
    int dfSpawnNumberAtOnce = GetLocalInt(oModule, "df_SpawnNumberAtOnce");
    int dfSpawnNumberAtOnceMin = GetLocalInt(oModule, "df_SpawnNumberAtOnceMin");
    int dfSpawnDayStart = GetLocalInt(oModule, "df_SpawnDayStart");
    int dfSpawnDayEnd = GetLocalInt(oModule, "df_SpawnDayEnd");
    int dfSpawnHourStart = GetLocalInt(oModule, "df_SpawnHourStart");
    int dfSpawnHourEnd = GetLocalInt(oModule, "df_SpawnHourEnd");
    int dfWanderRange = GetLocalInt(oModule, "df_WanderRange");
    int dfReturnHomeRange = GetLocalInt(oModule, "df_ReturnHomeRange");
    int dfPCCheckDelay = GetLocalInt(oModule, "df_PCCheckDelay");
    int dfRandomGold = GetLocalInt(oModule, "df_RandomGold");
    int dfRandomGoldMin = GetLocalInt(oModule, "df_RandomGoldMin");
    int dfGoldChance = GetLocalInt(oModule, "df_GoldChance");
    int dfSpawnEffect = GetLocalInt(oModule, "df_SpawnEffect");
    int dfDespawnEffect = GetLocalInt(oModule, "df_DespawnEffect");
    int dfPatrolRoute = GetLocalInt(oModule, "df_PatrolRoute");
    int dfRouteType = GetLocalInt(oModule, "df_RouteType");
    int dfPlaceableType = GetLocalInt(oModule, "df_PlaceableType");
    int dfTrapDisabled = GetLocalInt(oModule, "df_TrapDisabled");
    int dfPlaceableRefreshPeriod = GetLocalInt(oModule, "df_PlaceableRefreshPeriod");
    int dfLootTable = GetLocalInt(oModule, "df_LootTable");
    int dfLootTable1ItemChance = GetLocalInt(oModule, "df_LootTable1ItemChance");
    int dfLootTable2ItemChance = GetLocalInt(oModule, "df_LootTable2ItemChance");
    int dfLootTable3ItemChance = GetLocalInt(oModule, "df_LootTable3ItemChance");
    int dfDeactivateSpawn = GetLocalInt(oModule, "df_DeactivateSpawn");
    int dfDeactivateScript = GetLocalInt(oModule, "df_DeactivateScript");
    int dfDeactivationInfo = GetLocalInt(oModule, "df_DeactivationInfo");
    int dfChildLifespanMax = GetLocalInt(oModule, "df_ChildLifespanMax");
    int dfChildLifespanMin = GetLocalInt(oModule, "df_ChildLifespanMin");
    int dfSpawnRadius = GetLocalInt(oModule, "df_SpawnRadius");
    int dfSpawnRadiusMin = GetLocalInt(oModule, "df_SpawnRadiusMin");
    int dfSpawnUnseen = GetLocalInt(oModule, "df_SpawnUnseen");
    int dfUnseenRetryCount = GetLocalInt(oModule, "df_dfUnseenRetryCount");
    int dfCorpseDecay = GetLocalInt(oModule, "df_CorpseDecay");
    int dfCorpseDecayType = GetLocalInt(oModule, "df_CorpseDecayType");
    int dfCorpseRemainsType = GetLocalInt(oModule, "df_CorpseRemainsType");
    int dfCampDecay = GetLocalInt(oModule, "df_CampDecay");
    int dfSpawnScript = GetLocalInt(oModule, "df_SpawnScript");
    int dfDespawnScript = GetLocalInt(oModule, "df_DespawnScript");
    int dfDeathScript = GetLocalInt(oModule, "df_DeathScript");
    int dfSpawnCheckCustom = GetLocalInt(oModule, "df_SpawnCheckCustom");
    int dfSpawnCheckPCs = GetLocalInt(oModule, "df_SpawnCheckPCs");
    int dfCheckPCsRadius = GetLocalInt(oModule, "f_CheckPCsRadius");
    int dfSpawnTrigger = GetLocalInt(oModule, "df_SpawnTrigger");
    int dfDespawnTrigger = GetLocalInt(oModule, "df_DespawnTrigger");
    int dfSpawnAreaEffect = GetLocalInt(oModule, "df_SpawnAreaEffect");
    int dfAreaEffectDuration = GetLocalInt(oModule, "df_AreaEffectDuration");
    int dfObjectEffect = GetLocalInt(oModule, "df_ObjectEffect");
    int dfObjectEffectDuration = GetLocalInt(oModule, "df_ObjectEffectDuration");
    int dfRandomSpawn = GetLocalInt(oModule, "df_RandomSpawn");
    int dfSpawnFaction = GetLocalInt(oModule, "df_SpawnFaction");
    int dfSpawnAlignment = GetLocalInt(oModule, "df_SpawnAlignment");
    int dfAlignmentShift = GetLocalInt(oModule, "df_AlignmentShift");
    int dfHeartbeatScript = GetLocalInt(oModule, "df_HeartbeatScript");
    int dfSpawnLocation = GetLocalInt(oModule, "df_SpawnLocation");
    int dfSpawnLocationMin = GetLocalInt(oModule, "df_SpawnLocationMin");
    int dfSpawnFacing = GetLocalInt(oModule, "df_SpawnFacing");
    int dfEntranceExit = GetLocalInt(oModule, "df_EntranceExit");
    int dfEntranceExitMin = GetLocalInt(oModule, "df_EntranceExitMin");
    int dfExit = GetLocalInt(oModule, "df_Exit");
    int dfExitMin = GetLocalInt(oModule, "df_ExitMin");
    int dfHealChildren = GetLocalInt(oModule, "df_HealChildren");
    int dfGlobalSuppressDR = GetLocalInt(oModule, "df_GlobalSuppressDR");
    int dfSuppressDR = GetLocalInt(oModule, "df_SuppressDR");
    int dfEncounterLevel = GetLocalInt(oModule, "df_EncounterLevel");
    int dfUseCache = GetLocalInt(oModule, "df_UseCache");
    int dfCacheBucket = GetLocalInt(oModule, "df_CacheBucket");
    int dfCacheCondition = GetLocalInt(oModule, "df_CacheCondition");
    int dfCacheTiming = GetLocalInt(oModule, "df_CacheTiming");

    int dfTrapType = GetLocalInt(oModule, "df_TrapType");
	int dfTrapMinType = GetLocalInt(oModule, "df_TrapMinType");
    int dfTrapSize = GetLocalInt(oModule, "df_TrapSize");
    int dfTrapFaction = GetLocalInt(oModule, "df_TrapFaction");
    int dfTrapDisarmScript = GetLocalInt(oModule, "df_TrapDisarmScript");
    int dfTrapTriggerScript = GetLocalInt(oModule, "df_TrapTriggerScrip");
    int dfTrapDetectDC = GetLocalInt(oModule, "df_TrapDetectDC");
    int dfTrapDisarmDC = GetLocalInt(oModule, "df_TrapDisarmDC");
    int dfTrapRecoverable = GetLocalInt(oModule, "df_TrapRecoverable");
	
	
    //debug("init flags: " + sSpawnName);
    SetLocalString(oSpawn, "f_Flags", sSpawnName);
    SetLocalString(oSpawn, "f_Template", sSpawnTag);

    // Initialize FlagTable
    int nFlagTable = IsFlagPresent(sSpawnName, "_FT");
    int nFlagTableNumber = GetFlagValue(sSpawnName, "_FT", dfFlagTableNumber);

    if (nFlagTable == TRUE)
    {
        SpawnFlags(oSpawn, nFlagTableNumber);
        if (GetStringLeft(GetLocalString(oSpawn, "f_Flags"), 2) == "SP")
        {
            sSpawnName = GetLocalString(oSpawn, "f_Flags");
        }
        else if (GetStringLeft(GetLocalString(oSpawn, "f_Flags"), 1) == "_")
        {
            sSpawnName = sSpawnName + GetLocalString(oSpawn, "f_Flags");
        }

        SetLocalString(oSpawn, "f_Flags", sSpawnName);
        sSpawnTag = GetLocalString(oSpawn, "f_Template");
    }

    // Initialize CustomFlag
    string sCustomFlag;
    int nCustomFlag = IsFlagPresent(sSpawnName, "CF");

    if (nCustomFlag == TRUE)
    {
        sCustomFlag = GetStringRight(sSpawnName, GetStringLength(sSpawnName) -
            (FindSubString(sSpawnName, "CF") + 2));
        sSpawnName = GetStringLeft(sSpawnName, GetStringLength(sSpawnName) -
            (GetStringLength(sCustomFlag) + 3));
        SetLocalString(oSpawn, "f_Flags", sSpawnName);

    }

    // Record CustomFlag
    SetLocalString(oSpawn, "f_CustomFlag", sCustomFlag);
    ParseCustomFlags(oSpawn, sCustomFlag);

    // Initialize Process Frequency
    int nProcessFrequency = GetFlagValue(sSpawnName, "SP", dfProcessFrequency);
    int nProcessOffset = GetSubFlagValue(sSpawnName, "SP", "O", dfProcessOffset);
    if (nProcessFrequency <= 0)
    {
        nProcessFrequency = 1;
    }

    // Record Process Frequency
    SetLocalInt(oSpawn, "f_ProcessFrequency", nProcessFrequency);
    SetLocalInt(oSpawn, "f_ProcessOffset", nProcessOffset);

    // Initialize InitialState
    int nInitialState = GetFlagValue(sSpawnName, "IS", dfInitialState);
    int nInitialDelay = GetSubFlagValue(sSpawnName, "IS", "D", dfInitialDelay);
    nInitialDelay *= 60;  // convert to seconds

    // Record InitialState
    SetLocalInt(oSpawn, "f_InitialState", nInitialState);
    SetLocalInt(oSpawn, "f_InitialDelay", nInitialDelay);

    // Initialize SpawnID
    int nSpawnID = GetFlagValue(sSpawnName, "ID", 0);

    // Record SpawnID
    if (nSpawnID > 0)
    {
        SetLocalInt(oSpawn, "SpawnID", nSpawnID);
    }

    // Initialize SpawnDelay
    int nSpawnDelay = GetFlagValue(sSpawnName, "SD", dfSpawnDelay);
    nSpawnDelay *= 60;  // convert to seconds
    int nDelayRandom = IsSubFlagPresent(sSpawnName, "SD", "M");
    int nDelayMinimum = GetSubFlagValue(sSpawnName, "SD", "M", dfDelayMinimum);
    nDelayMinimum *= 60; // convert to seconds
    int nSpawnDelayPeriodic = IsSubFlagPresent(sSpawnName, "SD", "P");

    if (nDelayMinimum > nSpawnDelay)
    {
        nDelayRandom = FALSE;
        nDelayMinimum = 0;
    }

    // Record SpawnDelay
    SetLocalInt(oSpawn, "f_SpawnDelay", nSpawnDelay);
    SetLocalInt(oSpawn, "f_DelayRandom", nDelayRandom);
    SetLocalInt(oSpawn, "f_DelayMinimum", nDelayMinimum);
    SetLocalInt(oSpawn, "f_SpawnDelayPeriodic", nSpawnDelayPeriodic);

    // Initialize SpawnNumber
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", dfSpawnNumber);
    int nSpawnNumberMax = nSpawnNumber;
    int nSpawnNumberMin = GetSubFlagValue(sSpawnName, "SN", "M", dfSpawnNumberMin);
    int nSpawnAllAtOnce = IsFlagPresent(sSpawnName, "SA");
    int nSpawnNumberAtOnce = GetFlagValue(sSpawnName, "SA", dfSpawnNumberAtOnce);
    int nSpawnNumberAtOnceMin = GetSubFlagValue(sSpawnName, "SA", "M",
       dfSpawnNumberAtOnceMin);

    if (nSpawnNumberMin > nSpawnNumber)
    {
        nSpawnNumberMin = -1;
    }
    if (nSpawnNumberMin > -1)
    {
        int nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        while (nRndSpawnNumber < nSpawnNumberMin)
        {
            nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        }
        nSpawnNumber = nRndSpawnNumber;
    }

    if (nSpawnNumberAtOnce == 1)
    {
        nSpawnAllAtOnce = FALSE;
    }
    if (nSpawnNumberAtOnceMin > nSpawnNumberAtOnce)
    {
        nSpawnNumberAtOnceMin = 0;
    }

    // Record SpawnNumber
    SetLocalInt(oSpawn, "f_SpawnNumber", nSpawnNumber);
    SetLocalInt(oSpawn, "f_SpawnNumberMin", nSpawnNumberMin);
    SetLocalInt(oSpawn, "f_SpawnNumberMax", nSpawnNumberMax);
    SetLocalInt(oSpawn, "f_SpawnAllAtOnce", nSpawnAllAtOnce);
    SetLocalInt(oSpawn, "f_SpawnNumberAtOnce", nSpawnNumberAtOnce);
    SetLocalInt(oSpawn, "f_SpawnNumberAtOnceMin", nSpawnNumberAtOnceMin);

    // Initialize Day/Night Only
    int nDayOnly = IsFlagPresent(sSpawnName, "DO");
    int nDayOnlyDespawn = IsSubFlagPresent(sSpawnName, "DO", "D");
    int nNightOnly = IsFlagPresent(sSpawnName, "NO");
    int nNightOnlyDespawn = IsSubFlagPresent(sSpawnName, "NO", "D");

    // Record Day/Night Only
    SetLocalInt(oSpawn, "f_DayOnly", nDayOnly);
    SetLocalInt(oSpawn, "f_DayOnlyDespawn", nDayOnlyDespawn);
    SetLocalInt(oSpawn, "f_NightOnly", nNightOnly);
    SetLocalInt(oSpawn, "f_NightOnlyDespawn", nNightOnlyDespawn);

    // Initialize Day/Hour Spawns
    int nSpawnDayStart = GetFlagValue(sSpawnName, "DY", dfSpawnDayStart);
    int nSpawnDayEnd = GetSubFlagValue(sSpawnName, "DY", "T", dfSpawnDayEnd);
    if (nSpawnDayEnd > nSpawnDayStart)
    {
        nSpawnDayEnd = -1;
    }
    int nSpawnHourStart = GetFlagValue(sSpawnName, "HR", dfSpawnHourStart);
    int nSpawnHourEnd = GetSubFlagValue(sSpawnName, "HR", "T", dfSpawnHourEnd);
    if (nSpawnHourStart > nSpawnHourEnd)
    {
        nSpawnHourEnd = -1;
    }

    // Record Day/Hour Spawns
    SetLocalInt(oSpawn, "f_SpawnDayStart", nSpawnDayStart);
    SetLocalInt(oSpawn, "f_SpawnDayEnd", nSpawnDayEnd);
    SetLocalInt(oSpawn, "f_SpawnHourStart", nSpawnHourStart);
    SetLocalInt(oSpawn, "f_SpawnHourEnd", nSpawnHourEnd);

    // Initialize RandomWalk
    int nRandomWalk = IsFlagPresent(sSpawnName, "RW");
    float fWanderRange = IntToFloat(GetSubFlagValue(sSpawnName, "RW", "R", dfWanderRange));

    // Record RandomWalk
    SetLocalInt(oSpawn, "f_RandomWalk", nRandomWalk);
    SetLocalFloat(oSpawn, "f_WanderRange", fWanderRange);

    // Initialize ReturnHome
    int nReturnHome = IsFlagPresent(sSpawnName, "RH");
    float fReturnHomeRange = IntToFloat(GetFlagValue(sSpawnName, "RH", dfReturnHomeRange));

    // Record ReturnHome
    SetLocalInt(oSpawn, "f_ReturnHome", nReturnHome);
    SetLocalFloat(oSpawn, "f_ReturnHomeRange", fReturnHomeRange);

    // Initialize PCCheck
    int nPCCheck = IsFlagPresent(sSpawnName, "PC");
    int nPCCheckDelay = GetFlagValue(sSpawnName, "PC", dfPCCheckDelay);
    nPCCheckDelay *= 60; // convert to seconds
    int nPCReset = IsSubFlagPresent(sSpawnName, "PC", "R");

    // Record PCCheck
    SetLocalInt(oSpawn, "f_PCCheck", nPCCheck);
    SetLocalInt(oSpawn, "f_PCCheckDelay", nPCCheckDelay);
    SetLocalInt(oSpawn, "f_PCReset", nPCReset);

    // Initialize RandomGold
    int nRandomGold = GetFlagValue(sSpawnName, "RG", dfRandomGold);
    int nRandomGoldMin = GetSubFlagValue(sSpawnName, "RG", "M", dfRandomGoldMin);
    int nGoldChance = GetSubFlagValue(sSpawnName, "RG", "C", dfGoldChance);

    // Record RandomGold
    SetLocalInt(oSpawn, "f_RandomGold", nRandomGold);
    SetLocalInt(oSpawn, "f_RandomGoldMin", nRandomGoldMin);
    SetLocalInt(oSpawn, "f_GoldChance", nGoldChance);

    // Initialize SpawnEffects
    int nSpawnEffect = GetFlagValue(sSpawnName, "FX", dfSpawnEffect);
    int nDespawnEffect = GetSubFlagValue(sSpawnName, "FX", "D", dfDespawnEffect);

    // Record SpawnEffects
    SetLocalInt(oSpawn, "f_SpawnEffect", nSpawnEffect);
    SetLocalInt(oSpawn, "f_DespawnEffect", nDespawnEffect);

    // Initialize PatrolRoutes
    int nPatrolRoute = GetFlagValue(sSpawnName, "PR",  dfPatrolRoute);
    int nRouteType = GetSubFlagValue(sSpawnName, "PR", "T", dfRouteType);
    int nStartAtClosest = IsSubFlagPresent(sSpawnName, "PR", "C");

    // Record PatrolRoutes
    SetLocalInt(oSpawn, "f_PatrolRoute", nPatrolRoute);
    SetLocalInt(oSpawn, "f_RouteType", nRouteType);
    SetLocalInt(oSpawn, "f_PatrolStartAtClosest", nStartAtClosest);

    // Initialize Placeables
    int nPlaceable = IsFlagPresent(sSpawnName, "PL");
    int nPlaceableType = GetFlagValue(sSpawnName, "PL", dfPlaceableType);
    int nTrapDisabled = GetSubFlagValue(sSpawnName, "PL", "T",  dfTrapDisabled);
    int nPlaceableRefreshPeriod = GetSubFlagValue(sSpawnName, "PL",  "P",  dfPlaceableRefreshPeriod);
    nPlaceableRefreshPeriod *= 60; // convert to seconds

    // Record Placeables
    SetLocalInt(oSpawn, "f_Placeable", nPlaceable);
    SetLocalInt(oSpawn, "f_PlaceableType", nPlaceableType);
    SetLocalInt(oSpawn, "f_TrapDisabled", nTrapDisabled);
    SetLocalInt(oSpawn, "f_PlaceableRefreshPeriod", nPlaceableRefreshPeriod);

    // Initialize SpawnGroups
    int nSpawnGroup = IsFlagPresent(sSpawnName, "SG");

    // Record SpawnGroups
    SetLocalInt(oSpawn, "f_SpawnGroup", nSpawnGroup);

    // Initialize LootTable
    int nLootTable = GetFlagValue(sSpawnName, "LT", dfLootTable);
    int nLootTable1ItemChance = GetSubFlagValue(sSpawnName, "LT", "A", dfLootTable1ItemChance);
    int nLootTable2ItemChance = GetSubFlagValue(sSpawnName, "LT", "B", dfLootTable2ItemChance);
    int nLootTable3ItemChance = GetSubFlagValue(sSpawnName, "LT", "C", dfLootTable3ItemChance);

    if (nLootTable1ItemChance > 100) nLootTable1ItemChance = 100;
    if (nLootTable2ItemChance > 100) nLootTable2ItemChance = 100;
    if (nLootTable3ItemChance > 100) nLootTable3ItemChance = 100;

    // Record LootTable
    SetLocalInt(oSpawn, "f_LootTable", nLootTable);
    SetLocalInt(oSpawn, "f_LootTable1ItemChance", nLootTable1ItemChance);
    SetLocalInt(oSpawn, "f_LootTable2ItemChance", nLootTable2ItemChance);
    SetLocalInt(oSpawn, "f_LootTable3ItemChance", nLootTable3ItemChance);

    // Initialize SpawnDeactivation
    int nDeactivateSpawn = GetFlagValue(sSpawnName, "DS", dfDeactivateSpawn);
    int nDeactivateScript = GetSubFlagValue(sSpawnName, "DS", "S", dfDeactivateScript);
    int nDeactivationInfo = GetFlagValue(sSpawnName, "DI", dfDeactivationInfo);

    // Record SpawnDeactivations
    SetLocalInt(oSpawn, "f_DeactivateSpawn", nDeactivateSpawn);
    SetLocalInt(oSpawn, "f_DeactivateScript", nDeactivateScript);

    if (nDeactivateSpawn == 4)
    {
        nDeactivationInfo *= 60; // convert minutes to seconds
    }
    else if (nDeactivateSpawn == 5)
    {
        nDeactivationInfo *= 6; // convert cycles to seconds
    }

    SetLocalInt(oSpawn, "f_DeactivationInfo", nDeactivationInfo);

    // Initialize ChildLifespan
    int nChildLifespanMax = GetFlagValue(sSpawnName, "CL", dfChildLifespanMax);
    nChildLifespanMax *= 60;  // convert to seconds
    int nChildLifespanMin = GetSubFlagValue(sSpawnName, "CL", "M", dfChildLifespanMin);
    nChildLifespanMin *= 60; // convert to seconds
    if (nChildLifespanMin > nChildLifespanMax)
    {
        nChildLifespanMin = -1;
    }

    // Record ChildLifespan
    SetLocalInt(oSpawn, "f_ChildLifespanMax", nChildLifespanMax);
    SetLocalInt(oSpawn, "f_ChildLifespanMin", nChildLifespanMin);

    // Initialize SpawnRadius
    float fSpawnRadius = IntToFloat(GetFlagValue(sSpawnName, "SR", dfSpawnRadius));
    float fSpawnRadiusMin = IntToFloat(GetSubFlagValue(sSpawnName, "SR", "M", dfSpawnRadiusMin));
    int nSpawnNearPCs = IsSubFlagPresent(sSpawnName, "SR", "P");
    if (fSpawnRadiusMin > fSpawnRadius)
    {
        fSpawnRadiusMin = 0.0;
    }

    // Record SpawnRadius
    SetLocalFloat(oSpawn, "f_SpawnRadius", fSpawnRadius);
    SetLocalFloat(oSpawn, "f_SpawnRadiusMin", fSpawnRadiusMin);
    SetLocalInt(oSpawn, "f_SpawnNearPCs", nSpawnNearPCs);

    // Initialize SpawnUnseen
    float fSpawnUnseen = IntToFloat(GetFlagValue(sSpawnName, "SU", dfSpawnUnseen));

    int nUnseenIndividual = IsSubFlagPresent(sSpawnName, "SU", "I");
    int nUnseenRetryCount = GetSubFlagValue(sSpawnName, "SU", "I", dfUnseenRetryCount);

    // Record SpawnUnseen
    SetLocalFloat(oSpawn, "f_SpawnUnseen", fSpawnUnseen);
    SetLocalInt(oSpawn, "f_UnseenIndividual", nUnseenIndividual);
    SetLocalInt(oSpawn, "f_UnseenRetryCount", nUnseenRetryCount);

    // Initialize CorpseDecay
    float fCorpseDecay = IntToFloat(GetFlagValue(sSpawnName, "CD", dfCorpseDecay));
    int nCorpseDecayType = GetSubFlagValue(sSpawnName, "CD", "T", dfCorpseDecayType);
    int nCorpseRemainsType = GetSubFlagValue(sSpawnName, "CD", "R", dfCorpseRemainsType);
    int bDropWielded = IsSubFlagPresent(sSpawnName, "CD", "D");

    string sCorpseRemainsResRef;
    int bDeleteLootOnDecay = FALSE;

    switch (nCorpseRemainsType)
    {
        case 0: sCorpseRemainsResRef = "invis_corpse_obj"; break;
        case 1: sCorpseRemainsResRef = "invis_corpse_bdy"; break;
        case 2: sCorpseRemainsResRef = "invis_corpse_bon"; break;
        case 3: sCorpseRemainsResRef = "invis_corpse_pot"; break;
        case 4: sCorpseRemainsResRef = "invis_corpse_pch"; break;
        case 5: sCorpseRemainsResRef = "invis_corpse_scr"; break;
        case 6: sCorpseRemainsResRef = "invis_corpse_tre"; break;
        case 7:
            sCorpseRemainsResRef = "invis_corpse_obj";
            bDeleteLootOnDecay = TRUE;
            break;
    }

    // Record CorpseDecay
    SetLocalFloat(oSpawn, "f_CorpseDecay", fCorpseDecay);
    SetLocalInt(oSpawn, "f_CorpseDecayType", nCorpseDecayType);
    SetLocalString(oSpawn, "f_CorpseRemainsResRef", sCorpseRemainsResRef);
    SetLocalInt(oSpawn, "f_CorpseDropWielded", bDropWielded);
    SetLocalInt(oSpawn, "f_CorpseDeleteLootOnDecay", bDeleteLootOnDecay);

    // Initialize SpawnCamp
    int nSpawnCamp = IsFlagPresent(sSpawnName, "CM");
    float fCampDecay = IntToFloat(GetSubFlagValue(sSpawnName, "CM", "D", dfCampDecay));

    // Record SpawnCamp
    SetLocalInt(oSpawn, "f_SpawnCamp", nSpawnCamp);
    SetLocalFloat(oSpawn, "f_CampDecay", fCampDecay);

    // Initialize Spawn Scripts
    int nSpawnScript = GetFlagValue(sSpawnName, "SS", dfSpawnScript);
    int nDespawnScript = GetSubFlagValue(sSpawnName, "SS", "D", dfDespawnScript);

    // Record Spawn Scripts
    SetLocalInt(oSpawn, "f_SpawnScript", nSpawnScript);
    SetLocalInt(oSpawn, "f_DespawnScript", nDespawnScript);

    // Initialize Death Scripts
    int nDeathScript = GetFlagValue(sSpawnName, "DT", dfDeathScript);

    // Record Death Scripts
    SetLocalInt(oSpawn, "f_DeathScript", nDeathScript);

    // Initialize SpawnCheckCustom
    int nSpawnCheckCustom = GetFlagValue(sSpawnName, "CC", dfSpawnCheckCustom);

    // Record SpawnCheckCustom
    SetLocalInt(oSpawn, "f_SpawnCheckCustom", nSpawnCheckCustom);

    // Initialize SpawnCheckPCs
    int nSpawnCheckPCs = GetFlagValue(sSpawnName, "CP", dfSpawnCheckPCs);
    float fCheckPCsRadius = IntToFloat(GetSubFlagValue(sSpawnName, "CP", "R", dfCheckPCsRadius));

    // Record SpawnCheckPCs
    SetLocalInt(oSpawn, "f_SpawnCheckPCs", nSpawnCheckPCs);
    SetLocalFloat(oSpawn, "f_CheckPCsRadius", fCheckPCsRadius);

    // Intialize SpawnTrigger
    float fSpawnTrigger = IntToFloat(GetFlagValue(sSpawnName, "TR", dfSpawnTrigger));
    float fDespawnTrigger = IntToFloat(GetSubFlagValue(sSpawnName, "TR", "D", dfDespawnTrigger));

    // Record SpawnTrigger
    SetLocalFloat(oSpawn, "f_SpawnTrigger", fSpawnTrigger);
    SetLocalFloat(oSpawn, "f_DespawnTrigger", fDespawnTrigger);

    // Initialize AreaEffect
    int nSpawnAreaEffect = GetFlagValue(sSpawnName, "AE", dfSpawnAreaEffect);
    float fAreaEffectDuration = IntToFloat(GetSubFlagValue(sSpawnName, "AE", "D", dfAreaEffectDuration));

    // Record AreaEffect
    SetLocalInt(oSpawn, "f_SpawnAreaEffect", nSpawnAreaEffect);
    SetLocalFloat(oSpawn, "f_AreaEffectDuration", fAreaEffectDuration);

    // Initialize ObjectEffect
    int nObjectEffect = GetFlagValue(sSpawnName, "OE", dfObjectEffect);
    float fObjectEffectDuration = IntToFloat(GetSubFlagValue(sSpawnName, "OE", "D", dfObjectEffectDuration));
    if (fObjectEffectDuration == 0.0)
    {
        fObjectEffectDuration = -1.0;
    }

    // Record ObjectEffect
    SetLocalInt(oSpawn, "f_ObjectEffect", nObjectEffect);
    SetLocalFloat(oSpawn, "f_ObjectEffectDuration", fObjectEffectDuration);

    // Initialize RandomSpawn
    int nRandomSpawn = GetFlagValue(sSpawnName, "RS", dfRandomSpawn);

    // Record RandomSpawn
    SetLocalInt(oSpawn, "f_RandomSpawn", nRandomSpawn);

    // Initialize SpawnFaction
    int nSpawnFaction = GetFlagValue(sSpawnName, "FC", dfSpawnFaction);

    // Record SpawnFaction
    SetLocalInt(oSpawn, "f_SpawnFaction", nSpawnFaction);

    // Initialize SpawnAlignment
    int nSpawnAlignment = GetFlagValue(sSpawnName, "AL", dfSpawnAlignment);
    int nAlignmentShift = GetSubFlagValue(sSpawnName, "AL", "S", dfAlignmentShift);

    // Record SpawnAlignment
    SetLocalInt(oSpawn, "f_SpawnAlignment", nSpawnAlignment);
    SetLocalInt(oSpawn, "f_AlignmentShift", nAlignmentShift);

    // Initialize Heartbeat
    int nHeartbeatScript = GetFlagValue(sSpawnName, "HB", dfHeartbeatScript);

    // Record HeartBeat
    SetLocalInt(oSpawn, "f_HeartbeatScript", nHeartbeatScript);

    // Initialize SpawnLocation
    int nSpawnLocation = GetFlagValue(sSpawnName, "SL", dfSpawnLocation);
    int nSpawnLocationMin = GetSubFlagValue(sSpawnName, "SL", "R", dfSpawnLocationMin);
    int nSpawnLocationInd = IsSubFlagPresent(sSpawnName, "SL", "I");
    if (nSpawnLocationMin > nSpawnLocation)
    {
        nSpawnLocationMin = -1;
    }

    // Record SpawnLocation
    SetLocalInt(oSpawn, "f_SpawnLocation", nSpawnLocation);
    SetLocalInt(oSpawn, "f_SpawnLocationMin", nSpawnLocationMin);
    SetLocalInt(oSpawn, "f_SpawnLocationInd", nSpawnLocationInd);

    // Initialize SpawnFacing
    float fSpawnFacing;
    int nSpawnFacing = IsFlagPresent(sSpawnName, "SF");
    if (nSpawnFacing == TRUE)
    {
        fSpawnFacing = GetFacingFromLocation(GetLocation(oSpawn));
    }
    else
    {
        // If f_Facing is false, fSpawnFacing is now calculated for
        // each individual creature
        fSpawnFacing = 0.0;
        // fSpawnFacing = IntToFloat(Random(360));
    }

    // Record SpawnFacing
    SetLocalInt(oSpawn, "f_Facing", nSpawnFacing);
    SetLocalFloat(oSpawn, "f_SpawnFacing", fSpawnFacing);

    // Initialize EntranceExit
    int nEntranceExit = GetFlagValue(sSpawnName, "EE", dfEntranceExit);
    int nEntranceExitMin = GetSubFlagValue(sSpawnName, "EE", "R", dfEntranceExitMin);
    if (nEntranceExitMin > nEntranceExit)
    {
        nEntranceExitMin = -1;
    }
    int nExit = GetFlagValue(sSpawnName, "EX", dfExit);
    int nExitMin = GetSubFlagValue(sSpawnName, "EX", "R", dfExitMin);
    if (nExitMin > nExit)
    {
        nExitMin = -1;
    }

    // Record EntranceExit
    SetLocalInt(oSpawn, "f_EntranceExit", nEntranceExit);
    SetLocalInt(oSpawn, "f_EntranceExitMin", nEntranceExitMin);
    SetLocalInt(oSpawn, "f_Exit", nExit);
    SetLocalInt(oSpawn, "f_ExitMin", nExitMin);

    // Initialize HealChildren
    int nHealChildren = GetFlagValue(sSpawnName, "HL", dfHealChildren);
    int nHealEffects = IsSubFlagPresent(sSpawnName, "HL", "E");
    if (nHealChildren == 1)
    {
        nHealChildren == 100;
    }

    // Record HealChildren
    SetLocalInt(oSpawn, "f_HealChildren", nHealChildren);
    SetLocalInt(oSpawn, "f_HealEffects", nHealEffects);

    // Initialize SpawnItem
    int nSpawnItem = IsFlagPresent(sSpawnName, "IT");

    // Record SpawnItem
    SetLocalInt(oSpawn, "f_SpawnItem", nSpawnItem);

    // Initialize SpawnSit
    int nSpawnSit = IsFlagPresent(sSpawnName, "ST");

    // Record SpawnSit
    SetLocalInt(oSpawn, "f_SpawnSit", nSpawnSit);

    // Initialize SpawnPlot
    int nSpawnPlot = IsFlagPresent(sSpawnName, "PT");

    // Record SpawnPlot
    SetLocalInt(oSpawn, "f_SpawnPlot", nSpawnPlot);

    // Initialize SpawnMerchant
    int nSpawnMerchant = IsFlagPresent(sSpawnName, "SM");

    // Record SpawnMerchant
    SetLocalInt(oSpawn, "f_SpawnMerchant", nSpawnMerchant);

	// Initialize SpawnIllumination
    int nSpawnIllumination = IsFlagPresent(sSpawnName, "SI");
    // Record SpawnIllumination
    SetLocalInt(oSpawn, "f_SpawnIllumination", nSpawnIllumination);

	// Initialize SpawnEffect (placed Effect)
    int nSpawnPlacedEffect = IsFlagPresent(sSpawnName, "SE");
    // Record SpawnPlacedEffect
    SetLocalInt(oSpawn, "f_SpawnPlacedEffect", nSpawnPlacedEffect);

	// Initialize SpawnDoor
    int nSpawnDoor = IsFlagPresent(sSpawnName, "DR");
    // Record SpawnPlacedEffect
    SetLocalInt(oSpawn, "f_SpawnDoor", nSpawnDoor);

    // Initialize Traps
    int nSpawnTrap = IsFlagPresent(sSpawnName, "TP");
    int nTrapType = GetFlagValue(sSpawnName, "TP", dfTrapType);
	int nTrapMinType = GetSubFlagValue(sSpawnName, "TP", "M", dfTrapMinType);
    int nTrapSize = GetSubFlagValue(sSpawnName, "TP", "S",  dfTrapSize);
    int nTrapFaction = GetSubFlagValue(sSpawnName, "TP", "F",  dfTrapFaction);
    int nTrapDisarmScript = GetSubFlagValue(sSpawnName, "TP", "D",  dfTrapDisarmScript);
    int nTrapTriggerScript = GetSubFlagValue(sSpawnName, "TP", "T",  dfTrapTriggerScript);
    int nTrapDetectDC = GetSubFlagValue(sSpawnName, "TP", "A",  dfTrapDetectDC);
    int nTrapDisarmDC = GetSubFlagValue(sSpawnName, "TP", "B",  dfTrapDisarmDC);
    int nTrapRecoverable = GetSubFlagValue(sSpawnName, "TP", "R",  dfTrapRecoverable);
	
	//record Traps
    SetLocalInt(oSpawn, "f_SpawnTrap", nSpawnTrap);
    SetLocalInt(oSpawn, "f_TrapType", nTrapType);
    SetLocalInt(oSpawn, "f_TrapMinType", nTrapMinType);    
	SetLocalInt(oSpawn, "f_TrapSize", nTrapSize);
    SetLocalInt(oSpawn, "f_TrapFaction", nTrapFaction);
    SetLocalInt(oSpawn, "f_TrapDisarmScript", nTrapDisarmScript);
    SetLocalInt(oSpawn, "f_TrapTriggerScrip", nTrapTriggerScript);
    SetLocalInt(oSpawn, "f_TrapDetectDC", nTrapDetectDC);
    SetLocalInt(oSpawn, "f_TrapDisarmDC", nTrapDisarmDC);
    SetLocalInt(oSpawn, "f_TrapRecoverable", nTrapRecoverable);

	
    // Initialize Dim Returns Suppression
    int nSuppressDimReturns = IsFlagPresent(sSpawnName, "SX");

    if (nSuppressDimReturns)
    {
      // If the flag is present, get suppression mode from its value
      nSuppressDimReturns = GetFlagValue(sSpawnName, "SX", dfSuppressDR);
    }

    else
    {
      // Use the global setting
      nSuppressDimReturns = dfGlobalSuppressDR;
    }

    // Record Dim Returns Suppression
    SetLocalInt(oSpawn, "f_SuppressDimReturns", nSuppressDimReturns);

    // Initialize Loot Suppression
    int nSuppressLooting = IsFlagPresent(sSpawnName, "NL");

    // Record Loot Suppression
    SetLocalInt(oSpawn, "f_SuppressLooting", nSuppressLooting);

    // Initialize Subdual Mode
    int nSubdualMode = IsFlagPresent(sSpawnName, "SB");

    // Record Subdual Mode
    SetLocalInt(oSpawn, "f_SubdualMode", nSubdualMode);

    int nEncounterLevel;

    // Initialize Encounter Level
    if (IsFlagPresent(sSpawnName, "EL"))
    {
      nEncounterLevel = GetFlagValue(sSpawnName, "EL", dfEncounterLevel);
      SetLocalInt(oSpawn, "f_EncounterLevel", nEncounterLevel);
    }

    int nUseCache;
    int nCacheBucket;
    int nCacheCondition;
    int nCacheTiming;

    //iniitialize Cached Spawning
    if(IsFlagPresent(sSpawnName, "CS") || 0 != dfUseCache)
    {
        nCacheBucket = GetFlagValue(sSpawnName, "CS", dfCacheBucket);
        nCacheCondition = GetSubFlagValue(sSpawnName, "CS", "C", dfCacheCondition);
        nCacheTiming = GetSubFlagValue(sSpawnName, "CS", "T", dfCacheTiming);

        SetLocalInt(oSpawn, "f_UseCache", TRUE);
        SetLocalInt(oSpawn, "f_CacheBucket", nCacheBucket);
        SetLocalInt(oSpawn, "f_CacheCondition", nCacheCondition);
        SetLocalInt(oSpawn, "CacheTiming", nCacheTiming);
    }

    // Record Flags Initialized
    SetLocalInt(oSpawn, "FlagsInitialized", TRUE);
}
//

// This Function Sets the Spawns
int SetSpawns(location lBase)
{
    string sSpawnName, sSpawnNum, sSpawnTag;
    int nNth = 1;
    int nSpawnNum = 0;

    // Enumerate Waypoints in the Area
    object oSpawn = GetFirstObjectInArea(OBJECT_SELF);
    while (oSpawn != OBJECT_INVALID)
    {
        // Check for a local string called "NESS" on the waypoint
        // first.  If it exists, use it instead of the name
        sSpawnName = GetLocalString(oSpawn, "NESS");

        if (GetStringLeft(sSpawnName, 2) != "SP")
        {
            // Retrieve Name
            sSpawnName = GetName(oSpawn);
        }

        // Check if Waypoint is a Spawn Controller
        if (GetStringLeft(sSpawnName, 2) == "SP")
        {
            // Set Spawn
            nSpawnNum++;
            sSpawnNum = "Spawn" + PadIntToString(nSpawnNum, 2);
            SetLocalObject(OBJECT_SELF, sSpawnNum, oSpawn);


            sSpawnTag = GetLocalString(oSpawn, "NESS_TAG");
            if (sSpawnTag == "")
            {
              sSpawnTag = GetTag(oSpawn);
            }

            DelayCommand(0.0, InitFlags(oSpawn, sSpawnName, sSpawnTag));
        }
        nNth++;
        oSpawn = GetNextObjectInArea(OBJECT_SELF);
    }
    SetLocalInt(OBJECT_SELF, "Spawns", nSpawnNum);
    return nSpawnNum;
}
//

// This Function returns the Number of PCs in an Area
int CountPCsInArea(object oArea = OBJECT_INVALID, int nDM = FALSE)
    {
    int retVal = 0;
    if (oArea == OBJECT_INVALID)
    {
        oArea = GetArea(OBJECT_SELF);
    }
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        if (GetArea(oPC) == oArea)
        {
            if (GetIsDM(oPC) == TRUE)
            {
                if (nDM == TRUE)
                {
                    retVal++;
                }
            }
            else
            {
                retVal++;
            }
        }
        oPC = GetNextPC();
    }
    return retVal;
}
//

// This Function Returns the Number of PCs in a Radius
int CountPCsInRadius(location lCenter, float fRadius, int nDM = FALSE)
{
    int nPCs = 0;
    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lCenter, FALSE,
      OBJECT_TYPE_ALL);

    while (oPC != OBJECT_INVALID)
    {
        if (GetIsPC(oPC))
        {
            if (GetIsDM(oPC))
            {
                //debug(GetName(oPC) + " is a DM ");
                if (nDM == TRUE)
                {
                    nPCs++;
                }
            }
            else
            {
                //debug("found a real PC");
                nPCs++;
            }
        }

        oPC = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lCenter, FALSE,
            OBJECT_TYPE_ALL);
    }
    return nPCs;
}
//

int IsCreatureItem(object oItem)
{
    if (GetBaseItemType(oItem) == BASE_ITEM_CREATUREITEM ||
        GetBaseItemType(oItem) == BASE_ITEM_CBLUDGWEAPON ||
        GetBaseItemType(oItem) == BASE_ITEM_CPIERCWEAPON ||
        GetBaseItemType(oItem) == BASE_ITEM_CSLASHWEAPON ||
        GetBaseItemType(oItem) == BASE_ITEM_CSLSHPRCWEAP)
    {
        return TRUE;
    }

    return FALSE;
}

// This Function Returns a Random PC from Area
object GetRandomPCInArea(object oArea, object oSpawn)
{
    int nPCsInArea = CountPCsInArea(oArea, TRUE);
    int nNth = Random(nPCsInArea) + 1;
    object oRandomPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSpawn, nNth);
    return oRandomPC;
}

object NESS_CopyCorpseItem(object oSource, object oInventory)
{
    int bWasPlot = GetPlotFlag(oSource);
    object oNewItem = CopyItem(oSource, oInventory);
    if (bWasPlot == TRUE)
    {
        SetPlotFlag(oNewItem,TRUE);
    }

    return oNewItem;
}

//
struct NESS_CorpseInfo TransferAllInventorySlots(object oVictim,
    object oCorpse, int bDropWielded=FALSE)
{
    int i=0;
    object oItem = OBJECT_INVALID;
    location locItem;
    struct NESS_CorpseInfo stCorpseInfo;

    // Initialize
    stCorpseInfo.origRgtWpn = OBJECT_INVALID;
    stCorpseInfo.origLftWpn = OBJECT_INVALID;
    stCorpseInfo.origArmor = OBJECT_INVALID;
    stCorpseInfo.lootRgtWpn = OBJECT_INVALID;
    stCorpseInfo.lootLftWpn = OBJECT_INVALID;
    stCorpseInfo.lootArmor = OBJECT_INVALID;

    for (i=0; i < NUM_INVENTORY_SLOTS; i++)
    {
        oItem = GetItemInSlot(i, oVictim);

        // See if we're going to allow looting of this item.
        if (GetIsObjectValid(oItem) && GetDroppableFlag(oItem))
        {
            // Handle different items slightly differently.

            if (i == INVENTORY_SLOT_CHEST && GetIsVictimDressed(oVictim))
            {
                // The victim is wearing the armor. We don't want to destroy
                // it while the corpse is around, since that would leave the
                // body naked.
                stCorpseInfo.origArmor = oItem;
                stCorpseInfo.lootArmor = NESS_CopyCorpseItem(oItem, oCorpse);
            }

            else if (i == INVENTORY_SLOT_RIGHTHAND)
            {
                if (bDropWielded)
                {
                    // This is a wielded item. Drop it nearby.
                    locItem = GetStepRightLocation(oVictim);
                    CreateObject(OBJECT_TYPE_ITEM, GetResRef(oItem), locItem);
                    DestroyObject(oItem, 0.1);
                }

                else
                {
                    stCorpseInfo.origRgtWpn = oItem;
                    stCorpseInfo.lootRgtWpn = NESS_CopyCorpseItem(oItem, oCorpse);
                }

            }

            else if (i == INVENTORY_SLOT_LEFTHAND)
            {
                if(bDropWielded)
                {
                    // This is a wielded item. Drop it nearby.
                    locItem = GetStepLeftLocation(oVictim);
                    CreateObject(OBJECT_TYPE_ITEM, GetResRef(oItem), locItem);
                    DestroyObject(oItem, 0.1);
                }

                else
                {
                    stCorpseInfo.origLftWpn = oItem;
                    stCorpseInfo.lootLftWpn = NESS_CopyCorpseItem(oItem, oCorpse);
                }
            }

            else
            {
                NESS_CopyCorpseItem(oItem, oCorpse);
                DestroyObject(oItem, 0.1);
            }
        }
    }
    return stCorpseInfo;
}

//

// This Function Checks if the Party is within fDistance Meters of Each Other
int IsPartyTogether(object oPC, float fDistance)
{
    int nTogether = TRUE;
    object oMember = GetFirstFactionMember(oPC, TRUE);
    while (oMember != OBJECT_INVALID)
    {
        if (GetIsDead(oMember) == FALSE)
        {
            if (GetDistanceBetween(oPC, oMember) > fDistance)
            {
                nTogether = FALSE;
                oMember = OBJECT_INVALID;
            }
        }
        oMember = GetNextFactionMember(oPC, TRUE);
    }
    return nTogether;
}
//

// This Function Returns the Number of PCs in a Party
int CountMembersInParty(object oPC, int bPCOnly = TRUE)
{
    int nCount;
    object oMember = GetFirstFactionMember(oPC, bPCOnly);
    while (oMember != OBJECT_INVALID)
    {
        nCount++;
        oMember = GetNextFactionMember(oPC, bPCOnly);
    }
    return nCount;
}
//

// This Function Checks if nCheckDay is Between Days
int IsBetweenDays(int nCheckDay, int nDayStart, int nDayEnd)
{
    if (nDayEnd > -1)
    {
        if (nCheckDay >= nDayStart && nCheckDay <= nDayEnd)
        {
            return TRUE;
        }
    }
    else
    {
        if (nCheckDay == nDayStart)
        {
            return TRUE;
        }
    }

    return FALSE;
}
//

// This Function Checks if nCheckHour is Between Hours
int IsBetweenHours(int nCheckHour, int nHourStart, int nHourEnd)
{
    if (nHourEnd > -1)
    {
        if (nCheckHour >= nHourStart && nCheckHour <= nHourEnd)
        {
            return TRUE;
        }
    }
    else
    {
        if (nCheckHour == nHourStart)
        {
            return TRUE;
        }
    }

    return FALSE;
}
//

// This Function Pads an IntToString with 0s
string PadIntToString(int nInt, int nDigits)
{
    string sRetString;
    string sTempInt = IntToString(nInt);
    int iCount;

    sRetString = "";
    for (iCount = 1; iCount <= (nDigits - GetStringLength(sTempInt)); iCount++)
    {
        sRetString = sRetString + "0";
    }
    sRetString = sRetString + sTempInt;
    return sRetString;
}
//

// This Function returns a Child Object by Tag
object GetChildByTag(object oSpawn, string sChildTag)
{
    object oChild;
    object oRetChild = OBJECT_INVALID;
    string sChildSlot;
    int nChildSlot;

    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", 1);

    // Cycle through Children
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child

        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);
        if (GetTag(oChild) == sChildTag)
        {
            oRetChild = oChild;
        }
    }

    return oRetChild;
}
//

// This Function returns a Child Object by Slot Number
object GetChildByNumber(object oSpawn, int nChildNum)
{
    object oRetChild = OBJECT_INVALID;
    string sChildSlot;

    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", 1);

    // Check if Valid Number
    if (nChildNum > nSpawnNumber)
    {
        return oRetChild;
    }

    // Retrieve Child
    sChildSlot = "ChildSlot" + PadIntToString(nChildNum, 2);
    oRetChild = GetLocalObject(oSpawn, sChildSlot);

    // Return Child
    return oRetChild;
}
//
object NESS_GetSpawnByID(int nSpawnID, object oArea)
{
    string sSpawnName;
    object oRetSpawn;

    // Enumerate Waypoints in the Area
    object oSpawn = GetFirstObjectInArea(oArea);
    while (oSpawn != OBJECT_INVALID)
    {
        // Retrieve Name
        sSpawnName = GetLocalString(oSpawn, "f_Flags");

        // Check if Waypoint is a Spawn Controller
        if (GetStringLeft(sSpawnName, 2) == "SP")
        {
            if (GetLocalInt(oSpawn, "SpawnID") == nSpawnID)
            {
                oRetSpawn = oSpawn;
            }
        }
        oSpawn = GetNextObjectInArea(oArea);
    }
    return oRetSpawn;
}
//

// This Function returns a Spawn Object by ID
object GetSpawnByID(int nSpawnID)
{
    return NESS_GetSpawnByID(nSpawnID, OBJECT_SELF);
}
//

// This Function Sets Children to Despawn
void DespawnChildren(object oSpawn)
{
    object oChild;
    string sChildSlot;
    int nChildSlot;

    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", 1);

    // Cycle through Children
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child

        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);
        SetLocalInt(oChild, "ForceDespawn", TRUE);
    }
}
//

// This Function Sets Children to Despawn by Tag
void DespawnChildrenByTag(object oSpawn, string sChildTag)
{
    object oChild;
    string sChildSlot;
    int nChildSlot;

    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", 1);

    // Cycle through Children
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child

        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);
        if (GetTag(oChild) == sChildTag)
        {
            SetLocalInt(oChild, "ForceDespawn", TRUE);
        }
    }
}
//

// This Function Adds a Child to a Spawn
void AddChild(object oSpawn, object oSpawned)
{
    // Declare Variables
    int nEmptyChildSlot, nChildSlot;
    int nSpawnNumber, nSpawnCount, nChildrenSpawned;
    string sChildSlot, sEmptyChildSlot;
    object oChild;

    // Retreive Values
    nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

    // Find Empty Child Slot
    nEmptyChildSlot = 0;
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);

        // Check if this is Child Slot is Valid
        if (GetIsObjectValid(oChild) == FALSE || GetIsDead(oChild))
        {
            // Empty Slot
            if (nEmptyChildSlot == 0)
            {
                nEmptyChildSlot = nChildSlot;
                sEmptyChildSlot = sChildSlot;
            }
        }
    }

    if (nEmptyChildSlot != 0)
    {
        // Assign Values to oSpawned
        SetLocalObject(oSpawned, "ParentSpawn", oSpawn);
        SetLocalFloat(oSpawned, "HomeX", GetPositionFromLocation(GetLocation(oSpawned)).x);
        SetLocalFloat(oSpawned, "HomeY", GetPositionFromLocation(GetLocation(oSpawned)).y);

        // Assign Child Slot
        SetLocalObject(oSpawn, sEmptyChildSlot, oSpawned);
        SetLocalString(oSpawned, "ParentChildSlot", sEmptyChildSlot);

        // Assign Values to oSpawn
        nChildrenSpawned++;
        SetLocalInt(oSpawn, "ChildrenSpawned", nChildrenSpawned);
        nSpawnCount++;
        SetLocalInt(oSpawn, "SpawnCount", nSpawnCount);
    }
}
//

void NESS_DeactivateSpawnByID(int nSpawnID, object oArea)
{
    object oSpawn = NESS_GetSpawnByID(nSpawnID, oArea);
    NESS_DeactivateSpawn(oSpawn);
}
// Identical to DeactivateSpawn, but included for interface consistency
void NESS_DeactivateSpawn(object oSpawn)
{
    DeactivateSpawn(oSpawn);
}
// This Function Sets a Spawn to Deactivate
void DeactivateSpawn(object oSpawn)
{
    SetLocalInt(oSpawn, "ForceDeactivateSpawn", TRUE);
    NESS_ForceProcess(oSpawn);
}

void NESS_ActivateSpawnByID(int nSpawnID, object oArea)
{
    object oSpawn = NESS_GetSpawnByID(nSpawnID, oArea);
    NESS_ActivateSpawn(oSpawn);
}

// This Function Sets a Spawn to Activate
void NESS_ActivateSpawn(object oSpawn)
{
    SetLocalInt(oSpawn, "SpawnDeactivated", FALSE);
    NESS_ForceProcess(oSpawn);
}

void NESS_ForceProcess(object oSpawn)
{
    SetLocalInt(oSpawn, "SpawnForceProcess", TRUE);
}

void NESS_TrackModuleSpawns(int flag=TRUE)
{
  SetLocalInt(GetModule(), "TrackModuleSpawns", flag);
}

int NESS_IsModuleSpawnTracking()
{
    return GetLocalInt(GetModule(), "TrackModuleSpawns");
}

//

void NESS_DumpModuleSpawns(int flag=TRUE)
{
  SetLocalInt(GetModule(), "DumpModuleSpawns", flag);
}

int NESS_IsModuleSpawnDumping()
{
    return GetLocalInt(GetModule(), "DumpModuleSpawns");
}
//
// This Function Sets all Spawns by Tag to Deactivate
void DeactivateSpawnsByTag(string sSpawnTag)
{
    int nNth;
    object oSpawn;
    string sSpawnNum;

    int nSpawns = GetLocalInt(GetArea(OBJECT_SELF), "Spawns");

    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        oSpawn = GetLocalObject(OBJECT_SELF, sSpawnNum);
        if (GetTag(oSpawn) == sSpawnTag)
        {
            SetLocalInt(oSpawn, "ForceDeactivateSpawn", TRUE);
        }
    }
}
//

// This Function Sets all Spawns to Deactivate
void DeactivateAllSpawns()
{
    int nNth;
    object oSpawn;
    string sSpawnNum;

    int nSpawns = GetLocalInt(GetArea(OBJECT_SELF), "Spawns");

    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        oSpawn = GetLocalObject(OBJECT_SELF, sSpawnNum);
        SetLocalInt(oSpawn, "ForceDeactivateSpawn", TRUE);
    }
}
//
location GetRandomLocationInRadius(object oSpawn, float fWalkingRadius)
{
    vector vCurrentLocation, vTargetLocation;
    float fRadiusX, fRadiusY;
    location lTargetLocation;

    // Create our Random Location
    fRadiusX = IntToFloat(Random(FloatToInt(fWalkingRadius)));
    fRadiusY = IntToFloat(Random(FloatToInt(fWalkingRadius)));
    if (d2() == 2)
    {
        fRadiusX = -fRadiusX;
    }
    if (d2() == 2)
    {
        fRadiusY = -fRadiusY;
    }
    vTargetLocation = Vector(fRadiusX, fRadiusY);
    vCurrentLocation = GetPositionFromLocation(GetLocation(oSpawn));
    lTargetLocation = Location(OBJECT_SELF, vCurrentLocation + vTargetLocation,
       0.0);

    return lTargetLocation;
}

// Random Walking with Range
void RandomWalk(object oSpawn, float fWalkingRadius, int nRun)
{
    // Walk to the New Location
    float fRadiusX, fRadiusY;

    // Create our Random Location
    fRadiusX = IntToFloat(Random(FloatToInt(fWalkingRadius)));
    fRadiusY = IntToFloat(Random(FloatToInt(fWalkingRadius)));
    if (d2() == 2)
    {
        fRadiusX = -fRadiusX;
    }
    if (d2() == 2)
    {
        fRadiusY = -fRadiusY;
    }

    location lSpawnLocation = GetLocation(oSpawn);
    vector vNewPosition = GetPositionFromLocation(lSpawnLocation);

    vNewPosition.x += fRadiusX;
    vNewPosition.y += fRadiusY;

    location lRandomWalkLocation = Location(GetArea(OBJECT_SELF), vNewPosition,
       0.0);
    ActionMoveToLocation(lRandomWalkLocation, nRun);
}
//

// This Function Finds aaSeatnd Sits in It
void FindSeat(object oSpawn, object oSpawned)
{
    object oSeat;
    string sSeatTag = GetLocalString(GetModule(), "df_SeatTag");
    location lSeatLocation;

    int nNth = 1;
    object oSittable = GetNearestObjectByTag(sSeatTag, oSpawned, nNth);
    while (oSittable != OBJECT_INVALID && oSeat == OBJECT_INVALID)
    {
        if (GetSittingCreature(oSittable) == OBJECT_INVALID)
        {
            oSeat = oSittable;
        }
        nNth++;
        oSittable = GetNearestObjectByTag(sSeatTag, oSpawned, nNth);
    }

    if (GetIsObjectValid(oSeat))
    {
      lSeatLocation = GetLocation(oSeat);
      AssignCommand(oSpawned, ClearAllActions());
      AssignCommand(oSpawned, ActionMoveToLocation(lSeatLocation));
      AssignCommand(oSpawned, ActionSit(oSeat));
    }
}
//

// This Function Cleans an Object's Inventory

void NESS_CleanCorpse(object oSpawned)
{
  NESS_CleanEquipped(oSpawned);
  NESS_CleanInventory(oSpawned);
}

void NESS_CleanEquipped(object oSpawned)
{
    int i = 0;
    object oItem = OBJECT_INVALID;

    for (i=0; i < NUM_INVENTORY_SLOTS; i++)
    {
        oItem = GetItemInSlot(i, oSpawned);

        if (GetIsObjectValid(oItem))
        {
            // Why the delay?  This is used to remove equipped items from corpses.  If the
            // corpse is still around, it do it's unequip animation...
            SetDroppableFlag( oItem, FALSE );
            DestroyObject(oItem, 1.0);
        }
    }
}

void NESS_CleanInventory(object oSpawned)
{
    // Clean out oSpawned's Inventory
    //debug("in clean inventory");
    object oItem = GetFirstItemInInventory(oSpawned);
    while (oItem != OBJECT_INVALID)
    {
        //debug("destroying " + GetName(oItem));
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oSpawned);
    }
}

//

// This Functions Sets up the Patrol Route
void SetPatrolRoute(int nPatrolRoute, int nStartClosest=FALSE)
{
    object oStop;
    int nRouteNumber, nStopNumber, iCount, nNumStops;
    string sStop;

    // These 3 vars only used if nStartClosest is TRUE;
    float fLeastDistance = 9999999.0;// any distance returned should be smaller
    float fCurrentDistance;
    int nClosestStopNum;

    // Cycle through Available Patrol Route Stops
    iCount = 0;
    nNumStops = 0;
    oStop = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, iCount);
    while (oStop != OBJECT_INVALID)
    {
        sStop = GetTag(oStop);
        // Check Route Number
        nRouteNumber = GetFlagValue(sStop, "PR", -1);
        if (nRouteNumber == nPatrolRoute)
        {
            // Identical Route Number, Add this Stop to oSpawned
            nNumStops++;
            nStopNumber = GetFlagValue(sStop, "SN", 0);
            SetLocalObject(OBJECT_SELF, "PR_SN" + PadIntToString(nStopNumber, 2), oStop);
            if (nStartClosest)
            {
                fCurrentDistance = GetDistanceToObject(oStop);
                if (fCurrentDistance < fLeastDistance)
                {
                     nClosestStopNum = nStopNumber;
                     fLeastDistance = fCurrentDistance;
                }
            }

        }
        iCount++;
        oStop = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, iCount);
    }
    SetLocalInt(OBJECT_SELF, "PR_STOPS", nNumStops);
    if (nStartClosest && (nClosestStopNum > 0))
    {
        SetLocalInt(OBJECT_SELF, "PR_LASTSTOP", nClosestStopNum - 1);

        // Force it to go to a new waypoint
        SetLocalInt(OBJECT_SELF, "PR_NEXTSTOP", -1);

    }
}
//

// This Function Performs the Patrol Route
void DoPatrolRoute(int nPatrolRoute, int nRouteType)
{
    int nNumStops, nDespawn;
    int nNextPatrolStop = -1;
    int nLastPatrolStop = -1;
    int nReturnRoute = FALSE;

    if (GetCurrentAction() != ACTION_INVALID)
        return;

    ClearAllActions();

    // Retreive Stop Information
    nNumStops = GetLocalInt(OBJECT_SELF, "PR_STOPS");
    if ( nNumStops == 0 ) return;
    nNextPatrolStop = GetLocalInt(OBJECT_SELF, "PR_NEXTSTOP");
    nLastPatrolStop = GetLocalInt(OBJECT_SELF, "PR_LASTSTOP");
    nReturnRoute = GetLocalInt(OBJECT_SELF, "PR_RETURNROUTE");

    // Add New Stop to Route
    if (nNextPatrolStop == -1)
    {
        // Sequential Route
       if (nRouteType == 0 || nRouteType == 3)
        {
            if (nReturnRoute == TRUE)
            {
                if (nLastPatrolStop == 0)
                {
                    nReturnRoute = FALSE;
                    SetLocalInt(OBJECT_SELF, "PR_RETURNROUTE", nReturnRoute);
                    nNextPatrolStop = nLastPatrolStop + 1;
                }
                else
                {
                    nNextPatrolStop = nLastPatrolStop - 1;
                }
            }
            else
            {
                if (nLastPatrolStop == nNumStops)
                {
                    if (nRouteType == 3)
                    {
                        // End of Line, Despawn
                        nDespawn = TRUE;
                    }
                    else
                    {
                        nReturnRoute = TRUE;
                        SetLocalInt(OBJECT_SELF, "PR_RETURNROUTE", nReturnRoute);
                        nNextPatrolStop = nLastPatrolStop - 2;
                    }
                }
                else
                {
                    nNextPatrolStop = nLastPatrolStop + 1;
               }
            }
        }

        // Circular Route
        if (nRouteType == 1)
        {
            if (nLastPatrolStop == nNumStops)
            {
                nNextPatrolStop = 0;
            }
            else
            {
                nNextPatrolStop = nLastPatrolStop + 1;
            }
        }

        // Random Route
        if (nRouteType == 2)
        {
            nNextPatrolStop = Random(nNumStops);
            while (nNextPatrolStop == nLastPatrolStop)
            {
                nNextPatrolStop = Random(nNumStops);
            }
        }
    }

    if (nDespawn == TRUE)
    {
        ClearAllActions();
        SetLocalInt(OBJECT_SELF, "ForceDespawn", TRUE);
    }
    else
    {
        // Set Next Stop
        SetLocalInt(OBJECT_SELF, "PR_NEXTSTOP", nNextPatrolStop);

        // Add Stop to Patrol
        AddPatrolStop(nPatrolRoute, nNextPatrolStop);

        // Repeat the Process
        ActionDoCommand(DoPatrolRoute(nPatrolRoute, nRouteType));
    }
}
//

// This Function adds a Stop to the Patrol Route
void AddPatrolStop(int nPatrolRoute, int nStopNumber, int bJump=FALSE)
{
    object oStop;
    int nRun, nScript, nFacing;
    int nDayOnly, nNightOnly;
    float fPause;
    // Danmar:  Added below for random pause setup
    int nRandomPause;
    int nRandomRoute;
    // End Danmar changes
    string sStop;
    int nValid = TRUE;

    // Gather Stop Information
    oStop = GetLocalObject(OBJECT_SELF, "PR_SN" +
       PadIntToString(nStopNumber, 2));

    if (GetIsObjectValid( oStop ) )
    {
        sStop = GetTag(oStop);
        nRun = IsFlagPresent(sStop, "RN");
        fPause = IntToFloat(GetFlagValue(sStop, "PS", 1));

        // Danmar:  Added RP###/RR### flag to patrol points to allow randomization
        // of the pause time and stops.
        nRandomPause = GetFlagValue(sStop, "RP", 0);
        nRandomRoute = GetFlagValue(sStop, "RR", 0);
        // End Danmar changes.

        nScript = GetFlagValue(sStop, "SC",  -1);
        nFacing = IsFlagPresent(sStop, "SF");
        nDayOnly = IsFlagPresent(sStop, "DO");
        nNightOnly = IsFlagPresent(sStop, "NO");

        // Day Only
        if (nDayOnly == TRUE && (GetIsDay() == FALSE && GetIsDawn() == FALSE))
        {
            nValid = FALSE;
        }

        // Night Only
        if (nNightOnly == TRUE && (GetIsNight() == FALSE && GetIsDusk() == FALSE))
        {
            nValid = FALSE;
        }

        // Check if Valid
        if (nValid == TRUE)
        {
            // Move to Stop
            // Modified by Danmar
            // ActionMoveToObject(oStop, nRun); // Original NESS line.
            // if d% is less than nRandomRoute (RRxxx) then we move to the next stop.
            // If its not then we skip that one and move to the next.
            if ((nRandomRoute == 0) || ((Random(100) + 1) < nRandomRoute))
            {
                if (bJump)
                {
                  ActionJumpToLocation(GetLocation(oStop));
                }
                else
                {
                  ActionMoveToObject(oStop, nRun);
                }
            }
            // End Danmar Changes
            if (nFacing == TRUE)
            {
                ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(oStop))));
            }

            // Execute Script
            if (nScript > -1)
            {
                SetLocalInt(OBJECT_SELF, "PatrolScript", nScript);
                ActionDoCommand(SetLocalInt(OBJECT_SELF, "PatrolScriptRunning", TRUE));
                ExecuteScript("spawn_sc_patrol", OBJECT_SELF);
                ActionDoCommand(SetLocalInt(OBJECT_SELF, "PatrolScriptRunning", FALSE));
            }

            // Pause
            /*  Danmar: If fRandomPause!=0 then let's pick a random pause length and
                add it to the existing fpause.  This way you can use PS to set the
                minimum pause and RP to set the maximum pause.
                Example: PR01_SN01_PS010_RR011 would cause the creature to pause between
                10 to 20 seconds.  */
            if (nRandomPause != 0)
            {
                fPause = fPause + IntToFloat(Random(nRandomPause));
            }
            // End Danmar Changes
            ActionWait(fPause);
        }
    }

    // Record this Stop and Clear Next Stop
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "PR_LASTSTOP", nStopNumber));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "PR_NEXTSTOP", -1));
}

void CheckForStuckPatrol(object oCreature, int nPatrolRoute, int nRouteType)
{
   // are we at the same location as last time?
   location lLast = GetLocalLocation(oCreature, "NESSLastLoc");
   location lCurrent = GetLocation(oCreature);
   if (lLast != lCurrent)
   {
      SetLocalLocation(oCreature, "NESSLastLoc", lCurrent);
      SetLocalInt(oCreature, "NESSStuckCount", 0);
      return;
   }

   int nStuckCount = GetLocalInt(oCreature, "NESSStuckCount");
   nStuckCount += 1;

   if (nStuckCount < 3)
   {
      SetLocalInt(oCreature, "NESSStuckCount", nStuckCount);
      return;
   }

   AssignCommand(oCreature, ClearAllActions());

   // unstuck 'im
   int nLastStop = GetLocalInt(OBJECT_SELF, "PR_LASTSTOP");

   // force a move
   AssignCommand(oCreature, AddPatrolStop(nPatrolRoute, nLastStop, TRUE));

   // reset
   SetLocalInt(oCreature, "NESSStuckCount", 0);

}
//

// This Function Checks Camp State
int ProcessCamp(object oCamp)
{
    int iCount;
    int nIsAlive = FALSE;
    int nCampNumC, nCampNumP, nPlaceableType, nDeathScript;
    float fCorpseDecay;
    object oSpawned, oCampTrigger, oItem;
    string sObject, sFlags, sCampTrigger;

    // Check Creatures
    nCampNumC = GetLocalInt(oCamp, "CampNumC");

    // Suppress despawning on creatureless camps
    if ( nCampNumC == 0 )
    {
       nIsAlive = TRUE;
    }

    for (iCount = 1; iCount <= nCampNumC; iCount++)
    {
        sObject = "CampC" + IntToString(iCount - 1);
        sFlags = GetLocalString(oCamp, sObject + "_Flags");
        fCorpseDecay = IntToFloat(GetFlagValue(sFlags, "CD", 0));
        nDeathScript = GetFlagValue(sFlags, "DT", -1);
        oSpawned = GetLocalObject(oCamp, sObject);
        if (oSpawned != OBJECT_INVALID)
        {
            if (GetIsDead(oSpawned) == FALSE)
            {
                nIsAlive = TRUE;
                int nIsBusy = FALSE;
                if (GetIsInCombat(oSpawned) || IsInConversation(oSpawned) ||
                    (GetCurrentAction(oSpawned) != ACTION_INVALID))
                {
                    nIsBusy = TRUE;
                }
                if (! nIsBusy)
                {
                    // Do return home processing
                    int nReturnHome = GetLocalInt(oSpawned, "f_ReturnHome");
                    if (nReturnHome)
                    {
                        // retrieve lHome and fReturnRange
                        float fReturnHomeRange = GetLocalFloat(oSpawned,
                           "f_ReturnHomeRange");
                        float fHomeX = GetLocalFloat(oSpawned, "HomeX");
                        float fHomeY = GetLocalFloat(oSpawned, "HomeY");
                        vector vHome = Vector(fHomeX, fHomeY, 0.0);
                        location lHome = Location(OBJECT_SELF, vHome, 0.0);

                        if (GetDistanceBetweenLocations(lHome, GetLocation(oSpawned))
                           > fReturnHomeRange)
                        {
                            AssignCommand(oSpawned, ReturnHome(lHome));
                            nIsBusy = TRUE;
                        }

                   }
                }

                // Do random walk
                if (! nIsBusy)
                {
                    int nRandomWalk = GetLocalInt(oSpawned, "f_RandomWalk");
                    if (nRandomWalk &&
                        GetCurrentAction(oSpawned) != ACTION_WAIT &&
                        GetCurrentAction(oSpawned) != ACTION_CASTSPELL &&
                        (d2(1) == 2))
                    {
                        AssignCommand(oSpawned, ClearAllActions());
                        AssignCommand(oSpawned, ActionRandomWalk());
                    }
                }
            }
            else
            {
               NESS_ProcessDeadCreature(oSpawned);
               DeleteLocalObject(oCamp, sObject);
            }
        }
    }

    // Check Camp Trigger
    if (nIsAlive)
    {
       sCampTrigger = GetLocalString(oCamp, "CampTrigger");
       if (sCampTrigger != "")
       {
           oCampTrigger = GetLocalObject(oCamp, "Camp" + sCampTrigger);
           if (oCampTrigger == OBJECT_INVALID || GetIsDead(oCampTrigger) == TRUE)
           {
               // Run Trigger Script
               ExecuteScript("spawn_sc_cmptrig", oCamp);
           }
       }
    }

    // Check Placeable
    nCampNumP = GetLocalInt(oCamp, "CampNumP");
    for (iCount = 1; iCount <= nCampNumP; iCount++)
    {
        sObject = "CampP" + IntToString(iCount - 1);
        sFlags = GetLocalString(oCamp, sObject + "_Flags");
        nPlaceableType = GetFlagValue(sFlags, "PL", 0);
        if (nPlaceableType == 1)
        {
            // Despawn if Empty
            oSpawned = GetLocalObject(oCamp, sObject);
            if (GetFirstItemInInventory(oSpawned) == OBJECT_INVALID)
            {
                DestroyObject(oSpawned);
            }
        }
    }

    return nIsAlive;
}
//

// This Function will Despawn a Camp
void DestroyCamp(object oCamp, float fCampDecay, int nSaveState)
{
    int iCount;
    object oSpawned;
    string sObject;

    int nCampNumP = GetLocalInt(oCamp, "CampNumP");
    int nCampNumC = GetLocalInt(oCamp, "CampNumC");

    // Destroy Placeables
    for (iCount = 1; iCount <= nCampNumP; iCount++)
    {
        sObject = "CampP" + IntToString(iCount - 1);
        oSpawned = GetLocalObject(oCamp, sObject);

        if (nSaveState)
        {
            //debug("Saving " + sObject);
            SaveStateOnDespawn(oSpawned, oCamp, TRUE);
        }
        SpawnCountDebug(oCamp, "despawning camp object " + ObjectToString(oSpawned));
        DestroyObject(oSpawned, fCampDecay);
    }

    // Destroy Creatures
    for (iCount = 1; iCount <= nCampNumC; iCount++)
    {
        sObject = "CampC" + IntToString(iCount - 1);
        oSpawned = GetLocalObject(oCamp, sObject);

        if (nSaveState)
        {
            //debug("Saving " + sObject);
            SaveStateOnDespawn(oSpawned, oCamp, TRUE);
        }
        AssignCommand(oSpawned, ClearAllActions());
        if (oSpawned != OBJECT_INVALID)
        {

            NESS_CleanInventory(oSpawned);
            AssignCommand(oSpawned, SetIsDestroyable(TRUE));
            SpawnCountDebug(oCamp, "despawning camp creature " + ObjectToString(oSpawned));

            DestroyObject(oSpawned);
        }
        // remove from camp object
        DeleteLocalObject(oCamp, sObject);
    }
}
//

object GetSpawnLocationObject(object oSpawn, int nSpawnLocationMin,
    int nSpawnLocation, int nSpawnLocationInd)
{
    string sSpawnLocation;
    object oSpawnLocation;

    if (nSpawnLocationInd)
    {
        int nNextEmptySlot;

        nNextEmptySlot = FindNextEmptyChildSlot(oSpawn);

        if (nNextEmptySlot > 0)
        {
          sSpawnLocation = "SL" + PadIntToString(nSpawnLocation + nNextEmptySlot - 1,
             2);
        }

        else
        {
          // no empty slots?  Just use base, I guess
          sSpawnLocation = "SL" + PadIntToString(nSpawnLocation, 2);
        }

        oSpawnLocation = GetNearestObjectByTag(sSpawnLocation, oSpawn);
    }

    else
    {
        int nRndSpawnLocation;

        if (nSpawnLocationMin > -1)
        {
            nRndSpawnLocation = Random(nSpawnLocation + 1);
            while (nRndSpawnLocation < nSpawnLocationMin)
            {
                nRndSpawnLocation = Random(nSpawnLocation + 1);
            }
            nSpawnLocation = nRndSpawnLocation;
        }
        sSpawnLocation = "SL" + PadIntToString(nSpawnLocation, 2);
        oSpawnLocation = GetNearestObjectByTag(sSpawnLocation, oSpawn);
    }

    return oSpawnLocation;
}

vector GetSpawnRadiusPosition(vector vSpawnPos, float fSpawnRadius,
   float fSpawnRadiusMin, int nRadialDistribution=FALSE)
{
    float fX, fY;
    vector vRadius;

    if (nRadialDistribution)
    {
        float fSpawnAngle, fRadius;

        fSpawnAngle = IntToFloat(Random(361));
        if (fSpawnRadiusMin == fSpawnRadius)
        {
            fX = fSpawnRadius * cos(fSpawnAngle);
            fY = fSpawnRadius * sin(fSpawnAngle);
        }
        else
        {
            fRadius = IntToFloat(Random(FloatToInt(fSpawnRadius) + 1));
            while (fRadius < fSpawnRadiusMin)
            {
                fRadius = IntToFloat(Random(FloatToInt(fSpawnRadius) + 1));
            }
            fX = fRadius * cos(fSpawnAngle);
            fY = fRadius * sin(fSpawnAngle);
        }
    }

    else
    {
        float fTestDistSquared, fMaxRadiusSquared, fMinRadiusSquared;
        int nSpawnRadius = FloatToInt(fSpawnRadius);

        // Set up comparators
        fMaxRadiusSquared = fSpawnRadius * fSpawnRadius;
        fMinRadiusSquared = fSpawnRadiusMin * fSpawnRadiusMin;

        // Calculate first attempt
        fX = IntToFloat(Random((2 * nSpawnRadius) + 1) -
            nSpawnRadius + 1);
        fY = IntToFloat(Random((2 * nSpawnRadius) + 1) -
            nSpawnRadius + 1);
        fTestDistSquared = (fX * fX) + (fY * fY);

        while (fTestDistSquared < fMinRadiusSquared ||
               fTestDistSquared > fMaxRadiusSquared)
        {
            fX = IntToFloat(Random((2 * nSpawnRadius) + 1) -
                nSpawnRadius + 1);
            fY = IntToFloat(Random((2 * nSpawnRadius) + 1) -
                nSpawnRadius + 1);
            fTestDistSquared = (fX * fX) + (fY * fY);
        }
    }
    vRadius = Vector(vSpawnPos.x + fX, vSpawnPos.y + fY, vSpawnPos.z);
    return vRadius;
}

int CheckPositionUnseen(vector vSpawnPos, float fUnseenRadius)
{
    location lSpawn = Location(OBJECT_SELF, vSpawnPos, 0.0);

    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fUnseenRadius,
       lSpawn, FALSE, OBJECT_TYPE_CREATURE);

    while (oCreature != OBJECT_INVALID)
    {
        if (GetIsPC(oCreature) == TRUE)
        {
            return FALSE;
        }
        oCreature = GetNextObjectInShape(SHAPE_SPHERE, fUnseenRadius,
           lSpawn, FALSE, OBJECT_TYPE_CREATURE);
    }

    return TRUE;

}

void ReportSpawns(int nAreaSpawns, int nModuleSpawns)
{
    SendMessageToAllDMs("New creature count in " +
        GetName(OBJECT_SELF) + ": " + IntToString(nAreaSpawns) +
        " Module spawn count: " + IntToString(nModuleSpawns) +
        (SPAWN_DELAY_DEBUG ?  " (sd+)" : " (sd-)") +
        (SPAWN_COUNT_DEBUG ?  " (sc+)" : " (sc-)"));
}

void TrackModuleSpawns(int nAreaSpawnCount, int nTrackModuleSpawns)
{
    int nNewAreaSpawnCount = GetLocalInt(OBJECT_SELF, SPAWN_AREA_COUNT );
    int nSpawnDifference =  nNewAreaSpawnCount - nAreaSpawnCount;

    if (nSpawnDifference)
    {
        int nModuleSpawns = GetLocalInt(GetModule(), "ModuleSpawnCount");
        nModuleSpawns += nSpawnDifference;
        SetLocalInt(GetModule(), "ModuleSpawnCount", nModuleSpawns);
        if (nTrackModuleSpawns)
        {
            ReportSpawns(nNewAreaSpawnCount, nModuleSpawns);
        }
    }
}

void DumpModuleSpawns()
{
    int nAreaSpawnCount = GetLocalInt(OBJECT_SELF, SPAWN_AREA_COUNT );
    if (nAreaSpawnCount > 0)
    {
        SendMessageToAllDMs("Area " + GetName(OBJECT_SELF) + ": " +
            IntToString(nAreaSpawnCount) +
            (SPAWN_DELAY_DEBUG ?  " (sd+)" : " (sd-)") +
            (SPAWN_COUNT_DEBUG ?  " (sc+)" : " (sc-)"));
    }
}

void NESS_ReturnHome(object oCreature, int bRun=FALSE)
{
    float fHomeX = GetLocalFloat(oCreature, "HomeX");
    float fHomeY = GetLocalFloat(oCreature, "HomeY");
    vector vHome = Vector(fHomeX, fHomeY, 0.0);
    location lHome = Location(GetArea(oCreature), vHome, 0.0);

    ClearAllActions();
    ActionMoveToLocation(lHome, bRun);
}

void ReturnHome(location lHome)
{
    if (GetCurrentAction() != ACTION_INVALID)
        return;

   ClearAllActions();
   ActionMoveToLocation(lHome);
}

void DestroyIfNonDrop(object oItem)
{
    if(GetIsObjectValid(oItem))
    {
        if (! GetDroppableFlag(oItem))
        {
            //debug("Destroying non-drop item named " + GetName(oItem));
            DestroyObject(oItem);
        }
    }
}

void StripNonDroppables(object oSpawned)
{
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_ARMS, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_ARROWS, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_BELT, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_BOLTS, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_BOOTS, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_BULLETS, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_CHEST, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_CLOAK, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_HEAD, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_NECK, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oSpawned));
    DestroyIfNonDrop(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oSpawned));

    object oItem = GetFirstItemInInventory(oSpawned);
    while (oItem != OBJECT_INVALID)
    {
        DestroyIfNonDrop(oItem);
        oItem = GetNextItemInInventory(oSpawned);
    }
}

void NESS_ProcessDeadCreature(object oCreature, object oSpawn=OBJECT_INVALID)
{
    int nCampCreature;

    // Only do once per creature.  Since this may be called from onDeath
    // or within a NESS HB, check/mark for having been processed
    int nProcessedDeath = GetLocalInt(oCreature, "ProcessedDeath");
    if (nProcessedDeath)
    {
        return;
    }


    SetLocalInt(oCreature, "ProcessedDeath", TRUE);

    // Find parent if not passed in
    if (oSpawn == OBJECT_INVALID)
    {
        oSpawn = GetLocalObject(oCreature, "ParentSpawn");
    }

    object oArea = GetArea(oCreature);
    SPAWN_DELAY_DEBUG = GetLocalInt(oArea, "SpawnDelayDebug");
    SPAWN_COUNT_DEBUG = GetLocalInt(oArea, "SpawnCountDebug");
    SpawnDelayDebug(oSpawn, "creature " + ObjectToString(oCreature) + " died");

    // Remove non-drop items
    // StripNonDroppables(oCreature);

    // Initialize DeathScripts
    int nDeathScript;
    float fCorpseDecay;
    if (oSpawn == OBJECT_INVALID)
    {
        //debug("camp creature died");
        string sCampFlags;
        nCampCreature = TRUE;
        sCampFlags = GetLocalString(oCreature, "CreatureFlags");
        //debug("in process dead with flags " + sCampFlags);
        fCorpseDecay = IntToFloat(GetFlagValue(sCampFlags, "CD", 0));
        nDeathScript = GetFlagValue(sCampFlags, "DT", -1);
        //debug("camp creature: cd = " + FloatToString(fCorpseDecay));
    }

    else
    {
        //debug("non-camp creature died");
        nCampCreature = FALSE;
        nDeathScript = GetLocalInt(oSpawn, "f_DeathScript");
        fCorpseDecay = GetLocalFloat(oSpawn, "f_CorpseDecay");
        //debug("not a camp creature: cd = " + FloatToString(fCorpseDecay));
    }

    // Run Death Script
    if (nDeathScript > -1 && GetLocalInt(oCreature, "DeathScriptRan") == FALSE)
    {
        SetLocalInt(oCreature, "DeathScript", nDeathScript);
        ExecuteScript("spawn_sc_death", oCreature);
    }

    // Spawn Corpse if Dead and No Corpse
    if (fCorpseDecay > 0.0)
    {
      if (GetLocalObject(oCreature, "Corpse") == OBJECT_INVALID)
      {
         //debug("calling spawn_corpse_dth");
         ExecuteScript("spawn_corpse_dth", oCreature);
      }
    }

    else
    {
      if (GetLocalInt(GetModule(), "AlwaysDestroyCorpses"))
      {
      	SetLootable(oCreature, FALSE);
        AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
      }
    }
}

void ResetSpawn(object oSpawn, int nTimeNow)
{
    // Reset the Spawn
    SetLocalInt(oSpawn, "NextSpawnTime", nTimeNow);
    //debug("set next spawn time on reset: " + IntToString(nTimeNow));
    SetLocalInt(oSpawn, "SpawnDeactivated", FALSE);
    SetLocalInt(oSpawn, "ChildrenSpawned", 0);
    SetLocalInt(oSpawn, "CurrentProcessTick", 0);
    SetLocalInt(oSpawn, "SpawnAgeTime", 0);
    //debug("PC reset");

}

//

void SaveStateOnDespawn(object oSpawned, object oSpawn, int nCamp=FALSE)
{
    string sSaveVarName;

    // These are the values needed to recreate the spawned object where
    // it was when it despawned
    int nObjectType = 0;
    string sTemplate;
    location lLastLocation;
    float fLastFacing;
    float fHomeX;
    float fHomeY;
    int nReturnHome;

    if (nCamp && !GetIsObjectValid(oSpawned))
    {
        SpawnCountDebug(oSpawn, "creating slot for dead camp object" +
           ObjectToString(oSpawned));
        sTemplate = "";
    }

    else
    {
        nObjectType = GetObjectType(oSpawned);
        sTemplate = GetResRef(oSpawned);
        lLastLocation = GetLocation(oSpawned);
        fLastFacing = GetFacing(oSpawned);
        fHomeX = GetLocalFloat(oSpawned, "HomeX");
        fHomeY = GetLocalFloat(oSpawned, "HomeY");

        // if the return home flag is on, respawn at the home point
        if (nCamp)
        {
           nReturnHome = GetLocalInt(oSpawned, "f_ReturnHome");
        }

        else
        {
           nReturnHome = GetLocalInt(oSpawn, "f_ReturnHome");
        }

        if (nReturnHome)
        {
            vector vHome = Vector(fHomeX, fHomeY, 0.0);
           location lHome = Location(GetArea(oSpawned), vHome, fLastFacing);
           lLastLocation = lHome;
        }
    }

    int nNumberSaveStates = GetLocalInt(oSpawn, "SpawnNumSavedStates");
    SetLocalInt(oSpawn, "SpawnNumSavedStates", ++nNumberSaveStates);
    string sSaveVarNameBase = "SpawnedSaveState" + IntToString(nNumberSaveStates);
    SpawnCountDebug(oSpawn,  "PC despawn save count: " + IntToString(nNumberSaveStates));


    // Save the stuff needed to respawn
    sSaveVarName = sSaveVarNameBase + "ObjectType";
    SetLocalInt(oSpawn, sSaveVarName, nObjectType);

    sSaveVarName = sSaveVarNameBase + "Template";
    SetLocalString(oSpawn, sSaveVarName, sTemplate);

    sSaveVarName = sSaveVarNameBase + "LastLocation";
    SetLocalLocation(oSpawn, sSaveVarName, lLastLocation);

    sSaveVarName = sSaveVarNameBase + "HomeX";
    SetLocalFloat(oSpawn, sSaveVarName, fHomeX);

    sSaveVarName = sSaveVarNameBase + "HomeY";
    SetLocalFloat(oSpawn, sSaveVarName, fHomeY);

    // These need to be preserved so they can be rewritten to the respawned
    // object; they may be used in ProcessSpawn
    if (! nCamp)
    {
        float fSpawnFacing = GetLocalFloat(oSpawned, "SpawnFacing");
        float fEntranceExitX = GetLocalFloat(oSpawned, "EntranceExitX");
        float fEntranceExitY = GetLocalFloat(oSpawned, "EntranceExitY");
        int iExpireTime = GetLocalInt(oSpawned, "LifespanExpireTime");

        // Save the stuff we need to rewrite onto the spawn
        sSaveVarName = sSaveVarNameBase + "SpawnFacing";
        SetLocalFloat(oSpawn, sSaveVarName, fSpawnFacing);

        sSaveVarName = sSaveVarNameBase + "EntranceExitX";
        SetLocalFloat(oSpawn, sSaveVarName, fEntranceExitX);

        sSaveVarName = sSaveVarNameBase + "EntranceExitY";
        SetLocalFloat(oSpawn, sSaveVarName, fEntranceExitY);

        sSaveVarName = sSaveVarNameBase + "LifeSpanExpireTime";
        SetLocalInt(oSpawn, sSaveVarName, iExpireTime);
    }
}

//

void SaveCampStateOnDespawn(object oCamp, object oSpawn)
{
    // Note that most of what needs to be saved is on the camp object itself.
    // This saves the camp object onto oSpawn
    int nNumSavedCampStates = GetLocalInt(oSpawn,"SpawnNumSavedCampStates");
    SetLocalInt(oSpawn, "SpawnNumSavedCampStates",++nNumSavedCampStates);

    SpawnCountDebug(oSpawn, "PC despawn camp save count: " + IntToString(nNumSavedCampStates));

    string sSaveCampVarName = "SpawnedSaveCampState" +
       IntToString(nNumSavedCampStates);
    SetLocalObject(oSpawn, sSaveCampVarName, oCamp);
}

//

void RestorePCDespawns(object oSpawn, int nTimeNow)
{
    int nSpawnNumSavedStates = GetLocalInt(oSpawn, "SpawnNumSavedStates");
    string sSaveVarNameBase;
    string sSaveVarName;
    int nChildNum;

    object oSpawned;
    int nObjectType;
    string sTemplate;
    location lLastLocation;
    location lEntranceExit;
    float fHomeX;
    float fHomeY;
    location lHome;
    int iExpireTime;
    int i;

    SpawnCountDebug(oSpawn, "restoring " + IntToString(nSpawnNumSavedStates) + " objects");

    for (i = 0; i < nSpawnNumSavedStates; i++)
    {
        nChildNum = i + 1;
        sSaveVarNameBase = "SpawnedSaveState" + IntToString(nChildNum);

        sSaveVarName = sSaveVarNameBase + "ObjectType";
        nObjectType = GetLocalInt(oSpawn,  sSaveVarName);
        DeleteLocalInt(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "Template";
        sTemplate = GetLocalString(oSpawn,  sSaveVarName);
        DeleteLocalString (oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "LastLocation";
        lLastLocation = GetLocalLocation(oSpawn, sSaveVarName);
        DeleteLocalLocation(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "SpawnFacing";
        float fSpawnFacing = GetLocalFloat(oSpawn, sSaveVarName);
        DeleteLocalFloat(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "HomeX";
        fHomeX = GetLocalFloat(oSpawn, sSaveVarName);
        DeleteLocalFloat(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "HomeY";
        fHomeY = GetLocalFloat(oSpawn, sSaveVarName);
        DeleteLocalFloat(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "EntranceExitX";
        float fEntranceExitX = GetLocalFloat(oSpawn, sSaveVarName);
        DeleteLocalFloat(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "EntranceExitY";
        float fEntranceExitY = GetLocalFloat(oSpawn, sSaveVarName);
        DeleteLocalFloat(oSpawn, sSaveVarName);

        sSaveVarName = sSaveVarNameBase + "LifeSpanExpireTime";
        iExpireTime = GetLocalInt(oSpawn, sSaveVarName);
        DeleteLocalInt(oSpawn, sSaveVarName);

        //Initialize Cached Spawning
        int nUseCache = GetLocalInt(oSpawn, "f_UseCache");
        int nCacheBucket = GetLocalInt(oSpawn, "f_CacheBucket");
        int nCacheCondition = GetLocalInt(oSpawn, "f_CacheCondition");
        int nCacheTiming = GetLocalInt(oSpawn, "CacheTiming");

	    int nTrapType = GetLocalInt(oSpawn, "f_TrapType");
	    int nTrapMinType = GetLocalInt(oSpawn, "f_TrapMinType");
	    int nTrapSize = GetLocalInt(oSpawn, "f_TrapSize");
	    int nTrapFaction = GetLocalInt(oSpawn, "f_TrapFaction");
	    int nTrapDisarmScript = GetLocalInt(oSpawn, "f_TrapDisarmScript");
	    int nTrapTriggerScript = GetLocalInt(oSpawn, "f_TrapTriggerScrip");

        if (! IsRestoreBlocked(oSpawn, lLastLocation, iExpireTime, nTimeNow))
        {
            if(FALSE == nUseCache || nCacheTiming == 1)
            {
                //**FLAG standard create
				//Traps do not use the standard CreateObject so if we're spawning
				//a trap we need to call a different create function
				if(OBJECT_TYPE_TRIGGER != nObjectType)
                {
	                oSpawned = CreateObject(nObjectType, sTemplate, lLastLocation);
				}
				else
				{
					//Create Spawned Trap
					oSpawned = CreateNessTrap(oSpawn, nObjectType, sTemplate, lLastLocation
												, nTrapType, nTrapMinType, nTrapSize, nTrapFaction, nTrapDisarmScript
												, nTrapTriggerScript);
				}
            }
            else
            {
                oSpawned = CreateNessObject(oSpawn, nObjectType, sTemplate, lLastLocation, nCacheCondition, nCacheBucket);
            }

          SpawnCountDebug(oSpawn, "restored " + sSaveVarNameBase + "object id: " +
              ObjectToString(oSpawned));

          lHome = Location(OBJECT_SELF, Vector(fHomeX, fHomeY, 0.), fSpawnFacing);
          lEntranceExit = Location(OBJECT_SELF, Vector(fEntranceExitX,
             fEntranceExitY, 0.), fSpawnFacing);

          RecordSpawned(oSpawn, oSpawned, lHome, lEntranceExit, fSpawnFacing);
          SetupSpawned(oSpawn, oSpawned, lHome, nTimeNow, FALSE);
          if(TRUE == nUseCache && 1 == nCacheTiming)
          {
              CreateCachedObject(oSpawn, oSpawned, nCacheBucket, nCacheCondition);
          }

          // Lifespan expire time needs to be rewritten the the spawned object,
          // since SetupSpawned generated a new one based on the current time...
          SetLocalInt(oSpawned, "LifespanExpireTime", iExpireTime);
        }

        else
        {
          SpawnCountDebug(oSpawn, "restore blocked: " + sSaveVarNameBase);
        }
    }

    int nNumSavedCampStates = GetLocalInt(oSpawn, "SpawnNumSavedCampStates");

    // restore camps
    for (i = 0; i < nNumSavedCampStates; i++)
    {
        int j;
        int nCampNum = i + 1;

        string sSaveCampVarName = "SpawnedSaveCampState" +
            IntToString(nCampNum);
        object oCamp = GetLocalObject(oSpawn, sSaveCampVarName);
        DeleteLocalObject(oSpawn, sSaveCampVarName);

        // respawn camp objects
        //debug("restoring " + sSaveCampVarName);
        nSpawnNumSavedStates = GetLocalInt(oCamp, "SpawnNumSavedStates");
        int nPlaceableCount = 0;
        int nCreatureCount = 0;
        for (j = 0; j <  nSpawnNumSavedStates; j++)
        {
            nChildNum = j + 1;
            sSaveVarNameBase = "SpawnedSaveState" + IntToString(nChildNum);
            //debug("restoring " + sSaveVarNameBase);

            sSaveVarName = sSaveVarNameBase + "ObjectType";
            //debug("Getting objtype with var name " + sSaveVarName);
            nObjectType = GetLocalInt(oCamp,  sSaveVarName);
            DeleteLocalInt(oCamp, sSaveVarName);

            sSaveVarName = sSaveVarNameBase + "Template";
            sTemplate = GetLocalString(oCamp,  sSaveVarName);
            //debug("template: " + sTemplate);
            DeleteLocalString (oCamp, sSaveVarName);

            sSaveVarName = sSaveVarNameBase + "LastLocation";
            lLastLocation = GetLocalLocation(oCamp, sSaveVarName);
            DeleteLocalLocation(oCamp, sSaveVarName);

            sSaveVarName = sSaveVarNameBase + "HomeX";
            fHomeX = GetLocalFloat(oCamp, sSaveVarName);
            DeleteLocalFloat(oCamp, sSaveVarName);

            sSaveVarName = sSaveVarNameBase + "HomeY";
            fHomeY = GetLocalFloat(oCamp, sSaveVarName);
            DeleteLocalFloat(oCamp, sSaveVarName);
            lHome = Location(OBJECT_SELF, Vector(fHomeX, fHomeY, 0.), 0.);

            sSaveVarName = sSaveVarNameBase + "LifeSpanExpireTime";
            iExpireTime = GetLocalInt(oSpawn, sSaveVarName);
            DeleteLocalInt(oSpawn, sSaveVarName);

            string sObject;

            if (nObjectType == OBJECT_TYPE_CREATURE)
            {
                sObject = "CampC" + IntToString(nCreatureCount++);
            }

            else if (nObjectType == OBJECT_TYPE_PLACEABLE)
            {
                sObject = "CampP"+ IntToString(nPlaceableCount++);
            }

            if (sTemplate != "")
            {
              if (! IsRestoreBlocked(oCamp, lLastLocation, iExpireTime, nTimeNow))
              {
                oSpawned = CreateObject(nObjectType, sTemplate, lLastLocation);

                SetLocalObject(oCamp, sObject, oSpawned);

                vector vCamp = GetPositionFromLocation(GetLocation(oSpawn));
                string sFlags = GetLocalString(oCamp, sObject + "_Flags");

                SetupCampSpawned(oSpawn, oSpawned, vCamp, lHome, sFlags);

                // Lifespan expire time needs to be rewritten the the spawned object,
                // since SetupSpawned generated a new one based on the current time...
                SetLocalInt(oSpawned, "LifespanExpireTime", iExpireTime);

              }

              else
              {
                SetLocalObject(oCamp, sObject, OBJECT_INVALID);
              }
            }

            else
            {
                SetLocalObject(oCamp, sObject, OBJECT_INVALID);
            }
        }
        location lCampLocation = GetLocation(oSpawn);
        float fCampFacing = GetFacing(oSpawn);
        RecordSpawned(oSpawn, oCamp, lCampLocation, lCampLocation, fCampFacing);
    }

    SetLocalInt(oSpawn, "SpawnNumSavedStates", 0);
    SetLocalInt(oSpawn, "SpawnNumSavedCampStates",  0);
}

//

void RecordSpawned(object oSpawn, object oSpawned, location lHome,
    location lEntranceExit, float fSpawnedFacing)
{
    int nChildrenSpawned;
    int nSpawnCount;
    int nChildSlot;
    int nEmptyChildSlot;
    object oChild;
    string sChildSlot, sEmptyChildSlot;

    string sCustomFlag = GetLocalString(oSpawn, "f_CustomFlag");
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

    // Assign Values to oSpawned
    SetLocalObject(oSpawned, "ParentSpawn", oSpawn);
    SetLocalFloat(oSpawned, "SpawnFacing", fSpawnedFacing);
    SetLocalFloat(oSpawned, "HomeX", GetPositionFromLocation(lHome).x);
    SetLocalFloat(oSpawned, "HomeY", GetPositionFromLocation(lHome).y);
    SetLocalFloat(oSpawned, "EntranceExitX", GetPositionFromLocation(lEntranceExit).x);
    SetLocalFloat(oSpawned, "EntranceExitY", GetPositionFromLocation(lEntranceExit).y);
    SetLocalString(oSpawned, "CustomFlag", sCustomFlag);

    // Assign Values to oSpawn
    nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    nChildrenSpawned++;
    SetLocalInt(oSpawn, "ChildrenSpawned", nChildrenSpawned);
    nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");
    nSpawnCount++;
    SetLocalInt(oSpawn, "SpawnCount", nSpawnCount);

    // Find Empty Child Slot
    nChildSlot = 1;
    nEmptyChildSlot = 0;
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);

        // Check if this is Child Slot is Valid
        if (GetIsObjectValid(oChild) == FALSE || GetIsDead(oChild))
        {
            // Empty Slot
            if (nEmptyChildSlot == 0)
            {
                nEmptyChildSlot = nChildSlot;
                sEmptyChildSlot = sChildSlot;
            }
        }
    }

    // Assign Child Slot
    SpawnCountDebug(oSpawn, "recorded spawn " +  GetTag(oSpawned) + " ("  +
       ObjectToString(oSpawned) + ") as " + sEmptyChildSlot);
    SetLocalObject(oSpawn, sEmptyChildSlot, oSpawned);
    SetLocalString(oSpawned, "ParentChildSlot", sEmptyChildSlot);
    object oIdiot = GetLocalObject(oSpawn, sEmptyChildSlot);
    string sValid = GetIsObjectValid(oIdiot) ? "valid" : "invalid";
}

//

// Returns 0 if no empty slots
int FindNextEmptyChildSlot(object oSpawn)
{
    int nChildSlot;
    int nEmptyChildSlot;
    object oChild;
    string sChildSlot;
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

    nChildSlot = 1;
    nEmptyChildSlot = 0;
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oChild = GetLocalObject(oSpawn, sChildSlot);

        // Check if this is Child Slot is Valid
        if (GetIsObjectValid(oChild) == FALSE || GetIsDead(oChild))
        {
            // Empty Slot
            nEmptyChildSlot = nChildSlot;
            break;

        }
    }

    return nEmptyChildSlot;
}

void SetupSpawned(object oSpawn, object oSpawned, location lHome,
   int nTimeNow, int nWalkToHome = FALSE)
{
    object oFaction;
    int nChildLifespanExpireTime;
    int nGoldAmount;
    effect eObject;

    int nSpawnFaction = GetLocalInt(oSpawn, "f_SpawnFaction");
    int nSpawnSit = GetLocalInt(oSpawn, "f_SpawnSit");
    int nSpawnPlot = GetLocalInt(oSpawn, "f_SpawnPlot");
    int nSpawnAlignment = GetLocalInt(oSpawn, "f_SpawnAlignment");
    int nAlignmentShift = GetLocalInt(oSpawn, "f_AlignmentShift");
    int nChildLifespanMax = GetLocalInt(oSpawn, "f_ChildLifespanMax");
    int nChildLifespanMin = GetLocalInt(oSpawn, "f_ChildLifespanMin");
    int nRandomGold = GetLocalInt(oSpawn, "f_RandomGold");
    int nRandomGoldMin = GetLocalInt(oSpawn, "f_RandomGoldMin");
    int nGoldChance = GetLocalInt(oSpawn, "f_GoldChance");
    int nLootTable = GetLocalInt(oSpawn, "f_LootTable");
    int nTrapDisabled = GetLocalInt(oSpawn, "f_TrapDisabled");
    float fCorpseDecay = GetLocalFloat(oSpawn, "f_CorpseDecay");
    int nCorpseDecayType = GetLocalInt(oSpawn, "f_CorpseDecayType");
    int bDropWielded = GetLocalInt(oSpawn, "f_CorpseDropWielded");
    int bDeleteLootOnDecay = GetLocalInt(oSpawn, "f_CorpseDeleteLootOnDecay");
    string sCorpseRemainsResRef = GetLocalString(oSpawn, "f_CorpseRemainsResRef");
    int nDeathScript = GetLocalInt(oSpawn, "f_DeathScript");
    int nSpawnScript = GetLocalInt(oSpawn, "f_SpawnScript");
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");
    float fAreaEffectDuration = GetLocalFloat(oSpawn, "f_AreaEffectDuration");
    int nObjectEffect = GetLocalInt(oSpawn, "f_ObjectEffect");
    float fObjectEffectDuration = GetLocalFloat(oSpawn, "f_ObjectEffectDuration");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    int nPatrolRoute = GetLocalInt(oSpawn, "f_PatrolRoute");
    int nPatrolStartAtClosest = GetLocalInt(oSpawn, "f_PatrolStartAtClosest");
    int nRouteType = GetLocalInt(oSpawn, "f_RouteType");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    float fWanderRange = GetLocalFloat(oSpawn, "f_WanderRange");
    int nSuppressLooting = GetLocalInt(oSpawn, "f_SuppressLooting");
    int nSubdualMode = GetLocalInt(oSpawn, "f_SubdualMode");
    int nEncounterLevel = GetLocalInt(oSpawn, "f_EncounterLevel");

	int nSpawnTrap = GetLocalInt(oSpawn, "f_SpawnTrap");
	int nTrapDetectDC = GetLocalInt(oSpawn, "f_TrapDetectDC");
	int nTrapDisarmDC = GetLocalInt(oSpawn, "f_TrapDisarmDC");
	int nTrapRecoverable = GetLocalInt(oSpawn, "f_TrapRecoverable");
	int nTrapDisarmScript = GetLocalInt(oSpawn, "f_TrapDisarmScript");
	int nTrapTriggerScript = GetLocalInt(oSpawn, "f_TrapTriggerScript");
	//special options if the spawned is a trap
	if(TRUE == nSpawnTrap)
	{
		if(0 != nTrapDetectDC)
		{
			SetTrapDetectDC(oSpawned, nTrapDetectDC);
		}
		if(0 != nTrapDisarmDC)
		{
			SetTrapDisarmDC(oSpawned, nTrapDisarmDC);
		}
		if(-1 != nTrapRecoverable)
		{
			SetTrapRecoverable(oSpawned, nTrapRecoverable);
		}
		SetLocalInt(oSpawned, "TrapDisarmScript", nTrapDisarmScript);
		SetLocalInt(oSpawned, "TrapTriggerScript", nTrapTriggerScript);
	}
	
    if (nWalkToHome)
    {
        AssignCommand(oSpawned, ActionMoveToLocation(lHome));
    }

    // Spawn it in with the right facing, and you don't need this; and
    // then it works for placeables as well!
    // AssignCommand(oSpawned, ActionDoCommand(SetFacing(fSpawnedFacing)));

    // Set up SpawnPlot
    if (nSpawnPlot == TRUE)
    {
        SetPlotFlag(oSpawned, TRUE);
    }

    // Set up Faction
    if (nSpawnFaction > -1)
    {
        switch (nSpawnFaction)
        {
            case 0:
                ChangeToStandardFaction(oSpawned, STANDARD_FACTION_COMMONER);
            break;
            case 1:
                ChangeToStandardFaction(oSpawned, STANDARD_FACTION_DEFENDER);
            break;
            case 2:
                ChangeToStandardFaction(oSpawned, STANDARD_FACTION_MERCHANT);
            break;
            case 3:
                ChangeToStandardFaction(oSpawned, STANDARD_FACTION_HOSTILE);
            break;
            case 4:
                oFaction = GetNearestObjectByTag("SpawnFaction", oSpawned);
                if (oFaction != OBJECT_INVALID)
                {
                    ChangeFaction(oSpawned, oFaction);
                }
            break;
        }
    }

    // Set up Alignment
    if (nSpawnAlignment > -1)
    {
        switch (nSpawnAlignment)
        {
            case 0:
                AdjustAlignment(oSpawned, ALIGNMENT_NEUTRAL, nAlignmentShift);
            break;
            case 1:
                AdjustAlignment(oSpawned, ALIGNMENT_LAWFUL, nAlignmentShift);
            break;
            case 2:
                AdjustAlignment(oSpawned, ALIGNMENT_CHAOTIC, nAlignmentShift);
            break;
            case 3:
                AdjustAlignment(oSpawned, ALIGNMENT_GOOD, nAlignmentShift);
            break;
            case 4:
                AdjustAlignment(oSpawned, ALIGNMENT_EVIL, nAlignmentShift);
            break;
            case 5:
                AdjustAlignment(oSpawned, ALIGNMENT_ALL, nAlignmentShift);
            break;
        }
    }

    // Set up Lifespan
    if (nChildLifespanMax > -1)
    {
        if (nChildLifespanMin > -1)
        {
            nChildLifespanExpireTime = -1;
            while (nChildLifespanExpireTime < nChildLifespanMin)
            {
                nChildLifespanExpireTime = nTimeNow + Random(nChildLifespanMax) + 1;
            }
        }
        else
        {
            nChildLifespanExpireTime = nTimeNow + nChildLifespanMax;
        }
        SetLocalInt(oSpawned, "LifespanExpireTime", nChildLifespanExpireTime);
    }

    // Give Creature Loot
    if (nLootTable > -1)
    {
        DelayCommand(1.0, LootTable(oSpawn, oSpawned, nLootTable));
    }

    // Give RandomGold
    if (nRandomGold > 0)
    {
        // One in Four Creatures give Gold
        if (d100(1) <= nGoldChance)
        {
            // Calculate Gold to Drop
            nGoldAmount = Random(nRandomGold + 1);
            while (nGoldAmount < nRandomGoldMin)
            {
                nGoldAmount = Random(nRandomGold + 1);
            }

            // Give Gold
            CreateItemOnObject("nw_it_gold001", oSpawned, nGoldAmount);
        }
    }

    // Set up Trap on Placeable
    if (GetIsTrapped(oSpawned) && FALSE == nSpawnTrap)
    {
        if (d100(1) <=  nTrapDisabled)
        {
            SetTrapDisabled(oSpawned);
        }
    }

    // Set up Corpse Decay
    if (fCorpseDecay > 0.0)
    {
        SetLocalFloat(oSpawned, "CorpseDecay", fCorpseDecay);
        SetLocalInt(oSpawned, "CorpseDecayType", nCorpseDecayType);
        SetLocalString(oSpawned, "CorpseRemainsResRef", sCorpseRemainsResRef);
        SetLocalInt(oSpawned, "CorpseDropWielded", bDropWielded);
        SetLocalInt(oSpawned, "CorpseDeleteLootOnDecay", bDeleteLootOnDecay);
        AssignCommand(oSpawned, SetIsDestroyable(FALSE, FALSE, FALSE));
    }

    // Set up Death Script
    if (nDeathScript > -1)
    {
        AssignCommand(oSpawned, SetIsDestroyable(FALSE, FALSE, FALSE));
    }

    // Set up Object Effects
    if (nObjectEffect > 0)
    {
        eObject = ObjectEffect(oSpawn);
        if (fObjectEffectDuration == -1.0)
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eObject, oSpawned, 0.0);
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eObject, oSpawned, fObjectEffectDuration);
        }
    }

    // Set up Area Effect
    if (nSpawnAreaEffect > 0 && sSpawnTag == "AE" && fAreaEffectDuration > 0.0)
    {
        DestroyObject(oSpawned, fAreaEffectDuration);
    }

    // Run the Spawn Script
    if (nSpawnScript > -1)
    {
        SetLocalInt(oSpawned, "SpawnScript", nSpawnScript);
        ExecuteScript("spawn_sc_spawn", oSpawned);
    }

    // Set up Random Walking
    if (nRandomWalk == TRUE)
    {
        if (fWanderRange > 0.0)
        {
            AssignCommand(oSpawned, RandomWalk(oSpawn, fWanderRange, FALSE));
        }
        else
        {
            AssignCommand(oSpawned, ActionRandomWalk());
        }
    }

    // Set up the Patrol Route
    if (nPatrolRoute > -1)
    {
        AssignCommand(oSpawned, SetPatrolRoute(nPatrolRoute,
            nPatrolStartAtClosest));
        AssignCommand(oSpawned, DoPatrolRoute(nPatrolRoute, nRouteType));
    }

    // Set up Spawn Sit
    if (nSpawnSit == TRUE)
    {
        FindSeat(oSpawn, oSpawned);
    }

    // Set up loot suppression
    if (nSuppressLooting)
    {
        SetLocalInt(oSpawned, "DoNotLoot", TRUE);
    }

    // Set up subdual mode
    if (nSubdualMode)
    {
        SetLocalInt(oSpawned, "SubdualMode", TRUE);
    }

    // Set up encounter level
    if (nEncounterLevel > 0)
    {
        SetLocalInt(oSpawned, "AlfaEncounterLevel", nEncounterLevel);
    }

    SetupCustomFlags(oSpawn, oSpawned);
}

//

void SetupCampSpawned(object oSpawn, object oSpawned, vector vCampPosition,
   location lHome, string sFlags)
{
    //debug("in setupCampSpawned");

    // This is the closest we get to an "InitFlags" call for camp creatures
    // write the flags onto the spawned creature
    SetLocalString(oSpawned, "CreatureFlags", sFlags);
    int nSpawnFacing = IsFlagPresent(sFlags, "SF");

    object oModule = GetModule();
    int dfLootTable = GetLocalInt(oModule, "df_LootTable");
    int dfLootTable1ItemChance = GetLocalInt(oModule, "df_LootTable1ItemChance");
    int dfLootTable2ItemChance = GetLocalInt(oModule, "df_LootTable2ItemChance");
    int dfLootTable3ItemChance = GetLocalInt(oModule, "df_LootTable3ItemChance");
    int nLootTable = GetFlagValue(sFlags, "LT", dfLootTable);
    int nLootTable1ItemChance = GetSubFlagValue(sFlags, "LT", "A", dfLootTable1ItemChance);
    int nLootTable2ItemChance = GetSubFlagValue(sFlags, "LT", "B", dfLootTable2ItemChance);
    int nLootTable3ItemChance = GetSubFlagValue(sFlags, "LT", "C", dfLootTable3ItemChance);
    if (nLootTable1ItemChance > 100) nLootTable1ItemChance = 100;
    if (nLootTable2ItemChance > 100) nLootTable2ItemChance = 100;
    if (nLootTable3ItemChance > 100) nLootTable3ItemChance = 100;
    // Make %'s available to spawn_cfg_loot
    SetLocalInt(oSpawn, "f_LootTable1ItemChance", nLootTable1ItemChance);
    SetLocalInt(oSpawn, "f_LootTable2ItemChance", nLootTable2ItemChance);
    SetLocalInt(oSpawn, "f_LootTable3ItemChance", nLootTable3ItemChance);

    int nTrapDisabled = GetSubFlagValue(sFlags, "PL", "T", 100);
    int nRandomWalk = IsFlagPresent(sFlags, "RW");
    SetLocalInt(oSpawned, "f_RandomWalk", nRandomWalk);

    float fCorpseDecay = IntToFloat(GetFlagValue(sFlags, "CD", 0));
    int nCorpseDecayType = GetSubFlagValue(sFlags, "CD", "T", 0);
    int nCorpseRemainsType = GetSubFlagValue(sFlags, "CD", "R", 0);
    int bDropWielded = IsSubFlagPresent(sFlags, "CD", "D");

    int nDeathScript = GetFlagValue(sFlags, "DT", -1);
    int nReturnHome = IsFlagPresent(sFlags, "RH");
    SetLocalInt(oSpawned, "f_ReturnHome", nReturnHome);


    if (nReturnHome)
    {
        int dfReturnHomeRange = GetLocalInt(GetModule(), "df_ReturnHomeRange");
        float fReturnHomeRange = IntToFloat(GetFlagValue(sFlags, "RH",
            dfReturnHomeRange));
        SetLocalFloat(oSpawned, "f_ReturnHomeRange", fReturnHomeRange);
        SetLocalFloat(oSpawned, "HomeX", GetPositionFromLocation(lHome).x);
        SetLocalFloat(oSpawned, "HomeY", GetPositionFromLocation(lHome).y);
    }

    // Spawn Facing
    if (nSpawnFacing == TRUE)
    {
        AssignCommand(oSpawned, SetFacingPoint(vCampPosition));
    }
    else
    {
        AssignCommand(oSpawned, SetFacing(IntToFloat(Random(360))));
    }

    // Loot Table
    if (nLootTable > -1)
    {
        LootTable(oSpawn, oSpawned, nLootTable);
    }

    // Trap Disabled
    if (GetIsTrapped(oSpawned))
    {
        if (d100(1) <=  nTrapDisabled)
        {
            SetTrapDisabled(oSpawned);
        }
    }

    // RandomWalk
    if (nRandomWalk == TRUE)
    {
        AssignCommand(oSpawned, ActionRandomWalk());
    }

    // Corpse Decay
    if (fCorpseDecay > 0.0)
    {
        string sCorpseRemainsResRef;
        int bDeleteLootOnDecay = FALSE;

        switch (nCorpseRemainsType)
        {
            case 0: sCorpseRemainsResRef = "invis_corpse_obj"; break;
            case 1: sCorpseRemainsResRef = "invis_corpse_bdy"; break;
            case 2: sCorpseRemainsResRef = "invis_corpse_bon"; break;
            case 3: sCorpseRemainsResRef = "invis_corpse_pot"; break;
            case 4: sCorpseRemainsResRef = "invis_corpse_pch"; break;
            case 5: sCorpseRemainsResRef = "invis_corpse_scr"; break;
            case 6: sCorpseRemainsResRef = "invis_corpse_tre"; break;
            case 7:
                sCorpseRemainsResRef = "invis_corpse_obj";
                bDeleteLootOnDecay = TRUE;
                break;
        }

        // Record CorpseDecay
        SetLocalString(oSpawned, "CorpseRemainsResRef", sCorpseRemainsResRef);
        SetLocalInt(oSpawned, "CorpseDropWielded", bDropWielded);
        SetLocalInt(oSpawned, "CorpseDeleteLootOnDecay", bDeleteLootOnDecay);
        SetLocalFloat(oSpawned, "CorpseDecay", fCorpseDecay);
        SetLocalInt(oSpawned, "CorpseDecayType", nCorpseDecayType);
        AssignCommand(oSpawned, SetIsDestroyable(FALSE, FALSE, FALSE));
    }

    // Death Script
    if (nDeathScript > -1)
    {
        AssignCommand(oSpawned, SetIsDestroyable(FALSE, FALSE, FALSE));
    }
}

int SetupSpawnDelay(int nSpawnDelay, int nDelayRandom, int nDelayMinimum,
   int nTimeNow)
{
    int nNextSpawnTime;

    if (nDelayRandom == TRUE)
    {
        // Setup Next Spawn Randomly
        nNextSpawnTime = Random(nSpawnDelay) + 1;
        while (nNextSpawnTime < nDelayMinimum)
        {
            nNextSpawnTime = Random(nSpawnDelay) + 1;
        }
        nNextSpawnTime += nTimeNow;
    }
    else
    {
        // Setup Next Spawn
        nNextSpawnTime = nTimeNow + nSpawnDelay;
    }
    return nNextSpawnTime;
}

int IsRestoreBlocked(object oSpawn, location lChildLoc, int iExpireTime,
   int nTimeNow)
{
  int nSpawnBlock = FALSE;

  if(GetResRef(oSpawn) == "plc_invisobj") oSpawn = GetLocalObject(oSpawn, "ParentSpawn");

  // Initialize Day/Night Only
  int nDayOnly = GetLocalInt(oSpawn, "f_DayOnly");
  int nDayOnlyDespawn = GetLocalInt(oSpawn, "f_DayOnlyDespawn");
  int nNightOnly = GetLocalInt(oSpawn, "f_NightOnly");
  int nNightOnlyDespawn = GetLocalInt(oSpawn, "f_NightOnlyDespawn");

  // Initialize Day/Hour Spawns
  int nDay, nHour;
  int nSpawnDayStart = GetLocalInt(oSpawn, "f_SpawnDayStart");
  int nSpawnDayEnd = GetLocalInt(oSpawn, "f_SpawnDayEnd");
  int nSpawnHourStart = GetLocalInt(oSpawn, "f_SpawnHourStart");
  int nSpawnHourEnd = GetLocalInt(oSpawn, "f_SpawnHourEnd");

  // Initialize Child Lifespan
  int nChildLifespanMax = GetLocalInt(oSpawn, "f_ChildLifespanMax");

  // Initialize SpawnUnseen
  float fSpawnUnseen = GetLocalFloat(oSpawn, "f_SpawnUnseen");
  int nUnseenIndividual = GetLocalInt(oSpawn, "f_UnseenIndividual");


  // Check Against Spawn Unseen (_SUnn|I_)
  if (fSpawnUnseen > 0.0)
  {
    if (nUnseenIndividual)
    {
      vector vChildPos = GetPositionFromLocation(lChildLoc);

      if (CheckPositionUnseen(vChildPos, fSpawnUnseen) == FALSE)
      {
        nSpawnBlock = TRUE;
      }
    }

    else
    {
      vector vSpawnPos = GetPositionFromLocation(GetLocation(oSpawn));

      if (CheckPositionUnseen(vSpawnPos, fSpawnUnseen) == FALSE)
      {
        nSpawnBlock = TRUE;
      }
    }
  }

  // Check Against Night Only.  Since this is a restore of something already
  // spawned, it should only be blocked if despawn has been specified for the
  // creature (_NOD_)
  if (nNightOnly && nNightOnlyDespawn)
  {
    if (GetIsDay() || GetIsDawn())
    {
      nSpawnBlock = TRUE;
    }
  }

  // Check Against Day Only (_DOD_)
  if (nDayOnly && nDayOnlyDespawn)
  {
    if (GetIsDay() == FALSE && GetIsDawn() == FALSE)
    {
      nSpawnBlock = TRUE;
    }
  }

  // Check Against Specific Day(s) (_DYnn_)
  if (nSpawnDayStart > -1)
  {
      nDay = GetCalendarDay();
      if (IsBetweenDays(nDay, nSpawnDayStart, nSpawnDayEnd) == FALSE)
      {
          nSpawnBlock = TRUE;
      }
  }

  // Check Against Specific Hour(s) (_HRnn_)
  if (nSpawnHourStart > -1)
  {
      nHour = GetTimeHour();
      if (IsBetweenHours(nHour, nSpawnHourStart, nSpawnHourEnd) == FALSE)
      {
          nSpawnBlock = TRUE;
      }
  }

  // Check Lifespan (_CLnn_)
  if (nChildLifespanMax > -1)
  {
      if (nTimeNow >= iExpireTime)
      {
          //debug("restore: lifespawn exceeded");
          nSpawnBlock = TRUE;
      }
  }

  return nSpawnBlock;
}

int NeedPseudoHeartbeat( object oArea )
{
  int bPCsInArea = GetLocalInt( oArea, SPAWN_PCS_IN_AREA );
  int nAreaSpawnCount = GetLocalInt( oArea, SPAWN_AREA_COUNT );
  int bHeartbeatScheduled = GetLocalInt( oArea, SPAWN_HEARTBEAT_SCHEDULED );
  int bLeftoversForceProcessing = GetLocalInt( GetModule(),
     "LeftoversForceProcessing");

  // Do a heartbeat if there are PCs in the area or any spawns up, and we
  // don't already have a heartbeat scheduled

  if (bLeftoversForceProcessing)
  {
    return ( (bPCsInArea || nAreaSpawnCount) && ! bHeartbeatScheduled );
  }

  return ( bPCsInArea  && ! bHeartbeatScheduled );
}

void Spawn_OnAreaEnter( string sHeartbeatScript = "spawn_sample_hb",
  float fHeartbeatInterval = 6.0, float fFirstDelay = 0.0 )
{
  object oPC = GetEnteringObject();
  object oArea = OBJECT_SELF;

  SetLocalString( oArea, SPAWN_HEARTBEAT_SCRIPT, sHeartbeatScript );
  SetLocalFloat( oArea, SPAWN_INTERVAL, fHeartbeatInterval );

  if ( GetIsPC( oPC ) )
  {
    SetLocalInt(oPC, "NESS_Player", TRUE);
    int nPCsInArea = GetLocalInt( oArea, SPAWN_PCS_IN_AREA );
    int nAreaSpawnCount = GetLocalInt( oArea, SPAWN_AREA_COUNT );

    nPCsInArea++;
    SetLocalInt( oArea, SPAWN_PCS_IN_AREA, nPCsInArea );

    if ( NeedPseudoHeartbeat( oArea ) )
    {
      if ( fFirstDelay > 0.0 )
      {
        DelayCommand( fFirstDelay, ExecuteScript( "spawn_pseudohb", oArea ) );
      }

      else
      {
        ExecuteScript( "spawn_pseudohb", oArea );
      }
    }
  }
}

void Spawn_OnAreaExit()
{
  object oPC = GetExitingObject();
  object oArea = OBJECT_SELF;
  int bIsPC = GetLocalInt(oPC, "NESS_Player");

  if ( bIsPC )
  {
    int nPCsInArea = GetLocalInt( oArea, SPAWN_PCS_IN_AREA );
    nPCsInArea--;
    SetLocalInt( oArea, SPAWN_PCS_IN_AREA, nPCsInArea );
  }
}

void ScheduleNextPseudoHeartbeat( object oArea )
{
  float fInterval = GetLocalFloat( oArea, SPAWN_INTERVAL );

  if ( fInterval == 0.0 )
  {
      fInterval = 6.0;
  }

  DelayCommand( fInterval, ExecuteScript( "spawn_pseudohb", oArea ) );
  SetLocalInt( oArea, SPAWN_HEARTBEAT_SCHEDULED, TRUE );
}

void CountAndTrackModuleSpawns( int nAreaSpawnCount )
{
    int nSpawns = GetLocalInt(OBJECT_SELF, "Spawns");
    int nNewAreaSpawnCount = 0;
    // First we count the spawns in the area
    int nNth;
    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        string sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        object oSpawn = GetLocalObject(OBJECT_SELF, sSpawnNum);
        nNewAreaSpawnCount += GetLocalInt(oSpawn, "SpawnCount");
    }
    SetLocalInt(OBJECT_SELF, SPAWN_AREA_COUNT, nNewAreaSpawnCount);
    // Do spawn tracking
    int nTrackModuleSpawns = GetLocalInt(GetModule(), "TrackModuleSpawns");
    // call with old count
    TrackModuleSpawns(nAreaSpawnCount, nTrackModuleSpawns);
    // Do Spawn dumping
    int nDumpModuleSpawns = GetLocalInt(GetModule(), "DumpModuleSpawns");
    if (nDumpModuleSpawns)
    {
        DumpModuleSpawns();
    }
}
//creates a Ness trap
object CreateNessTrap(object oSpawn, int nObjectType, string sTemplate, location lLocation
                        , int nTrapType, int nTrapMinType, int nTrapSize, int nTrapFaction
						, int nTrapDisarmScript, int nTrapTriggerScript)
{
	string sDisarmScript = "";
	string sTriggerScript = "";
	// if a disarm script was specified
	if(0 < nTrapDisarmScript) 
	{
		sDisarmScript = "spawn_sc_trpdis";
	}
	//if a trigger script was specified
	if(0 < nTrapTriggerScript) 
	{
		sTriggerScript = "spawn_sc_trptrig";
	}
	if("" == sTemplate)
	{
		 sTemplate = "NessTrap";
	}
	float fSize = IntToFloat(nTrapSize) / 10.0f;
	
	//if Mintype is greather than type use type as a strength indicator
	//and generate a random type 
	if(nTrapMinType > nTrapType && (nTrapType < 4))
	{
		//There are 11 "tpypes" with 4 strengths
		//This will get you a random type within nTrapType strength
		nTrapType = (4 * Random(11)) + nTrapType; 
	}	
	else
	if(0 <= nTrapMinType)
	{
		nTrapType = nTrapMinType + Random((nTrapType-nTrapMinType)+1);
	}	
	
/*	SendMessageToPC(GetFirstPC(), "Trap Spawned: " +
		"\nnTrapType: " + IntToString(nTrapType) +
		"\nnTrapMinType: "+ IntToString(nTrapMinType) +
		"\nTemplate: " + sTemplate +
		"\nSize: " + FloatToString(fSize) +
		"\nnFaction: " + IntToString(nTrapFaction) +
		"\nnDisarmScriptn: " + sDisarmScript +
		"\nnTriggerScript: " + sTriggerScript);*/
		
	return CreateTrapAtLocation(nTrapType, lLocation, fSize, sTemplate, nTrapFaction, sDisarmScript, sTriggerScript); 
}
//creates a Ness object by either copying or creating and copying
object CreateNessObject(object oSpawn, int nObjectType, string sTemplate, location lLocation
                        , int nCacheCondition = 0, int nCacheBucket = 0)
{
    string sBucketWPTag = "wpNessCachedLoc";
    if(nCacheBucket != 0)
    {
        sBucketWPTag += IntToString(nCacheBucket);
    }

    int nRefCount;
    location lCachedLocation = GetLocation(GetObjectByTag(sBucketWPTag));

    object oModule = GetModule();
    object oCachedObject = GetLocalObject(oModule, sTemplate);

    if(!GetIsObjectValid(oCachedObject))
    {
        if(2 == nCacheCondition)
        {
            return OBJECT_INVALID;
        }

        oCachedObject = CreateObject(nObjectType, sTemplate, lCachedLocation);
        SetLocalObject(oModule, sTemplate, oCachedObject);
    }
    else
    if(1 == nCacheCondition)//if object valid and force cache is true
    {
        // get cached object RefCount
        nRefCount = RefCount(oCachedObject);

        DestroyObject(oCachedObject);
        oCachedObject = CreateObject(nObjectType, sTemplate, lCachedLocation);

        //do refcounting
        if(0 < nRefCount) SetRefOverride(oCachedObject, nRefCount);

        SetLocalObject(oModule, sTemplate, oCachedObject);
    }

    if(!GetIsObjectValid(oCachedObject))
    {
        WriteTimestampedLogEntry("Failed to cache object");
        return CreateObject(nObjectType, sTemplate, lLocation);
    }
    object oSpawned = CopyObjectAndVars(oCachedObject, lLocation);
    AddRef(oCachedObject, oSpawn);
    return oSpawned;
}

//creates a cached object from oSpawned
void CreateCachedObject(object oSpawn, object oSpawned, int nCacheBucket = 0, int nCacheCondition = 0)
{
    string sTemplate = GetResRef(oSpawned);
    object oModule = GetModule();
    string sBucketWPTag = "wpNessCachedLoc";
    int nRefCount = -1;

    if(!GetIsObjectValid(oSpawned)) return;
    if(nCacheBucket != 0)
    {
        sBucketWPTag += IntToString(nCacheBucket);
    }
    location lCachedLocation = GetLocation(GetObjectByTag(sBucketWPTag));

    object oCachedObject = GetLocalObject(oModule, sTemplate);

    if(GetIsObjectValid(oCachedObject))
    {
        if(0 == nCacheCondition)
        {
            AddRef(oCachedObject, oSpawn);
            return;
        }

        //get cached object refcount
        nRefCount = RefCount(oCachedObject);
        DestroyObject(oCachedObject);
    }

    //create cached by copying spawned
    oCachedObject = CopyObjectAndVars(oSpawned, lCachedLocation);
    SetLocalObject(oModule, sTemplate, oCachedObject);

    //do refcounting
    if(0 < nRefCount)
    {
        SetRefOverride(oCachedObject, nRefCount);
    }
    AddRef(oCachedObject, oSpawn);
}

//adds to the refcount of oCachedSpawn
int AddRef(object oCachedSpawn, object oCounter)
{
    if(FALSE == bUseRefCount) return -1;
    if(!GetIsObjectValid(oCachedSpawn) || !GetIsObjectValid(oCounter))
    {
        return -1;
    }
    string sResRef = GetResRef(oCachedSpawn);

    if(0 != GetLocalInt(oCounter, sResRef))
    {
        return 0;
    }
    SetLocalInt(oCounter, sResRef, 1);
    AddRefCountList(oCounter, sResRef);

    int nRefCount = GetLocalInt(oCachedSpawn, REFCOUNT) + 1;
    SetLocalInt(oCachedSpawn, REFCOUNT, nRefCount);

    return nRefCount;
}

//reduces the refcount of oCachedSpawn. If the count drops to zero the cached spawn
//is destroyed
int Release(object oCachedSpawn, object oCounter)
{
    if(FALSE == bUseRefCount) return -1;

    if(!GetIsObjectValid(oCachedSpawn) || !GetIsObjectValid(oCounter))
    {
        return -1;
    }

    string sResRef = GetResRef(oCachedSpawn);
    if(1 != GetLocalInt(oCounter, sResRef))
    {
        return -1;
    }
    SetLocalInt(oCounter, sResRef, 0);

    int nRefCount = GetLocalInt(oCachedSpawn, REFCOUNT) - 1;
    if(0 >= nRefCount)
    {
        DestroyObject(oCachedSpawn);
        return 0;
    }

    SetLocalInt(oCachedSpawn, REFCOUNT, nRefCount);
    return nRefCount;
}

int RefCount(object oCachedSpawn)
{
    if(!GetIsObjectValid(oCachedSpawn)) return -1;
    return GetLocalInt(oCachedSpawn, REFCOUNT);
}

void SetRefOverride(object oCachedSpawn, int nRefCount)
{
    if(GetIsObjectValid(oCachedSpawn))
    {
        SetLocalInt(oCachedSpawn, REFCOUNT, nRefCount);
    }
}

//adds to a running list of templates for caches the spawn point. This
//list is used to release cached spawns when no longer in use.
void AddRefCountList(object oCounter, string sTemplate)
{
    if(!GetIsObjectValid(oCounter)) return;
    if(TRUE == TemplateInRefCountList(oCounter, sTemplate)) return;

    int nRefCountListCount = GetLocalInt(oCounter, "RefCountListCount");
    SetLocalString(oCounter, "RefCountList" + IntToString(nRefCountListCount), sTemplate);
    nRefCountListCount++;
    SetLocalInt(oCounter, "RefCountListCount", nRefCountListCount);
}

int TemplateInRefCountList(object oCounter, string sTemplate)
{
    int nRet = FALSE;
    int nRefCountListCount = GetLocalInt(oCounter, "RefCountListCount");
    if(nRefCountListCount <= 0) return FALSE;

    int nth;
    string sVarTemplate;
    for(nth = 0; nth < nRefCountListCount; nth++)
    {
        sVarTemplate = GetLocalString(oCounter, "RefCountList" + IntToString(nth));
        if(sTemplate == sVarTemplate)
        {
            nRet = TRUE;
            break;
        }

    }

    return nRet;
}

void ReleaseAll(object oCounter)
{
    int nRefCountListCount = GetLocalInt(oCounter, "RefCountListCount");
    if(nRefCountListCount <= 0) return;

    int nth;
    string sVarTemplate;
    object oCachedObject;
    for(nth = 0; nth < nRefCountListCount; nth++)
    {
        sVarTemplate = GetLocalString(oCounter, "RefCountList" + IntToString(nth));

        if(GetLocalInt(oCounter, sVarTemplate) == 1)
        {
            oCachedObject = GetLocalObject(GetModule(), sVarTemplate);
            Release(oCachedObject, oCounter);
        }
    }
}

void ReleaseAreaRefs(object oArea)
{

    // Declare Variables
    object oSpawn;
    string sSpawnName, sSpawnNum;
    int nNth;

    int nSpawns = GetLocalInt(OBJECT_SELF, "Spawns");

    // Enumerate Waypoints in the Area
    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        oSpawn = GetLocalObject(OBJECT_SELF, sSpawnNum);

        // Validate spawn
        if (! GetIsObjectValid( oSpawn ) )
        {
           continue;
        }

        ReleaseAll(oSpawn);
    }
}

// Copies an object and all reference variables
object CopyObjectAndVars(object oSource, location lLocation)
{
	object oRetObject = CopyObject(oSource, lLocation);
	int nVarCount = GetLocalInt(oSource, "VarCount");
 	SetLocalInt(oRetObject, "VarCount", nVarCount);
	int nLoop;
	string sVarName;
	int nType;

	for(nLoop = 1; nLoop <= nVarCount; nLoop++)
	{
		sVarName = GetLocalString(oSource, "VarName" + IntToString(nLoop));

		SetLocalString(oRetObject, "VarName" + IntToString(nLoop), sVarName);
		nType = GetLocalInt(oSource, "VarType" + IntToString(nLoop));
		switch(nType)
		{
			case 1: //integer
				SetLocalInt(oRetObject
					, sVarName
					, GetLocalInt(oSource, sVarName));
			break;
			case 2: //string	
				SetLocalString(oRetObject
					, sVarName
					, GetLocalString(oSource, sVarName));
			break;
		}
		
		SetLocalInt(oRetObject, "VarType" + IntToString(nLoop), nType);
	}

	return oRetObject;
}