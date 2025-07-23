/* 

This script was created by Gildren for the Daleland Beyond server

this script goes into OnEnter event of a trigger

this script checks to see if the PC is a worshiper of Lolth
if the PC is not, it inflicts divine damage over time

this script goes with "ud_heretic_biter_stop"

this script is used with a trigger painted over Lolthite 
holy ground, causing those who do not worship Lloth to 
take 8 points of divine damage each round they remain 
within the trigger. Exting the triggered area ends
the effect (via "ud_heretic_biter_stop" noted above)

a message appears over the target's head, but is not
broadcast over a distance


 //Updates: 
 //[29/07/14] Removed the effect that gets a spider to deal damage to heretic.
*/

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetStringLowerCase(GetDeity(oPC))=="lolth")
   return;

object oTarget;
oTarget = oPC;

FloatingTextStringOnCreature ("The Spider Queen's eyes lay upon your heretic form. You feel a dark presence surround you and watched like a poor insect trapped in a spider's web; waiting to be devoured.", oPC, FALSE, 6.0);

}