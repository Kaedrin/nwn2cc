//::///////////////////////////////////////////////
//:: Hellfire Shield HEARTBEAT
//:: NW_S2_hellfireshield.nss
//:: Copyright (c) 2008 Obsidian Entertainment, Inc.
//:://////////////////////////////////////////////
/*
    Hellfire Warlock aura. Hits everyone in melee
	range on heartbeat with a Heallfire Blast in
	exchange for 1 Con per hit.  HEARTBEAT SCRIPT
*/
//:://////////////////////////////////////////////
//:: Created By: Justin Reynard (JWR-OEI)
//:: Created On: 06/20/2008
//:://////////////////////////////////////////////
//:: RPGplayer1 11/30/2008: No more hellfire, if immune to ability damage
//:: RPGplayer1 12/22/2008: Constitution damage changed to Extraordinary (to prevent dispelling)
//:: RPGplayer1 01/31/2008:
//::   Doesn't halve damage on failed saving throw anymore
//::   Will respect Evasion (uses GetReflexAdjustedDamage)
//::   Won't run hit vfx, if damage inflicted is 0

#include "nw_i0_invocatns"
#include "NW_I0_SPELLS"

void main()
{
	object oCaster = GetAreaOfEffectCreator();
	
	// JWR-OEI 10/06/2008
	// Exit out if the player is dying! don't want to be a
	// dead guy killing all the mobs!
	if (GetIsDead(oCaster, FALSE))
	{
		return;
	}
	
	//SpeakString("DEBUG MESSAGE (JWR-OEI 08.22.08): HellfireShield Heartbeat");
	int bIsShieldActive = GetActionMode(oCaster, ACTION_MODE_HELLFIRE_SHIELD);
	if (!bIsShieldActive)
	{
		return;
	}
	
	//SpeakString("DEBUG MESSAGE(JWR-OEI 08.22.08): HellfireShield GOOOOOOOOOOOOOOOOOOOOOOOOOO");
	//int nLevels = GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK, oCaster) + GetLevelByClass(CLASS_TYPE_WARLOCK, oCaster);
	int nChrMod = GetAbilityModifier(ABILITY_CHARISMA, oCaster);
	int nDC = 10 + (GetHitDice(oCaster)/2) + nChrMod;
	int nTotal = 0; // number of creatures we hit.
	int nDice = GetEldritchBlastLevel(oCaster) + GetHellfireBlastDiceBonus(oCaster); // number of dice to roll
	int nDmg = 0; // amount to damage
	effect eDmg; // damage effect
	effect eHit = EffectVisualEffect(VFX_HIT_SPELL_FIRE); // hit vfx VFX_HIT_SPELL_FIRE
	effect eLink; // linked effect
	
	// make sure we have valid const to cast this
	int nCurrCon = GetAbilityScore( oCaster, ABILITY_CONSTITUTION );
	if ( nCurrCon < 1 )
	{
		//Display Stopping Text
		FloatingTextStringOnCreature(GetStringByStrRef(STRREF_HELLFIRE_SHIELD_NO_CON), oCaster);
		SetActionMode(oCaster, ACTION_MODE_HELLFIRE_SHIELD, 0); 
		return;	
	}
	//FIX: if immune to ability damage, no hellfire for you!
	else if ( GetIsImmune(oCaster, IMMUNITY_TYPE_ABILITY_DECREASE) )
	{
		SetActionMode(oCaster, ACTION_MODE_HELLFIRE_SHIELD, 0); 
		return;	
	}
	object oTarget = GetFirstInPersistentObject();
	
	while(GetIsObjectValid(oTarget))
	 {
	 	if (  oTarget != oCaster && GetIsEnemy(oTarget, oCaster)) 
		{
			if ( !MyResistInvocation(oCaster, oTarget) )
			{
				nDmg = d6(nDice);
				// Relex Throw chance to halve the damage
				/*if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_NONE))
				{
					nDmg=nDmg/2;
				}*/
				//FIX: Now includes Evasion
				nDmg = GetReflexAdjustedDamage(nDmg, oTarget, nDC, SAVING_THROW_TYPE_NONE); 
			} else nDmg = 0; //needed to remove value from previous loop
				
			if (nDmg > 0)
			{
				eDmg = EffectDamage(nDmg, DAMAGE_TYPE_MAGICAL);
				eLink = EffectLinkEffects(eHit, eDmg);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
			}
			nTotal++;
			
					
		}
		oTarget = GetNextInPersistentObject();
	 }
	
	// Apply CON Damage
	if (nTotal > 0)
	{
		effect eConst = EffectAbilityDecrease(ABILITY_CONSTITUTION, nTotal);
		eConst = SetEffectSpellId(eConst, -1); // set to invalid spell ID to allow stacking.
		eConst = ExtraordinaryEffect(eConst);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConst, oCaster);
		HellfireShieldFeedbackMsg(nTotal, STRREF_HELLFIRE_SHIELD_NAME, oCaster);
	} 
}