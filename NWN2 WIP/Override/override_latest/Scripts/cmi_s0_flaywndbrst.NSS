//::///////////////////////////////////////////////
//:: Flaywind Burst
//:: cmi_s0_flaywndbrst
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: May 6, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

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

    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
	float fMaxDelay = 0.0f;
	int nDamage;
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	if (nCasterLvl > 10)
		nCasterLvl = 10;
	int nOrigDmg;	
		
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, FeetToMeters(60.0f), lTargetLocation, TRUE);
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
                    nDamage = d6(nCasterLvl);
        		    nDamage = ApplyMetamagicVariableMods( nDamage, (6 * nCasterLvl) );
					nOrigDmg = nDamage;
					nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ALL);

                    //int nRefSave = ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ALL);
                    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
                    
					if(nOrigDmg == nDamage)
					{
						effect eKD = EffectKnockdown();
						effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
						DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKD, oTarget, 5.0f));
					}
					else
                    {
						effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, FeetToMeters(60.0f), lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5f;
	effect eCone = EffectVisualEffect(VFX_DUR_CONE_MAGIC);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}