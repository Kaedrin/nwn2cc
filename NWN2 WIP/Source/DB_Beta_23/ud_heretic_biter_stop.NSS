/* 

This script was created by Gildren for the Dalelands Beyond server

This script goes into the "On Exit Script"  of a trigger.
This script will stop all damage over time effects that have been placed on the PC

this script goes with "ud_heretic_biter_start" and is used to end the effect
placed on a PC when they exit the triggered area

*/

void main()
{

object oPC = GetExitingObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = GetFirstEffect(oTarget);
while (GetIsEffectValid(eEffect))
{
if (GetEffectType(eEffect)==EFFECT_TYPE_DAMAGEOVERTIME) RemoveEffect(oTarget, eEffect);
eEffect = GetNextEffect(oTarget);
}

}