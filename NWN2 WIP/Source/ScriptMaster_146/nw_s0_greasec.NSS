//::///////////////////////////////////////////////
//:: Grease: Heartbeat
//:: NW_S0_GreaseC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creatures entering the zone of grease must make
    a reflex save or fall down.  Those that make
    their save have their movement reduced by 1/2.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 1, 2001
//:://////////////////////////////////////////////
//:: RPGplayer1 08/14/2009: Incoporeal cretures are now properly unaffected

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{


    //Declare major variables
    object oTarget;
    effect eFall = EffectKnockdown();
	effect eHit = EffectVisualEffect(VFX_HIT_SPELL_ENCHANTMENT);
	effect eLink = EffectLinkEffects(eFall, eHit);
    float fDelay;
    //Get first target in spell area
    oTarget = GetFirstInPersistentObject();
	int nDC = GetSpellSaveDC();	
	if (nDC >= 100)
	{
		nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC66");
		if (nDC == 0)
			nDC = 14;
	}	
	
    while(GetIsObjectValid(oTarget))
    {
       // if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
       if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )	// AFW-OEI 05/01/2006: Woodland Stride no longer protects from spells.
       {
            if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
            {
                fDelay = GetRandomDelay(0.0, 2.0);
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 4.0));
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject();
    }
}