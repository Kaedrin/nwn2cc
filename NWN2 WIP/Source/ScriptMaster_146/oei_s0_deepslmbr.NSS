//::///////////////////////////////////////////////
//:: Deep Slumber
//:: NW_S0_DeepSlmbr
//:://////////////////////////////////////////////
/*
    Goes through the area and sleeps the lowest 10+1d10
    HD of creatures first.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: June 11, 2005
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "oei_i0_spells"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
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
    object oTarget;
    object oLowest;
    effect eSleep =  EffectSleep();
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ENCHANTMENT);

     // * Moved the linking for the ZZZZs into the later code
     // * so that they won't appear if creature immune

	int nDecrement = 0;
    int bContinueLoop;
    int nHD = 10 + d10();
    int nCurrentHD;
    int bAlreadyAffected;
    int nMax = 11;// maximun hd creature affected
    int nLow;
	int nDur;
	int nSpellDC;
	if (GetSpellId() == SPELL_ASN_Deep_Slumber)
	{	
        nDur = GetAssassinCasterLevel(OBJECT_SELF);
		nSpellDC = oei_GetSpellSaveDC(ABILITY_INTELLIGENCE);
	}
	else
	{
    	nDur = GetCasterLevel(OBJECT_SELF);
		nSpellDC = GetSpellSaveDC();
	}
    nDur = 3 + GetScaledDuration(nDur, oTarget);	
    float fDuration = RoundsToSeconds(nDur);

    string sSpellLocal = "BIOWARE_SPELL_LOCAL_SLEEP_" + ObjectToString(OBJECT_SELF);

    //Enter Metamagic conditions
    nHD = ApplyMetamagicVariableMods(nHD, 20);
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);
    fDuration += RoundsToSeconds(2);

    //Get the first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    //If no valid targets exists ignore the loop
    if (GetIsObjectValid(oTarget))
    {
        bContinueLoop = TRUE;
    }
    // The above checks to see if there is at least one valid target.
    while ((nHD > 0) && (bContinueLoop))
    {
        nLow = nMax;
        bContinueLoop = FALSE;
        //Get the first creature in the spell area
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget))
        {
            //Make faction check to ignore allies
        	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)
                && GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
        	{
                //Get the local variable off the target and determined if the spell has already checked them.
                bAlreadyAffected = GetLocalInt(oTarget, sSpellLocal);
                if (!bAlreadyAffected)
                {
                     //Get the current HD of the target creature
                     nCurrentHD = GetHitDice(oTarget);
                     //Check to see if the HD are lower than the current Lowest HD stored and that the
                     //HD of the monster are lower than the number of HD left to use up.
                     if(nCurrentHD < nLow && nCurrentHD <= nHD && nCurrentHD < 11)
                     {
                         nLow = nCurrentHD;
                         oLowest = oTarget;
                         bContinueLoop = TRUE;
                     }
                }
            }
            //Get the next target in the shape
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
        }
		nDecrement = 0;
        //Check to see if oLowest returned a valid object
        if(oLowest != OBJECT_INVALID)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLEEP));
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oLowest))
            {
                //Make Will save
                if(!MySavingThrow(SAVING_THROW_WILL, oLowest, nSpellDC, SAVING_THROW_TYPE_MIND_SPELLS))
                {
                    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oLowest);
                    if (GetIsImmune(oLowest, IMMUNITY_TYPE_SLEEP) == FALSE)
                    {
                        ApplyEffectToObject(nDurType, eSleep, oLowest, fDuration);
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oLowest);
						nDecrement = GetHitDice(oLowest);
                    }
                    else
                    // * even though I am immune apply just the sleep effect for the immunity message
                    {
                        ApplyEffectToObject(nDurType, eSleep, oLowest, fDuration);
                    }

                }
            }
        }
        //Set a local int to make sure the creature is not used twice in the pass.  Destroy that variable in
        //.3 seconds to remove it from the creature
        SetLocalInt(oLowest, sSpellLocal, TRUE);
        DelayCommand(0.5, SetLocalInt(oLowest, sSpellLocal, FALSE));
        DelayCommand(0.5, DeleteLocalInt(oLowest, sSpellLocal));
        //Remove the HD of the creature from the total
        nHD = nHD - nDecrement;
        oLowest = OBJECT_INVALID;
    }
}