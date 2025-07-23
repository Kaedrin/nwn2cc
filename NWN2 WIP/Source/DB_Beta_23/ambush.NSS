/*
 * ambush
 *
 * Base script for ambushes
 * 
 * Defines rules for giving warning about an impending ambush and 
 * relies upon calling scripts to specify the group doing the ambush
 */

#include "ginc_group"


string createAttackingGroup(object ambushVictim);

void activateAmbush(object ambushVictim) {
    
	SendMessageToPC(ambushVictim, "Ambush!");
	string attackers = createAttackingGroup(ambushVictim);
	if (GetIsGroupValid(attackers)) {
		string party = GetPartyGroup(ambushVictim);
		GroupAttackGroup(attackers,party);
	}
}



void ambush() {

    object ambushVictim = GetEnteringObject();
	int lastAmbushTime = GetLocalInt(OBJECT_SELF,"lastAmbushTime");
	if (GetTimeHour() == lastAmbushTime) {
		SendMessageToPC(ambushVictim, "It appears there was a battle here recently");
	}
	else if (GetIsPC(ambushVictim)) {	
		SetLocalInt(OBJECT_SELF,"lastAmbushTime", GetTimeHour());
        if (GetIsSkillSuccessful(ambushVictim, SKILL_SURVIVAL, GetLocalInt(OBJECT_SELF, "ambushSneakiness"), FALSE)) {
            SendMessageToPC(ambushVictim, "You see fresh tracks");
            DelayCommand(20.0, activateAmbush(ambushVictim));
        }
        else if (GetIsSkillSuccessful(ambushVictim, SKILL_LISTEN, GetLocalInt(OBJECT_SELF, "ambushSilence"), FALSE)) {
            SendMessageToPC(ambushVictim, "You hear footsteps");
            DelayCommand(15.0, activateAmbush(ambushVictim));
        }
        else if (GetIsSkillSuccessful(ambushVictim, SKILL_SPOT, GetLocalInt(OBJECT_SELF, "ambushCamouflage"), FALSE)) {
            SendMessageToPC(ambushVictim, "You see movement in the brush");
            DelayCommand(10.0, activateAmbush(ambushVictim));
        }
        else {
            activateAmbush(ambushVictim);
        }
    }
}