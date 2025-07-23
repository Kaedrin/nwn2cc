/*
 * Drow/Elf Ambush
 *
 * Defines a variably sized ambush, drow if night, elf if day
 * Currently the script just scales the encounter by numbers
 * as I do not have clarity on the tags to be used for various
 * elf or drow creatures and their relative strength
 * "drow_base" is the name of the waypoint used to place the 
 * amush point, this need not be close to the calling trigger
 * but that would be an option for them to spawn right on top
 * of the victim
 */

#include "ambush"
#include "ginc_group"

void main() {
  	ambush();
}

// Get total party level
int GetPartyLevel(object oPC)
{
	int nPartyLevel = 0;
	
	// Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
	
    // We stop when there are no more valid PC's in the party.
    while(GetIsObjectValid(oPartyMember) == TRUE) {
					
		// Get level
		nPartyLevel += GetHitDice(oPartyMember);
					
        // Get the next PC member of oPC's faction.
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
	
	return nPartyLevel;
}

string createAttackingGroup(object ambushVictim) {
	
	string WAYPOINT   =  "drow_base";
	string GROUP_NAME = "BadassElvenBand";
	if (GetIsDay()) {
		switch (GetSubRace(ambushVictim)) {
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_TIEFLING:
		case RACIAL_SUBTYPE_DROW:
		case RACIAL_SUBTYPE_GRAYORC:		
			ResetGroup(GROUP_NAME);
			int partyLvl = GetPartyLevel(ambushVictim);
			if (partyLvl > 100) {
				SpawnCreaturesInGroupAtWP(1, "alex_elfsword_cr20", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(2, "alex_elfsorcerer_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(1 + ((partyLvl - 100)/15) , "alex_elfarcher_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(2, "alex_elfsword_cr15", GROUP_NAME, WAYPOINT);
			}	
			else if (partyLvl > 60) {
				SpawnCreaturesInGroupAtWP(1, "alex_elfsword_cr20", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(1, "alex_elfsorcerer_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(1 + ((partyLvl - 60)/15) , "alex_elfarcher_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(1, "alex_elfsword_cr15", GROUP_NAME, WAYPOINT);
			}		
			else if (partyLvl > 15) {
				SpawnCreaturesInGroupAtWP(((partyLvl)/30), "alex_elfsorcerer_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(((partyLvl)/20) , "alex_elfarcher_cr15", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(((partyLvl)/15), "alex_elfsword_cr15", GROUP_NAME, WAYPOINT);
			}
			else {
		    	SpawnCreaturesInGroupAtWP((1 + partyLvl/3), "c_elf", GROUP_NAME, WAYPOINT);
			}
			return GROUP_NAME;
		}
	}
	else {
		switch (GetSubRace(ambushVictim)) {
		case RACIAL_SUBTYPE_HUMAN:
		case RACIAL_SUBTYPE_GOLD_DWARF:
		case RACIAL_SUBTYPE_SHIELD_DWARF:
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
		case RACIAL_SUBTYPE_SUN_ELF:
		case RACIAL_SUBTYPE_WOOD_ELF:
		case RACIAL_SUBTYPE_WILD_ELF:
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
		case RACIAL_SUBTYPE_HALFELF:
			ResetGroup(GROUP_NAME);
			int partyLvl = GetPartyLevel(ambushVictim);
			if (partyLvl > 15) {
				SpawnCreaturesInGroupAtWP(((partyLvl)/30), "madseer_drowsorcerer", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(((partyLvl)/20), "madseer_drowrogue", GROUP_NAME, WAYPOINT);
				SpawnCreaturesInGroupAtWP(((partyLvl)/15), "madseer_drowwarrior", GROUP_NAME, WAYPOINT);
			}
			else {
		    	SpawnCreaturesInGroupAtWP((1 + partyLvl/3), "c_drow", GROUP_NAME, WAYPOINT);
			}
			return GROUP_NAME;
		}
	}
	ResetGroup("emptyGroup");
	return "emptyGroup";
}
 