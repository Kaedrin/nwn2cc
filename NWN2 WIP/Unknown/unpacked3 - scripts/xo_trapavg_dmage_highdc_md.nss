//::///////////////////////////////////////////////////
//:: X0_TRAPAVG_DMAGC
//:: OnTriggered script for a projectile trap
//:: Spell fired: SPELL_DISPEL_MAGIC
//:: Spell caster level: 5
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/17/2002
//:: Edited by Bucephalus for higher dc
//::///////////////////////////////////////////////////

#include "x0_i0_projtrap"

void main()
{
 	object oPC = GetEnteringObject();

	if (!GetIsPC(oPC)) return;

	if (GetItemPossessedBy(oPC, "elf_df_key")!= OBJECT_INVALID)
   		return;  

 	//TriggerProjectileTrap(SPELL_DISPEL_MAGIC, GetEnteringObject(), 25);
}
