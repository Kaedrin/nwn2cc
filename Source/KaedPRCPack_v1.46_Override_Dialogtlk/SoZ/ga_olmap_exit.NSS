//ka_olmap_exit 
//script to run OnExit() of OL Map
#include "ginc_overland"

void main()
{
	object oExit = GetExitingObject();
	if( GetLocalInt(oExit, "pcshrunk"))
		ExitOverlandMap(oExit);
}