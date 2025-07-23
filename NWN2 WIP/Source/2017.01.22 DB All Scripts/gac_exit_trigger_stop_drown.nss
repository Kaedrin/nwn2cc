/* This script goes into the "On Exit Script"  of a trigger.
This script will stop all damage over time effects that have been placed on the PC
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