/*
	
	Mini-quests functions & constants

*/

#include "nwnx_sql"

const string GUI_NAME = "ev_mq_npc";
const string GUI_LIST = "LIST_QUESTS";
const string DOMAIN_SD = "sd";
const string DOMAIN_MD = "md";
const string DOMAIN_UD = "ud";
const string CURRENT_QUEST_VAR = "ev_mq_current";
const string KILL_COUNT_VAR = "ev_mq_killcount";
const string KILLS_NEEDED_VAR = "ev_mq_maxkills";
const string KILL_MSG_VAR = "ev_mq_killmsg";

// used as toon/player name in database to store general quests data
const string QUESTS_DUMMY = "dummy";

const int HOURS_BETWEEN_QUESTS = 12;
const int REWARD_GOLD = 500;
const int REWARD_XP = 100;

void set_var_value_nopc(string toon, string player, string var, string value);
void add_mini_quest(int id, string name, string description, string domain, int level, int kills_needed, string kill_msg);

/*
	Adds quest to databse.
	Runs each module load to update the quests
	and add new ones when needed.
*/
void add_all_mini_quests()
{
	int id; // unique id for the quest
	string name; // the name of the quest which will appear on the list
	string description; // quest description, providing additional details
	string domain; // the domain this area is part of (sd, md, ud etc.)
	int level; // the difficulty level of the quest, 2-30
	int kills_needed; // number of kills required to complete the quest
	string kill_msg; // the message to display to the player when a creature from the quest is killed

	// old skull bats
	id = 1;
	kills_needed = 15;
	kill_msg = "Acquired one bat fang!";
	name = "Bat Fangs";
	description = "You were asked to collect "+IntToString(kills_needed)+" bat fangs.";
	domain = DOMAIN_SD;
	level = 2;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// old skull rats
	id = 2;
	kills_needed = 15;
	kill_msg = "Acquired one rat pelt!";
	name = "Rat Pelts";
	description = "You were asked to collect "+IntToString(kills_needed)+" rat pelts.";
	domain = DOMAIN_SD;
	level = 2;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// old skull talona cave - slimes
	id = 3;
	kills_needed = 3;
	kill_msg = "Acquired one slime goo!";
	name = "Slime Goo";
	description = "You were asked to collect "+IntToString(kills_needed)+" slimes goos.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// old skull talona cave - centipedes
	id = 4;
	kills_needed = 6;
	kill_msg = "Acquired one gland sack!";
	name = "Gland Sacks";
	description = "You were asked to collect "+IntToString(kills_needed)+" Giant Centipedes gland sacks.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// old skull talona cave - rat queen
	id = 5;
	kills_needed = 1;
	kill_msg = "Acquired one long rat tail!";
	name = "Long Rat Tail";
	description = "You were asked to collect "+IntToString(kills_needed)+" long rat tail.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// old skull talona cave - humans
	id = 6;
	kills_needed = 5;
	kill_msg = "Acquired one talona spice!";
	name = "Talona Spices";
	description = "You were asked to collect "+IntToString(kills_needed)+" Talona spices.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd crypt - magical zombies
	id = 7;
	kills_needed = 9;
	kill_msg = "Acquired one magical zombie nail!";
	name = "Magical Zombie Nails";
	description = "You were asked to collect "+IntToString(kills_needed)+" magical zombie nails.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd crypt - tiny spiders
	id = 8;
	kills_needed = 2;
	kill_msg = "Acquired one miniature spider mandible!";
	name = "Miniature Spider Mandibles";
	description = "You were asked to collect "+IntToString(kills_needed)+" miniature spider mandibles.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd crypt - regular zombies
	id = 9;
	kills_needed = 12;
	kill_msg = "Acquired one zombie nail!";
	name = "Zombie Nails";
	description = "You were asked to collect "+IntToString(kills_needed)+" zombie nails.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd crypt - skeleton boss
	id = 10;
	kills_needed = 1;
	kill_msg = "Acquired one skeletone bone!";
	name = "Skeleton Bone";
	description = "You were asked to collect "+IntToString(kills_needed)+" skeleton bone.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd goblins - first level
	id = 11;
	kills_needed = 15;
	kill_msg = "Acquired one goblin tooth!";
	name = "Goblin Teeth";
	description = "You were asked to collect "+IntToString(kills_needed)+" goblin teeth.";
	domain = DOMAIN_SD;
	level = 3;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd goblins - first level, shaman boss
	id = 12;
	kills_needed = 1;
	kill_msg = "Acquired one goblin spices!";
	name = "Goblin Spices";
	description = "You were asked to collect "+IntToString(kills_needed)+" goblin spices.";
	domain = DOMAIN_SD;
	level = 4;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd goblins - second level
	id = 13;
	kills_needed = 15;
	kill_msg = "Acquired one goblin helm!";
	name = "Goblin Helms";
	description = "You were asked to collect "+IntToString(kills_needed)+" goblin helms.";
	domain = DOMAIN_SD;
	level = 4;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd goblins - second level - ogre
	id = 14;
	kills_needed = 1;
	kill_msg = "Acquired one ogre tooth!";
	name = "Ogre tooth";
	description = "You were asked to collect "+IntToString(kills_needed)+" ogre tooth.";
	domain = DOMAIN_SD;
	level = 4;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd kobolds
	id = 15;
	kills_needed = 20;
	kill_msg = "Acquired one kobold tail!";
	name = "Kobold Tails";
	description = "You were asked to collect "+IntToString(kills_needed)+" kobold tails.";
	domain = DOMAIN_SD;
	level = 5;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd kobolds - shaman boss
	id = 16;
	kills_needed = 1;
	kill_msg = "Acquired one kobold spices!";
	name = "Kobold Spices";
	description = "You were asked to collect "+IntToString(kills_needed)+" kobold spices.";
	domain = DOMAIN_SD;
	level = 6;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// fox ridge - weak gnolls
	id = 17;
	kills_needed = 10;
	kill_msg = "Acquired one gnoll fur!";
	name = "Gnoll Fur";
	description = "You were asked to collect "+IntToString(kills_needed)+" gnoll furs.";
	domain = DOMAIN_SD;
	level = 6;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// fox ridge - strong gnolle
	id = 18;
	kills_needed = 10;
	kill_msg = "Acquired one gnoll tooth!";
	name = "Gnoll Teeth";
	description = "You were asked to collect "+IntToString(kills_needed)+" gnoll teeth.";
	domain = DOMAIN_SD;
	level = 7;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// fox ridge cave - big boss
	id = 19;
	kills_needed = 1;
	kill_msg = "Acquired one gnoll spices!";
	name = "Gnoll Spices";
	description = "You were asked to collect "+IntToString(kills_needed)+" gnoll spices.";
	domain = DOMAIN_SD;
	level = 9;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// sd spiders
	id = 20;
	kills_needed = 15;
	kill_msg = "Acquired one shadow spider mandible!";
	name = "Shadow Spider Mandibles";
	description = "You were asked to collect "+IntToString(kills_needed)+" shadow spider mandibles.";
	domain = DOMAIN_SD;
	level = 7;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// fire ants
	id = 21;
	kills_needed = 15;
	kill_msg = "Acquired one ant leg!";
	name = "Ant Legs";
	description = "You were asked to collect "+IntToString(kills_needed)+" ant legs.";
	domain = DOMAIN_SD;
	level = 10;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// fire ants - queen
	id = 22;
	kills_needed = 1;
	kill_msg = "Acquired one giant ant antennae!";
	name = "Giant Ant Antennae";
	description = "You were asked to collect "+IntToString(kills_needed)+" giant ant antennae.";
	domain = DOMAIN_SD;
	level = 10;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
	
	// rotten roots
	id = 23;
	kills_needed = 8;
	kill_msg = "Acquired one rotten root!";
	name = "Rotten Roots";
	description = "You were asked to collect "+IntToString(kills_needed)+" rotten roots.";
	domain = DOMAIN_SD;
	level = 10;
	add_mini_quest(id, name, description, domain, level, kills_needed, kill_msg);
}

void add_mini_quest(int id, string name, string description, string domain, int level, int kills_needed, string kill_msg)
{
	name = SQLEncodeSpecialChars(name);
	description = SQLEncodeSpecialChars(description);
	domain = SQLEncodeSpecialChars(domain);
	kill_msg = SQLEncodeSpecialChars(kill_msg);

	// check if row exists
    string sSQL = "SELECT * FROM mini_quests "
				  +"WHERE toon='" +  QUESTS_DUMMY
				  +"' AND player='" + QUESTS_DUMMY 
				  +"' AND id=" + IntToString(id);
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE mini_quests SET "
				+"toon='" + QUESTS_DUMMY 
				+"',player='" + QUESTS_DUMMY
				+"',name='" + name
				+"',description='" + description
				+"',domain='" + domain
				+"',id=" + IntToString(id)
				+",level=" + IntToString(level)
				+",times_completed=-1"
				+" WHERE toon='" + QUESTS_DUMMY
				+"' AND player='" + QUESTS_DUMMY
				+"' AND id=" + IntToString(id);
				
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO mini_quests (toon,player,id,name,description,times_completed,level,domain) VALUES" +
            "('" + QUESTS_DUMMY + "','" + QUESTS_DUMMY + "'," + IntToString(id) + ",'" + name + "','" + description + "',-1,"+ IntToString(level) + ",'" + domain + "')";
        SQLExecDirect(sSQL);
    }
	
	set_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILLS_NEEDED_VAR + IntToString(id), IntToString(kills_needed));
	set_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILL_MSG_VAR + IntToString(id), kill_msg);
}

// show info screen
void show_info_screen(object pc, string msg)
{
	//DisplayGuiScreen(pc, "ev_mq_info", FALSE, "ev_mq_info.xml");
	//SetGUIObjectText(pc, "ev_mq_info", "INFO", -1, msg);
	DisplayMessageBox(pc, -1, msg);
}

// display a ui with the job's description
void show_description(object pc, int id)
{
	string sSQL = "SELECT description FROM mini_quests "
				  +"WHERE toon='" +  QUESTS_DUMMY
				  +"' AND player='" + QUESTS_DUMMY 
				  +"' AND id=" + IntToString(id);
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
		string desc = SQLGetData(1);
		desc += "\n\nOOC: When the appropriate creature for the quest is killed, a message will appear "+
		                  "in your combat log indicating that the ingredient was found, and how many left to find. "+
						  "There are no actual items to gather - you get them automatically when the appropriate creature is killed."+
						  " You can also keep track of the quest in your Jobs tab inside the journal.";
		show_info_screen(pc, desc);
	}
}

// get total quests completed at least once
int total_completed(object pc)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT COUNT(id) FROM mini_quests "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND times_completed > 0";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
         return StringToInt(SQLGetData(1));
	else
		return 0;
}

// returns TRUE if quest was completed by pc
int completed_quest(object pc, int id)
{
	// get pc data
    string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT * FROM mini_quests "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND times_completed>0" 
				  +" AND id=" + IntToString(id);
    SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS) return TRUE;
	else return FALSE;
}

string get_domain_blacklist(string domain)
{
	string blacklist = "";
	if (domain == DOMAIN_SD) {
		blacklist = "AND domain<>'" + DOMAIN_UD + "'";
	}
	else if (domain == DOMAIN_MD) {
		blacklist = "AND domain<>'" + DOMAIN_UD + "'";
	}
	else if (domain == DOMAIN_UD) {
		blacklist = "AND domain<>'" + DOMAIN_SD + "' "
				   +"AND domain<>'" + DOMAIN_MD + "'";
	}
	return blacklist;
}

// return TRUE if pc completed all available quests for this NPC
int completed_all(object pc)
{
	// count how many quests available to their level and the current domain
	string domain = GetLocalString(pc, "ev_mq_domain");
	int total_quests_for_pc = 0;
	
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	domain = SQLEncodeSpecialChars(domain);
	
	int pc_level = GetTotalLevels(pc, FALSE);
    string sSQL = "SELECT id FROM mini_quests "
				  +"WHERE toon='" + QUESTS_DUMMY 
				  +"' AND player='" + QUESTS_DUMMY 
				  +"' AND level<=" + IntToString(pc_level)
				  +" AND level>=" + IntToString(pc_level - 10)
				  +" AND id NOT IN ( SELECT id FROM mini_quests "
				  					+"WHERE toon='"+toon+"' "
									+"AND player='"+player+"' "
									+"AND times_completed>0 )";
	
	// add blacklisted domains
	string blacklist = get_domain_blacklist(domain);
	if (blacklist != "") {
		sSQL += " " + blacklist;
	}
    SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS) return FALSE;
	
	return TRUE;
}

// add a random quest to the list from quests already completed
void add_random_completed_quest(object pc)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	string domain = GetLocalString(pc, "ev_mq_domain");
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);	
	domain = SQLEncodeSpecialChars(domain);
	int pc_level = GetTotalLevels(pc, FALSE);
	
    string sSQL = "SELECT id,name FROM mini_quests "
				  +"WHERE toon='" + QUESTS_DUMMY 
				  +"' AND player='" + QUESTS_DUMMY
				  +"' AND level>=" + IntToString(pc_level - 10) 
				  +"' AND id IN ( SELECT id FROM mini_quests "
				  					+"WHERE toon='"+toon+"' "
									+"AND player='"+player+"' "
									+"AND times_completed>0 )";
									
	// add blacklisted domains
	string blacklist = get_domain_blacklist(domain);
	if (blacklist != "") {
		sSQL += " " + blacklist;
	}
	
	sSQL += " ORDER BY RAND() LIMIT 1";				  	
    SQLExecDirect(sSQL);
	
	 if (SQLFetch() == SQL_SUCCESS) {
		string name = SQLGetData(2);
		int id   = StringToInt(SQLGetData(1));
	
		AddListBoxRow(pc, GUI_NAME, GUI_LIST, "","NAME_B="+name,"", "0="+IntToString(id), "");
	}
}

// List quests
void list_quests(object pc)
{	
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	string domain = GetLocalString(pc, "ev_mq_domain");
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);	
	domain = SQLEncodeSpecialChars(domain);

	// get uncompleted quests according to level
	int pc_level = GetTotalLevels(pc, FALSE);
    string sSQL = "SELECT id,name FROM mini_quests "
				  +"WHERE toon='" + QUESTS_DUMMY 
				  +"' AND player='" + QUESTS_DUMMY 
				  +"' AND level<=" + IntToString(pc_level)
				  +" AND level>=" + IntToString(pc_level - 10)
				  +" AND id NOT IN ( SELECT id FROM mini_quests "
				  					+"WHERE toon='"+toon+"' "
									+"AND player='"+player+"' "
									+"AND times_completed>0 )";
									
	// add blacklisted domains
	string blacklist = get_domain_blacklist(domain);
	if (blacklist != "") {
		sSQL += " " + blacklist;
	}
				  			
    SQLExecDirect(sSQL);

    while (SQLFetch() == SQL_SUCCESS) {
		string name = SQLGetData(2);
		int id   = StringToInt(SQLGetData(1));
	
		AddListBoxRow(pc, GUI_NAME, GUI_LIST, "","NAME_B="+name,"", "0="+IntToString(id), "");
	}
}

string get_var_value_nopc(string toon, string player, string var)
{	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT val FROM mini_quests_vars "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND var='" + var + "'";
    SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS)
		return SQLGetData(1);
		
	return "";
}


// returns value of given variable.
// return "" on error.
string get_var_value(object pc, string var)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	return get_var_value_nopc(toon, player, var);
}

void set_var_value_nopc(string toon, string player, string var, string value)
{
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	// check if row exists
    string sSQL = "SELECT val FROM mini_quests_vars "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND var='" + var + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE mini_quests_vars SET "
				+"toon='" + toon 
				+"',player='" + player
				+"',val='" + value
				+"' WHERE toon='" + toon
				+"' AND player='" + player
				+"' AND var='" + var + "'";
				
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO mini_quests_vars (toon,player,var,val) VALUES" +
            "('" + toon + "','" + player + "','" + var + "','" + value + "')";
        SQLExecDirect(sSQL);
    }
}

// set var value
void set_var_value(object pc, string var, string value)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	set_var_value_nopc(toon, player, var, value);
}

// player picked a quest
void set_current_quest(object pc, int id)
{
	set_var_value(pc, CURRENT_QUEST_VAR, IntToString(id));
	
	show_info_screen(pc, "Accepted new job!\nThe job has been added to your journal.");
}

// return the id of the currently active quest.
// -1 if there is no active quest.
int get_current_quest(object pc)
{
	string id_s = get_var_value(pc, CURRENT_QUEST_VAR);
	if (id_s == "" || id_s == "-1") {
		return -1;
	}
	else {
		return StringToInt(id_s);
	}
}

// display current quest
void display_quest_log(object pc)
{	
	int id = get_current_quest(pc);
	
	// get quest name
	string quest_name = "No job taken.";
	string quest_desc = "";
	if (id != -1) {
		string sSQL = "SELECT name,description FROM mini_quests "
				  +"WHERE toon='" + QUESTS_DUMMY 
				  +"' AND player='" + QUESTS_DUMMY 
				  +"' AND id=" + IntToString(id);
		
		SQLExecDirect(sSQL);
		
		if (SQLFetch() == SQL_SUCCESS) {
			quest_name = SQLGetData(1);
			quest_desc = SQLGetData(2);
		}
	}
	
	// no job taken
	else {
		SetGUIObjectText(pc, "SCREEN_JOURNAL", "JOBS_FIELD", -1, "Current job: No job taken.");
		return;
	}
	
	string killed_s = get_var_value(pc, KILL_COUNT_VAR + IntToString(id));
	if (killed_s == "") killed_s = "0";
	string kills_needed = get_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILLS_NEEDED_VAR + IntToString(id));
	
	string job_entry = "Current job: " + quest_name + "\nDescription: " + quest_desc + "\n\nStatus: gathered ("+killed_s+"/"+kills_needed+")";
	SetGUIObjectText(pc, "SCREEN_JOURNAL", "JOBS_FIELD", -1, job_entry);
}

// progress kill quest by 1
void progress_kill_quest(object pc, int id)
{
	// get current kill count
	string killed_s = get_var_value(pc, KILL_COUNT_VAR + IntToString(id));
	int killed = 1;	
	if (killed_s != "") {
		killed = StringToInt(killed_s) + 1;
	}
	
	// do not increase counter beyond needed kills
	int needed_kills = StringToInt(get_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILLS_NEEDED_VAR + IntToString(id)));
	if (killed <= needed_kills) {
		set_var_value(pc, KILL_COUNT_VAR + IntToString(id), IntToString(killed));		
	}
	else {
		killed = killed - 1;
	}
	
	// notify player of quest status
	string msg = get_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILL_MSG_VAR + IntToString(id));
	msg += " (" + IntToString(killed) + "/" + IntToString(needed_kills) + ")";
	SendMessageToPC(pc, msg);
	
	// finished job
	if (killed == needed_kills) {
		if (GetLocalInt(pc, "ev_mq_got_msg") == 0) {
			SetNoticeText(pc, "Collected enough materials for the current job!");
			SetLocalInt(pc, "ev_mq_got_msg", 1);
		}
	}
}

// advance quest for creature killed if the job is active
void check_active_kill_quest(object pc, object creature)
{
	int id = GetLocalInt(creature, "ev_mq_id");
	if (id != 0) {
		// check if pc and her party has active quest
		object member = GetFirstFactionMember(pc);
		while (member != OBJECT_INVALID) {
			if (GetArea(pc) == GetArea(member) && GetDistanceBetween(pc, member) <= 30.0) {
				if (get_current_quest(member) == id) {
					progress_kill_quest(member, id);
				}
			}
			member = GetNextFactionMember(pc);
		}
	}	
}

// Mark the quest as completed, incrementing its times_completed by one
void set_quest_completed(object pc, int id)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	// check if row exists
    string sSQL = "SELECT times_completed FROM mini_quests "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player 
				  +"' AND times_completed>0" 
				  +" AND id=" + IntToString(id);
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
		int completed = StringToInt(SQLGetData(1)) + 1;

        // row exists
        sSQL = "UPDATE mini_quests SET "
				+"times_completed=" +  IntToString(completed)
				+"WHERE toon='" + toon
				+"' AND player='" + player
				+"' AND id=" + IntToString(id);
				
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO mini_quests (toon,player,id,times_completed) VALUES" +
            "('" + toon + "','" + player + "'," + IntToString(id) + ",1)";
        SQLExecDirect(sSQL);
    }
}

// return how many hours have passed since the last quest was completed.
// -1 on error.
int last_completed(object pc)
{
	string toon = GetName(pc);
	string player = GetPCPlayerName(pc);
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT TIMESTAMPDIFF(HOUR, last_write, NOW()) as 'last_completed' "
				  +"FROM mini_quests_vars "
				  +"WHERE toon='" + toon + "' "
				  +"AND player='" + player + "' "
				  +"AND var='" + CURRENT_QUEST_VAR + "' ";
    SQLExecDirect(sSQL);
	
	if (SQLFetch() == SQL_SUCCESS) {
		return StringToInt(SQLGetData(1));
	}
	else
		return -1;
}

// Used in the npc's conversation - check if the current quest was completed.
// if it was, reward player.
void completed_current_quest(object pc)
{
	int id = get_current_quest(pc);
	if (id != -1) {
		// identify killing quest
		string needed_kills_s = get_var_value_nopc(QUESTS_DUMMY, QUESTS_DUMMY, KILLS_NEEDED_VAR + IntToString(id));
		if (needed_kills_s != "") {
			int needed_kills = StringToInt(needed_kills_s);
			string current_kills_s = get_var_value(pc, KILL_COUNT_VAR + IntToString(id));
			if (current_kills_s != "") {
				
				// finished quest!
				if (needed_kills == StringToInt(current_kills_s)) {
				
					// reward player
					// if completed it already give half reward
					if (completed_quest(pc, id) == TRUE) {
						GiveGoldToCreature(pc, REWARD_GOLD / 2);
						GiveXPToCreature(pc, REWARD_XP / 2);
					}
					else {
						GiveGoldToCreature(pc, REWARD_GOLD);
						GiveXPToCreature(pc, REWARD_XP);
					}
					
					// reset kill counter, for next time we take the quest
					set_var_value(pc, KILL_COUNT_VAR + IntToString(id), "0");
					show_info_screen(pc, "I see you've finished the job. Here's your reward...");
					set_var_value(pc, CURRENT_QUEST_VAR, "-1"); // no currently active quest
					set_quest_completed(pc, id);								
				} 
			} 
		}
		
		// not killing quest
		else {
			
		}
	}
	
}