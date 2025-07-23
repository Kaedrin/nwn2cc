#include "hcr2_timers_i"

void main()
{	
	int nTimerID = h2_CreateTimer(GetModule(), "alex_serverreset", 60.0);
	h2_StartTimer(nTimerID);
}		