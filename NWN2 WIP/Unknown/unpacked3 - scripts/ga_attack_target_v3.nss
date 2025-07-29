/* A Gildren modified verison of Hyper-V's versio... oh nm
This resets the attackign creatures faction to "ALIGNMENT_NEUTRAL"
03-03-12

Modified version of the ga_attack_target script by Hyper-V 02-18-12
This version adds in a time delayed changed of the attacking NPC to 
a faction of "commoner" so that it will stop attacking player characters
All credits should go to Hyper-V for the adjustments - Gildren

// ga_attack_target
/*
   This script makes the sAttacker attack the sTarget. It should be placed on an [END DIALOG] node.

   Parameters:
     string sAttacker 	- Tag of attacker.  Default is OWNER.
     string sTarget 	- Tag of Target.  Default is PC.
	 int bMaintainFaction - 0 (FALSE) = change attacker to the standard HOSTILE faction. 1(TRUE) = don't change faction.  
	 int nDelay         - Number of seconds before attacker is set back to Common faction.
*/
// FAB 10/7
// ChazM 4/26
// ChazM 5/10/07 - added bMaintainFaction

#include "ginc_param_const"
#include "ginc_actions"

void CeaseAttack(object oNPC)
{
	AssignCommand(oNPC, ClearAllActions(TRUE));
	ChangeToStandardFaction(oNPC, ALIGNMENT_NEUTRAL);
	AssignCommand(oNPC, ClearAllActions(TRUE));
}

void main(string sAttacker, string sTarget, int bMaintainFaction, int nDelay)
{
    object oAttacker = GetTarget(sAttacker, TARGET_OWNER);
    object oTarget = GetTarget(sTarget, TARGET_PC);
	StandardAttack(oAttacker, oTarget, !bMaintainFaction);
	
	float fDelay = IntToFloat(nDelay);
	DelayCommand(fDelay, CeaseAttack(oAttacker));
}