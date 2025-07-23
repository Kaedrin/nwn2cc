//::///////////////////////////////////////////////
//:: Eldritch Disciple, Healing Blast
//:: cmi_s2_gifthb
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 2, 2009
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

#include "nw_i0_invocatns"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nSpellId = SPELLABILITY_ELDDISC_HB;	
	int nDice = GetEldritchBlastLevel(OBJECT_SELF);
	location lTarget = GetSpellTargetLocation();
	int nAmount;
	effect eHeal;
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	object oCaster = OBJECT_SELF;
	while (GetIsObjectValid(oTarget)) {
		if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster)) 
		{
			//Fire cast spell at event for the specified target
    		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
			
			nAmount = d6(nDice);
			if (GetHasFeat(1958))
				nAmount = (nAmount * 3)/2;
			eHeal = EffectHeal(nAmount);
    		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));

		}
		else
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster)) 
		{
			if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
			{	       
				if (!MyResistSpell(OBJECT_SELF, oTarget, GetRandomDelay(0.2f,0.4f)))
				{
					nAmount = d6(nDice);
					if (GetHasFeat(1958))
						nAmount = (nAmount * 3)/2;
					eHeal = EffectDamage(nAmount, DAMAGE_TYPE_POSITIVE);
	    			DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));					
				}
			}
		}
		
		oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}
	DecrementRemainingFeatUses(oCaster, 294);
}      