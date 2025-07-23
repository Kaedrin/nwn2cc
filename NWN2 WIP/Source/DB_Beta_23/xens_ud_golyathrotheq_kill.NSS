//Author: Xeneize
//Will check if PC has quest active.

//

//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("gac_xen_ud_golrotheyath_quest");

DelayCommand(15.0, AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("port_gol_sacrifice"))));

oTarget = GetObjectByTag("gac_xen_ud_golrotheyath_quest");

DelayCommand(1.0, DestroyObject(oTarget, 0.0));

}