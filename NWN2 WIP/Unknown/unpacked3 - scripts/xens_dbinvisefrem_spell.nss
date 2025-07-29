//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Removes Invisibily effect from target PC.
//Script is attached to convo_invcheckmd
//Put this on action taken in the conversation editor

void main()
{
object oPC = GetPCSpeaker();
 
object oTarget;
 
//Remove INVISIBILITY from the PC.
effect eLoop=GetFirstEffect(oPC);
 
while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_INVISIBILITY)
         RemoveEffect(oPC, eLoop);
 
   eLoop=GetNextEffect(oPC);
   }
}