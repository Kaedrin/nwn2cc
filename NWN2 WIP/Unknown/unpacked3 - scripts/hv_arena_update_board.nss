#include "hv_arena_inc"
#include "hcr2_core_i"

// Get data from DB and refresh board description.
// place on Client Enter for the arena
void main()
{
	int playercount = GetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA);
    SetLocalInt(OBJECT_SELF, H2_PLAYERS_IN_AREA, playercount + 1);    
	
	int nUpdated = GetLocalInt(OBJECT_SELF, "hv_arena_board_updated");
	if (nUpdated == 0) {
		UpdateRecords();
		SetLocalInt(OBJECT_SELF, "hv_arena_board_updated", 1);
	}
	
	h2_RunObjectEventScripts(H2_AREAEVENT_ON_CLIENT_ENTER, OBJECT_SELF);
}