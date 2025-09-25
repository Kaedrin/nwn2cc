//::///////////////////////////////////////////////
//:: Evards Black Tentacles: On Enter
//:: NW_S0_EvardsA
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the mass of rubbery tentacles the
    target is struck by 1d4 tentacles.  Each has
    a chance to hit of 5 + 1d20. If it succeeds then
    it does 1d6 damage and the target must make
    a Fortitude Save versus paralysis or be paralyzed
    for 1 round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
//:: GZ: Removed SR, its not there by the book

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

			int nDC = GetSpellSaveDC();
			if (nDC >= 100)
			{
				nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC375");
				if (nDC == 0)
					nDC = 17;
			}

    object oTarget = GetEnteringObject();
    effect eParal = EffectParalyze(nDC, SAVING_THROW_FORT);
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eLink = EffectLinkEffects(eDur, eParal);
    effect eDam;
		
	int nCL = GetCasterLevel(GetAreaOfEffectCreator());
	int nMaxHitRoll = 24 + nCL;
	int nMinHitRoll = 5 + nCL;
	int nCasterGrapRoll;
	int nTargetGrapRoll;
	
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nAC = GetAC(oTarget);
    int nHits = d4();
    int nRoll;
    float fDelay;
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EVARDS_BLACK_TENTACLES));
        for (nHits = d4(); nHits > 0; nHits--)
        {
            fDelay = GetRandomDelay(1.0, 2.2);
            nRoll = 4 + d20() + nCL;
            if( ((nRoll >= nAC) || (nRoll == nMaxHitRoll)) && (nRoll != nMinHitRoll) )
            {
			
				//Hit, now grapple
				nCasterGrapRoll = d20() + nCL + 8;
				nTargetGrapRoll = d20() + GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetBaseAttackBonus(oTarget);			
				if (nCasterGrapRoll > nTargetGrapRoll)
				{
	                nDamage = d6() + 4;
	                //Enter Metamagic conditions
	                if (nMetaMagic == METAMAGIC_MAXIMIZE)
	                {
	                    nDamage = 6 + 4;//Damage is at max
	                }
	                else if (nMetaMagic == METAMAGIC_EMPOWER)
	                {
	                    nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
	                }
									
					eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWO);
		            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
		            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
		            {
		                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1)));
		            }
					
				}
				

            }      
		}
	}
}