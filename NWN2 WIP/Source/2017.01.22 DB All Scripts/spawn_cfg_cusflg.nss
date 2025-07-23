//
// NESS V8.1
// Spawn Config Custom Flags
//
//  This file is for the USER to to add support for custom flags.  It will
//  normally not be overwritten by UPDATE releases, so remerging can be avoided.
//
//  ALFA and LoG Custom Flags (included here both as examples and to aid
//  ALFA builders in switching over to the new methodology)
//
//   SXn
//   : Suppress XP
//   : Suppress diminishing returns XP
//   : SX1 turns suppression on (the default, you may just use SX)
//   : SX0 turns suppression off for the spawn if it has been put on
//   : globally (by setting nGlobalSuppressDR to TRUE in spawn_cfg_global)
//
//   NL
//   : No Loot
//   : Suppress player corpse looting
//
//   SB
//   : SuBdual
//   : Spawn creatures in in subdual mode
//
//   ELn
//   : Encounter Level
//   : Set the encounter level for a spawn
//   : This is used by the ALFA core rules in determining whether or not
//   : an encounter should result in XP to a given level party.  If not
//   : specified, the CR of the creature killed is used as the EL.
//
//

#include "spawn_flags"

void ParseCustomFlags(object oSpawn, string sFlags)
{
    // Get Defaults.  You can set defaults for your custom flags in
    // spawn_cfg_global
      object oModule = GetModule();

    int dfSuppressDR = GetLocalInt(oModule, "df_SuppressDR");
    int dfGlobalSuppressDR = GetLocalInt(oModule, "df_GlobalSuppressDR");
    int dfEncounterLevel = GetLocalInt(oModule, "df_EncounterLevel");


    // NOTE:  Because of the unique nature of these flags being present as both 
    // standard flags and custom flags (for back compatibility) only write flags
    // if they're present!!

    // Initialize Dim Returns Suppression
    int nSuppressDimReturns = IsFlagPresent(sFlags, "SX");

    if (nSuppressDimReturns)
    {
      // If the flag is present, get suppression mode from its value
      nSuppressDimReturns = GetFlagValue(sFlags, "SX", dfSuppressDR);
      SetLocalInt(oSpawn, "f_SuppressDimReturns", nSuppressDimReturns);
    }

    // Initialize Loot Suppression
    int nSuppressLooting = IsFlagPresent(sFlags, "NL");

    // Record Loot Suppression
    if (nSuppressLooting)
    {
      SetLocalInt(oSpawn, "f_SuppressLooting", nSuppressLooting);
    }

    // Initialize Subdual Mode
    int nSubdualMode = IsFlagPresent(sFlags, "SB");

    // Record Subdual Mode
    if (nSubdualMode)
    {
      SetLocalInt(oSpawn, "f_SubdualMode", nSubdualMode);
    }

    int nEncounterLevel;

    // Initialize Encounter Level
    if (IsFlagPresent(sFlags, "EL"))
    {
      nEncounterLevel = GetFlagValue(sFlags, "EL", dfEncounterLevel);
      SetLocalInt(oSpawn, "f_EncounterLevel", nEncounterLevel);
    }
}

void SetupCustomFlags(object oSpawn, object oSpawned)
{
    int nSuppressLooting = GetLocalInt(oSpawn, "f_SuppressLooting");
    int nSubdualMode = GetLocalInt(oSpawn, "f_SubdualMode");
    int nEncounterLevel = GetLocalInt(oSpawn, "f_EncounterLevel");


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
}