effect eEffect;
object oTarget;


//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (ReflexSave(oPC, 15))
   {
   }
else
   {
   FloatingTextStringOnCreature("With all the grace of a three legged horse, you lose your footing and fall over backwards.", oPC);

   oTarget = oPC;

   eEffect = EffectKnockdown();

   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 15.0f);

   }

}