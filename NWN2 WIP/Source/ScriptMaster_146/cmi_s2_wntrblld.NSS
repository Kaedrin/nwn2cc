//::///////////////////////////////////////////////
//:: Stormsingers Winters Ballad
//:: cmi_s2_wntrblld
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 16, 2008
//:://////////////////////////////////////////////

//Based on Call Lightning Storm by OEI


#include "nw_i0_spells" 
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_ginc_chars"

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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetStormSongCasterLevel(oCaster);

	if (nCasterLvl < 15) //Short circuit
	{
		SendMessageToPC(OBJECT_SELF, "Insufficient Perform skill, you need 15 or more to use this ability.");
		return;
	}
	if (!GetHasFeat(257))
	{
		SpeakString("No uses of the Bard Song ability are available");
		return;
	}
	else
	{
		DecrementRemainingFeatUses(OBJECT_SELF, 257);		
	}	
			
	int nSpellID = STORMSINGER_WINTER_BALLAD;
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
	effect eVis2 = EffectVisualEffect(916); //VFX_SPELL_HIT_CALL_LIGHTNING
	effect eDur = EffectVisualEffect(915); //VFX_SPELL_DUR_CALL_LIGHTNING
	effect eLink = EffectLinkEffects(eVis, eVis2);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 15)
    {
        nCasterLvl = 15;
    }
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oCaster, 1.75);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
           //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetRandomDelay(1.4, 2.25);	// AFW-OEI 07/10/2007: Increase delay to synch better with AoE VFX.
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                //Roll damage for each target
                nDamage = d6(nCasterLvl);
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, (GetSpellSaveDC()+4), SAVING_THROW_TYPE_ELECTRICITY);
                //Set the damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}