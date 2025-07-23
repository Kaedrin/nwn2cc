//::///////////////////////////////////////////////
//:: Beam of Sunlight (Master of Radiance)
//:: cmi_s2_searlght
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:://////////////////////////////////////////////
//:: Based on Sunbeam by OEI

#include "cmi_includes"
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

	if (!GetHasSpellEffect(SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA))
	{
        SpeakString("This ability can only be used while Radiant Aura is active.");
	}
	else
	{
	
	    //Declare major variables
	    int nMetaMagic = GetMetaMagicFeat();
	    effect eVis2 = EffectVisualEffect(VFX_HIT_SPELL_HOLY);
	    effect eDam;
	    effect eBlind = EffectBlindness();
	    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
	    effect eLink = EffectLinkEffects(eBlind, eDur);
	
	    int nCasterLevel= GetCasterLevel(OBJECT_SELF) +2;
	    int nDamage;
	    int nOrgDam;
	    int nMax;
	    float fDelay;
	    int nBlindLength = 3;
	    //Limit caster level
	    if (nCasterLevel > 20)
	    {
	        nCasterLevel = 20;
	    }
	    //Get the first target in the spell area
	    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
	    while(GetIsObjectValid(oTarget))
	    {
	        // Make a faction check
	        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	        {
	            fDelay = GetRandomDelay(1.0, 2.0);
	            //Fire cast spell at event for the specified target
	            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));
	            //Make an SR check
	            if ( ! MyResistSpell(OBJECT_SELF, oTarget, 1.0))
	            {
	                //Check if the target is an undead
	                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
	                {
	                    //Roll damage and save
	                    nDamage = d6(nCasterLevel);
	                    nMax = 6;
	                }
	                else
	                {
	                    //Roll damage and save
	                    nDamage = d6(4);
	                    nOrgDam = nDamage;
	                    nMax = 6;
	                    nCasterLevel = 4;
	                    //Get the adjusted damage due to Reflex Save, Evasion or Improved Evasion
	                }
	
	                //Do metamagic checks
	                if (nMetaMagic == METAMAGIC_MAXIMIZE)
	                {
	                    nDamage = nMax * nCasterLevel;
	                }
	                if (nMetaMagic == METAMAGIC_EMPOWER)
	                {
	                    nDamage = nDamage + (nDamage/2);
	                }
	
	                //Check that a reflex save was made.
	                /*if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 1.0) == 0)
	                {
	                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength)));
	                    if (GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
	                        nDamage = nDamage / 2;
	                }
	                else
	                {
	                    //nDamage = GetReflexAdjustedDamage(nDamage, oTarget, 0, SAVING_THROW_TYPE_DIVINE);
	                    if (GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
	                        nDamage = 0;
	                    else nDamage = nDamage / 2;
	                }*/
	
	                nOrgDam = nDamage;
	                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DIVINE);
	
	                //Set damage effect
	                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
	                if(nDamage > 0)
	                {
	                    if (nDamage == nOrgDam || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
	                        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength)));
	
	                    //Apply the damage effect and VFX impact
	                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
	                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
	                }
	            }
	        }
	        //Get the next target in the spell area
	        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
	    }
	}
}