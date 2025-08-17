//::///////////////////////////////////////////////
//:: Battletide
//:: X2_S0_BattTideA
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You create an aura that steals energy from your
    enemies. Your enemies suffer a -2 circumstance
    penalty on saves, attack rolls, and damage rolls,
    once entering the aura. On casting, you gain a
    +2 circumstance bonus to your saves, attack rolls,
    and damage rolls.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Dec 04, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs 06/06/03


#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"

void main()
{
	int nDC = GetSpellSaveDC();
	if (nDC >= 100)
	{
		nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC517");
		if (nDC == 0)
			nDC = 19;
	}
	
    //Declare major variables
    effect eLink = CreateBadTideEffectsLink();
    object oTarget = GetEnteringObject();
    object oCreator = GetAreaOfEffectCreator();
    float fDelay;

    //Check faction of spell targets.
    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCreator))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
        //Make a SR check
        if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget))
        {
            //Make a Fort Save
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget,nDC, SAVING_THROW_TYPE_NEGATIVE))
            {
               fDelay = GetRandomDelay(0.75, 1.75);
               //Apply the VFX impact and linked effects
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
            }
        }
    }
}