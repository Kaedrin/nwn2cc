//::///////////////////////////////////////////////
//:: Winter's Blast
//:: cmi_s2_winterblast
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 21, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

int GetColdReserveLevel()
{

	if ( GetHasSpell(158) || GetHasSpell(1045))
		return 9;
			
	if (GetHasSpell(886))
		return 8;
			
	if (GetHasSpell(25))
		return 5;
			
	if ( GetHasSpell(47) || GetHasSpell(368) || GetHasSpell(1043) || GetHasSpell(1825) || GetHasSpell(1206) || GetHasSpell(2098) || GetHasSpell(2131))
		return 4;	
															
	if ( GetHasSpell(1031) || GetHasSpell(1753) || GetHasSpell(1814) || GetHasSpell(2132))
		return 3;
		
	if ( GetHasSpell(1042) || GetHasSpell(1747) || GetHasSpell(2028))
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
	int nReserveLevel = 0;
	nReserveLevel = GetColdReserveLevel();
		
	object oTarget;
	location lTargetLocation = GetSpellTargetLocation();
    float fDelay;
	float fMaxDelay = 0.0f;
	int nDamage;
	
	int bIgnoreResists = GetHasFeat(FEAT_IMPROVED_RESERVE_FEATS, OBJECT_SELF);
	int bUseOrbEffect = GetHasFeat(FEAT_RESERVE_FEAT_ENHANCEMENT, OBJECT_SELF); 
		
	effect eOrbEffect = EffectBlindness();
	int nSaveThrow = SAVING_THROW_TYPE_COLD;
			 
	if (nReserveLevel == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	//if (GetIsObjectValid(oTarget))
	{
    	oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 6.1, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
		int nDC = GetReserveSpellSaveDC(nReserveLevel,OBJECT_SELF);
	    while(GetIsObjectValid(oTarget))
	    {
	        if (oTarget != OBJECT_SELF && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	    	{
	                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
	                //Get the distance between the target and caster to delay the application of effects
	                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
					if (fDelay > fMaxDelay)
					{
						fMaxDelay = fDelay;
					}

	                    //Detemine damage
	                    nDamage = d6(nReserveLevel);
						nDamage = HandleReserveMeta(nReserveLevel, 6);

						if (GetLevelByClass(CLASS_MYSTIC_RESV) == 0)
						{
							if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_COLD))
								nDamage = nDamage/2;
						}
						
						if (GetLocalInt(GetModule(), "WintersBlastUsesPiercingCold"))
						{
							if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD , OBJECT_SELF))
								bIgnoreResists = TRUE;
						}						
						
	                    // Apply effects to the currently selected target.
						effect eCold = EffectDamage(nDamage, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, bIgnoreResists);

	                    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);
	                    if(nDamage > 0)
	                    {
	                        //Apply delayed effects
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oTarget));
							
							if (bUseOrbEffect)
							{
								if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, nSaveThrow))
									DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOrbEffect, oTarget, 6.0f));
							}
	                    }
	        }
	        //Select the next target within the spell shape.
	        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 6.1, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	    }
		fMaxDelay += 0.5f;
		effect eCone = EffectVisualEffect(VFX_DUR_CONE_ICE);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
		
	}			


}