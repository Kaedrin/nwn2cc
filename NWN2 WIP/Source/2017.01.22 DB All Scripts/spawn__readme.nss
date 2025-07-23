//
//  
//   NESS
//   Version 2.2 for NWN2
//   Spawn Readme
//
//
//   Neshke Narovken (Original Author)
//
//   Cereborn (Maintainer)
//
//   Loudent2 (NWN2 converter)
//*******************************************************************
//     
//
// INCLUDES:
//
//   Do NOT Modify Main Script:
//
//     Spawn:           'spawn_main'
//
//   Do NOT Modify Helper Scripts:
//
//     Information:     'spawn__readme'
//     Functions:       'spawn_functions'
//     Corpse Death:    'spawn_corpse_dth'
//     Corpse Decay:    'spawn_corpse_dcy'
//     Global Defaults: 'spawn_defaults'
//     Flag Parsing:    'spawn_flags'
//     Pseudo-heartbeat 'spawn_pseudohb"
//
//   Lootable corpse event scripts:

//     Corpse On Open:   'spawn_onopencrp'
//     Corpse On Closed: 'spawn_oncloscrp'
//     Corpse disturbed: 'spawn_dist_corps' 
//     Corpse used:      'spawn_used_corps'               
//
//
// CONFIGURATION:
//
//   Modify Configuration Includes if Needed
//   Only where Specified in Each File:
//
//     Spawn Flags:     'spawn_cfg_flag'
//     Spawn Groups:    'spawn_cfg_group'
//     Loot Tables:     'spawn_cfg_loot'
//     Spawn Camps:     'spawn_cfg_camp'
//     Spawn Effects:   'spawn_cfg_fxsp'
//     Area Effects:    'spawn_cfg_fxae'
//     Object Effects:  'spawn_cfg_fxobj'
//     User Defaults:   'spawn_cfg_global'
//     Custom Flags:    'spawn_cfg_cusflg'
//
//   Modify Check Includes if Needed
//   Only where Specified in each File:
//
//     Check PCs:       'spawn_chk_pcs'
//     Custom Check:    'spawn_chk_custom'
//
//   Modify Scripting Includes if Needed
//   Only where Specified in Each File:
//
//     Spawn/Despawn:   'spawn_sc_spawn'
//     Heartbeat:       'spawn_sc_hbeat'
//     Death:           'spawn_sc_death'
//     Deactivation:    'spawn_sc_deactiv'
//     Camp Trigger:    'spawn_sc_cmptrig'
//     Patrol Stops:    'spawn_sc_patrol'
//     Trap Disarmed    'spawn_sc_trdis'
//     Trap Triggered   'spawn_sc_trptrig'
//
//
// USAGE:
//
//   Add Following to Area Heartbeat:
//
//     Sample Script:   'spawn_sample_hb'
//
//     #include "spawn_main"
//     Spawn();
//
//   Add Spawn Waypoints
//   All Switches Optional
//
//   Waypoint Name:
//     SP_<Spawn Flags>
//
//   Waypoint Tag:
//     Child Object Tag/ResRef
//     Group Designation
//     Camp Designation
//
//   Note:
//     For Custom Creatures
//     You must use the ResRef
//
//   Available Flags:
//     SPnOn_ISnDn_IDn_FTn_SNnMn_SAnMn_SRnMnP_SDnMn_CLnMn
//     _RGnMnCn_RWRn_DYnTn_HRnTn_DOD_NOD_PCnR_SF_SUnIn_FXnDn
//     _PRnTn_PLnTn_EEnRn_EXnRn_SG_CDnTnRnD_LTnAnBnCn_DSnSn_DIn_CMDn
//     _SSnDn_CCn_CPnRn_TRnDn_AEnDn_OEnDn_RSn_FCn
//     _ALnSn_HBn_SLnRnI_RHDn_DTn_HLnE_IT_ST_PT_SM_CF
//     _SXn_NL_SB_ELn_CSnCnTn
//
//
//   Format:
//     Flag|OptionalFlag
//
//
//   SPn|On
//   : Designates Spawn Waypoint
//   : SP is Required on all Spawn Waypoints
//   : Performs Spawn processing every SP1 to SP99 heartbeats
//   : Default is SP1 Heartbeat : ~6 Seconds
//   : SP00 Defaults to SP01
//   : Optional Flag: On
//   : Offset processing spawn from first process by n heartbeats.
//   : Used to stagger spawn processing within an area
//
//   ISn|Dn
//   : Initial State
//   : Type 0 : Inactive
//   : Type 1 : Default : Active
//   : Optional Flag: D000
//   :   Delay Initial Spawn D000 Minutes
//
//   IDn
//   : SpawnID
//   : Sets LocalInt "SpawnID" to SpawnID
//   : On Spawn Waypoint Object
//
//   FTn
//   : Flag Table
//   : Use Flags from Table FT00
//   : Flags are Defined in 'spawn_cfg_flag'
//
//
//   SNn|Mn
//   : Spawn Number
//   : Maintains a Spawn of SN00 to SN99 Children
//   : Despawns Extra Children
//   : Optional Flag: M00
//   :   Minimum Children
//   :   Will Randomly Spawn between M00 and SN00 Children
//
//   SA|n|Mn
//   : Spawn All at Once
//   : Default is Spawn One Child per Cycle
//   : Optional Flag: 00
//   :   Spawn 00 Children per Cycle
//   : Optional Flag: M00
//   :   Spawn Minimum M00 per Cycle
//
//   SRn|Mn|P
//   : Spawn Radius
//   : Randomly Spawns Children in a
//   : Location SR00 to SR99 Meters from Waypoint
//   : Optional Flag: M00
//   :   Minimum Radius, M00 to SR99 Meters
//   : Optional Flag: P
//   :   Spawn Center is Near a Random PC in Area
//
//   SDn|Mn|P
//   : Spawn Delay
//   : Delay SD00 to SD99 Minutes between Spawns
//   : Optional Flag: M00
//   :   Minimum Delay, M00 to SD99 Minutes
//   : Optional Flag: P
//   :   This flag sets up a spawn period, whereas the default spawn delay
//   :   specifies a spacing between spawns.
//   :   This is particularly useful with PL3 (keep the times the same on
//   :   each) it will cause the placeable to refresh if alive or respawn
//   :   if not on a regular schedule. Note that if the P subflag is used,
//   :   the M subflag is ignored.
//
//
//   CLn|Mn
//   : Child Lifespan
//   : Child will Despawn after CL00 Minutes
//   : Optional Flag: M00
//   :   Child will Despawn after M00 to CL00 Minutes
//
//   DYn|Tn
//   : Spawn Day
//   : Spawn Only on Day DY00 to DY28
//   : Children are Despawned during Invalid Days
//   : Optional Flag: T00
//   :   Spawn from Day DY00 to Day T00
//
//   HRn|Tn
//   : Spawn Hour
//   : Spawn Only during Hour HR00 to HR24
//   : Children are Despawned during Invalid Hours
//   : Optional Flag: T00
//   :  Spawn from Hour HR00 to Hour T00
//
//   DO|D
//   : Day Only
//   : Only Spawns at Day
//   : Optional Flag: D
//   :   Despawn Children at Nightfall
//
//   NO|D
//   : Night Only
//   : Only Spawns at Night
//   : Optional Flag: D
//   :   Despawn Children at Daybreak
//
//   RW|Rn
//   : Random Walk
//   : Children Wander Randomly
//   : Optional Flag: R00
//   :   WARNING:  This is Resource Intensive!!
//   :   Wander Range, R00 to R99 Meters
//
//   PC|n|R
//   : PC Check
//   : Only Spawn Children if PCs are in Area
//   : Children are Despawned if no PCs in Area
//   : Optional Flag: PC00
//   :   Depawn if no PCs in Area for PC00 Minutes
//   : Optional Flag: R
//   :   Reset Spawn Point if no PCs are Present
//
//   RGn|Mn|Cn
//   : Random Gold
//   : Generates Random Amount of Gold on Children
//   : From RG000 to RG999 Gold
//   : Optional Flag: M00
//   :   Minimum Gold Amount
//   : Optional Flag: C00
//   :   Gold Chance C00% to C99%
//   :   Default 100% chance
//
//   SF
//   : Spawn Facing
//   : Set Facing of Children to Match Waypoint
//   : Default Random Facing
//
//   SUn|In
//   : Spawn Unseen
//   : Only Spawn if PCs are not within SU00 to SU99 Meters
//   : Optional flag: I00
//   :   Use the location of each individual child to determine if that
//   :   child can spawn, instead of using to location of the spawn itself.
//   :   If using SR or SL|R, I00 to I99 additional random locations will be
//   :   attempted
//
//   FXn|Dn
//   : Spawn Effect
//   : Spawn in with Effect FX001 to FX999
//   : Effects are Defined in 'spawn_cfg_fxsp'
//   : Optional Flag: D000
//   :   Despawn with Effect D001 to D999
//
//   PRn|Tn|C
//   : Patrol Route
//   : Assign Waypoints Route PR00 to PR99
//   : Optional Flag: T0
//   :   Route Type
//   :   0 - Sequential
//   :   1 - Circular
//   :   2 - Random
//   :   3 - Walk Once/Despawn
//   : Optional Flag C
//   :   Start at closest waypoint. Does not apply to T2 (random)
//   :
//   : Route Name: Variable
//   : Route Tag: PR00_SN00_PS000_RN_FC_DO_NO_SC000
//   :
//   : PR - Route Number 00 to 99
//   : SN - Stop Number 00 to 99
//   : PS - Pause 000 to maxint seconds at Stop
//   : RP - Random additional amount (0 - maxint) added to PS
//   : RN - Run to Stop
//   : RR - Percentage chance a Stop will be visited (skipped otherwise)
//   : SF - Face the Waypoint Direction
//   : DO - Only Stop here during the Day
//   : NO - Only Stop here during the Night
//   : SC - Run script 000 to 999
//   :      Scripts are Defined in 'spawn_sc_patrol'
//
//   EEn|Rn
//   : Entrance/Exit
//   : Enter and Exit at Waypoint EE00
//   : Optional Flag: R
//   :   Choose Random Entrance Exit
//   :   from R00 to EE00
//   :
//   : Entrance/Exit Name: Variable
//   : Entrance/Exit Tag: EE00
//
//   EXn|Rn
//   : Exit
//   : Exit at Waypoint EX00
//   : Optional Flag: R
//   :   Choose Random Exit
//   :   from R00 to EX00
//   :
//   : Exit Name: Variable
//   : Exit Tag: EX00
//
//   PLn|Tn|Pn
//   : Placeable Object
//   : Spawns a Placeable Object with Behavior
//   :   Behavior 0: Default Behavior
//   :   Behavior 1: Despawn if Empty
//   :   Behavior 2: Refill if Empty (after spawn delay minutes!)
//   :   Behavior 3: Refresh (despawn/respawn) every P000 minutes; default
//   :   (if no Pn specified) is 60 minutes
//   : Optional Flag: T00
//   :   Trap Disabled Chance
//   :   00% to 99% chance of Trap Disabled
//   :   Trap must already be part of Placeable's Template
//   :   Default 100% Chance Trap is Disabled
//   : Optional Flag: P00
//   :   Refresh period (in minutes)
//
//   SG
//   : Spawn Group
//   : Spawn Children from Group
//   : Waypoint Tag is Defined Group
//   : Groups are Defined in 'spawn_cfg_group'
//
//   CDn|Tn|Rn|D
//   : Corpse Decay
//   : Decay Corpse after CD000 to CD999 Seconds
//   : Default No Corpse, Standard Loot Bag
//   : Optional Flag: T
//   :   Corpse Inventory Type
//   :   Type 0: Inventory Items
//   :   Type 1: Inventory & Equipped Items
//   :   Type 2: Inventory Items, if PC Killed
//   :   Type 3: Inventory & Equipped Items, if PC Killed
//   : Optional Flag: R
//   :   Remains Type
//   :   Type 0: Loot bag
//   :   Type 1: Body
//   :   Type 2: Bones
//   :   Type 3: Potion
//   :   Type 4: Pouch
//   :   Type 5: Scroll
//   :   Type 6: Treasure
//   :   Type 7: None (destroy loot on decay)
//   : Optional Flag: D
//   :   Drop wielded weapons
//
//  LTn|An|Bn|Cn
//   : Loot Table
//   : Spawn Loot on Children from Table LT000 to LT999
//   : Loot Tables are Defined in 'spawn_cfg_loot'
//   : LT500 to LT999 currently reserved for merchant-based
//   : loot tables
//   : Optional Flag: A000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   only 1 item will spawn.  Default is 50%. Values over 100% are truncated
//   :   to 100%
//   : Optional Flag: B000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   2 items will spawn.  Default is 15%. Values over 100% are truncated
//   :   to 100%
//   : Optional Flag: C000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   3 items will spawn.  Default is 05%. Values over 100% are truncated
//   :   to 100%
//
//   DSn|Sn
//   : Deactivate Spawn
//   : Deactivate Spawn based on Condition
//   :   Type 0: Deactivate if all Children are Dead
//   :   Type 1: Deactivate if Spawn Number has been Spawned
//   :   Type 2: Deactive Spawn until all Children are Dead
//   :   Type 3: Deactivate Spawn after DI00 Children
//   :   Type 4: Deactivate Spawn after DI00 Minutes
//   :   Type 5: Deactivate Spawn after DI00 Cycles
//   :   Type 6: Deactivate when Spawn Count == Spawn Number
//   : Optional Flag: S000
//   :   Run Script 000 to 999 when Spawn Deactivated
//   :   Scripts are Defined in 'spawn_sc_deactiv'
//   :
//   : Can Reactivate by Manually Calling:
//   :   SetLocalInt(oSpawn, "SpawnDeactivated", FALSE);
//
//   DIn
//   : Deactivation Information
//
//   CM|Dn
//   : Spawn Camp
//   : Spawns Camp of Creatures and Placeables
//   : Waypoint Tag is Defined Camp
//   : Despawns Camp when all Children Dead
//   : Camps are Defined in 'spawn_cfg_camp'
//   : Optional Flag: D000
//   :   Placeables Decay 000 Seconds after Camp Despawn
//   :
//   : Camp Children Flags:
//   :
//   :   RW       : Random Walk
//   :   SF       : Spawn Facing Camp
//   :   SG       : Spawn Group
//   :   LT00     : Loot Table
//   :   CD000|T0 : Corpse Decay
//   :   PL0|T00  : Placeable Type
//   :             Placeable Trap Disabled
//
//   SSn|Dn
//   : Spawn Script
//   : Run Script 001 to 999 on Spawn
//   : Scripts are Defined in 'spawn_sc_spawn'
//   : Optional Flag: D000
//   :   Run Script 001 to 999 on Despawn
//
//   DTn
//   : Death Script
//   : Run Script 001 to 999 on Death
//   : Scripts are Defined in 'spawn_sc_death'
//
//   CPn|Rn
//   : Spawn Check PCs
//   : Check Custom Code to see if Spawn Proceeds
//   : Custom Code is Defined in 'spawn_chk_pcs'
//   : Optional Flag: R00
//   :   Check all PCs in Radius R00
//   :   Default Check all PCs in Area
//
//   CCn
//   : Spawn Check Custom
//   : Check Custom Code to see if Spawn Proceeds
//   : Custom Code is Defined in 'spawn_chk_custom'
//
//   TRn|Dn
//   : Spawn Trigger
//   : Only Spawns if PC is within 00 Meters
//   : Optional Flag: D00
//   :   Despawns if PC is not within D00 Meters
//
//   AEn|Dn
//   : Spawn Area Effect
//   : Area Effects are Defined in 'spawn_cfg_fxae'
//   : Waypoint Tag can be "AE" to Spawn only Area Effect
//   : Optional Flag: D000
//   :   Area Effect Duration of 000 to 999 Seconds
//   :   Duration of 000 means Permanent Area Effect
//   :   Default Duration is 005 Seconds
//
//   OEn|Dn
//   : Object Effect
//   : Object Effects are Defined in 'spawn_cfg_fxobj'
//   : Optional Flag: D000
//   :   Object Effect Duration of 000 to 999 Seconds
//   :   Duration of 000 means Permanent Object Effect
//   :   Default Duration is Permanent
//
//   RSn
//   : Random Spawn
//   : Percentage Chance Spawn will Occur
//   : Default 100% Chance
//
//   FCn
//   : Spawn Faction
//   : Change Faction of Children:
//   :   Faction 0: COMMONER
//   :   Faction 1: DEFENDER
//   :   Faction 2: MERCHANT
//   :   Faction 3: HOSTILE
//   :   Faction 4: CUSTOM
//   :     Change Faction to Same as Nearest
//   :     Object with Tag 'SpawnFaction'
//
//   ALn|Sn
//   : Spawn Alignment
//   : Shift Alignment of Children
//   :   Alignment 0: Neutral
//   :   Alignment 1: Law
//   :   Alignment 2: Chaos
//   :   Alignment 3: Good
//   :   Alignment 4: Evil
//   :   Alignment 5: All
//   : Optional Flag: S00
//   :   Shift Alignment by S00
//   :   Default Shift by 10
//
//   HBn
//   : Heartbeat Script
//   : Children will Run Script HB000 each Cycle
//   : Scripts are Defined in 'spawn_sc_hbeat'
//
//   SLn|Rn|I
//   : Spawn Location
//   : Spawn Children at Waypoint SL00
//   : Optional Flag: R
//   :   Choose Random Location
//   :   from R00 to SL00
//   : Optional Flag: I
//   :   When spawning multiple children, each child takes the next
//   :   waypoint, In order - (first child spawns at SL00, next at SL01, etc.)
//   :
//   : Location Name: Variable
//   : Location Tag: SL00
//
//   RH|Dn
//   : Return Home
//   : Child will always Return to Home
//   : Optional Flag: D00
//   :   Child will Return to Home
//   :   Only if further than D00 Meters
//
//   HL|n|E
//   : Heal Children if Not in Combat
//   : Optional Value: 00
//   :   Heal 00% per Cycle
//
//   IT
//   : Spawn Item
//   : Spawnpoint Tag is Item Template
//
//   ST
//   : Spawn Sit
//   : Children will Sit in Nearest Unoccupied Sittable
//   : Sittable's Tag must be 'Seat'
//
//   PT
//   : Spawn Plot
//   : Sets Children as Plot
//
//   SM
//   : Spawn Merchant
//   : Spawnpoint Tag is Merchant Template
//
//   CF
//   : Custom Flag
//   : Everything in Spawn Name after CF
//   : Is Stored in LocalString "CustomFlag"
//   : On Each Spawned Child
//
//   CSn|Cn|Tn
//   : Cache Spawn
//   : Allows NESS to create a cached object to copy from
//   : Values 0-9 indicate "buckets". Use sepearate buckets for 
//   : mobs hostile to each other
//   : Optional Flag: C
//   :   Condition type
//   :   Type 0: Default Caching- Create Cache if none exist, use cache if it does
//   :   Type 1: Overwrite cache. This waypoint will always create a cache. Destroying any that may exist.
//   :   Type 2: Spawn only if Cache exists. If there is no cache, no mob will spawn.
//   : Optional Flag: T
//   :   Cache Timing
//   :   Type 0: Create cache before SetUpSpawned is called
//   :   Type 1:Create cache after SetUpSpawned is called.
//
//   SI
//   : Spawn Illumination
//   : Spawnpoint Tag is light resource name
//
//   SE
//   : Spawn Placed Effect
//   : Spawnpoint Tag is placed effect name
//
//   DR
//   : Spawn Door (No-op placeholder. doors cannot be spawned)
//   : Spawnpoint Tag is placed effect name
//
//   TPn|Mn|Sn|Fn|Dn|Tn|An|Bn|Rn
//   : Spawn Trap
//   : Values 0-47 indicate trap 'type' as defined in nwscript.nss (TRAP_BASE_TYPE_*)      
//	 : Optional Flag: M
//   :   Minimun trap type value (use this to set a range of values).
//   :   If this value is greater than the TPn number then the TPn number will
//   :   Actually be used as a "strength" type (i.e. 0 = a random minor trap, 
//   :   1 = random average strength trap). TPn must be less than 4 for this
//	 : Optional Flag: S
//   :   Size of trap (in 1/10ths of a meter) Default 10
//	 : Optional Flag: F
//   :   Faction of Trap. Default = 0(Hostile)
//	 : Optional Flag: D
//   : 	 Run Script 001 to 999 on disarm
//   :   Scripts are Defined in 'spawn_sc_trpdis'
//   : Optional Flag: T
//   :   Run Script 001 to 999 on trigger
//   :   Scripts are Defined in 'spawn_sc_trptrig'
//	 : Optional Flag: A
//   :   Disarm DC. 0 = default
//	 : Optional Flag: B
//   :   Detect DC 0 = default
//	 : Optional Flag: R
//   :   Is trap recoverable (0 = no, 1 = yes)

//
//

//
// Functions for external control.  Please use these when possible instead
// of modifying variables directly in NESS.
//
// object NESS_GetSpawnByID(int nSpawnID, object oArea)
//   : Returns the spawn waypoint in area oArea with ID nSpawnID
//
// void   NESS_ActivateSpawnByID(int nSpawnID, object oArea)
//   : Activates the spawn in area oArea with ID nSpawnID
//
// void   NESS_DeactivateSpawnByID(int nSpawnID, object oArea)
//   : Deactivates the spawn in area oArea with ID nSpawnID
//
// void   NESS_ActivateSpawn(object oSpawn)
//   : Activates spawn oSpawn
//
// void   NESS_DeactivateSpawn(object oSpawn)
//   : Deactivates spawn oSpawn
//
// void   NESS_ForceProcess(object oSpawn)
//   : Force spawn oSpawn to be processed next heartbeat (regardless of
//   : SPxx value)
//
// void   NESS_TrackModuleSpawns(int nFlag=TRUE)
//   :  Enable (nFlag == TRUE) or Disable (nFlag == FALSE) Spawn Tracking
//
// int    NESS_IsModuleSpawnTracking()
//   :  Returns TRUE is spawn tracking is enabled, FALSE otherwise
//
//
// Some Tips and Pointers
// - with Thanks to Eliha for Creating this Section
//
// 1. The .erf script files we import for NWN usually contain .nss and
// .utp files.
//
// 1.1. The .nss files are the Nwn Source Scripts that are in plain text that
// we manipulate in the script editor.
//
// 1.2. The .utp file(s) are objects such as an invisible corpse object that
// automatically gets put in the right column of the toolset where you select
// the creatures, doors, placeables, etc. under the custom button.
//
// 2. After importing the .erf and ignoring that it couldn't find the .ncs files
// you'll need to save your module then reopen it for the new scripts to appear
// in the left column (due to the lack of a refresh button).
//
// 3. When working in the various configuration scripts you only need to save
// them, not compile them. They are just add-ons to the main spawn_sample_hb.nss
// script and attempts to compile them will result in errors. The spawn_sc_xxxx
// files will compile but even they should just be saved like all the other
// spawn_cfg_xxxx scripts.
//
// 4. When finished editing and saving the various configuration scripts you
// will then need to open the spawn_sample_hb script and compile it to integrate
// your new changes into the system. If you customized your scripts, saved them,
// saved the module, then loaded the game and find nothings working....chances are
// you forgot to compile the spawn_sample_hb script after making your changes.
//
// 5. You can usually tell which script needs to be compiled by noticing which
// one needs to be put in an area heartbeat or on an object somewhere, etc.. In
// this case, we are adding the spawn_sample_hb to the area heartbeat so it is the
// main file and requires compiling.
//


//
// Package Header
//
/*
NESS Version 2.2

Cereborn

See 'spawn__readme' for Instructions
Ignore all 'Missing Resource' Errors
See the NWN Forums for More Info

Spawn Package:

 NESS Scripts:
- spawn__readme
- spawn__history
- spawn_cfg_camp
- spawn_cfg_flag
- spawn_cfg_fxae
- spawn_cfg_fxobj
- spawn_cfg_fxsp
- spawn_cfg_global
- spawn_cfg_group
- spawn_cfg_loot
- spawn_cfg_cusflg
- spawn_chk_pcs
- spawn_chk_custom
- spawn_corpse_dcy
- spawn_corpse_dth
- spawn_defaults
- spawn_dist_corps
- spawn_flags
- spawn_functions
- spawn_main
- spawn_onopencrp
- spawn_oncloscrp
- spawn_pseudohb
- spawn_sample_hb
- spawn_sc_cmptrig
- spawn_sc_deactiv
- spawn_sc_death
- spawn_sc_patrol
- spawn_sc_spawn
- spawn_sc_trpdis
- spawn_sc_trptrig
- spawn_smpl_onent
- spawn_smpl_onext
- spawn_timefuncs
- spawn_used_corps

 NESS Resources:
- invis_corpse_obj
- invis_corpse_bdy
- invis_corpse_bon
- invis_corpse_pot
- invis_corpse_pch
- invis_corpse_ser
- invis_corpse_tre

 Spawn Banner Scripts:
- spawnb_cc_activ
- spawnb_cc_dactiv
- spawnb_cc_dump
- spawnb_cc_nodump
- spawnb_cc_notrck
- spawnb_cc_nsclog
- spawnb_cc_nsdlog
- spawnb_cc_sclog
- spawnb_cc_sdlog
- spawnb_cc_trck
- spawnb_main
- spawnb_sample_ai
- spawnb_sc_activ
- spawnb_sc_dactiv
- spawnb_sc_disp
- spawnb_sc_dump
- spawnb_sc_nodump
- spawnb_sc_notrck
- spawnb_sc_nsdlog
- spawnb_sc_sclog
- spawnb_sc_sdlog
- spawnb_sc_snclog
- spawnb_sc_trck

 Spawn Banner Resources:
- spawn_ban_rod.uti
- spawn_banner.dlg
- spawn_ban_a.utp
- spawn_ban_d.utp


*/