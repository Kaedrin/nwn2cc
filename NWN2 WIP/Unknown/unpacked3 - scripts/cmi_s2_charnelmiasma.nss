//::///////////////////////////////////////////////
//:: Charnel Miasma
//:: cmi_s2_charnelmiasma
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 12, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

int GetDeathReserveLevel()
{

	if (GetHasSpell(190))
		return 9;
	if (GetHasSpell(29))
		return 8;
	if (GetHasSpell(366))
		return 7;
	if (GetHasSpell(30))
		return 6;
	if (GetHasSpell(164))
		return 5;
	if (GetHasSpell(127))
		return 4;
	if (GetHasSpell(38))
		return 3;												
	if (GetHasSpell(866))
		return 2;
		
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nDamageDice = 0;
	
	nDamageDice = GetDeathReserveLevel();
		 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		

		}	
	}			



}