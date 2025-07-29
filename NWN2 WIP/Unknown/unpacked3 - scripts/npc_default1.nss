/////////////////////////////////////////////////
//NPC Control 1.4
//npc_default1 HB script
//wrapper for NW_C2_DEFAULT1 or npc_leg_oh
//Uncle FB 05/09
////////////////////////////////////////////////

#include "hench_i0_ai"
#include "npc_include"


void main()
{
object oPC = GetFirstPC();
object oNpc = OBJECT_SELF;
object oMod = GetModule();
GlobalSet (oMod);
AreaTransition(oNpc);
HeartbeatCheck (oNpc);
int nUd = GetLocalInt(oNpc, "ud");
if (nUd == 1) {return;}
int nActivity = GetTimeActivity (oNpc);
if (nActivity != 200) {ExecuteScript ("npc_leg_oh", oNpc); return;}
	else
	{ExecuteScript ("nw_c2_default1", oNpc);}
}	