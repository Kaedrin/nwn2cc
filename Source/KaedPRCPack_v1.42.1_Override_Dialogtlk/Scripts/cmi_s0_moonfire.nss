//::///////////////////////////////////////////////
//:: Moonfire
//:: cmi_s0_moonfire
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April, 2012
//:://////////////////////////////////////////////

float SpellDelay (object oTarget, int nShape);

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

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

	int nDmgType = DAMAGE_TYPE_COLD;
	int nSaveThrow = SAVING_THROW_TYPE_COLD;
	int nHasPierceCold = FALSE;	
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD))
	{
		nHasPierceCold = TRUE;
	}	

    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
	float fMaxDelay = 0.0f; // Used to determine duration of cold cone
    object oTarget;
    //Limit Caster level for the purposes of damage.
    if (nCasterLevel > 20)
    {
        nCasterLevel = 20;
    }
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 22.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    	{
     // March 2003. Removed this as part of the reputation pass
     //            if((GetSpellId() == 340 && !GetIsFriend(oTarget)) || GetSpellId() == 25)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONE_OF_COLD));
                //Get the distance between the target and caster to delay the application of effects
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
				if (fDelay > fMaxDelay)
				{
					fMaxDelay = fDelay;
				}
                //Make SR check, and appropriate saving throw(s).
                //if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
                if(oTarget != OBJECT_SELF && !MyResistSpell(OBJECT_SELF, oTarget, fDelay)) //FIX: prevents caster from getting SR check against himself
                {
                    //Detemine damage
                    nDamage = d8(nCasterLevel);
					
					if (nHasPierceCold)
					{
						nDamage = AdjustPiercingColdDamage(nDamage, oTarget);
					}
					
                    //Adjust damage according to Reflex Save, Evasion or Improved Evasion
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), nSaveThrow);

                    // Apply effects to the currently selected target.
                    effect eCold = EffectDamage(nDamage, nDmgType, DAMAGE_POWER_NORMAL, nHasPierceCold);
                    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);
                    if(nDamage > 0)
                    {
                        //Apply delayed effects
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oTarget));
                    }
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 22.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
	fMaxDelay += 0.5f;
	effect eCone = EffectVisualEffect(VFX_DUR_CONE_ICE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}