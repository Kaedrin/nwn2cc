//::///////////////////////////////////////////////
//:: Frightful Presence
//:: cmi_s0_frightpres
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "nw_i0_spells"

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

    int nCasterLevel = GetWarlockCasterLevel(OBJECT_SELF);
	int nSpellId = SPELL_I_FRIGHTFUL_PRESENCE;
	//Has same SpellId as Fear, not an item, but returns no valid class -> it's Fiendish Presence

    float fDuration = TurnsToSeconds(10);
    float fDelay;
	
	location lLocation = GetSpellTargetLocation();
	
	effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_MIND_SPELLS);
	effect eDamagePenalty = EffectDamageDecrease(2);
	effect eAttackPenalty = EffectAttackDecrease(2);
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_FEAR );
	
	effect eLink = EffectLinkEffects(eSave, eDamagePenalty);
	eLink = EffectLinkEffects(eLink, eAttackPenalty);
	eLink = EffectLinkEffects(eLink, eVis);	
	eLink = SetEffectSpellId(eLink, nSpellId); //needed to keep different essences stack, if using same shape
	
	
    object oTarget;
    //Get first target in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    	{
            fDelay = GetRandomDelay();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId));
            //Make SR Check
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                //Make a will save
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, TRUE), SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
                {
                    //Apply the linked effects and the VFX impact
					RemoveEffectsFromSpell(oTarget, nSpellId);					
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
                }
            }
        }
        //Get next target in the spell
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLocation, TRUE, OBJECT_TYPE_CREATURE);
    }
	
}	