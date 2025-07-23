#include "npc_include"

void main()
{
object oPC = GetEnteringObject ();
object oArea = GetArea(oPC);
object oNpc = GetFirstObjectInArea (oArea);
while (oNpc != OBJECT_INVALID)
    {
	DeleteLocalInt (oNpc, "prone");
	NpcReset(oNpc);
    oNpc = GetNextObjectInArea(oArea);
	}
//ExecuteScript ("your normal OnClient script here", oArea);	
}	