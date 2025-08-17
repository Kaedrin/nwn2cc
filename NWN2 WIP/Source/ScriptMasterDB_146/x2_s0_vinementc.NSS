//::///////////////////////////////////////////////
//:: Vine Mine, Entangle C
//:: X2_S0_VineMEntC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the AOE the target must make
    a reflex save or be entangled by vegitation
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 25, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller, 14/08/2003
//:: RPGplayer1 08/14/2009: Incoporeal cretures are now properly unaffected

#include "NW_I0_SPELLS"
#include "x0_i0_spells"

void main()
{

    //Declare major variables
    effect eHold = EffectEntangle();
    effect eEntangle = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
    //Link Entangle and Hold effects
    effect eLink = EffectLinkEffects(eHold, eEntangle);

    //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail. Its better to remove the barrier then
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

			int nDC = GetSpellSaveDC();
			if (nDC >= 100)
			{
				nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC529");
				if (nDC == 0)
					nDC = 16;
			}

    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {  // SpawnScriptDebugger();
        //if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
	if( (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
         {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), 529));
                //Make SR check
                if(!GetHasSpellEffect(SPELL_VINE_MINE_ENTANGLE, oTarget))
                {
                    //if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget))
                    {
                        //Make reflex save
                        int n =   MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC,SAVING_THROW_TYPE_NONE,GetAreaOfEffectCreator() );
                        if(n == 0)
                        {
                           //Apply linked effects
                           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                        }
                    }
                }
            }
        }
        //Get next target in the AOE
        oTarget = GetNextInPersistentObject();
    }
}