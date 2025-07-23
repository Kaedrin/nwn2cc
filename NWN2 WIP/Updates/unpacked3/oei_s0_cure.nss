//::///////////////////////////////////////////////
//:: [Inflict Wounds]
//:: [oei_S0_cure.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
//:: This script is used by all the inflict spells
//::
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "oei_i0_spells"

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    int nSpellID = GetSpellId();
    switch (nSpellID)
    {
/*Minor*/     case SPELL_CURE_MINOR_WOUNDS: oei_spellsCure(4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, nSpellID);; break;
/*Light*/     case SPELL_CURE_LIGHT_WOUNDS: case SPELL_BG_Cure_Light_Wounds: oei_spellsCure(d8(), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_M, nSpellID); break;
/*Moderate*/  case SPELL_CURE_MODERATE_WOUNDS: case SPELL_BG_Cure_Moderate_Wounds: oei_spellsCure(d8(2), 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_L, nSpellID); break;
/*Serious*/   case SPELL_CURE_SERIOUS_WOUNDS: case SPELL_BG_Cure_Serious_Wounds: oei_spellsCure(d8(3), 15, 24, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_X, nSpellID); break;
/*Critical*/  case SPELL_CURE_CRITICAL_WOUNDS: case SPELL_BG_Cure_Critical_Wounds: oei_spellsCure(d8(4), 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_G, nSpellID); break;

    }
}