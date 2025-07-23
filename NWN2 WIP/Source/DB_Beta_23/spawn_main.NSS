//
//
//   NESS
//   Spawn Main v2.2 for NWN2
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

// Function Includes
#include "spawn_functions"

//

// Configuration Includes
#include "spawn_cfg_flag"
#include "spawn_cfg_group"
#include "spawn_cfg_global"
#include "spawn_cfg_loot"
#include "spawn_cfg_camp"
#include "spawn_cfg_fxsp"
#include "spawn_cfg_fxae"
#include "spawn_cfg_fxobj"
//

// Check Includes
#include "spawn_chk_pcs"
#include "spawn_chk_custom"
//

// Declare external functions
int GetCurrentRealSeconds();

// Declare Function Includes
void SetGlobalDefaults();
int SetSpawns(location lBase);
string PadIntToString(int nInt, int nDigits);
int CountPCsInArea(object oArea = OBJECT_INVALID, int nDM = FALSE);
int CountPCsInRadius(location lCenter, float fRadius, int nDM = FALSE);
object GetRandomPCInArea(object oArea, object oSpawn);
int IsBetweenDays(int nCheckDay, int nDayStart, int nDayEnd);
int IsBetweenHours(int nCheckHour, int nHourStart, int nHourEnd);
void RandomWalk(object oSpawn, float fWalkingRadius, int nRun);
void FindSeat(object oSpawn, object oSpawned);
void SetPatrolRoute(int nPatrolRoute, int nStartClosest=FALSE);
void DoPatrolRoute(int nPatrolRoute, int nRouteType);
int ProcessCamp(object oCamp);
void DestroyCamp(object oCamp, float fCampDecay, int nSaveState);
//

// Declare Configuration Includes
void LootTable(object oSpawn, object oSpawned, int nLootTable);
string SpawnGroup(object oSpawn, string sTemplate);
int SpawnCheckCustom(object oSpawn);
int SpawnCheckPCs(object oSpawn);
effect SpawnAreaEffect(object oSpawn);
effect ObjectEffect(object oSpawn);
int SpawnEffect(object oSpawn, int nSpawnEffect, int nDespawnEffect);
void SetCampSpawn(object oCamp, string sCamp, location lCamp);
//

//Declare Functions we Define after Main Function
void ProcessSpawn(object oSpawn, int nProcessFrequency, int nPCCount, int nTimeNow,
   int nWaypointCount);
void DoSpawn(object oSpawn, int nTimeNow);
object CampSpawn(object oSpawn, string sCamp, location lCamp);
object DoCampSpawn(object oCamp, location lCamp, float fSpawnRadius,
   string sTemplate, int nPlaceable, int nSpawnNumber, int nCampCenter);

//

// The Spawn Function
void Spawn()
{
	if(GetLocalInt(OBJECT_SELF, "NO_SPAWN")==1)
		return;
	
    // Declare Variables
    object oSpawn;
    string sSpawnName, sSpawnNum;
    int nSpawnDeactivated;
    int nProcessSpawn;
    int nCurrentProcessTick;
    int nProcessFrequency;
    int nProcessOffset;
    int nNth;

    SPAWN_DELAY_DEBUG = GetLocalInt(OBJECT_SELF, "SpawnDelayDebug");
    SPAWN_COUNT_DEBUG = GetLocalInt(OBJECT_SELF, "SpawnCountDebug");

    int bAreaInitialized = GetLocalInt(OBJECT_SELF, "NESS_AreaInitialized");

    if (! bAreaInitialized)
    {
        // Set Global Defaults
        SetGlobalDefaults();

        // Set Spawns
        location lBase = Location(OBJECT_SELF, Vector(), 0.0);
        SetSpawns(lBase);
        SetLocalInt(OBJECT_SELF, SPAWN_AREA_COUNT, 0);
        SetLocalInt(OBJECT_SELF, "NESS_AreaInitialized", TRUE);

        // Recall ourselves after flags have been initialized
        DelayCommand(0.1, Spawn());
        return;
    }

    // Check Area State
    if (GetLocalInt(OBJECT_SELF, "AreaSpawnsDeactivated") == TRUE)
    {
        ReleaseAreaRefs(OBJECT_SELF);
        return;
    }

    int nPCCount = CountPCsInArea(OBJECT_SELF, TRUE);

    int nAreaSpawnCount = GetLocalInt(OBJECT_SELF, SPAWN_AREA_COUNT );
    int bLeftoversForceProcessing = GetLocalInt( GetModule(),
      "LeftoversForceProcessing");

    if (nPCCount == 0 && (nAreaSpawnCount == 0 || ! bLeftoversForceProcessing))
    {
        ReleaseAreaRefs(OBJECT_SELF);
        return;
    }

    int nSpawns = GetLocalInt(OBJECT_SELF, "Spawns");

    // What time is it?  Used to compare all times
    int nTimeNow = GetCurrentRealSeconds();

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
        sSpawnName = GetLocalString(oSpawn, "f_Flags");

        // Check for spawns that need to be processed because they despawned
        // due to a PCxx flag and PCs have returned
        if (nPCCount > 0)
        {
            int nSpawnNumSaveStates = GetLocalInt(oSpawn, "SpawnNumSavedStates");
            int nSpawnNumSaveCampStates = GetLocalInt(oSpawn, "SpawnNumSavedCampStates");
            if (nSpawnNumSaveStates > 0 || nSpawnNumSaveCampStates > 0)
            {
                //debug("forcing respawns");
                RestorePCDespawns(oSpawn, nTimeNow);
                NESS_ForceProcess(oSpawn);
            }
        }

        // Only Process every nProcessFrequency Seconds
        nProcessSpawn = FALSE;
        nProcessFrequency = GetLocalInt(oSpawn, "f_ProcessFrequency");
        nProcessOffset = GetLocalInt(oSpawn, "f_ProcessOffset");
        nCurrentProcessTick = GetLocalInt(oSpawn, "CurrentProcessTick");

        if (nProcessFrequency == 1)
        {
            // Don't even need to bother with CurrentProcessTick or offset
            nProcessSpawn = TRUE;
        }

        else if (nCurrentProcessTick == 0)
        {
            //  First time in. Always process the first time
            nProcessSpawn = TRUE;
            SetLocalInt(oSpawn, "CurrentProcessTick", 2-nProcessOffset);
            //debug("Tick 1");
            //debug("+");
        }

        else
        {
            int nForceProcess = GetLocalInt(oSpawn, "SpawnForceProcess");
            if (nForceProcess)
            {
                SetLocalInt(oSpawn, "SpawnForceProcess", FALSE);
            }

            if (nCurrentProcessTick > nProcessFrequency)
            {
                // Roll over Counter Tick
                nCurrentProcessTick = 1;
                //debug("Tick " + IntToString(nCurrentProcessTick));
                //debug("+");

                nProcessSpawn = TRUE;
            }

            else
            {
                //debug("Tick " + IntToString(nCurrentProcessTick));

                if (nForceProcess)
                {
                    //debug("+ (forced)");
                    nProcessSpawn = TRUE;
                }

            }
            // Increment Counter Tick
            nCurrentProcessTick++;
            SetLocalInt(oSpawn, "CurrentProcessTick", nCurrentProcessTick);
        }

        // Check if Deactivated
        nSpawnDeactivated = GetLocalInt(oSpawn, "SpawnDeactivated");
        if (nSpawnDeactivated == TRUE)
        {
            ReleaseAll(oSpawn);
            nProcessSpawn = FALSE;
        }

        // Process the Spawn
        if (nProcessSpawn == TRUE)
        {
            DelayCommand(0.0, ProcessSpawn(oSpawn, nProcessFrequency,
               nPCCount, nTimeNow, nNth));
        }
    }

    // New in 8.1.4
    DelayCommand(0.1, CountAndTrackModuleSpawns( nAreaSpawnCount ) );
}
//

// This Function Processes a Spawn
void ProcessSpawn(object oSpawn, int nProcessFrequency, int nPCCount,
   int nTimeNow, int nWaypoint)
{
    // Initialize Miscellaneous
    int iCount;
    int jCount;
	
	//This flag gets set to true if spawning lights. Needed so we know
	//Recompute needs to be called
	int bDirtyLight = FALSE;

    // Initialize Spawn and Spawned
    object oCreature, oChild;
    int nSpawnChild, nSpawnCount, nCurrentChildren;
    int nChildSlot, nEmptyChildSlots;
    string sChildSlot,  sChild;
    int nSpawnBlock, nSpawnDespawn, nDespawning;
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    location lSpawn = GetLocation(oSpawn);
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nProcessesPerMinute = 60 / (nProcessFrequency * 6);

    // Get New Name and Tag
    sSpawnName = GetLocalString(oSpawn, "f_Flags");
    sSpawnTag = GetLocalString(oSpawn, "f_Template");

    // Initialize InitialState
    int nInitialState = GetLocalInt(oSpawn, "f_InitialState");
    int nInitialDelay = GetLocalInt(oSpawn, "f_InitialDelay");
    int nNextSpawnTime = GetLocalInt(oSpawn, "NextSpawnTime");

    // Set Initial Delay
    if (nInitialDelay > 0)
    {
        if (GetLocalInt(oSpawn, "InitialDelaySet") == FALSE)
        {
            nNextSpawnTime = nTimeNow + nInitialDelay;
            SpawnDelayDebug(oSpawn, "setting NextSpawnTime for initial delay " +
               IntToString(nNextSpawnTime) + " [" + RealSecondsToString(nNextSpawnTime)
               + "]");
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
            SetLocalInt(oSpawn, "InitialDelaySet", TRUE);
        }
    }

    // Initialize SpawnDelay
    int nSpawnDelay = GetLocalInt(oSpawn, "f_SpawnDelay");
    int nDelayRandom = GetLocalInt(oSpawn, "f_DelayRandom");
    int nDelayMinimum = GetLocalInt(oSpawn, "f_DelayMinimum");
    int nSpawnDelayPeriodic = GetLocalInt(oSpawn, "f_SpawnDelayPeriodic");

    // Initialize SpawnNumber
    int nRndSpawnNumber;
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nSpawnNumberMax = GetLocalInt(oSpawn, "f_SpawnNumberMax");
    int nSpawnNumberMin = GetLocalInt(oSpawn, "f_SpawnNumberMin");
    int nSpawnAllAtOnce = GetLocalInt(oSpawn, "f_SpawnAllAtOnce");
    int nSpawnNumberAtOnce = GetLocalInt(oSpawn, "f_SpawnNumberAtOnce");
    int nSpawnNumberAtOnceMin = GetLocalInt(oSpawn, "f_SpawnNumberAtOnceMin");

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

    // Initialize RandomWalk
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    float fWanderRange = GetLocalFloat(oSpawn, "f_WanderRange");

    // Initialize ReturnHome
    int nReturnHome = GetLocalInt(oSpawn, "f_ReturnHome");
    float fReturnHomeRange = GetLocalFloat(oSpawn, "f_ReturnHomeRange");

    // Initialize PCCheck
    int nPCCheck = GetLocalInt(oSpawn, "f_PCCheck");
    int nPCCheckDelay = GetLocalInt(oSpawn, "f_PCCheckDelay");
    int nPCReset = GetLocalInt(oSpawn, "f_PCReset");

    // Initialize RandomGold
    int nGoldAmount;
    int nRandomGold = GetLocalInt(oSpawn, "f_RandomGold");
    int nRandomGoldMin = GetLocalInt(oSpawn, "f_RandomGoldMin");
    int nGoldChance = GetLocalInt(oSpawn, "f_GoldChance");

    // Initialize Spawn Effects
    effect sSpawn, eDespawn;
    int nSpawnEffect = GetLocalInt(oSpawn, "f_SpawnEffect");
    int nDespawnEffect = GetLocalInt(oSpawn, "f_DespawnEffect");

    // Initialize Patrol Routes
    int nPatrolScriptRunning;
    int nPatrolRoute = GetLocalInt(oSpawn, "f_PatrolRoute");
    int nRouteType = GetLocalInt(oSpawn, "f_RouteType");
    int bCheckForStuckPatrols;
    if (nPatrolRoute)
    {
       bCheckForStuckPatrols = GetLocalInt(GetModule(), "CheckForStuckPatrols");
    }

    // Initialize Placeables
    int nLootTime;
    int nRefreshTime;
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nPlaceableType = GetLocalInt(oSpawn, "f_PlaceableType");
    int nTrapDisabled = GetLocalInt(oSpawn, "f_TrapDisabled");
    int nPlaceableRefreshPeriod =  GetLocalInt(oSpawn, "f_PlaceableRefreshPeriod");

    // Initialize SpawnGroups
    int nSpawnGroup = GetLocalInt(oSpawn, "f_SpawnGroup");

    // Initialize LootTable
    int nLootTable = GetLocalInt(oSpawn, "f_LootTable");

    // Initialize Spawn Deactivation
    int nSpawnDeactivated, nRunDeactivateScript, nSpawnAgeTime;
    int nDeactivateSpawn = GetLocalInt(oSpawn, "f_DeactivateSpawn");
    int nDeactivateScript = GetLocalInt(oSpawn, "f_DeactivateScript");
    int nDeactivationInfo = GetLocalInt(oSpawn, "f_DeactivationInfo");
    int nForceDeactivateSpawn = GetLocalInt(oSpawn, "ForceDeactivateSpawn");

    // Initialize Child Lifespan
    int nChildLifespanExpireTime;
    int nChildLifespanMax = GetLocalInt(oSpawn, "f_ChildLifespanMax");
    int nChildLifespanMin = GetLocalInt(oSpawn, "f_ChildLifespanMin");

    // Initialize SpawnRadius
    float fSpawnRadius = GetLocalFloat(oSpawn, "f_SpawnRadius");
    float fSpawnRadiusMin = GetLocalFloat(oSpawn, "f_SpawnRadiusMin");
    int nSpawnNearPCs = GetLocalInt(oSpawn, "f_SpawnNearPCs");

    // Initialize SpawnUnseen
    float fSpawnUnseen = GetLocalFloat(oSpawn, "f_SpawnUnseen");
    int nUnseenIndividual = GetLocalInt(oSpawn, "f_UnseenIndividual");
    int nUnseenRetryCount = GetLocalInt(oSpawn, "f_UnseenRetryCount");

    // Initialize CorpseDecay
    float fCorpseDecay = GetLocalFloat(oSpawn, "f_CorpseDecay");

    // Initialize SpawnCamp
    int nSpawnCamp = GetLocalInt(oSpawn, "f_SpawnCamp");
    float fCampDecay = GetLocalFloat(oSpawn, "f_CampDecay");

    // Initialize SpawnScripts
    int nSpawnScript = GetLocalInt(oSpawn, "f_SpawnScript");
    int nDespawnScript = GetLocalInt(oSpawn, "f_DespawnScript");

    // Initialize SpawnCheckCustom
    int nSpawnCheckCustom = GetLocalInt(oSpawn, "f_SpawnCheckCustom");

    // Initialize SpawnCheckPCs
    int nSpawnCheckPCs = GetLocalInt(oSpawn, "f_SpawnCheckPCs");

    // Intialize SpawnTrigger
    float fSpawnTrigger = GetLocalFloat(oSpawn, "f_SpawnTrigger");
    float fDespawnTrigger = GetLocalFloat(oSpawn, "f_DespawnTrigger");

    // Initialize AreaEffect
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");
    float fAreaEffectDuration = GetLocalFloat(oSpawn, "f_AreaEffectDuration");

    // Initialize ObjectEffect
    int nObjectEffect = GetLocalInt(oSpawn, "f_ObjectEffect");
    float fObjectEffectDuration = GetLocalFloat(oSpawn, "f_ObjectEffectDuration");

    // Initialize RandomSpawn
    int nRandomSpawn = GetLocalInt(oSpawn, "f_RandomSpawn");

    // Initialize SpawnFaction
    int nSpawnFaction = GetLocalInt(oSpawn, "f_SpawnFaction");

    // Initialize SpawnAlignment
    int nSpawnAlignment = GetLocalInt(oSpawn, "f_SpawnAlignment");
    int nAlignmentShift = GetLocalInt(oSpawn, "f_AlignmentShift");

    // Initialize Heartbeat Script
    int nHeartbeatScript = GetLocalInt(oSpawn, "f_HeartbeatScript");

    // Initialize SpawnLocation
    int nSpawnLocation = GetLocalInt(oSpawn, "f_SpawnLocation");
    int nSpawnLocationMin = GetLocalInt(oSpawn, "f_SpawnLocationMin");
    int nSpawnLocationInd = GetLocalInt(oSpawn, "f_SpawnLocationInd");

    // Initialize SpawnFacing
    int nFacing = GetLocalInt(oSpawn, "f_Facing");
    float fSpawnFacing = GetLocalFloat(oSpawn, "f_SpawnFacing");

    // Initialize EntranceExit
    float fEntranceExitX, fEntranceExitY;
    vector vEntranceExit;
    string sEntranceExit, sExit;
    location lEntranceExit, lExit;
    int nRndExit;
    object oExit;
    int nEntranceExit = GetLocalInt(oSpawn, "f_EntranceExit");
    int nEntranceExitMin = GetLocalInt(oSpawn, "f_EntranceExitMin");
    int nExit = GetLocalInt(oSpawn, "f_Exit");
    int nExitMin = GetLocalInt(oSpawn, "f_ExitMin");

    // Initialize HealChildren
    int nHealAmount;
    effect eEffect;
    int nHealChildren = GetLocalInt(oSpawn, "f_HealChildren");
    int nHealEffects = GetLocalInt(oSpawn, "f_HealEffects");

    // Initialize SpawnItem
    int nSpawnItem = GetLocalInt(oSpawn, "f_SpawnItem");

    // Initialize SpawnSit
    int nSpawnSit = GetLocalInt(oSpawn, "f_SpawnSit");

    // Initialize SpawnPlot
    int nSpawnPlot = GetLocalInt(oSpawn, "f_SpawnPlot");

    // Initialize SpawnMerchant
    int nSpawnMerchant = GetLocalInt(oSpawn, "f_SpawnMerchant");

	// Initialize SpawnIllumination
 	int nSpawnIllumination = GetLocalInt(oSpawn, "f_SpawnIllumination");

	// Initialize SpawnPlacedEffect
 	int nSpawnPlacedEffect = GetLocalInt(oSpawn, "f_SpawnPlacedEffect");

	// Initialize SpawnDoor
 	int nSpawnDoor = GetLocalInt(oSpawn, "f_SpawnDoor");
		    
	// Initialize SpawnTrap
 	int nSpawnTrap = GetLocalInt(oSpawn, "f_SpawnTrap");

	int nPCCheckDespawn = FALSE;

    // decide if we'll despawn this HB due to PC Check
    if (nPCCheck == TRUE)
    {
        //debug("Pc check");
        // Check for PCs
        if (nPCCount == 0)
        {
            int nPCCheckDespawnTime = GetLocalInt(oSpawn, "PCCheckDespawnTime");
            //debug("despawn time = " + IntToString(nPCCheckDespawnTime));
            //debug("time now = " + IntToString(nTimeNow));
            if (nPCCheckDespawnTime == 0)
            {
                nPCCheckDespawnTime = nTimeNow + nPCCheckDelay;
                SetLocalInt(oSpawn, "PCCheckDespawnTime", nPCCheckDespawnTime);
            }
            if (nTimeNow >= nPCCheckDespawnTime)
            {
                nPCCheckDespawn = TRUE;
                SetLocalInt(oSpawn, "PCCheckDespawnTime", 0);
            }
        }
        else
        {
            SetLocalInt(oSpawn, "PCCheckDespawnTime", 0);
        }
    }

    // Enumerate oSpawned Children
    nChildSlot = 1;
    nSpawnCount = 0;
    nEmptyChildSlots = 0;
    int nSpawnDelayTimerExpired = FALSE;

    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Starting Conditional
        nSpawnDespawn = FALSE;
        nDespawning = FALSE;
        nSpawnChild = FALSE;

        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oCreature = GetLocalObject(oSpawn, sChildSlot);
        //debug("checking " + sChildSlot + " of " + IntToString(nSpawnNumber));


        // Check if this is Child Slot is Valid
        if (GetIsObjectValid(oCreature) == FALSE)
        {
            // Empty Slot
            SpawnDelayDebug(oSpawn, "invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature));
            SpawnCountDebug(oSpawn, "invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature));
            nEmptyChildSlots++;

        }
        else
        {
            if (nPlaceable == FALSE && nSpawnCamp == FALSE && nSpawnItem == FALSE 
			&& nSpawnTrap == FALSE && nSpawnIllumination == FALSE && nSpawnPlacedEffect == FALSE)
            {
                // Don't process DM possessed creatures

                if (GetIsDMPossessed( oCreature ) )
                {
                   continue;
                }

                // Check for Corpses
                if (GetIsDead(oCreature) == FALSE)
                {
                    //debug("alive");
                    nSpawnChild = TRUE;
                }
                else
                {
                    // Empty Slot
                    SpawnDelayDebug(oSpawn, "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    SpawnCountDebug(oSpawn, "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    nEmptyChildSlots++;
                    NESS_ProcessDeadCreature(oCreature, oSpawn);
                }
            }
            else
            {
                nSpawnChild = TRUE;
            }
        }

        if (nSpawnChild == TRUE)
        {
            // Add to Count Total
            nSpawnCount++;
            //SpawnCountDebug("+ spawn count to " + IntToString(nSpawnCount));
            nSpawnBlock = FALSE;

            // Check Despawning
            nDespawning = GetLocalInt(oCreature, "Despawning");

            // Check Force Despawn
            if (GetLocalInt(oCreature, "ForceDespawn") == TRUE)
            {
                //debug("force despawn");
                nDespawning = TRUE;
                nSpawnDespawn = TRUE;
            }

            // Get Creature Home
            float fHomeX = GetLocalFloat(oCreature, "HomeX");
            float fHomeY = GetLocalFloat(oCreature, "HomeY");
            vector vHome = Vector(fHomeX, fHomeY, 0.0);
            location lHome = Location(OBJECT_SELF, vHome, 0.0);

            // Check Facing
            float fChildFacing = GetLocalFloat(oCreature, "SpawnFacing");

            // Check Lifespan
            if (nChildLifespanMax > -1)
            {
                nChildLifespanExpireTime = GetLocalInt(oCreature, "LifespanExpireTime");
                if (nTimeNow >= nChildLifespanExpireTime)
                {
                    //debug("despawn: lifespawn exceeded");
                    nSpawnDespawn = TRUE;
                }
            }

            // Day Only
            if (nDayOnlyDespawn == TRUE && (nDayOnly == TRUE && (GetIsDay() == FALSE && GetIsDawn() == FALSE)))
            {
                //debug("despawn: night time for DO spawn");
                nSpawnDespawn = TRUE;
            }

            // Night Only
            if (nNightOnlyDespawn == TRUE && (nNightOnly == TRUE && (GetIsNight() == FALSE && GetIsDusk() == FALSE)))
            {
                //debug("despawn: day for NO spawn");
                nSpawnDespawn = TRUE;
            }

            // Check Against Day
            if (nSpawnDayStart > -1)
            {
                nDay = GetCalendarDay();
                if (IsBetweenDays(nDay, nSpawnDayStart, nSpawnDayEnd) == FALSE)
                {
                    //debug("despawn: not right day");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Against Hour
            if (nSpawnHourStart > -1)
            {
                nHour = GetTimeHour();
                if (IsBetweenHours(nHour, nSpawnHourStart, nSpawnHourEnd) == FALSE)
                {
                    //debug("despawn: not right hour");
                    nSpawnDespawn = TRUE;
                }
            }

            // Random Walk
            if (nRandomWalk == TRUE && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (GetCurrentAction(oCreature) != ACTION_WAIT &&
                    GetCurrentAction(oCreature) != ACTION_CASTSPELL &&
                   !GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                {
                    if (d2(1) == 2)
                    {
                        if (fWanderRange > 0.0)
                        {
                            //AssignCommand(oCreature, ClearAllActions());
                            //RandomWalk(oSpawn, oCreature, fWanderRange, FALSE);
                            AssignCommand(oCreature, RandomWalk(oSpawn,
                               fWanderRange, FALSE));
                        }
                        else
                        {
                            AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionRandomWalk());
                        }
                    }
                }
            }

            // Patrol
            if (nPatrolRoute > -1 && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (!GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                {

                    nPatrolScriptRunning = GetLocalInt(oCreature, "PatrolScriptRunning");
                    if (GetCurrentAction(oCreature) == ACTION_INVALID && nPatrolScriptRunning == FALSE)
                    {
                        // He's Slacking!  Send him back to work!
                        //AssignCommand(oCreature, ClearAllActions());
                        AssignCommand(oCreature, SetPatrolRoute(nPatrolRoute));
                        AssignCommand(oCreature, DoPatrolRoute(nPatrolRoute, nRouteType));
                    }

                    else if (bCheckForStuckPatrols)
                    {
                        CheckForStuckPatrol(oCreature, nPatrolRoute, nRouteType);
                    }
                }
                else if (IsInConversation(oCreature) == TRUE)
                {
                    // Reset Script State
                    SetLocalInt(oCreature, "PatrolScriptRunning", FALSE);
                }
            }

            // ReturnHome
            if (nReturnHome == TRUE && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (GetDistanceBetweenLocations(lHome, GetLocation(oCreature)) > fReturnHomeRange)
                {
                    if (GetCurrentAction(oCreature) == ACTION_INVALID && !GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                    {
                        // Send them back to Home
                        //AssignCommand(oCreature,ClearAllActions());
                        //AssignCommand(oCreature,ActionMoveToLocation(lHome));
                        AssignCommand(oCreature, ReturnHome(lHome));

                        if (nFacing == TRUE)
                        {
                            AssignCommand(oCreature, ActionDoCommand(SetFacing(fChildFacing)));
                        }
                    }
                }
            }

            // PC Check
            if (nPCCheckDespawn == TRUE)
            {
                //debug("despawn: PC Check");
               nSpawnDespawn = TRUE;
            }

            // Check Camp
            if (nSpawnCamp == TRUE)
            {
                if (ProcessCamp(oCreature) == 0)
                {
                    //debug("despawn: camp state is 0");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Trigger
            if (fDespawnTrigger > 0.0)
            {
                if (CountPCsInRadius(lSpawn, fDespawnTrigger, TRUE) == 0)
                {
                    //debug("despawn: PCs in despawn trigger");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Placeable
            if (nPlaceable == TRUE)
            {
                // Despawn if Empty
                if (nPlaceableType == 1)
                {
                    if (GetFirstItemInInventory(oCreature) == OBJECT_INVALID)
                    {
                        //debug("despawn: empty placeable");
                        nSpawnDespawn = TRUE;
                    }
                }
                // Generate Loot if Empty
                else if (nPlaceableType == 2)
                {
                    if (GetFirstItemInInventory(oCreature) == OBJECT_INVALID && GetIsOpen(oCreature) == FALSE)
                    {
                        // Check Delay Timer
                        if (nSpawnDelay > 0)
                        {
                            nLootTime = GetLocalInt(oCreature, "LootTime");
                            if (nLootTime == 0)
                            {
                                // first time
                                if (nDelayRandom == TRUE)
                                {
                                    nLootTime = -1;
                                    while (nLootTime < nDelayMinimum)
                                    {
                                        nLootTime = Random(nSpawnDelay) + 1;
                                    }
                                }
                                else
                                {
                                    // Setup Next Spawn
                                    nLootTime = nSpawnDelay;
                                }
                                nLootTime += nTimeNow;
                                SetLocalInt(oCreature, "LootTime", nLootTime);
                            }
                        }
                        else
                        {
                            nLootTime = nTimeNow;
                        }

                        if (nTimeNow >= nLootTime)
                        {
                            // Give Random Gold
                            if (nRandomGold > 0)
                            {
                                if (d100(1) <= nGoldChance)
                                {
                                    // Calculate Gold to Drop
                                    nGoldAmount = Random(nRandomGold + 1);
                                    while (nGoldAmount < nRandomGoldMin)
                                    {
                                        nGoldAmount = Random(nRandomGold + 1);
                                    }
                                    // Give Gold
                                    CreateItemOnObject("nw_it_gold001", oCreature,
                                       nGoldAmount);
                                }
                            }
                            // Generate New Loot
                            if (nLootTable > -1)
                            {
                                LootTable(oSpawn, oCreature, nLootTable);
                            }

                            if (nSpawnDelay > 0)
                            {
                                // Set up Delay for next time
                                if (nDelayRandom == TRUE)
                                {
                                    nLootTime = -1;
                                    while (nLootTime < nDelayMinimum)
                                    {
                                        nLootTime = Random(nSpawnDelay) + 1;
                                    }
                                }
                                else
                                {
                                    // Setup Next Spawn
                                    nLootTime = nSpawnDelay;
                                }
                                nLootTime += nTimeNow;
                                SetLocalInt(oCreature, "LootTime", nLootTime);
                            }
                        } // end if time to refill
                    } // end if empty
                } // end if placeable-type == 2

                else if (nPlaceableType == 3)
                {
                    nRefreshTime = GetLocalInt(oCreature, "RefreshTime");
                    if (nRefreshTime == 0)
                    {
                        nRefreshTime = nTimeNow + nPlaceableRefreshPeriod;
                        SetLocalInt(oCreature, "RefreshTime", nRefreshTime);
                    }
                    //debug("time now: " + IntToString(nTimeNow));
                    //debug("refesh at: " + IntToString(nRefreshTime));
                    if (nTimeNow >= nRefreshTime)
                    {
                        if (!GetIsOpen(oCreature))
                        {
                            // Do the refresh

                            // Despawn the current placeable
                            //debug("despawn: placeable refresh");
                            nSpawnDespawn = TRUE;

                            // Override SpawnDelay for respawn
                            SetLocalInt(oSpawn, "OverrideSpawnDelay", 1);

                            // let the system know this is gone this frame
                            nEmptyChildSlots++;
                        }
                    }
                }
            }

            // Run Heartbeat Script
            if (nHeartbeatScript > -1 && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                SetLocalInt(oCreature, "HeartbeatScript", nHeartbeatScript);
                ExecuteScript("spawn_sc_hbeat", oCreature);
            }

            // Set Facing
            if (nFacing == TRUE && nDespawning == FALSE)
            {
                if (GetFacing(oCreature) != fChildFacing && IsInConversation(oCreature) == FALSE && GetIsInCombat(oCreature) == FALSE && GetDistanceBetweenLocations(lHome, GetLocation(oCreature)) < 1.0)
                {
                    AssignCommand(oCreature, ActionDoCommand(SetFacing(fChildFacing)));
                }
            }

            // Heal Children
            if (nHealChildren > 0)
            {
                if (GetIsInCombat(oCreature) == FALSE && (GetMaxHitPoints(oCreature) != GetCurrentHitPoints(oCreature)))
                {
                    nHealAmount = FloatToInt(IntToFloat(GetMaxHitPoints(oCreature)) * (IntToFloat(nHealChildren) / 100.0));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHealAmount), oCreature, 0.0);
                    if (nHealEffects == TRUE)
                    {
                        eEffect = GetFirstEffect(oCreature);
                        while (GetIsEffectValid(eEffect) == TRUE)
                        {
                            RemoveEffect(oCreature, eEffect);
                            eEffect = GetNextEffect(oCreature);
                        }
                    }
                }
            }

            // Spawn Sit
            if (nSpawnSit == TRUE && nDespawning == FALSE)
            {
                if (GetCurrentAction(oCreature) != ACTION_SIT)
                {
                    if (GetIsInCombat(oCreature) == FALSE && IsInConversation(oCreature) == FALSE)
                    {
                        FindSeat(oSpawn, oCreature);
                    }
                }
            }

            // Check if Item is Possessed by Someone
            if (nSpawnItem == TRUE)
            {
                if (GetItemPossessor(oCreature) != OBJECT_INVALID)
                {
                    // Remove Child Status
                    DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"));
                }
            }

            // Population Control
            if (nSpawnCount > nSpawnNumber)
            {
                nSpawnDespawn = TRUE;
                nSpawnBlock = TRUE;
            }
        }


        // Despawn Creatures
        //if (GetIsDM(object) == TRUE || GetIsDM(GetMaster(object)) == TRUE)
        if (nSpawnDespawn == TRUE && ! GetIsDM(oCreature) &&
                                     ! GetIsDM(GetMaster(oCreature)))
        {
            int nSaveState = nPCCheckDespawn && ! nPCReset;
            SetLocalInt(oCreature, "Despawning", TRUE);
            if (nSpawnPlot == TRUE)
            {
                SetPlotFlag(oCreature, FALSE);
            }
            if (nPlaceable == TRUE || nSpawnCamp == TRUE || nSpawnItem == TRUE
                || nSpawnMerchant == TRUE || nSpawnPlacedEffect == TRUE
				|| nSpawnIllumination == TRUE || TRUE == nSpawnDoor
				|| TRUE == nSpawnTrap)
            {
                if (nDespawnScript > -1)
                {
                    SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                    ExecuteScript("spawn_sc_spawn", oCreature);
                }
                if (nSpawnCamp == TRUE)
                {
                    // Destroy camp will save info about what in the camp is
                    // still present on the camp object (oCreature in this
                    // case) if nSaveState is true
                    DestroyCamp(oCreature, fCampDecay, nSaveState);
                    //if (! nSaveState)
                    //{
                    //    // This isn't a PC despawn, so set up SD if needed
                    //    if (nSpawnDelay && nNextSpawnTime == 0)
                    //    {
                    //        nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
                    //           nDelayRandom, nDelayMinimum, nTimeNow);
                    //        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                    //    }
                    //}
                }

                if (nDespawnEffect > 0)
                {
                    eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn,
                       GetLocation(oCreature), 5.0);
                }

                // remove the child object from the spawn
                DeleteLocalObject(oSpawn, GetLocalString(oCreature,
                   "ParentChildSlot"));

                if (nSaveState)
                {
                    if (nSpawnCamp)
                    {
                        SaveCampStateOnDespawn(oCreature, oSpawn);
                    }
                    else
                    {
                        SaveStateOnDespawn(oCreature, oSpawn);
                    }

                }

                // saved camp states don't get destroyed; but everything else
                // (including unsaved camp states do
                if (! (nSaveState && nSpawnCamp))
                {
                    NESS_CleanInventory(oCreature);
                    AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE,
                       FALSE));
                    SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));
					
					//recompute for lights
					if(TRUE == nSpawnIllumination)
					{	
						bDirtyLight = TRUE;
					}
					DestroyObject(oCreature);
					
                }
                nSpawnCount--;
                //debug("- spawn count to " + IntToString(nSpawnCount));
            }
            else  // is not placeable, camp, item, or merchant
            {
                if ((!GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                   || (nPCCheck == TRUE && nPCCount == 0))
                {
                    AssignCommand(oCreature, ClearAllActions());
                    AssignCommand(oCreature, ActionWait(1.0) );
                    
					if (nEntranceExit > -1 || nExit > -1)
                    {
                        if (nExit > -1)
                        {
                            if (nExitMin > -1)
                            {
                                nRndExit = Random(nExit + 1);
                                while (nRndExit < nExitMin)
                                {
                                    nRndExit = Random(nExit + 1);
                                }
                                nExit = nRndExit;
                            }
                            sExit = "EX" + PadIntToString(nExit, 2);
                            oExit = GetNearestObjectByTag(sExit, oSpawn);
                            lExit = GetLocation(oExit);
                            //AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionMoveToLocation(lExit));
                        }
                        else
                        {
                            // Get Creature EntranceExit
                            fEntranceExitX = GetLocalFloat(oCreature, "EntranceExitX");
                            fEntranceExitY = GetLocalFloat(oCreature, "EntranceExitY");
                            vEntranceExit = Vector(fEntranceExitX, fEntranceExitY, 0.0);
                            lEntranceExit = Location(OBJECT_SELF, vEntranceExit, 0.0);
                            //AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionMoveToLocation(lEntranceExit));
                        }
                        if (nDespawnScript > -1)
                        {
                            SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                            ExecuteScript("spawn_sc_spawn", oCreature);
                        }
                        if (nDespawnEffect > 0)
                        {
                            eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                            AssignCommand(oCreature, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn, GetLocation(oCreature), 5.0)));
                        }
                        AssignCommand(oCreature, ActionDoCommand(DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"))));
                        AssignCommand(oCreature, ActionDoCommand(NESS_CleanInventory(oCreature)));
                        if (nSaveState)
                        {
                            AssignCommand(oCreature, ActionDoCommand(
                               SaveStateOnDespawn(oCreature, oSpawn)));
                        }

                        AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
                        SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));

                        AssignCommand(oCreature, ActionDoCommand(DestroyObject(oCreature)));
                    }
                    else // doesn't have to exit at a specific place
                    {
                        if (nDespawnScript > -1)
                        {
                            SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                            ExecuteScript("spawn_sc_spawn", oCreature);
                        }
                        if (nDespawnEffect > 0)
                        {
                            eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn, GetLocation(oCreature), 5.0);
                        }
                        DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"));
                        NESS_CleanInventory(oCreature);
                        if (nSaveState)
                        {
                            SaveStateOnDespawn(oCreature, oSpawn);
                        }

                        AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
                        SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));

                        DestroyObject(oCreature);
                    }
                    nSpawnCount--;
                    //debug("- spawn count to " + IntToString(nSpawnCount));

                }
            }
        }
    }

    if (nPCCheckDespawn && (nPCReset == TRUE))
    {
        //debug("reset");
        ResetSpawn(oSpawn, nTimeNow);
    }

    //++ Done processing living children

    // Record SpawnCount
    SetLocalInt(oSpawn, "SpawnCount", nSpawnCount);
    //SpawnCountDebug("set spawn count to " + IntToString(nSpawnCount));

    // Recalculate spawn number if random spawn number range in use...
    if (nSpawnCount == 0 && (!nPCCheckDespawn) && nSpawnNumberMin > -1 && nPCCount > 0)
    {
        nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        while (nRndSpawnNumber < nSpawnNumberMin)
        {
            nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        }
        nSpawnNumber = nRndSpawnNumber;
        nEmptyChildSlots = nSpawnNumber;
        SetLocalInt(oSpawn, "f_SpawnNumber", nSpawnNumber);
        SpawnCountDebug(oSpawn, "spawn number set to " + IntToString(nSpawnNumber));
        SpawnCountDebug(oSpawn, "empty slots is " + IntToString(nEmptyChildSlots));
    }

    // Check InitialState
    if (nInitialState == 0)
    {
        if (GetLocalInt(oSpawn, "InitialStateProcessed") == FALSE)
        {
            nForceDeactivateSpawn = TRUE;
            SetLocalInt(oSpawn, "InitialStateProcessed", TRUE);
        }
    }

    // Check to Deactivate Spawn
    if (nDeactivateSpawn > -1 || nForceDeactivateSpawn == TRUE)
    {
        nSpawnDeactivated = FALSE;
        nRunDeactivateScript = FALSE;
        if (nForceDeactivateSpawn == FALSE)
        {
            switch (nDeactivateSpawn)
            {
                // Deactivate if all Children are Dead
                case 0:
                    if (nSpawnCount == 0 && nChildrenSpawned != 0)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate if Spawned SpawnNumber Children
                case 1:
                    if (nChildrenSpawned >= nSpawnNumber)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Temporary Pause until all Children are Dead
                case 2:
                    if (nSpawnCount != 0)
                    {
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate after DI00 Children Spawned
                case 3:
                    if (nChildrenSpawned >= nDeactivationInfo)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate after DI00 Minutes  (converted to seconds)
                case 4:
                // Deactivate after DI00 Cycles (converted to seconds
                case 5:
                    nSpawnAgeTime = GetLocalInt(oSpawn, "SpawnAgeTime");
                    if (nSpawnAgeTime == 0)
                    {
                        // first time
                        nSpawnAgeTime = nTimeNow + nDeactivationInfo;
                    }

                    if (nTimeNow >= nSpawnAgeTime)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                    SetLocalInt(oSpawn, "SpawnAgeTime", nSpawnAgeTime);
                break;
                // Deactivate when spawn count == spawn number
                case 6:
                    if (nSpawnCount >= nSpawnNumber)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
            }
        }
        else
        {
            // Force Deactivate
            nSpawnDeactivated = TRUE;
            nRunDeactivateScript = TRUE;
            nSpawnBlock = TRUE;
            SetLocalInt(oSpawn, "ForceDeactivateSpawn", FALSE);
        }

        // Record Deactivated State
        SetLocalInt(oSpawn, "SpawnDeactivated", nSpawnDeactivated);

        // Run Deactivation Script
        if (nRunDeactivateScript == TRUE && nDeactivateScript > -1)
        {
            SetLocalInt(oSpawn, "DeactivateScript", nDeactivateScript);
            ExecuteScript("spawn_sc_deactiv", oSpawn);
            SetLocalInt(oSpawn, "DeactivateScript", -1);
        }
    }

    //++ Done checking deactivation

    // Check Number of Creatures against nSpawnNumber
    if (nEmptyChildSlots > 0)
    {
        // If there are empty slots and nSpawnDelay is true and nNextSpawnTime is 0
        // (which indicates no timer is currently set) and this isn't the first time
        // we've ever spawned (as indicated by nNumberChildrenSpawned) and we're not
        // despawning because PCs have left we should
        // set up a timer
        if (nSpawnDelay && (! nSpawnDelayPeriodic) &&
            nChildrenSpawned > 0 && nNextSpawnTime == 0 && nPCCount > 0 )
        {
            nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
               nDelayRandom, nDelayMinimum, nTimeNow);
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
            SpawnDelayDebug(oSpawn, "setup spawn delay: " + IntToString(nNextSpawnTime)
            + " [" + RealSecondsToString(nNextSpawnTime) + "]");
            SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
            + " [" + RealSecondsToString(nTimeNow) + "]");
        }

        SpawnCountDebug(oSpawn, IntToString(nEmptyChildSlots) + " empty slots");

        // Check Against Spawn Unseen
        if (fSpawnUnseen > 0.0 && ! nUnseenIndividual)
        {
            if (nEntranceExit > -1)
            {
                fEntranceExitX = GetLocalFloat(oCreature, "EntranceExitX");
                fEntranceExitY = GetLocalFloat(oCreature, "EntranceExitY");
                vEntranceExit = Vector(fEntranceExitX, fEntranceExitY, 0.0);
                lEntranceExit = Location(OBJECT_SELF, vEntranceExit, 0.0);
                oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                   lEntranceExit, FALSE, OBJECT_TYPE_CREATURE);
            }
            else
            {
                oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                   lSpawn, FALSE, OBJECT_TYPE_CREATURE);
            }
            while (oCreature != OBJECT_INVALID)
            {
                if (GetIsPC(oCreature) == TRUE)
                {
                    nSpawnBlock = TRUE;
                    oCreature = OBJECT_INVALID;
                }
                if (nEntranceExit > -1)
                {
                    oCreature = GetNextObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                       lEntranceExit, FALSE, OBJECT_TYPE_CREATURE);
                }
                else
                {
                    oCreature = GetNextObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                       lSpawn, FALSE, OBJECT_TYPE_CREATURE);
                }
            }
        }

        // Check Against Day or Night Only
        if ((nNightOnly == TRUE && (GetIsNight() == FALSE && GetIsDusk() == FALSE)) || (nDayOnly == TRUE && (GetIsDay() == FALSE && GetIsDawn() == FALSE)))
        {
            nSpawnBlock = TRUE;
        }

        // Check Against Day
        if (nSpawnDayStart > -1)
        {
            nDay = GetCalendarDay();
            if (IsBetweenDays(nDay, nSpawnDayStart, nSpawnDayEnd) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Against Hour
        if (nSpawnHourStart > -1)
        {
            nHour = GetTimeHour();
            if (IsBetweenHours(nHour, nSpawnHourStart, nSpawnHourEnd) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Against PCCheck
        if (nPCCheck == TRUE)
        {
            // Check for PCs
            if (CountPCsInArea(OBJECT_SELF, TRUE) == 0)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Trigger
        if (fSpawnTrigger > 0.0)
        {
            //debug("checking trigger");
            if (CountPCsInRadius(lSpawn, fSpawnTrigger, TRUE) == 0)
            {
                //debug("no one close");
                nSpawnBlock = TRUE;
            }
            else
            {
                //debug("trigger tripped");
            }
        }

        // Check Spawn Check PCs
        if (nSpawnCheckPCs > -1)
        {
            // If Spawn Cannot Proceed, Block
            if (SpawnCheckPCs(oSpawn) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Spawn Check Custom
        if (nSpawnCheckCustom > -1)
        {
            // If Spawn Cannot Proceed, Block
            if (SpawnCheckCustom(oSpawn) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        if (nSpawnBlock == FALSE)
        {

            // Check the spawn delay timer
            int nOverrideSpawnDelay = GetLocalInt(oSpawn, "OverrideSpawnDelay");
            if (nSpawnDelay || nInitialDelay)
            {
                // need to refetch, as the death of a child may have changed it
                //nNextSpawnTime = GetLocalInt(oSpawn, "NextSpawnTime");
                //debug("next spawn time: " + IntToString(nNextSpawnTime));
                //debug("time now: " + IntToString(nTimeNow));
                if ((nTimeNow >= nNextSpawnTime)  && (! nPCCheck || nPCCount > 0))
                {
                    nSpawnDelayTimerExpired = TRUE;

                    if (nInitialDelay)
                    {
                        nInitialDelay = 0;
                        SetLocalInt(oSpawn, "f_InitialDelay", nInitialDelay );
                    }

                    if (! nSpawnDelayPeriodic)
                    {
                        SpawnDelayDebug(oSpawn, "SD timer expired: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");

                        nNextSpawnTime = 0;
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                    }
                }
            }


            // Check Against spawn delay (SD flag)
            //debug("SpawnDelayTimerExpired: " + IntToString(nSpawnDelayTimerExpired));

            if ( ( (!nSpawnDelay || nOverrideSpawnDelay) && ! nInitialDelay ) ||
                nSpawnDelayTimerExpired )
            {
                //debug("respawn after delay");
                SetLocalInt(oSpawn, "OverrideSpawnDelay", 0);

                // Check RandomSpawn
                if (d100() <= nRandomSpawn)
                {
                    SpawnDelayDebug(oSpawn, "spawn!");
                    //debug("periodic: " + IntToString(nSpawnDelayPeriodic));
                    //debug("nChildrenSpawned: " + IntToString(nChildrenSpawned));
                    // Set up periodic spawn delay if first spawn
                    if (nSpawnDelayPeriodic && nChildrenSpawned == 0)
                    {
                        // little kludge here.  Knock a second off so it
                        // won't roll over when we get to the bottom of this
                        // function.  Avoids creating yet another special flag
                        nNextSpawnTime = nTimeNow + nSpawnDelay - 1;
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                        //debug("setup first periodic delay: " + IntToString(nNextSpawnTime));
                    }

                    if (nSpawnAllAtOnce == FALSE)
                    {
                        // Spawn another Creature
                        DoSpawn(oSpawn, nTimeNow);
                    }
                    else
                    {
                        if (nSpawnNumberAtOnce > 0)
                        {
                            if (nSpawnNumberAtOnceMin == 0 || nEmptyChildSlots >= nSpawnNumberAtOnceMin)
                            {
                                // Spawn Sets of Creatures
                                for (jCount = 1; (jCount <= nEmptyChildSlots) && (jCount <= nSpawnNumberAtOnce); jCount++)
                                {
                                    DelayCommand(0.0, DoSpawn(oSpawn, nTimeNow));
                                }
                            }
                        }
                        else
                        {
                            // Spawn All Creatures
                            for (jCount = 1; jCount <= nEmptyChildSlots; jCount++)
                            {
                                DelayCommand(0.0, DoSpawn(oSpawn, nTimeNow));
                            }
                        }
                    }
                
					//if we're spawning lights need to recompute
					if(TRUE == nSpawnIllumination)
					{	
						bDirtyLight = TRUE;
					}	
				} // end RS

                else
                {
                    SpawnDelayDebug(oSpawn, "Spawn blocked by RS");
                    if (nSpawnDelay && ! nSpawnDelayPeriodic)
                    {
                        // reset spawn delay timer
                        nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
                           nDelayRandom, nDelayMinimum, nTimeNow);
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                        SpawnDelayDebug(oSpawn, "setup spawn delay: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");


                    }
                }

            } // end spawn delay test
        }  // end if not spawn blocked (PC check or spawn unseen, for instance)
    } // end if empty slots

    // If the SD is periodic, check for rollover
    if (nSpawnDelayPeriodic)
    {
        // if next spawn time is zero, there is no timer in play
        if (nNextSpawnTime > 0 && nTimeNow >= nNextSpawnTime)
        {
            // Setup Next Spawn
            //debug("rollover - timeNow: " + IntToString(nTimeNow) + " nNextSpawnTime: "
            //    + IntToString(nNextSpawnTime));
            nNextSpawnTime += nSpawnDelay;
            //debug("setup new periodic delay: " + IntToString(nNextSpawnTime));
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
        }
    }

	//if we spawned or despawned lights then we need to recompute the lighting
	if(TRUE == bDirtyLight)
	{	
		bDirtyLight = FALSE;
		DelayCommand(0.9,RecomputeStaticLighting(GetArea(oCreature)));	
	}
}
//

// This Function Performs the Spawn
void DoSpawn(object oSpawn, int nTimeNow)
{
    vector vSpawnPos;
    // lHome is the location of the actual spawn waypoint
    location lHome;
    // The location of an entrance waypoint to spawn in at instead of lHome
    location lEntranceExit;
    // lSpawnLocation is where we actually spawn in
    location lSpawnLocation;
    float fRadius, fRadiusX, fRadiusY, fSpawnAngle;
    object oSpawned, oEntranceExit, oSpawnLocation, oPC;
    effect eSpawn, eArea;
    int nObjectType, nRadiusValid;
    int nRndEntranceExit;
    string sTemplate, sEntranceExit;
    int nUnseenTryCount, nUnseen;
    int nWalkToHome = FALSE;

    // Initialize Variables
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    // location lSpawn = GetLocation(oSpawn);
    float fSpawnRadius = GetLocalFloat(oSpawn, "f_SpawnRadius");
    float fSpawnRadiusMin = GetLocalFloat(oSpawn, "f_SpawnRadiusMin");
    int nSpawnNearPCs = GetLocalInt(oSpawn, "f_SpawnNearPCs");
    float fSpawnFacing;
    int nFacing = GetLocalInt(oSpawn, "f_Facing");


    int nSpawnEffect = GetLocalInt(oSpawn, "f_SpawnEffect");
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");
    float fAreaEffectDuration = GetLocalFloat(oSpawn, "f_AreaEffectDuration");

    int nEntranceExit = GetLocalInt(oSpawn, "f_EntranceExit");
    int nEntranceExitMin = GetLocalInt(oSpawn, "f_EntranceExitMin");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nSpawnGroup = GetLocalInt(oSpawn, "f_SpawnGroup");
    int nSpawnCamp = GetLocalInt(oSpawn, "f_SpawnCamp");
    int nSpawnLocation = GetLocalInt(oSpawn, "f_SpawnLocation");
    int nSpawnLocationMin = GetLocalInt(oSpawn, "f_SpawnLocationMin");
    int nSpawnLocationInd = GetLocalInt(oSpawn, "f_SpawnLocationInd");
    int nSpawnItem = GetLocalInt(oSpawn, "f_SpawnItem");
    int nSpawnMerchant = GetLocalInt(oSpawn, "f_SpawnMerchant");
 	int nSpawnIllumination = GetLocalInt(oSpawn, "f_SpawnIllumination");
 	int nSpawnPlacedEffect = GetLocalInt(oSpawn, "f_SpawnPlacedEffect");
	int nSpawnDoor = GetLocalInt(oSpawn, "f_SpawnDoor");
	
    float fSpawnUnseen = GetLocalFloat(oSpawn, "f_SpawnUnseen");
    int nUnseenIndividual = GetLocalInt(oSpawn, "f_UnseenIndividual");
    int nUnseenRetryCount = GetLocalInt(oSpawn, "f_UnseenRetryCount");

    //Initialize Cached Spawning
    int nUseCache = GetLocalInt(oSpawn, "f_UseCache");
    int nCacheBucket = GetLocalInt(oSpawn, "f_CacheBucket");
    int nCacheCondition = GetLocalInt(oSpawn, "f_CacheCondition");
    int nCacheTiming = GetLocalInt(oSpawn, "CacheTiming");

	int nSpawnTrap = GetLocalInt(oSpawn, "f_SpawnTrap");
    int nTrapType = GetLocalInt(oSpawn, "f_TrapType");
    int nTrapMinType = GetLocalInt(oSpawn, "f_TrapMinType");
    int nTrapSize = GetLocalInt(oSpawn, "f_TrapSize");
    int nTrapFaction = GetLocalInt(oSpawn, "f_TrapFaction");
    int nTrapDisarmScript = GetLocalInt(oSpawn, "f_TrapDisarmScript");
    int nTrapTriggerScript = GetLocalInt(oSpawn, "f_TrapTriggerScrip");

    // Start with this position for this spawn at the spawn waypoint
    vSpawnPos = GetPositionFromLocation(GetLocation(oSpawn));

    // Find facing for this spawn
    if (nFacing)
    {
        fSpawnFacing = GetLocalFloat(oSpawn, "f_SpawnFacing");
    }

    else
    {
        fSpawnFacing = IntToFloat(Random(360));
    }

    // Check Spawn Location
    if (nSpawnLocation > -1)
    {
        // Get SpawnLocation
        oSpawnLocation = GetSpawnLocationObject(oSpawn, nSpawnLocationMin,
            nSpawnLocation, nSpawnLocationInd);

        if (oSpawnLocation != OBJECT_INVALID)
        {
            vSpawnPos = GetPositionFromLocation(GetLocation(oSpawnLocation));
        }

        // kick out spawn unseen is true and SL location is in radius
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                nUnseenTryCount = 0;
                nUnseen = FALSE;

                while(nUnseenTryCount++ < nUnseenRetryCount && ! nUnseen)
                {
                    oSpawnLocation = GetSpawnLocationObject(oSpawn,
                        nSpawnLocationMin, nSpawnLocation, nSpawnLocationInd);

                    if (oSpawnLocation != OBJECT_INVALID)
                    {
                        vSpawnPos = GetPositionFromLocation(GetLocation(
                           oSpawnLocation));
                    }

                    if (CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
                    {
                        nUnseen = TRUE;
                    }
                }
                if (! nUnseen)
                {
                    // do not spawn this child
                    return;
                }
            }
        }

        // Adjust for New SpawnFacing
        if (nFacing == TRUE)
        {
            fSpawnFacing = GetFacing(oSpawnLocation);
        }
    }

    else if (fSpawnRadius > 0.0)
    {
        // Check SpawnNearPCs
        if (nSpawnNearPCs == TRUE)
        {
            oPC =  GetRandomPCInArea(OBJECT_SELF, oSpawn);
            if (oPC != OBJECT_INVALID)
            {
                vSpawnPos = GetPositionFromLocation(GetLocation(oPC));
            }
        }

        vSpawnPos = GetSpawnRadiusPosition(vSpawnPos, fSpawnRadius,
           fSpawnRadiusMin);

        // kick out spawn unseen is true and vSpawnPos is in range of PC
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                nUnseenTryCount = 0;
                nUnseen = FALSE;

                while(nUnseenTryCount++ < nUnseenRetryCount && ! nUnseen)
                {
                    vSpawnPos = GetSpawnRadiusPosition(vSpawnPos, fSpawnRadius,
                       fSpawnRadiusMin);

                    if (CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
                    {
                        nUnseen = TRUE;
                    }
                }

                if (! nUnseen)
                {
                    // do not spawn this child
                    return;
                }
            }
        }
    } // end else if SR

    else // Not SL or SR
    {
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                // do not spawn this child
                return;
            }
        }
    }

    // Home is where we spawn in OR where we WOULD spawn in if there were no
    // Alternate entrance specified.
    lHome = Location(OBJECT_SELF, vSpawnPos, fSpawnFacing);

    // If there's an entrance/exit, lSpawnLocation may still change to that
    lSpawnLocation = lHome;


    // Check Spawn Type
    nObjectType = OBJECT_TYPE_CREATURE;
    if (nPlaceable == TRUE || nSpawnCamp == TRUE || sSpawnTag == "AE")
    {
       nObjectType = OBJECT_TYPE_PLACEABLE;
    }
    if (nSpawnItem == TRUE)
    {
        nObjectType = OBJECT_TYPE_ITEM;
    }
    if (nSpawnMerchant == TRUE)
    {
        nObjectType = OBJECT_TYPE_STORE;
    }
 	if (TRUE == nSpawnIllumination)
    {
        nObjectType = OBJECT_TYPE_LIGHT;
    }
 	if (TRUE == nSpawnPlacedEffect)
    {
        nObjectType = OBJECT_TYPE_PLACED_EFFECT;
    }
 	if (TRUE == nSpawnDoor)
    {
        nObjectType = OBJECT_TYPE_DOOR;
    }
	if (TRUE == nSpawnTrap)
	{
		//There is no OBJECT_TYPE_TRAP so we're using the trigger
		//object type to identify trap spawning
		nObjectType = OBJECT_TYPE_TRIGGER; 
	}
	
    // Check Spawn Group
    if (nSpawnGroup == TRUE)
    {
        // Pull a Creature from the Group
        sTemplate = SpawnGroup(oSpawn, sSpawnTag);
    }
    else
    {
        sTemplate = sSpawnTag;
    }

    // Set up alternate Entrance/Exit
    if (!nSpawnCamp)
    {
        // EntranceExit
        if (nEntranceExit > -1)
        {
            // Get ExitEntrance
            if (nEntranceExitMin > -1)
            {
                nRndEntranceExit = Random(nEntranceExit + 1);
                while (nRndEntranceExit < nEntranceExitMin)
                {
                    nRndEntranceExit = Random(nEntranceExit + 1);
                }
                nEntranceExit = nRndEntranceExit;
            }
            sEntranceExit = "EE" + PadIntToString(nEntranceExit, 2);
            oEntranceExit = GetNearestObjectByTag(sEntranceExit, oSpawn);
            lEntranceExit = GetLocation(oEntranceExit);

            lSpawnLocation = lEntranceExit;
            nWalkToHome = TRUE;
        }
    }

    // Create Effect
    if (nSpawnEffect > 0)
    {
        eSpawn = EffectVisualEffect(SpawnEffect(oSpawn, TRUE, FALSE));
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpawn, lSpawnLocation,
           5.0);
    }

    // Check Area Effect
    if (nSpawnAreaEffect > 0)
    {
        eArea = SpawnAreaEffect(oSpawn);
        if (fAreaEffectDuration > 0.0)
        {
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eArea, lSpawnLocation,
               fAreaEffectDuration);
        }
        else
        {
            ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eArea, lSpawnLocation,
               0.0);
        }

        // Check Template
        if (sSpawnTag == "AE")
        {
            sTemplate = "plc_invisobj";
        }
    }

    // Validate sSpawnTag
    if (sTemplate != "")
    {
        // Spawn
        if (nSpawnCamp == TRUE)
        {
            oSpawned = CampSpawn(oSpawn, sTemplate, lSpawnLocation);
            RecordSpawned(oSpawn, oSpawned, lHome, lEntranceExit, fSpawnFacing);
        }
        else
        {

            //if the cache is not to be used OR the timing is after setup
            if(FALSE == nUseCache || nCacheTiming == 1)
            {
                //**FLAG standard create
				//Traps do not use the standard CreateObject so if we're spawning
				//a trap we need to call a different create function
				if(OBJECT_TYPE_TRIGGER != nObjectType)
                {
					oSpawned = CreateObject(nObjectType, sTemplate, lSpawnLocation);
				}
				else
				{
					//Spawn a trap at this locaton (disarm/detect/recoverable is set in SetupSpawned())
					oSpawned = CreateNessTrap(oSpawn, nObjectType, sTemplate, lSpawnLocation
												, nTrapType, nTrapMinType, nTrapSize, nTrapFaction, nTrapDisarmScript
												, nTrapTriggerScript);
				}
            }
            else
            {
                oSpawned = CreateNessObject(oSpawn, nObjectType, sTemplate, lSpawnLocation, nCacheCondition, nCacheBucket);
            }
            SpawnDelayDebug(oSpawn, "spawned " + ObjectToString(oSpawned));
            RecordSpawned(oSpawn, oSpawned, lHome, lEntranceExit,
               fSpawnFacing);
            SetupSpawned(oSpawn, oSpawned, lHome, nTimeNow, nWalkToHome);
            if(TRUE == nUseCache && 1 == nCacheTiming)
            {
                CreateCachedObject(oSpawn, oSpawned, nCacheBucket, nCacheCondition);
            }
        }
    }
}
//

// This Function Spawns a Camp
object CampSpawn(object oSpawn, string sCamp, location lCamp)
{
    // Spawn in Camp Placeholder
    object oCamp = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lCamp, FALSE);
    SetPlotFlag(oCamp, TRUE);
    SetLocalObject(oCamp, "ParentSpawn", oSpawn);
    SetCampSpawn(oCamp, sCamp, lCamp);

    // Initialize
    int nCampNumP = GetLocalInt(oCamp, "CampNumP");
    int nCampNumC = GetLocalInt(oCamp, "CampNumC");
    float fSpawnRadius = GetLocalFloat(oCamp, "CampRadius");
    vector vCamp = GetPositionFromLocation(lCamp);

    object oSpawned;
    int iCount;
    int nRandomWalk, nSpawnFacing;
    int nLootTable, nSpawnGroup, nTrapDisabled, nDeathScript;
    float fCorpseDecay;
    int nCorpseDecayType, nCampCenter;
    string sObject, sTemplate, sFlags, sCampCenter;

    // Get Camp Center
    sCampCenter = GetLocalString(oCamp, "CampCenter");

    // Spawn Placeables
    for (iCount = 1; iCount <= nCampNumP; iCount++)
    {
        // Initialize Values
        sObject = "CampP" + IntToString(iCount - 1);
        sTemplate = GetLocalString(oCamp, sObject);
        nCampCenter = FALSE;

        // Check Flags
        sFlags = GetLocalString(oCamp, sObject + "_Flags");
        nSpawnGroup = IsFlagPresent(sFlags, "SG");

        // Spawn Group
        if (nSpawnGroup == TRUE)
        {
            sTemplate = SpawnGroup(oSpawn, sTemplate);
        }

        // Check Camp Center
        if (sCampCenter != "")
        {
            if (sCampCenter == "P" + IntToString(iCount - 1))
            {
                nCampCenter = TRUE;
            }
        }
        // If no CampCenter set, Use first Placeable
        else if (iCount == 1)
        {
            nCampCenter = TRUE;
        }

        oSpawned = DoCampSpawn(oCamp, lCamp, fSpawnRadius, sTemplate, TRUE, iCount, nCampCenter);
        SetLocalObject(oCamp, sObject, oSpawned);
        SetupCampSpawned(oSpawn, oSpawned, vCamp, GetLocation(oSpawned), sFlags);

    }

    // Spawn Creatures
    for (iCount = 1; iCount <= nCampNumC; iCount++)
    {
        // Initialize Values
        sObject = "CampC" + IntToString(iCount - 1);
        sTemplate = GetLocalString(oCamp, sObject);

        // Check Flags
        sFlags = GetLocalString(oCamp, sObject + "_Flags");
        nSpawnGroup = IsFlagPresent(sFlags, "SG");

        // Spawn Group
        if (nSpawnGroup == TRUE)
        {
            sTemplate = SpawnGroup(oSpawn, sTemplate);
        }

        // Check Camp Center
        if (sCampCenter != "")
        {
            if (sCampCenter == "C" + IntToString(iCount - 1))
            {
                nCampCenter = TRUE;
            }
        }

        oSpawned = DoCampSpawn(oCamp, lCamp, fSpawnRadius, sTemplate, FALSE, iCount, nCampCenter);
        SetLocalObject(oCamp, sObject, oSpawned);
        SetupCampSpawned(oSpawn, oSpawned, vCamp, GetLocation(oSpawned), sFlags);
    }

    // Return Placeholder
    return oCamp;
}
//

// This Function Spawns the Camp Members
object DoCampSpawn(object oCamp, location lCamp, float fSpawnRadius,
   string sTemplate, int nPlaceable, int nSpawnNumber, int nCampCenter)
{
    object oCampSpawned;
    vector vCamp, vRadius;
    float fRadius, fRadiusX, fRadiusY, fAngle;

    // Set up Location
    if (nCampCenter == FALSE)
    {
        vCamp = GetPositionFromLocation(lCamp);
        fAngle = IntToFloat(Random(361));
        fRadius = IntToFloat(Random(FloatToInt(fSpawnRadius)) + 1);
        fRadiusX = fRadius * cos(fAngle);
        fRadiusY = fRadius * sin(fAngle);
        vRadius = Vector(fRadiusX, fRadiusY);
        lCamp = Location(OBJECT_SELF, vCamp + vRadius, 0.0);
    }

    // Spawn Camp Object
    if (nPlaceable == TRUE)
    {
        oCampSpawned = CreateObject(OBJECT_TYPE_PLACEABLE, sTemplate, lCamp, FALSE);
        //debug("created placeable at " + LocationToString(lCamp));
    }
    else
    {

//**FLAG        oCampSpawned = CreateNessObject(oCamp, OBJECT_TYPE_CREATURE, sTemplate, lCamp);
        oCampSpawned = CreateObject(OBJECT_TYPE_CREATURE, sTemplate, lCamp);
    }

    // Return Camp Object
    return oCampSpawned;
}