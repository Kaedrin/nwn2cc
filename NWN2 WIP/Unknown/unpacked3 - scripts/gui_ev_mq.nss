/*
	Handle gui calls from mini-quests interfaces.
*/

#include "ev_mq_inc"

void main(string action_name, string arg1 = "")
{
	object pc = OBJECT_SELF;
	
	// Show job description
	if (action_name == "show_desc") {
		show_description(pc, StringToInt(arg1));
	}
	
	// list available quests
	else if (action_name == "list_quests" && !GetIsPC(pc)) {
		pc = GetPCSpeaker();
	
	
		// already doing a quest
		if (get_current_quest(pc) != -1) {
			show_info_screen(pc, "You haven't finished the last job I gave you yet.");
		}
		
		// 12 hours have not yet passed since last completed quest
		else if (get_var_value(pc, CURRENT_QUEST_VAR) != "" && last_completed(pc) < HOURS_BETWEEN_QUESTS) {
			DisplayMessageBox(pc, -1, "I don't have jobs for you now. Come back later.");
		}
		
		// make sure the pc hasn't completed all her quests alreay
		else if (completed_all(pc) == TRUE) {
			show_info_screen(pc, "I don't have new jobs for you yet. But I do need your help with a job you completed before...");
			
			// give random quest...
			DisplayGuiScreen(pc, "ev_mq_npc", FALSE, "ev_mq_npc.xml");
			add_random_completed_quest(pc);
		}
		
		else {
			DisplayGuiScreen(pc, "ev_mq_npc", FALSE, "ev_mq_npc.xml");
			list_quests(pc);
		}
	}
	
	// select quest
	else if (action_name == "select_quest") {
		if (arg1 == "") {
			show_info_screen(pc, "No job was selected.");
			return;
		}
		set_current_quest(pc, StringToInt(arg1));
		CloseGUIScreen(pc, GUI_NAME);
	}
	
	// add current job to journal
	else if (action_name == "quests_log") {
		display_quest_log(pc);
	}
}