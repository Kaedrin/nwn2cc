//::///////////////////////////////////////////////
//:: Animate Dead
//:: NW_S0_AnimDead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a powerful skeleton or zombie depending
    on caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
//:: AFW-OEI 06/02/2006:
//::	Updated creature blueprints.

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"
#include "noc_evil_spell_corruption"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


	AddEvilCorruption(OBJECT_SELF, GetSpellLevel(GetSpellId()));

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
	int nRoll = d2();
    //nDuration = 24;	// AFW-OEI 06/02/2006: No longer lasts 24 hours.
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;	//Duration is +100%
    }
    //Summon the appropriate creature based on the summoner level
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
		
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF));
}