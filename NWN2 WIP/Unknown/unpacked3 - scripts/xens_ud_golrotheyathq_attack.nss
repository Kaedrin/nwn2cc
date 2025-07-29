//Attacks PC

//Put this on action taken in the conversation editor
#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = OBJECT_SELF;

AdjustReputation(oPC, oTarget, -100);

SetIsTemporaryEnemy(oPC, oTarget);

ActionAttack(oPC);

DetermineCombatRound(oPC);

}