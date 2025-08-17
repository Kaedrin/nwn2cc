//::///////////////////////////////////////////////
//:: Create Undead
//:: NW_S0_CrUndead.nss
//:: Copyright (c) 2005 Obsidian Entertainment
//:://////////////////////////////////////////////
/*
    Spell summons a Ghoul, Shadow, Ghast, Wight or
    Wraith
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Update By: Brock H. - OEI
//:: Update On: 10/07/05
//:: Changed summoned creature resrefs
//:://////////////////////////////////////////////
//:: AFW-OEI 06/02/2006:
//::	Updated creature blueprints.
//::	Changed duration from 24 hours to CL hours.

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
		// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
	int nRoll = d3();
    //nDuration = 24;
    effect eSummon;

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;	//Duration is +100%
    }
    //Set the summoned undead to the appropriate template based on the caster level
	switch (nRoll)
	{
		case 1:
			eSummon = EffectSummonCreature("c_s_mummy", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
		case 2:
			eSummon = EffectSummonCreature("c_s_wraith", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
		case 3:
			eSummon = EffectSummonCreature("c_s_ghast", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
        default: 
			eSummon = EffectSummonCreature("c_s_mummy", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
	}

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF));
}