//::///////////////////////////////////////////////
//:: [Inflict Wounds]
//:: [oei_S0_Inflict.nss]
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
/*Minor*/     case 431: oei_spellsInflictTouchAttack(1, 0, 1, 246, VFX_HIT_SPELL_INFLICT_1, nSpellID); break;
/*Light*/     case 432: case 609: oei_spellsInflictTouchAttack(d8(), 5, 8, 246, VFX_HIT_SPELL_INFLICT_2, nSpellID); break;
/*Moderate*/  case 433: case 610: oei_spellsInflictTouchAttack(d8(2), 10, 16, 246, VFX_HIT_SPELL_INFLICT_3, nSpellID); break;
/*Serious*/   case SPELL_BG_InflictSerious: case SPELL_BG_Spellbook_2: case 434: case 611: oei_spellsInflictTouchAttack(d8(3), 15, 24, 246, VFX_HIT_SPELL_INFLICT_4, nSpellID); break;
/*Critical*/  case SPELL_BG_Spellbook_4: case SPELL_BG_InflictCritical: case 435: case 612: oei_spellsInflictTouchAttack(d8(4), 20, 32, 246, VFX_HIT_SPELL_INFLICT_5, nSpellID); break;

    }
}