//::///////////////////////////////////////////////
//:: Deadly Lahar
//:: cmi_s0_deadlahar
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
                    nDamage = d6(10);
        		    nDamage = ApplyMetamagicVariableMods( nDamage, 60 );
					nOrigDmg = nDamage;
					nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
 					
                    //int nRefSave = ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
                    
					if(nDamage == nOrigDmg)
					{
						effect eSlow = EffectSlow();
						effect eBurn = EffectDamageOverTime(nDamage/2, 5.5f, DAMAGE_TYPE_FIRE);
						effect eLink = EffectLinkEffects(eSlow, eBurn);
						effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
						float fDuration =  ApplyMetamagicDurationMods(18.0f);
						DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
					}
					else
                    {
						effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, FeetToMeters(60.0f), lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5f;
	effect eCone = EffectVisualEffect(VFX_DUR_CONE_FIRE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}