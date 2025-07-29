#include "ev_warlock_pact_inc"


void main(string action_name, string arg1 = "")
{
	object pc = OBJECT_SELF;
	
	// list available pacts
	if (action_name == "init") {
		AddListBoxRow(pc, "ev_warlock_pact", "LIST_PACTS", "","NAME_B=Dark Pact (Abyssal)","", "0="+IntToString(PACT_DARK), "");
		AddListBoxRow(pc, "ev_warlock_pact", "LIST_PACTS", "","NAME_B=Infernal Pact","", "0="+IntToString(PACT_INFERNAL), "");
		AddListBoxRow(pc, "ev_warlock_pact", "LIST_PACTS", "","NAME_B=Seelie Fey","", "0="+IntToString(PACT_SEELIE), "");
		AddListBoxRow(pc, "ev_warlock_pact", "LIST_PACTS", "","NAME_B=Star Pact","", "0="+IntToString(PACT_STAR), "");
		AddListBoxRow(pc, "ev_warlock_pact", "LIST_PACTS", "","NAME_B=Unseelie Fey","", "0="+IntToString(PACT_UNSEELIE), "");
	}
	
	// selected pact
	else if (action_name == "select_pact") {
		if (arg1 == "") {
			DisplayMessageBox(pc, -1, "No pact was selected.");
			return;
		}
	
		CloseGUIScreen(pc, "ev_warlock_pact");
		FeatAdd(pc, StringToInt(arg1), FALSE, TRUE, TRUE);
	}
}