//::///////////////////////////////////////////////
//:: Natural Leader Fix - OnEnter
//:: cmi_s2_natleadera
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 31, 2011
//:://////////////////////////////////////////////



#include "x2_inc_spellhook"
#include "cmi_includes"

void main()
{
    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


	object	oTarget;
	object	oCreator =	GetAreaOfEffectCreator();
	effect eAB = EffectAttackIncrease(1);
	eAB = SupernaturalEffect(eAB);
	eAB = SetEffectSpellId(eAB,NATURAL_LEADER_FIX);
	float fDuration = HoursToSeconds(48);
		
	//If the caster is dead, kill the AOE
	if (!GetIsObjectValid(oCreator))
	{
		DestroyObject(OBJECT_SELF);
	}
	
	//Find our first target
	oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
	while(GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCreator) && (oTarget != oCreator) )
		{
   			 if(!GetHasSpellEffect(NATURAL_LEADER_FIX, oTarget))
			 {
			 	//Grant +1 AB bonus.
				DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oTarget, fDuration)); 
			 }
		}
		oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
	}
}
	
	