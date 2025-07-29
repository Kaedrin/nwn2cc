/*
 * Orc clan Ambush
 *
 * Defines a fixed force ambush by orcs
 * "funkytown" is the name of the waypoint 
 * the orcs will spawn around.  Be sure to
 * place the waypoint far enough from the 
 * area boundary so all creatures can spawn
 * properly
 */

#include "ambush"
#include "ginc_group"

void main() {
  	ambush();
}

string createAttackingGroup(object ambushVictim) {

	ResetGroup("BadassOrcClan");
	SpawnCreaturesInGroupAtWP(1, "c_orcchief", "BadassOrcClan", "funkytown");
	SpawnCreaturesInGroupAtWP(1, "c_orccleric", "BadassOrcClan", "funkytown");
	SpawnCreaturesInGroupAtWP(3, "c_orc", "BadassOrcClan", "funkytown");
	return "BadassOrcClan";
}