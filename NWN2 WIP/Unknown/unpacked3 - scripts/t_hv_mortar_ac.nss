/*

	Alchemy crafting

*/

string GetGrenadeName(string base_name, int level)
{
	switch (level) {
		case 1: return "Lesser " + base_name; break;
		case 2: return base_name; break;
		case 3: return "Improved " + base_name; break;
		case 4: return "Greater " + base_name; break;
		case 5: return "Master " + base_name; break;
		case 6: return "Perfected " + base_name; break;
		case 7: return "Epic " + base_name;	 break;
	}
	
	return "";
}

void SetGrenadeSpellID(object grenade, string type)
{
	if (type == "acid") {
		SetLocalInt(grenade, "ev_spellid", 1500);
	}
	else if (type == "fire") {
		SetLocalInt(grenade, "ev_spellid", 1501);
	}
	else if (type == "cold") {
		SetLocalInt(grenade, "ev_spellid", 1502);
	}	
	else if (type == "elect") {
		SetLocalInt(grenade, "ev_spellid", 1503);
	}
	else if (type == "sonic") {
		SetLocalInt(grenade, "ev_spellid", 1504);
	}
	else if (type == "entangle") {
		SetLocalInt(grenade, "ev_spellid", 1505);
	}
	else if (type == "sicken") {
		SetLocalInt(grenade, "ev_spellid", 1506);
	}
	else if (type == "holy") {
		SetLocalInt(grenade, "ev_spellid", 1507);
	}
	else if (type == "flash") {
		SetLocalInt(grenade, "ev_spellid", 1508);
	}	
	else if (type == "cinderfire") {
		SetLocalInt(grenade, "ev_spellid", 1509);
	}							
}

void CreateGrenade(string type, string level, object mold, object bench, object pc)
{
	// Create grenade
	object grenade = CreateItemOnObject("ev_alch_grenade_" + type, bench);
	
	if (grenade == OBJECT_INVALID) {
		SendMessageToPC(pc, "Failed to create " + type + " grenade.");
		return;
	}
	
	// Set vars on grenade
	int die = 0;
	int die_num = 0;
	int secondary_dc = 0; // for effects other than damage
	string name;
	string desc;
	
	if (type == "acid") {
		if (level == "1") {
			die = 4;
			die_num = 1;
		}
		else if (level == "2") {
			die = 8;
			die_num = 1;
		}
		else if (level == "3") {
			die = 6;
			die_num = 2;
		}
		else if (level == "4") {
			die = 6;
			die_num = 3;
		}
		else if (level == "5") {
			die = 6;
			die_num = 4;
		}
		else if (level == "6") {
			die = 6;
			die_num = 5;
		}
		else if (level == "7") {
			die = 6;
			die_num = 6;
		}		
	}
	
	else if (type == "fire" || type == "cold" || type == "elect" || type == "holy") {
		die = 6;
		die_num = StringToInt(level);
	}
	
	else if (type == "sonic") {
		if (level == "1") {
			die = 4;
			die_num = 1;
		}
		else if (level == "2") {
			die = 6;
			die_num = 1;
		}
		else if (level == "3") {
			die = 4;
			die_num = 2;
		}
		else if (level == "4") {
			die = 6;
			die_num = 2;
		}
		else if (level == "5") {
			die = 4;
			die_num = 3;
		}
		else if (level == "6") {
			die = 6;
			die_num = 3;
		}
		else if (level == "7") {
			die = 6;
			die_num = 4;
		}
		
		secondary_dc = 12 + (3 * StringToInt(level));
	}
	
	else if (type == "entangle" || type == "sicken") {
		secondary_dc = 10 + (5 * StringToInt(level));
	}
	
	else if (type == "flash") {
		secondary_dc = StringToInt(level) * 4;
	}
	
	int pc_skill = GetSkillRank(SKILL_CRAFT_ALCHEMY, pc);
	
	SetLocalInt(grenade, "ev_die", die);
	SetLocalInt(grenade, "ev_die_num", die_num);
	SetLocalInt(grenade, "ev_crafter_skill", pc_skill);
	SetLocalInt(grenade, "ev_dc_secondary", secondary_dc);
	
	// Name and description
	if (type != "cinderfire") {
		name = GetGrenadeName(GetName(grenade), StringToInt(level));
		SetFirstName(grenade, name);
	}
	else {
		name = GetName(grenade);
	}
	
	SetDescription(grenade, "");
	SetGrenadeSpellID(grenade, type);
	
	SendMessageToPC(pc, "Crafted " + name);
}

void main()
{
	object pc	= GetItemActivator();
	object bench = GetItemActivatedTarget();
	string tag;
	string type;
	
	// Not alchemy bench
	if (GetTag(bench) != "ench_alchemist_bench") return;
	
	// Go over items in the bench
	object item = GetFirstItemInInventory(bench);
	
	while (item != OBJECT_INVALID) {
	
		tag = GetTag(item);
		type = "";
	
		// Check for various grenades
		if (FindSubString(tag, "ev_alch_mold_acid") != -1) {
			type = "acid";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_fire") != -1) {
			type = "fire";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_cold") != -1) {
			type = "cold";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_elect") != -1) {
			type = "elect";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_sonic") != -1) {
			type = "sonic";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_holy") != -1) {
			type = "holy";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_sicken") != -1) {
			type = "sicken";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_flash") != -1) {
			type = "flash";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_entangle") != -1) {
			type = "entangle";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_cinderfire") != -1) {
			type = "cinderfire";
		}
		
		else if (FindSubString(tag, "ev_alch_mold_healkit") != -1) {
			type = "healkit";
		}
		
		if (type != "") {
			string level = GetSubString(tag, GetStringLength(tag) - 1, 1);
			
			if (type != "healkit") {
			
				if (GetSkillRank(SKILL_CRAFT_ALCHEMY, pc) < (4 * StringToInt(level))) {
					SendMessageToPC(pc, "Not skilled enough to create item from " + GetName(item));
				}
				else {
				
					// Handle stacks
					int stack_size = GetItemStackSize(item);
					int i;
					for (i = 0; i < stack_size; i++) {
						CreateGrenade(type, level, item, bench, pc);
					}
					
					// Chance to create another for free!
					int diff = GetSkillRank(SKILL_CRAFT_ALCHEMY, pc) - (4 * StringToInt(level));
					int rand;
					
					for (i = 0; i < stack_size; i++) {
						rand = Random(100) + 1;
						if (diff >= rand) {
							CreateGrenade(type, level, item, bench, pc);
						}
					}
									
					DestroyObject(item);
				}
			}
			else // heal kit
			{
				if (GetSkillRank(SKILL_CRAFT_ALCHEMY, pc) < (3 * StringToInt(level))) {
					SendMessageToPC(pc, "Not skilled enough to create item from " + GetName(item));
				}
				
				else {
				
					// Handle stacks
					int stack_size = GetItemStackSize(item);					
					int i;
					for (i = 0; i < stack_size; i++) {
						CreateItemOnObject("ev_alch_healkit" + level, bench);
					}
					
					
					// Chance to create another for free!
					int diff = GetSkillRank(SKILL_CRAFT_ALCHEMY, pc) - (3 * StringToInt(level));
					int rand;
					
					for (i = 0; i < stack_size; i++) {
						rand = Random(100) + 1;
						if (diff >= rand) {
							CreateItemOnObject("ev_alch_healkit" + level, bench);
						}
					}
					
					DestroyObject(item);
				}	
			}
		}
		
		item = GetNextItemInInventory(bench);
	}
}