#include "nw_i0_generic"

void main()
{
	object oPC = GetLastPerceived();

	if (!GetIsPC(oPC)) return;

	if (!GetLastPerceptionSeen()) 
		return;
	
	if (GetItemPossessedBy(oPC, "Key of Darkness")!= OBJECT_INVALID)
   		return;

	object oTarget;
	oTarget = OBJECT_SELF;

	SetIsTemporaryEnemy(oPC, oTarget);
	ActionAttack(oPC);
	DetermineCombatRound(oPC);
}