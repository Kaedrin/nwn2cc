//ka_olmap_exit 
//script to run OnExit() of OL Map
//NLC 03/03/08

#include "ginc_overland"

void main()
{
	object oExit = GetExitingObject();
	if( GetIsPC(oExit) )
		ExitOverlandMap(oExit);
}