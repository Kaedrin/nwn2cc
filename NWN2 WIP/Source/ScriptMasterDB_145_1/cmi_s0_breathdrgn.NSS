//::///////////////////////////////////////////////
//:: Breath of the Dragon
//:: cmi_s0_breathdrgn
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
	int nHD = GetHitDice(OBJECT_SELF);
	int nCasterLvl = 3 + nHD / 2;
	
	effect eVis;
	int nDamageType;
	effect eCone;
	
	if (GetHasSpellEffect(707))
	{
		//Red
		eVis = EffectVisualEffect(VFX_HIT_SPELL_FIRE);
		nDamageType = DAMAGE_TYPE_FIRE;
		eCone = EffectVisualEffect(VFX_DUR_CONE_FIRE);		
	}
	else
	if ( GetHasSpellEffect(2148)  )
	{
		//Silver
		eVis = EffectVisualEffect(VFX_HIT_SPELL_ICE);
		nDamageType = DAMAGE_TYPE_COLD;
		eCone = EffectVisualEffect(VFX_DUR_CONE_ICE);	
	}
	else
	if (GetHasSpellEffect(709))
	{
		//Black
		eVis = EffectVisualEffect(VFX_HIT_SPELL_ACID);
		nDamageType = DAMAGE_TYPE_ACID;
		eCone = EffectVisualEffect(VFX_DUR_CONE_ACID);	
	}	
	else
	if ( GetHasSpellEffect(2147)  )	
	{				
		//Bronze
		eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
		nDamageType = DAMAGE_TYPE_ELECTRICAL;
		eCone = EffectVisualEffect(VFX_DUR_CONE_LIGHTNING);
	}	
	else
	if ( GetHasSpellEffect(708)  )	
	{				
		//Blue
		eVis = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
		nDamageType = DAMAGE_TYPE_ELECTRICAL;
		eCone = EffectVisualEffect(VFX_DUR_CONE_LIGHTNING);
	}		
	else
	{
		//Not a dragon
		SendMessageToPC(OBJECT_SELF, "This spell can only be used while in one of the five dragon shapes.");
		return;
	}

	int nDC = 10 + (nHD/2) + GetAbilityModifier(ABILITY_CONSTITUTION);
	float nFeet = FeetToMeters(60.0f);
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, nFeet, lTargetLocation, TRUE);
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
					{
	                    nDamage = d8(nCasterLvl);
        		    	nDamage = ApplyMetamagicVariableMods( nDamage, (8 * nCasterLvl) );

	                    int nRefSave = ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_ALL);
	                    
						if(nRefSave == 0)
						{
							effect eBoom = EffectDamage(nDamage, nDamageType);
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oTarget));
						}
						else
	                    {
							nDamage = nDamage/2;
							effect eBoom = EffectDamage(nDamage, nDamageType);
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oTarget));
	                    }
					}
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, nFeet, lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5f;
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}