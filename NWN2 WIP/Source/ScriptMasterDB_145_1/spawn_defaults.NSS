//
// NESS V8.1.3
//
// Spawn Global Defaults
//
//

// SXn
// Set this value to 1 to have dim returns suppression be the default
// when no SX flag is present.
int nGlobalSuppressDR = 0;

// This is the default value for the SX flag when no value is specified.
// Set to 0 to make SX (without a value) enable dim returns.
int nSuppressDR = 1;

// SPnOn
int nProcessFrequency = 1;
int nProcessOffset = 0;

// ISnDn
// InitialState
int nInitialState = 1;
int nInitialDelay = -1;

// FTn
// FlagTable
int nFlagTableNumber = 0;

// SDn|Mn
// SpawnDelay
int nSpawnDelay = 0;
int nDelayMinimum = 0;

// SNn|Mn SA|n|Mn
// SpawnNumber
int nSpawnNumber = 1;
int nSpawnNumberMin = -1;
int nSpawnNumberAtOnce = 0;
int nSpawnNumberAtOnceMin = 0;

// DYn|Tn
// SpawnDay
int nSpawnDayStart = -1;
int nSpawnDayEnd = -1;

// HRn|Tn
// SpawnHour
int nSpawnHourStart = -1;
int nSpawnHourEnd = -1;

// RW|Rn
// RandomWalk
int nWanderRange = 0;

// RH|Dn
// ReturnHome
int nReturnHomeRange = 1;

// PC|n|R
// PCCheck
int nPCCheckDelay = 0;

// RGn|Mn|Cn
// RandomGold
int nRandomGold = 0;
int nRandomGoldMin = 0;
int nGoldChance = 100;

// FXn|Dn
// SpawnEffects
int nSpawnEffect = 0;
int nDespawnEffect = 0;

// PRn|Tn
// PatrolRoutes
int nPatrolRoute = -1;
int nRouteType = 0;

// PLn|Tn|Pn
// Placeables
int nPlaceableType = 0;
int nPlaceableRefreshPeriod = 60;
int nTrapDisabled = 100;

// LTn|An|Bn|Cn
// LootTable
int nLootTable = -1;

// Cereborn: added 12/31/02
int nLootTable1ItemChance = 50;
int nLootTable2ItemChance = 15;
int nLootTable3ItemChance = 5;

// DSn|Sn
// SpawnDeactivation
int nDeactivateSpawn = -1;
int nDeactivateScript = -1;

// DIn
// DeactivationInfo
int nDeactivationInfo = -1;

// CLn|Mn
// ChildLifespan
int nChildLifespanMax = -1;
int nChildLifespanMin = -1;

// SRn|Mn|P
// SpawnRadius
int nSpawnRadius = 0;
int nSpawnRadiusMin = 0;

// SUn|In
// SpawnUnseen
int nSpawnUnseen = 0;
int nUnseenRetryCount = -1;

// CDn|Tn|Rn|D
// CorpseDecay
int nCorpseDecay = 0;
int nCorpseDecayType = 0;
int nCorpseRemainsType = 0;

// CM|Dn
// SpawnCamp
int nCampDecay = 0;

// SSn|Dn
// SpawnScript
int nSpawnScript = -1;
int nDespawnScript = -1;

// DTn
// DeathScript
int nDeathScript = -1;

// CCn
// SpawnCheckCustom
int nSpawnCheckCustom = -1;

// CPn|Rn
// SpawnCheckPCs
int nSpawnCheckPCs = -1;
int nCheckPCsRadius = -1;

// TRn|Dn
// SpawnTrigger
int nSpawnTrigger = 0;
int nDespawnTrigger = 0;

// AEn|Dn
// AreaEffect
int nSpawnAreaEffect = 0;
int nAreaEffectDuration = 5;

// OEn|Dn
// ObjectEffect
int nObjectEffect = 0;
int nObjectEffectDuration = -1;

// RSn
// RandomSpawn
int nRandomSpawn = 100;

// FCn
// SpawnFaction
int nSpawnFaction = -1;

// ALn|Sn
int nSpawnAlignment = -1;
int nAlignmentShift = 10;

// HBn
// HeartbeatScript
int nHeartbeatScript = -1;

// SLn|Rn
// SpawnLocation
int nSpawnLocation = -1;
int nSpawnLocationMin = -1;

// EEn|Rn
// EntranceExit
int nEntranceExit = -1;
int nEntranceExitMin = -1;
int nExit = -1;
int nExitMin = -1;

// HL|n|E
// HealChildren
int nHealChildren = 0;

// Sittable Tag
string sSeatTag = "Seat";

int nEncounterLevel = 0;
int bLeftoversForceProcessing = 1;
int bCheckForStuckPatrols = 1;
int bAlwaysDestroyCorpses = 1;

//CS|n|Cn|Tn
//Cache Spawn

int nUseCache = 0; //if you set this to 1 then, by default all flags will assume to have basic caching.
int nCacheBucket = 0;
int nCacheCondition = 0;
int nCacheTiming = 0;

//IL
//Spawn light

//SE
//spawn placed effect

//TP
//spawn Trap
int nTrapType = 0;
int nTrapMinType = -1;
int nTrapSize = 10; //This is divided by 10 and converted to a float so 10 = 1.0f
int nTrapFaction = 0;
int nTrapDisarmScript = 0; //index into spawn_sc_trpdis
int nTrapTriggerScript = 0; //index into spawn_sc_trptrig
int nTrapDetectDC = 0;
int nTrapDisarmDC = 0;
int nTrapRecoverable = -1; //determines if trap can be recovered or not.

void SetUserGlobalDefaults();

void SetGlobalDefaults()
{
    SetUserGlobalDefaults();

    // Record Values
    object oModule = GetModule();
    SetLocalInt(oModule, "df_GlobalSuppressDR", nGlobalSuppressDR);
    SetLocalInt(oModule, "df_SuppressDR", nSuppressDR);
    SetLocalInt(oModule, "df_processFrequency", nProcessFrequency);
    SetLocalInt(oModule, "df_processOffset", nProcessOffset);
    SetLocalInt(oModule, "df_InitialState", nInitialState);
    SetLocalInt(oModule, "df_InitialDelay", nInitialDelay);
    SetLocalInt(oModule, "df_FlagTableNumber", nFlagTableNumber);
    SetLocalInt(oModule, "df_SpawnDelay", nSpawnDelay);
    SetLocalInt(oModule, "df_DelayMinimum", nDelayMinimum);
    SetLocalInt(oModule, "df_SpawnNumber", nSpawnNumber);
    SetLocalInt(oModule, "df_SpawnNumberMin", nSpawnNumberMin);
    SetLocalInt(oModule, "df_SpawnNumberAtOnce", nSpawnNumberAtOnce);
    SetLocalInt(oModule, "df_SpawnNumberAtOnceMin", nSpawnNumberAtOnceMin);
    SetLocalInt(oModule, "df_SpawnDayStart", nSpawnDayStart);
    SetLocalInt(oModule, "df_SpawnDayEnd", nSpawnDayEnd);
    SetLocalInt(oModule, "df_SpawnHourStart", nSpawnHourStart);
    SetLocalInt(oModule, "df_SpawnHourEnd", nSpawnHourEnd);
    SetLocalInt(oModule, "df_WanderRange", nWanderRange);
    SetLocalInt(oModule, "df_ReturnHomeRange", nReturnHomeRange);
    SetLocalInt(oModule, "df_PCCheckDelay", nPCCheckDelay);
    SetLocalInt(oModule, "df_RandomGold", nRandomGold);
    SetLocalInt(oModule, "df_RandomGoldMin", nRandomGoldMin);
    SetLocalInt(oModule, "df_GoldChance", nGoldChance);
    SetLocalInt(oModule, "df_SpawnEffect", nSpawnEffect);
    SetLocalInt(oModule, "df_DespawnEffect", nDespawnEffect);
    SetLocalInt(oModule, "df_PatrolRoute", nPatrolRoute);
    SetLocalInt(oModule, "df_RouteType", nRouteType);
    SetLocalInt(oModule, "df_PlaceableType", nPlaceableType);
    SetLocalInt(oModule, "df_PlaceableRefreshPeriod", nPlaceableRefreshPeriod);
    SetLocalInt(oModule, "df_TrapDisabled", nTrapDisabled);
    SetLocalInt(oModule, "df_LootTable", nLootTable);
    SetLocalInt(oModule, "df_LootTable1ItemChance", nLootTable1ItemChance);
    SetLocalInt(oModule, "df_LootTable2ItemChance", nLootTable2ItemChance);
    SetLocalInt(oModule, "df_LootTable3ItemChance", nLootTable3ItemChance);
    SetLocalInt(oModule, "df_DeactivateSpawn", nDeactivateSpawn);
    SetLocalInt(oModule, "df_DeactivateScript", nDeactivateScript);
    SetLocalInt(oModule, "df_DeactivationInfo", nDeactivationInfo);
    SetLocalInt(oModule, "df_ChildLifespanMax", nChildLifespanMax);
    SetLocalInt(oModule, "df_ChildLifespanMin", nChildLifespanMin);
    SetLocalInt(oModule, "df_SpawnRadius", nSpawnRadius);
    SetLocalInt(oModule, "df_SpawnRadiusMin", nSpawnRadiusMin);
    SetLocalInt(oModule, "df_SpawnUnseen", nSpawnUnseen);
    SetLocalInt(oModule, "df_UnseenRetryCount", nUnseenRetryCount);
    SetLocalInt(oModule, "df_CorpseDecay", nCorpseDecay);
    SetLocalInt(oModule, "df_CorpseDecayType", nCorpseDecayType);
    SetLocalInt(oModule, "df_CampDecay", nCampDecay);
    SetLocalInt(oModule, "df_SpawnScript", nSpawnScript);
    SetLocalInt(oModule, "df_DespawnScript", nDespawnScript);
    SetLocalInt(oModule, "df_DeathScript", nDeathScript);
    SetLocalInt(oModule, "df_SpawnCheckCustom", nSpawnCheckCustom);
    SetLocalInt(oModule, "df_SpawnCheckPCs", nSpawnCheckPCs);
    SetLocalInt(oModule, "f_CheckPCsRadius", nCheckPCsRadius);
    SetLocalInt(oModule, "df_SpawnTrigger", nSpawnTrigger);
    SetLocalInt(oModule, "df_DespawnTrigger", nDespawnTrigger);
    SetLocalInt(oModule, "df_SpawnAreaEffect", nSpawnAreaEffect);
    SetLocalInt(oModule, "df_AreaEffectDuration", nAreaEffectDuration);
    SetLocalInt(oModule, "df_ObjectEffect", nObjectEffect);
    SetLocalInt(oModule, "df_ObjectEffectDuration", nObjectEffectDuration);
    SetLocalInt(oModule, "df_RandomSpawn", nRandomSpawn);
    SetLocalInt(oModule, "df_SpawnFaction", nSpawnFaction);
    SetLocalInt(oModule, "df_SpawnAlignment", nSpawnAlignment);
    SetLocalInt(oModule, "df_AlignmentShift", nAlignmentShift);
    SetLocalInt(oModule, "df_HeartbeatScript", nHeartbeatScript);
    SetLocalInt(oModule, "df_SpawnLocation", nSpawnLocation);
    SetLocalInt(oModule, "df_SpawnLocationMin", nSpawnLocationMin);
    SetLocalInt(oModule, "df_EntranceExit", nEntranceExit);
    SetLocalInt(oModule, "df_EntranceExitMin", nEntranceExitMin);
    SetLocalInt(oModule, "df_Exit", nExit);
    SetLocalInt(oModule, "df_ExitMin", nExitMin);
    SetLocalInt(oModule, "df_HealChildren", nHealChildren);
    SetLocalInt(oModule, "df_EncounterLevel", nEncounterLevel);
    SetLocalInt(oModule, "df_CorpseRemainsType", nCorpseRemainsType);


    SetLocalInt(oModule, "df_UseCache", nUseCache);
    SetLocalInt(oModule, "df_CacheBucket", nCacheBucket);
    SetLocalInt(oModule, "df_CacheCondition", nCacheCondition);
    SetLocalInt(oModule, "df_CacheTiming", nCacheTiming);

	SetLocalInt(oModule, "df_TrapType", nTrapType);
	SetLocalInt(oModule, "df_TrapMinType", nTrapMinType);
	SetLocalInt(oModule, "df_TrapSize", nTrapSize);
	SetLocalInt(oModule, "df_TrapFaction", nTrapFaction);
    SetLocalInt(oModule, "df_TrapDisarmScript", nTrapDisarmScript);
    SetLocalInt(oModule, "df_TrapTriggerScrip", nTrapTriggerScript);
    SetLocalInt(oModule, "df_TrapDetectDC", nTrapDetectDC);
    SetLocalInt(oModule, "df_TrapDisarmDC", nTrapDisarmDC);
    SetLocalInt(oModule, "df_TrapRecoverable", nTrapRecoverable);

    SetLocalInt(oModule, "ModuleSpawnCount", 0);

    SetLocalString(oModule, "df_SeatTag", sSeatTag);
    SetLocalInt(oModule, "LeftoversForceProcessing", bLeftoversForceProcessing);
    SetLocalInt(oModule, "CheckForStuckPatrols", bCheckForStuckPatrols);
    SetLocalInt(oModule, "AlwaysDestroyCorpses", bAlwaysDestroyCorpses);

    // Record Initialization
    SetLocalInt(oModule, "GlobalDefaultsInitialized", TRUE);
}