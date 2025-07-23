//
//  
//   NESS
//   Version 2.2 for NWN2
//   Spawn History
//
//
//   Neshke Narovken (Original Author)
//
//   Cereborn (Maintainer)
//
//   Loudent (NWN2 converter)
//*******************************************************************
//
// History:
//
// +++ Start Version 7.0
//
//    --/--/--   Neshke            Created
//
//
// +++ Start Version 7.0.1
//
//    12/03/02   Cereborn          Added DanielleB's merchant-based loot tables
//    12/12/02   Cereborn          Added area-wide count of currently spawned
//                                 creatures
//    12/31/02   Cereborn          Added LT subflags A, B, and C for specifying
//                                 percentage chances of receiving 1, 2, or 3
//                                 loot items.
//    01/01/03   Cereborn          Added SX flag for dim returns suppression.
//
// +++ Start Version 7.0.2
//
//    01/07/03   Cereborn          Added NESS_ActivateSpawn(),
//                                 NESS_DeactivateSpawn, NESS_GetSpawnByID(),
//                                 NESS_ActivateSpawnByID(), NESS_ForceProcess()
//                                 NESS_DeactivateSpawnByID() and
//                                 NESS_TrackModuleSpawns().
//                                 Modified so that an activated spawn is processed
//                                 immediately instead of waiting for the next
//                                 process tick when using SPxx
//                                 Moved ReportSpawns and TrackModuleSpawns
//                                 to spawn_functions from spawn_main; modified
//                                 spawn_main to call TrackModuleSpawns() if
//                                 enabled, removing the need for placing
//                                 in each area heartbeat script
//
//    01/08/03   Cereborn          Fixed bug preventing initial flag processing
//                                 when using SPxx.
//                                 Added new deactivate spawn (DS) condition
//                                 (6) which deactivates a spawn whenever spawn
//                                 count reaches spawn number.  This is similar
//                                 to DS1, except that DS1 is based on number
//                                 of children *ever* spawned, so once
//                                 deactivated can never be reactivated, while
//                                 DS6 is based on current child count, allowing
//                                 the spawn to be re-activated if 1 or more of
//                                 it's children have been killed or despawned
//    01/10/03   Cereborn          Prevent despawning creatures when possessed
//                                 by a DM. (the code was attempting to do so
//                                 already but due to a Bioware bug it wasn't
//                                 working)
//    01/11/03   Cereborn          Added I subflag to SU to check each child's
//                                 location individually instead of the spawn's
//                                 location
//    01/17/03   Cereborn          Added force process of spawns when PCs
//                                 re-arrive id deactivated by PC flag
//    01/18/03   Cereborn          Added new type (3) to PL and subflag P
//                                 Added P subflag to SD.
//    01/20/03   Cereborn          Force process on deactivate
//                                 Added NESS_IsModuleSpawnTracking()
//
// +++ Start Version 7.0.3
//
//    01/22/03   Cereborn          Bug fix: Initialize module spawn count to
//                                 0 to fix bug with loading from saved games
//    01/24/03   Cereborn          Added NESS_DumpModuleSpawns() and
//                                 NESS_IsModuleSpawnDumping().  When spawn
//                                 dumping is enabled, each area with active
//                                 spawns reports its spawn count each HB
//
//
// +++ Start Version ALFA 1.0
//
//
//    02/05/03 - 03/21/03
//
//       Added NESS_ProcessDeadCreature().  This can be used to notify NESS that
//       a spawned creature has died (typically from an onDeath event script).
//       This is particularly useful when using larger SPxx values and the CD
//       flag, since without notification it can take a long time for NESS to
//       discover that the spawned creature has died and set up the lootable
//       corpse.
//
//       Added O(ffset) subflag to the SP flag. NESS now processes all spawns on
//       the first heartbeat, and then spawns are be processed on heartbeat
//       1 + offset + (processRate * N). For example, SP3 gets processed on
//       heartbeats 1, 4, 7, 10, etc.... while SP3O1 gets processed on heartbeats
//       1, 5, 8, 11..., and so on. This should be used to spread out heartbeats
//       within an area.
//
//       NESS no longer does any timing based on counted heartbeats.  All timings
//       are now based on the clock.  A new file, spawn_timefuncs, contains
//       functions for converting the game clock to real seconds for use in NESS
//       timings.
//
//       When spawns despawn due to using the PC flag (and if the R subflag is
//       not specified) the despawning creature resrefs and their locations are
//       recorded, and the spawn is restored to it previous state when PCs
//       re-enter the area.  This prevents exploits where players intentionally
//       'pop' a zone, then leave for the PC flag's duration, to effectively
//       clear an area of all obstacles until the spawn delay timer (if any)
//       expires.
//
//       Fixed the bug causing corpses that had been fully looted to not decay.
//
//       Fixed the bug that caused corpses to *never* decay if the decay timer
//       went off when the inventory was open (now a new decay timer is set).
//
//       Flag parsing code cleaned up; fixed a bug that caused the default value
//       for a flag to always be 1 (ignoring what was set up in spawn_cfg_global)
//
//       Items marked no-drop are no longer copied onto the lootable corpses
//
//       All no-drop items are explicitly destroyed (whether the CD flag is used
//       or not) to working around a current Bioware memory leak.
//
//       Added NESS_ReturnHome().  Call to force a NESS spawn to it's home point.
//
//       Added support for RH flag on spawn camps.
//
// +++ Start Version ALFA 1.0 Patch 1  (v1.0.1)
//
//    03/29/03
//
//       A bug where spawn delays were being applied to first time spawns that
//       didn't happen right away (such as triggered spawns, day/night only,
//       etc.) was fixed.
//
//       If a spawn has the RH flag and is respawned after being despawned due
//       to the PC flag, creatures will respawn at their home point instead of
//       where they were when they despawned.
//
//       An errant debug statement was removed.
//
// +++ Start Version ALFA 1.0 Patch 2 (v1.0.2)
//
//    03/30/03
//
//       Fixed a bug where the number of creatures in a spawn was getting
//       confused due to spawns that use the M subflag of the SN flag
//       recalculating their spawn numbers when spawns deactivated due to the
//       PC flag.  This bug fix should eliminate the overpopulating spawns
//       problem.
//
// +++ Start Version ALFA 1.0 Patch 3 (v1.0.3)
//
//    03/31/03
//
//       Fixed a bug where spawn delays could be skipped.
//
// +++ Start Version ALFA 1.0 Patch 4 (v1.0.4)
//
//    04/04/03
//
//       Fixed a bug where spawn delays were ignored on placeables.
//       Fixed P subflag of SD being ignored.
//       Reset spawn delay after RS-failed spawn attempt
//       Set up a new spawn delay when creature killed
//
// +++ Start Version ALFA 1.0 Patch 5 (v1.0.5)
//
//    04/07/03
//
//       Fixed bug in spawn_timefuncs that resulting in incorrect conversions
//       in years other than the Epoch year.
//       Changed the Epoch year to 1340 to conform to the lowest date in
//       the NWN engine.
//
// +++ Start Version ALFA 1.0 Patch 6 (v1.0.6)
//
//    04/08/03
//
//       Fixed bug with corpse decay and death script flags not being available
//       for camp spawns when onDeath notification occurs.
//
// +++ Start Version ALFA 1.0 Patch 7 (v1.0.7)
//
//    04/27/03
//
//       Added debugging for spawn delays and spawn counts that can be
//       independently enabled/disabled for each area from the spawn banner
//       rod.
//
// +++ Start Version ALFA 1.1 (v1.1)
//
//    04/28/03
//
//       Fixed bug in Loot Merchant code.  The original code used 
//       GetNearestObjectByTag() to look up loot merchants, which according to
//       the documentation should never have worked for merchants not in the same
//       area as the creature spawned.  In reality, it stopped working (at least
//       in some cases) after Bioware released version 1.29 of the game.
//
//    05/03/03
//
//       Changed distribution method used for SR flag to evenly distribute
//       spawns in the spawn circle instead.  The old method made the spawns
//       denser near the center and rarer near the circle's edge
//
//       Made SF work (again?) for placeables
//
//       When the SF flag is not specified for a multi-child spawn, a random
//       SF is now calcualated independently for each child
//
//    05/08/03
//
//       Added NL (No Loot) flag.  This suppresses looting of player corpses.
//       Only applies when using ACR 1.14 and higher
//
//    05/25/03
//
//       Fixed overspawning bug caused by changing child counts on spawns that
//       had been 'saved' with potentially different counts
//
//    05/27/03
//
//       Added C (Closest) subflag to the PR (Patrol Route) flag.  If C is 
//       specified, the spawned creature will start at the closest waypoint
//       rather than the first (does not apply to T2 flagged routes(random 
//       traverse)).
//
//    05/30/03
//
//       Added SB (Subdual) flag.  Causes creatures to be spawned in in subdual
//       mode. Only applies when using ACR 1.14 and higher.
//
//
// +++ Start Version ALFA 1.2 (v1.2)
//
//    08/24/03
//
//       Removed LocationToString() function from spawn_functions, as this is
//       now a Bioware function
//
//    08/25/03
//
//       Modified the way the SX flag works.  First, there is now a global flag,
//       nGlobalSuppressDR, in spawn_cfg_global that can be set to determine 
//       whether or not creatures spawn in with DR on or off when no SX flag is
//       specified.  The current default is for DR to *not* be suppressed, i.e.,
//       it will be operational.  Also, the SX flag can now take a value of 0 or 1.
//       If 1, DR is suppressed, if 0 DR is enabled (useful if you've set 
//       nGlobalSuppressDR to 1).  The default if no value is specified (just SX)
//       is 1 (to suppress).  You can also change this default in spawn_cfg_global.
//       If nGlobalSuppressDR is 1 and nSuppressDR is 0, you will get the opposite
//       of the v1.1 functionality; no DR on creatures, except when the SX flag is
//       present.
//
// +++ Start Version ALFA 1.2.1 (v1.2.1)
//
//    09/01/03
//
//       Fixed bug where spawn number was always being set to the number of saved 
//       camp spawns on PC-flag restore instead of the sum of saved camp and 
//       regular spawn counts.
//
// +++ Start Version ALFA 1.2.2 (v1.2.2)
//
//    09/02/03
//
//       Fixed bug introduced by last bug fix that caused overspawning!
//
// +++ Start Version ALFA 1.2.3 (v1.2.3)
//
//    09/21/03
//
//       Added EL - E(ncounter) L(evel) flag
//
// +++ Start Version ALFA 1.2.4 (v1.2.4)
//
//    10/03/03
// 
//       Added I subflag to SL flag.
//
//       Modified ST behavior so that spawned creatures walk to their seats
//       instead of running
//
//    10/18/03
//
//       Check night / day only, day, hour, lifespan and SU before restoring
//       spawns
//
//       Fixed recalculate random spawn number bug where the spawn number could 
//       change before a despawn due to the PC flag was restored, causing the 
//       number of creatures thought to exist to differ from what actually got
//       restored
//
//    10/19/03
//
//       Fixed SD bug; under certain cases (such as a despawn due to CL flag)
//       SD was being ignored.
//
//       Fixed bug where SU|I only worked if RS or SL were in use
//
// +++ Start Version ALFA 1.2.5 (v1.2.5)
//
//    10/25/03
//
//       Do a ClearAllActions() before despawning creatures.  This helps prevent
//       'broken' Bioware chairs caused by despawning creatures using the ST
//       flag.
//
//    10/27/03

//       Modified the spawn_cfg_camp example to use standard BW creatures /
//       placeables for the benefit of non-ALFA users.
//
//  
//    11/02/03
//
//       Added a scaled encounter example. This uses the same basic methodology
//       as Sareena's random wilderness spawns - an SNxx flag is given large 
//       enough for the largest possible spawn and then the actual number (and
//       types) of creatures is determined when the spawn actually takes place.  
//
//
// +++ Start Version 8.0
//
//    Given that NESS is now being supported outside the ALFA umbrella, I've
//    decided to begin version numbering from 8.0 from here out.  Version 8.0
//    is the immediate successor to ALFA version 1.2.5.
//
//    01/19/04
//
//      Fixed problems with naked NPC corpses that had droppable armor /
//      clothing. playable race characters (humans, dwarves, elves, etc.)
//      now keep a copy of whatever is in the chest slot on the original 
//      corpse.
//
//
//    01/21/04
//
//      Added Rn subflag to CD to specify what type of remains are left after
//      corpse decay.  These correspond 1 to 1 to the treasure type field for
//      placeables, except for R7, which causes no loot bag to be left (loot
//      destroyed when corpse decays).  See the specific flag documentation 
//      below for the values/types of each R subflag.
//
//      Added D subflag to CD to cause corpse to drop wielded weapons on the
//      ground. Note that droppable flag on weapon still takes precedence -
//      non-droppable wielded weapons will not be dropped.
//
//      Delete armor/clothing from corpse if looted.
//
//      Added scripts for lootable corpse onOpen, onClosed, onUsed, and
//      onDisturbed events (renamed with a spawn_ prefix).
//     
//      Added a lootable corpse placeable for each remains type;  each has the
//      correct event scripts attached.
//
//   01/22/04
//
//      Initialize global defaults and flags on first area heartbeat, not first
//      heartbeat with PCs present.
//
//      Use DelayCommand(0.0, ...) to give each spawn flag initialization 
//      function its own command queue (allowing many more spawn points before
//      TMIs at initialization occur).
//
//   01/23/04
//
//      Fixed bug with EE flag.  Spawned creature was not walking to spawn point
//      after entrance.
//
//      Fixed bug with spawn in effect when using EE.  Spawn in effect now happens
//      at the entrance point.
//
//      Added support for ALFA-specific flags as Custom Flags (following the CF 
//      flag.  Parsing and processing of custom flags can now be done by
//      modifying spawn_cfg_cusflg.  This file contains 2 functions: 
//      ParseCustomFlags() and SetupCustomFlags().  ParseCustomFlags is called
//      with whatever flags follow the CF_ flag (when flags for the spawn are 
//      being initialized.  Typically, flags are parsed and there values are 
//      written to the spawn object. SetupCustomFlags() is called when a 
//      creature is actually spawned (typically flags are copied from the spawn
//      object to the creature (spawned) object.  The processing of ALFA-specific
//      flags are included in this file as an example.
//
//
// +++ Start Version 8.1
//
//   1/29/04
//
//     Put better sounds for closing / opening corpses.  Changed the names of 
//     the onOpen and onClose event scripts for corpses, and updated the corpse
//     placeables to use those.
//
//   2/15/04
//
//     Fixed bugs in spawn_cfg_cusflag that caused flag values to be lost if
//     specified as normal flags rather than custom flags (only affected the 
//     ALFA custom flags).
//
//   3/8/04
//
//     'Home' is now either the place a creature spawned in, or the place it
//     *would have spawned in* if there wasn't an alternate specified by the EE
//     flag.  Hopefully, this restores it to its original, correct behavior.
//
//     The initial delay subflag of IS should now work correctly.
//
//     The corpse remains type default value was using one variable name in
//     spawn_defaults to set it and a different one in spawn_functions to
//     retrieve the value, which resulted in the default not working. This has
//     been fixed.
//
//     Added 2 new Patrol Route flags at Danmar's request.  They are RPn (for
//     random pause and RRn for Random Route.  These allow for some
//     randomization of patrol routes. The RRn flag sets the percentage chance
//     that the next stop in a route will actually be gone to (otherwise it's 
//     skipped.  RPn specifies a range to randomly choose an additional pause
//     amount which is added to the value specified by PSn.
//
//     At EPOlson's request, NESS will now look for a local string variable on
//     the spawn waypoint named "NESS" for spawn flags. If no string is found 
//     (or if it does not start with "SP") then the flags specified in the 
//     waypoint name are used (just like it used to).
//
//     NESS now has full support for using pseudo-heartbeats as an alternative
//     to the standard area heartbeats.  For those who wish to use this, remove
//     Spawn() from your area heartbeat script (or, if spawn_sample_hb is your 
//     area haertbeat script, just remove that script from your areas' On 
//     Heartbeat slots) and call Spawn_OnAreaEnter() and Spawn_OnAreaExit() 
//     from your area On Enter and On Exit scripts respectively. Again, if you
//     do no currrent have On Enter and or On Exit scripts in use for your areas
//     you can use spawn_smpl_onent and spawn_smpl_onext which are provided with
//     this release.
//
//      Spawn_OnAreaEnter() takes up to 3 optional arguments. The first is the
//      name of the script you want called when the pseudo-heartbeat happens.
//      By default, spawn_sample_hb is called (which in turn just calls Spawn().
//      You can put any script you like there, but remember that it will only be
//      when PCs or NESS creatures are in the area.  The second argument is the
//      time between pseudo-heartbeats.  The default is 6.0 seconds, which will
//      result in Spawn() being called about as often as when you used regular
//      area heartbeats.  If you find you can get away with 10.0 seconds (that's
//      what I'm currently using) you've reduced your NESS processing by 40%...
//      The 3rd argument specifies a delay for the first heartbeat after a PC or
//      PCs enter the area.  In areas where there aren't a lot of spawns, and 
//      you are spawning in sight (like NPCs in a store) no delay is ideal. For
//      outdoor areas with a lot of spawns that spawn away from the player, a 
//      delay helps prevent a spawn lag spike for the entering player.  The
//      default is 0.0 seconds (no delay). I'm currently delaying 3 seconds on 
//      all outdoor and underground areas, but no delay on indoor areas, by 
//      the following in my On Enter script:
//
//      if ( GetIsAreaAboveGround( oCurrArea ) && 
//         ! GetIsAreaNatural( oCurrArea ) )
//      { 
//        // Indoors - no delay on the first HB 
//        Spawn_OnAreaEnter( "spawn_sample_hb", 10.0 );
//      }
//
//      else
//      {
//        // Outdoors or underground - do a 3 second delay on the first HB
//        Spawn_OnAreaEnter( "spawn_sample_hb", 10.0, 3.0 );
//      }
//
//      Thanks to Mentha Arvensis who provided the starting scripts for pseudo-
//      heartbeats.
//
//
// +++ Start Version 8.1.1
// 
//   2/1/04 - 5/28/04
//
//   
//      NESS now allows you to specify the spawn tag by adding a variable, named
//      "NESS_TAG", on the spawn waypoint.  If this variable exists, it will use 
//      it's value as the spawn tag instead of waypoint's tag.
//  
//      Always retrieve spawn tag and spawn name from the variables written on 
//      the the spawn instead of using GetTag() an GetName().  This is necessary
//      to support use of the "NESS" and "NESS_TAG" variables.
//
//      Added a global flag, bLeftoversForceProcessing, to indicate whether or 
//      not spawned creatures in an area should cause NESS processing when no
//      PCs are in the area.  Default is TRUE (they do) which is how things
//      worked before the flag was added.  The flag essentially gives you the
//      ability to suppress that behavior. To do so, set 
//      bLeftoversForceProcessing to FALSE in your spawn_cfg_global script.
//
//      Added some bullet-proofing to check that spawn waypoints remain valid 
//      objects.
//
//      Turned off ALL NESS processing of creatures that are DM possessed.
//
//      Make sure a patrol waypoint actually exists before attempting to move to
//      it.
//
//      Normal Camp behavior is to despawn when all creatures in the camp have
//      been destroyed.  However, they were also despawning if there were never
//      any creatures in the camp to begin with (a placeable-only camp).  This
//      was fixed.
//
//      Loot/corpse decay was not working properly on camps, as the changes to
//      this system to the regular spawns was never propagated to the camps.
//      Fixed.
//
// +++ Start Version 8.1.2
// 
//   5/30/04
//
//      Advance routes to their next stop when patrol waypoints are missing
//
// +++ Start Version 8.1.3
//
//  7/04/04
//
//      Write a local var onto entering PCs which can be checked on area exit
//      to maintain a proper PC count.  This is necessary because GetIsPC() does
//      not work when a PC logs out.
//
//      Don't call NESS_CleanInventory on camp placeables when a camp is 
//      destroyed, as the placeables may remain for a while.
//
//  7/05/04
//
//      Added code to detect stalled patrol routes and jump the creature to it's
//      intended destination.  This can be turned off by setting 
//      CheckForStuckPatrols global variable to FALSE.
//
//      Write oSpawn onto the camp object "before" the call to SetCampSpawn() so
//      it is available to that function.
//
//      Added flag to turn off corpse destruction when CD is not specified.
//
//      Added additional on area enter script with indoor/outdoor checking to
//      determine if an initial delay should be used.
//
//  7/06/04
//
//      Added check to randomWalk for ACTION_CASTSPELL to avoid interruptions
//
// +++ Start Version 8.1.4
//
//  09/30/06
//
//      Packaged up all the change in the "Patches to 8.1.3" thread in the 
//      Bioware forums.
//
//  10/31/06
//
//      Added the Cache spawn flag. This Spawn allows users to specify a cached
//      object to spawn from. This should give some advantages in specific cases
//
//  11/09/07
//
//      Initial NWN2 conversion. All scripts remain intact.
//
//  11/17/06
//
//      Fixed a problem with the invisible placeables used for corpses
//
//  01/06/07
//
//     Added flags for spawning Lights, doors and placed effects
//
//  02/24/07
//
//     Re-classified some of the placeables/waypoints under the NESS heading
//
//  04/19/07 
// 
//     Added code to set lootable to false for corpses if AlwaysDestroyCorpses
//     is True.
//    
//     Fixed a bug where spawns would ignore exit waypoints if there was no entrance 
//     waypoint  
//
//  06/19/07
//
//     Added code to support the spawning of traps		 