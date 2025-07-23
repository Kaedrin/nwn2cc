//::///////////////////////////////////////////////
//:: Glass Doppelganger
//:: nx_s0_glass_doppelganger.nss
//:: Copyright (c) 2007 Obsidian Entertainment, Inc.
//:://////////////////////////////////////////////
/*
	Caster Level(s): Sorc/wiz 5
	Innate Level: 5
	School: Illusion
	Descriptor(s): Shadow
	Component(s): V, S
	Range: Touch
	Area of Effect / Target: Single creature
	Duration: 1 round / level
	Save: No
	Spell Resistance: No
	
	This spell forms a living glass creation that
	is an exact copy of the target with the following
	exceptions: The creature is made out of glass,
	and thus more brittle, being summoned in at 1/4
	of the current hitpoints of the target. The
	summoned creature has 15 resistance to fire,
	cold, electricity, acid, peircing, and slashing
	damage types. The summoned creature gains
	vulnerability 50% to sonic and bludgeoning damage.
	The glass copy is allied with the caster, but
	not under direct control, acting as a summoned
	animal or a henchman. Creatures copied are must
	have the same or fewer hit dice than the caster
	has caster levels, with a hard cap of 15 HD.
	Copied creatures have no memorized spells. 
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Woo (AFW-OEI)
//:: Created On: 05/14/2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	object oTarget = GetSpellTargetObject();
	int nTargetHD = GetHitDice(oTarget);
	int nCasterLevel = GetCasterLevel(OBJECT_SELF);
	
	string sSelf;
	if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	{
		sSelf = IntToString(ObjectToInt(OBJECT_SELF));
	}
	else
	{
		SendMessageToPC(OBJECT_SELF, "Only hostile targets can be cloned.");	
		return;	
	}	
	
	if ( (nTargetHD > (nCasterLevel/2)) || (nTargetHD > 15))
	{	// Targets with greater HD than the caster, or with more than 15 HD are immune.
		SendMessageToPC(OBJECT_SELF, "This spell will not affect those with more than 15 HD or more HD than your caster level. Spell Failed.");
		return;
	}
	
	if (GetLocalInt(oTarget, "isBoss"))
	{	// It the target has more than double the caster's level, the target is immune.
		SendMessageToPC(OBJECT_SELF, "This spell may not affect boss creatures. Spell Failed.");	
		return;
	}
	
	if (GetIsPossessedFamiliar(OBJECT_SELF))
	{
		// Using a familiar allows two copies at once time. Exploit fix.
		SendMessageToPC(OBJECT_SELF, "This spell may not be used while possessing a familiar. Spell Failed.");	
		return;	
	}
	
	string sTag = GetTag(oTarget);	
	if (FindSubString(sTag, sSelf) != -1)
	{
		SendMessageToPC(OBJECT_SELF, "You may not create a copy of a clone. Spell Failed.");
		return;
	}			
	
	if (GetIsPC(oTarget))
	{
		SendMessageToPC(OBJECT_SELF, "You may not create a copy of another player. Spell Failed.");
		return;
	}	
	
	string sNewTag = IntToString(ObjectToInt(OBJECT_SELF)) + "_" + sTag;	// Create "unique" tag
	int	nNewHP = GetCurrentHitPoints(oTarget)/4;	// Copy has 1/4 the HP of the target.	
    effect eSummon = EffectSummonCopy(oTarget, VFX_FNF_SUMMON_UNDEAD, 0.0f, sNewTag, nNewHP, "nx_s0_glass_doppel_buff");

    //Check for metamagic extend
    int nDuration = nCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;	//Duration is +100%
    }
	
    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF));

}