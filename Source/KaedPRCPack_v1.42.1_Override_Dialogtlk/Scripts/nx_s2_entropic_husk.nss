//::///////////////////////////////////////////////
//:: Entropic Husk
//:: nx_s2_entropic_husk
//:: Copyright (c) 2007 Obsidian Entertainment, Inc.
//:://////////////////////////////////////////////
/*
	Classes: Druid, Spirit Shaman, Wizard, Sorcerer, Warlock
	Spellcraft Required: 31
	Caster Level: Epic
	Innate Level: Epic
	School: Conjuration
	Descriptor(s): Chaos
	Components: Verbal, Somatic
	Range: Touch
	Area of Effect / Target: Creature Touched
	Duration: 20 rounds
	Save: Will negates (DC +5)
	Spell Resistance: No
	 
	You transform a single enemy into a vessel of pure chaos
	which randomly attacks all nearby creatures. 
	 
	You must succeed at a melee touch attack, and the target
	must fail at a Will saving throw (DC +5). If the target
	fails the saving throw, its soul is instantly annihilated,
	and its body is animated by primal entropy. For the
	duration of the spell, the creature becomes a juggernaut
	of destruction, gaining a +8 bonus to Strength and
	Constitution, and randomly attacking former allies and
	enemies alike. After 20 rounds, the entropic force
	animating the creature's body burns itself out, and the
	creature collapses into dust.

*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Woo
//:: Created On: 04/16/2007
//:://////////////////////////////////////////////
//:: AFW-OEI 06/25/2007: Reduce DC from +15 to +5.
//:: RPGplayer1 03/25/2008: Uses epic spell save workaround
//:: RPGplayer1 03/28/2008: Insanity will work on creatures immune to mind effects


#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "nx1_inc_epicsave"

void main()
{
	if (!X2PreSpellCastCode())
	{	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
		return;
	}
	
	int nSaveDC = GetEpicSpellSaveDC2(SPELL_SCHOOL_CONJURATION) + 5;
	float fDuration = RoundsToSeconds(20);
	
	object oTarget = GetSpellTargetObject();
	
	//effect eVis = EffectVisualEffect(VFX_HIT_SPELL_EVIL);
	effect eDeath = EffectDeath(FALSE, TRUE, TRUE); 		// No spectacular death, yes display feedback, yes ignore death immunity.	
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 8);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 8);
	effect eEnlarge = EffectSetScale(1.2);					// 20% size increase.
	effect eInsane = EffectInsane();
	
	effect eLink = EffectLinkEffects(eStr, eCon);
	eLink = EffectLinkEffects(eLink, eInsane);
	
	if (HasSizeIncreasingSpellEffect(oTarget) != TRUE)
	{	// Only link in enlarge if not already enlarged
		eLink = EffectLinkEffects(eLink, eEnlarge);
	}
		
	eLink = ExtraordinaryEffect(eLink);	// No dispelling!
	
	
	if (TouchAttackMelee(oTarget) != FALSE)
	{	// If we succeed at a melee touch attack
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));

			if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nSaveDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF))
			{	// Fail save, so go insane & get buffed, then die.
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

				if ( GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget))
				{	
					effect eHeal = EffectHeal(1);
					ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);	
				}				
				DelayCommand(fDuration, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));	// You're already dead and you don't even know it!

				if (GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF)) //FIX: will work on mind spell immune too
				{
					float fDelay = 0.0f;
					while (fDelay < fDuration)
					{
						DelayCommand(fDelay, ExecuteScript("nw_g0_insane", oTarget));
						fDelay += 6.0f;
					}
				}
			}
		}			
	}	
}