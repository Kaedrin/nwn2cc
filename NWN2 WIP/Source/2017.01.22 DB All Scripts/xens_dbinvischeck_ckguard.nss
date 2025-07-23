//Script for Dalelands Beyond.
//Copyrights Xeneize @2014 | Removes Invisibily effect from target PC.
//Goes OnPerception script of the desired Myth Drannor Guard to check for invisibility spells.
//The guard must have the ability to see invisible objects.

void main()
{

object oPC = GetLastPerceived();


if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;

effect eLoop=GetFirstEffect(oPC);
 
while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_INVISIBILITY)
         ActionStartConversation(oPC, "xenc_invcheck_ck");
 
   eLoop=GetNextEffect(oPC);
   }
}
