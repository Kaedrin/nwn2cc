//::///////////////////////////////////////////////
//:: Guarding the Lord
//:: NW_S2_GuardLord.nss
//:://////////////////////////////////////////////
/*
    Target creature gains +1 Deflection bonus to
    AC, +1 resistance to saves, and takes 30%
    damage.  50% of the original damage is applied
    to the caster of this spell.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: August 10, 2005
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001



// JLR - OEI 08/23/05 -- Metamagic changes
// RPGplayer1 02/10/09 - Use HD for caster level

#include "nwn2_inc_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook" 

void ProximityCheck(object oTarget, float fTime, float fDuration) {
	object oCaster = OBJECT_SELF;

	fTime = fTime + 6.0;

	// Only check if the spell is still in effect
	if(fTime <= fDuration) {
		// If the caster is logged out, remove the spell
	    if(!GetIsObjectValid(oCaster)) {
       		GZRemoveSpellEffects(929, oTarget);
       	 	return;
    	}
		
		// If either are dead, remove the spell
    	if (GetIsDead(oCaster) || GetIsDead(oTarget) ) {
        	GZRemoveSpellEffects(929, oTarget);
        	return;
    	}

		object oCasterArea = GetArea(oCaster);
		object oTargetArea = GetArea(oTarget);
		// Check if either are in transition.  If so, wait until the next cycle.
		if(!GetIsObjectValid(oCasterArea) || !GetIsObjectValid(oTargetArea)) {
			DelayCommand(6.0, ProximityCheck(oTarget, fTime, fDuration));			
		} else {
			// if the caster and target are on a different map, the spell effect is removed
			if (GetName(GetArea(oCaster)) != GetName(GetArea(oTarget))) {
				if(GetIsPC(oCaster)) 
					SendMessageToPC(oCaster, "Guarding the Lord: Target out of range");
	        	GZRemoveSpellEffects(929, oTarget);
			} else {  // schedule another check
				DelayCommand(6.0, ProximityCheck(oTarget, fTime, fDuration));
			}
		}
	}
}

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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nCasterLvl = GetHitDice(OBJECT_SELF);
    float fDuration = HoursToSeconds(nCasterLvl);

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

    effect eAC = EffectACIncrease(1, AC_DEFLECTION_BONUS);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1);
    effect eDmg = EffectShareDamage(OBJECT_SELF, 30, 50);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

	effect eHit = EffectVisualEffect(VFX_HIT_SPELL_ABJURATION);
    
    effect eLink = EffectLinkEffects(eAC, eSave);
    eLink = EffectLinkEffects(eLink, eDmg);
    eLink = EffectLinkEffects(eLink, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHIELD_OTHER, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);
	
	DelayCommand(6.0, ProximityCheck(oTarget, 1.0, fDuration));
}