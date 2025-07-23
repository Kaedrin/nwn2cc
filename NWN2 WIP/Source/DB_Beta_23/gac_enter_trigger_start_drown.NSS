/* This script goes into the "On Enter Script"  of a trigger.  
It will cause the PC to take unresitable cold damage every 3.0 seconds
if the PC does not have an "air_bladder" within his or her inventory
*/

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "gac_air_bladder")!= OBJECT_INVALID)
   return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectDamageOverTime(50, 3.0, DAMAGE_TYPE_COLD, TRUE);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}