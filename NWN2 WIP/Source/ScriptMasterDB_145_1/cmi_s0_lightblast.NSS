//::///////////////////////////////////////////////
//:: Lightning Blast
//:: cmi_s0_lightblast
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Dec 4, 2011
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
	if (nCasterLvl > GetHitDice(OBJECT_SELF))
		nCasterLvl = GetHitDice(OBJECT_SELF);
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
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
					if(!MyResistSpell(OBJECT_SELF, oTarget))
					{
	                    nDamage = d8(nCasterLvl);
        		    	nDamage = ApplyMetamagicVariableMods( nDamage, (8 * nCasterLvl) );

	                    int nFortSave = FortitudeSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ALL);
	                    
						if(nFortSave == 0)
						{
							effect eBoom = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oTarget));
						}
						else
						if(nFortSave == 1)
	                    {
							nDamage = nDamage/2;
							effect eBoom = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oTarget));
	                    }
					}
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, FeetToMeters(30.0f), lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5f;
	effect eCone = EffectVisualEffect(VFX_DUR_CONE_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}