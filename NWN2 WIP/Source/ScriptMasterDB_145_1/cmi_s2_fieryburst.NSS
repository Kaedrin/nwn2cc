//::///////////////////////////////////////////////
//:: Fiery Burst
//:: cmi_s2_fieryburst
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 12, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

int GetFieryBurstReserveDamageDice()
{

	if (GetHasSpell(116) || GetHasSpell(158) || GetHasSpell(48) )
		return 9;
								
	if (GetHasSpell(89) || GetHasSpell(2025))
		return 8;
		
	if ( GetHasSpell(39) || GetHasSpell(57) )
		return 7;	
												
	if ( GetHasSpell(61) || GetHasSpell(440) || GetHasSpell(446) || GetHasSpell(869) || GetHasSpell(871) )
		return 5;						
		
	if ( GetHasSpell(47) || GetHasSpell(191) || GetHasSpell(1826) || GetHasSpell(1208))
		return 4;
			
	if ( GetHasSpell(58) || GetHasSpell(59) || GetHasSpell(1753) || GetHasSpell(1759) || GetHasSpell(1814) )
		return 3;	
				
	if ( GetHasSpell(518) || GetHasSpell(542) || GetHasSpell(851) || GetHasSpell(1001) || GetHasSpell(1055) || 
		GetHasSpell(1747) || GetHasSpell(1858) )
		return 2;	
																													
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	int nDamageDice = 0;
	nDamageDice = GetFieryBurstReserveDamageDice();	 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
		return;	
	}

	int bIgnoreResists = GetHasFeat(FEAT_IMPROVED_RESERVE_FEATS, OBJECT_SELF);
	int bUseOrbEffect = GetHasFeat(FEAT_RESERVE_FEAT_ENHANCEMENT, OBJECT_SELF);
		
	float fDelay;
	int nDamage;
	effect eDam;
	effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
	int nSaveThrow = SAVING_THROW_TYPE_FIRE;
	
	effect eOrbEffect1 = EffectACDecrease(1);
	effect eOrbEffect2 = EffectAttackDecrease(1);
	effect eOrbEffect = EffectLinkEffects(eOrbEffect1, eOrbEffect2);		
    eOrbEffect = SetEffectSpellId(eOrbEffect, SPELL_SPELLABILITY_Fiery_Burst);
	eOrbEffect = SupernaturalEffect(eOrbEffect);		
		
		
	location lTarget = GetSpellTargetLocation();
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    	{
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
				
                    //Roll damage for each target
                    //nDamage = d6(nDamageDice);
					nDamage = HandleReserveMeta(nDamageDice, 6);

					int nDC = GetReserveSpellSaveDC(nDamageDice,OBJECT_SELF);
					
					if (GetLevelByClass(CLASS_MYSTIC_RESV) == 0)
					{
	                    //Adjust damage according to Reflex Save, Evasion or Improved Evasion
	                   	nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
					}
						
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL, bIgnoreResists);
                    if(nDamage > 0)
                    {
                        // Apply effects to the currently selected target.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        //This visual effect is applied to the target object not the location as above.  This visual effect
                        //represents the flame that erupts on the target not on the ground.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
						
						if (bUseOrbEffect)
						{
							if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, nSaveThrow))
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOrbEffect, oTarget, 6.0f);
						}
                    }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
			

}