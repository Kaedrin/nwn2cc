// Summon minions on heartbeat

#include "hv_cq_inc"
#include "hcr2_core_i"

void main()
{
	// Don't do anything if no one is in the area
	if (GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA) < 1)
		return;
	
	SummonMinions(OBJECT_SELF);
}