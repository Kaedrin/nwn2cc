//::///////////////////////////////////////////////
//:: Create Greater Undead
//:: NW_S0_CrGrUnd.nss
//:: Copyright (c) 2005 Obsidian Entertainment
//:://////////////////////////////////////////////
/*
    Summons an undead type pegged to the character's
    level.
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
//::	Updated creature blueprints
//::	Changed duration from 24 hours to CL hours


#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"
#include "noc_evil_spell_corruption"

void main()
{

    if (!X2PreSpellCastCode())
    {
		// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


	AddEvilCorruption(OBJECT_SELF, GetSpellLevel(GetSpellId()));
	
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
	int nRoll = d2();
    //nDuration = 24;
    effect eSummon;
    
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;	//Duration is +100%
    }
	switch (nRoll)
	{
		case 1:
			eSummon = EffectSummonCreature("c_s_vampire_warrior", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
		case 2:
			eSummon = EffectSummonCreature("c_s_vampire_warlock", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
        default: 
			eSummon = EffectSummonCreature("c_s_vampire_warrior", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
	}
	
	//Apply summon effect and VFX impact.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
  	DelayCommand(6.0f, BuffSummons(OBJECT_SELF));
	
}