//::///////////////////////////////////////////////
//:: Frost Breath
//:: cmi_s0_frostbrth
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 6, 2009
//:://////////////////////////////////////////////

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
	int nHasPierceCold = FALSE;
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD))
	{
		nHasPierceCold = TRUE;
	}
		
	//effect eImm = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD, 50);
	//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImm, OBJECT_SELF);
	//itemproperty ipx = ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEIMMUNITY_75_PERCENT);	
	//AddItemProperty(DURATION_TYPE_PERMANENT, ipx, GetItemInSlot(INVENTORY_SLOT_CARMOUR));
				
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
	float fMaxDelay = 0.0f;
	int nDamage;
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	if (nCasterLvl > 5)
		nCasterLvl = 5;
	int nOrigDmg;
			
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);	
		
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, FeetToMeters(30.0f), lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    	{
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
				if (fDelay > fMaxDelay)
				{
					fMaxDelay = fDelay;
				}
                if(oTarget != OBJECT_SELF)
                {
                    nDamage = d4(nCasterLvl);
        		    nDamage = ApplyMetamagicVariableMods( nDamage, (4 * nCasterLvl) );
					int nOrigDmg = nDamage;
					nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_COLD);
         
					//int nRefSave = ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_COLD);
					if(nOrigDmg == nDamage)
					{
						if (nHasPierceCold)
						{
							nDamage = AdjustPiercingColdDamage(nDamage, oTarget);
						}
						effect eDaze = EffectDazed();
						effect eCold = EffectDamage(nDamage, nDmgType, DAMAGE_POWER_NORMAL, nHasPierceCold);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oTarget));
						DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, 6.0f));
					}
					else
                    {
						if (nHasPierceCold)
						{
							nDamage = AdjustPiercingColdDamage(nDamage, oTarget);
						}					
						effect eCold = EffectDamage(nDamage, nDmgType);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oTarget));
                    }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, FeetToMeters(30.0f), lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5f;
	effect eCone = EffectVisualEffect(VFX_DUR_CONE_ICE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}