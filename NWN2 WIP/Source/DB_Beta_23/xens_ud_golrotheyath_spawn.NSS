//Author: Xeneize
//Will spawn quest creature and add it to the pc's party.

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oSpawn;
location lTarget;
oTarget = oPC;

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "gac_xen_ud_golrotheyath_quest", lTarget);

oTarget = GetObjectByTag("gac_xen_ud_golrotheyath_quest");

AssignCommand(oTarget, ActionForceFollowObject(oPC));

}




