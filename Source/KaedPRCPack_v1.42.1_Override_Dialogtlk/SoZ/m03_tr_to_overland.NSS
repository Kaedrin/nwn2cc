//	m03_tr_to_overland
/*
	Trigger transition to Overland Map.
*/
//	JSH-OEI 8/5/08

#include "ginc_debug"
#include "ginc_overland"
#include "ginc_companion"
#include "ginc_misc"

void main()
{
	object oEnter		= GetEnteringObject();
	
	if (!GetIsPC(oEnter) && !GetIsOwnedByPlayer(oEnter))
		return;
		
	string sDestWP		= "f00_wp_from_m03";
	string sDestModule	= "F_X2";
	
	if (GetJournalEntry("m_q10_associates", oEnter) == 800
		&& !IsMarkedAsDone())
	{
		SetGlobalInt("00_bCueMurder", TRUE);
		MarkAsDone();
	}
	
	ExitOverlandMap(oEnter);
	SaveRosterLoadModule(sDestModule, sDestWP);
}