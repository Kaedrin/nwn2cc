//:://///////////////////////////////////////////////
//:: Warlock Lesser Invocation: The Dead Walk(!)
//:: nw_s0_icharm.nss
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//::////////////////////////////////////////////////
//:: Created By: Brock Heinz
//:: Created On: 08/12/05
//::////////////////////////////////////////////////
/*
        5.7.2.5	Dead Walk, The
        Complete Arcane, pg. 133
        Spell Level:	4
        Class: 		Misc

        This functions identically to the animate dead spell (3rd level wizard).

        [Rules Note] There is a gem component to make the animated creatures 
        last more than 1 minute per level. Special component rules for spells 
        don't exist in NWN2.

*/
// AFW-OEI 06/02/2006:
//	Update creature blueprints

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
    int nMetaMagic      = GetMetaMagicFeat();
    int nCasterLevel    = GetWarlockCasterLevel(OBJECT_SELF);
    int nDuration       = nCasterLevel;		// AFW-OEI 06/02/2006: 24 -> CL
	int nRoll = d2();
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;

    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;	//Duration is +100%
    }

    switch (nRoll)
	{
		case 1:
			eSummon = EffectSummonCreature("c_s_skeleton", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
		case 2:
			eSummon = EffectSummonCreature("c_s_zombie", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
        default: 
			eSummon = EffectSummonCreature("c_s_skeleton", VFX_HIT_SPELL_SUMMON_CREATURE);
			break;
	}

    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
	DelayCommand(2.0f, BuffSummons(OBJECT_SELF));
}