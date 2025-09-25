//::///////////////////////////////////////////////
//:: Stormsong - Gust of Wind
//:: cmi_s2_gustwind
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: February 14, 2008
//:: Based On: x0_s0_gustwind.nss
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellID = STORMSINGER_GUST_OF_WIND;

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetStormSongCasterLevel(oCaster);
	
	if (nCasterLvl < 9) //Short circuit
	{
		SendMessageToPC(OBJECT_SELF, "Insufficient Perform skill, you need 9 or more to use this ability.");
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
		
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
   // effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_AREA_OF_EFFECT);

	int nDC = 13 + GetAbilityModifier(ABILITY_CHARISMA, oCaster);
	nDC += GetDCBonusByLevel(oCaster);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            DestroyObject(oTarget);
        }
        else
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    	{
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID));
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

                // * unlocked doors will reverse their open state
                if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                {
                    if (GetLocked(oTarget) == FALSE)
                    {
                        if (GetIsOpen(oTarget) == FALSE)
                        {
                            AssignCommand(oTarget, ActionOpenDoor(oTarget));
                        }
                        else
                            AssignCommand(oTarget, ActionCloseDoor(oTarget));
                    }
                }
				if (oTarget != OBJECT_SELF)
				{
	                if(!MyResistSpell(OBJECT_SELF, oTarget) && !/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, nDC))
	        	    {
	
	                    effect eKnockdown = EffectKnockdown();
	                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));
	                    // Apply effects to the currently selected target.
	                 //   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
	                    //This visual effect is applied to the target object not the location as above.  This visual effect
	                    //represents the flame that erupts on the target not on the ground.
	                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                    
	                 }
				 }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }
}