/*
Filename:           hcr2_playerreststarted
System:             core (rest started hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 13th, 2006
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_PLAYER_REST_STARTED, oPC) function that is called 
from hcr2_playerrest_e.

To make this script execute, a string variable, named OnPlayerRestStartedX,
where X is a number that indicates the order in which you want this player rest started script to execute,
should be assigned the value "hcr2_playerreststarted" under the variables section of Module properties.

By Default, h2_GetAllowRest, h2_GetAllowSpellRecovery, and h2_GetAllowFeatReceovery will return true
as hcr2_playerrest_e defaults them to that value before the rest started event scripts are ran.
Likewise, by default, h2_GetPostRestHealAmount is set to the PC's maximum hit points
to allow for full healing after the rest is finished.

These settings however are changed from their default values in this script.
(and may be changed yet again by other rest started hook-in scripts)

This script merely determines if the elspased time since the PC last rest with recovery
has been enough to allow recovery again.
If the elapased time is not enough, then spell and feat recovery set to false
and the post rest heal amount is set to 0.

If enough time has elapsed then the spell and feat recovery is not change from its default value of true,
and the post rest heal amount is set to the the value assigned to H2_HP_HEALED_PER_REST_PER_LEVEL
times the PC's level.

-----------------
Revision: v1.05
Fix for tracking rest time, spells, feats, and health 
for companions on rest

*/
#include "hcr2_playerrest_i"
#include "x0_i0_position"
#include "NW_I0_GENERIC"
 
void main()
{
    object oPC = GetLastPCRested();
    h2_SavePCLocation(oPC);
    int nRemainingTime = h2_RemainingTimeForRecoveryInRest(oPC);
    int bSkipMessageBox = GetLocalInt(oPC, H2_SKIP_REST_MESSAGEBOX);
    object oArea = GetArea(oPC);
    int nAreaRestDC = GetLocalInt(oArea, "RestDC");
    if (H2_REQUIRE_REST_TRIGGER_OR_CAMPFIRE)
    {
        object oRestTrigger = GetLocalObject(oPC, H2_REST_TRIGGER);
        object oCampfire = GetNearestObjectByTag(H2_CAMPFIRE, oPC);
        if (GetIsObjectValid(oRestTrigger))
        {
            if (GetLocalInt(oRestTrigger, H2_IGNORE_MINIMUM_REST_TIME))
                nRemainingTime = 0;
            string sFeedback = GetLocalString(oRestTrigger, H2_REST_FEEDBACK);
            if (sFeedback != "" && bSkipMessageBox)
                SendMessageToPC(oPC, sFeedback);
        } else if(H2_SURVIVALISTS_ALLOW_REST && nAreaRestDC > 0) {
            object oSurvivalist = oPC; // init to whatever... will be overritten
            int nSurvivalistsSkill = 0;
 
            // Get the first PC party member
            object oPartyMember = GetFirstFactionMember(oPC, TRUE);
            int nPartySize = 0;
            // We stop when there are no more valid PC's in the party.
            while(GetIsObjectValid(oPartyMember) == TRUE)
	        {
	            if(GetDistanceBetween(oPC, oPartyMember) < 8.0) {
                   // The party member is close enough to count.  Increment size by one.
                   nPartySize++;
				   int nPartyMembersSkill = GetSkillRank(SKILL_SURVIVAL,oPartyMember);
				   
                   if (nPartyMembersSkill > nSurvivalistsSkill) {
                      // this PC is the best Survivalist
                      oSurvivalist = oPartyMember;
                      nSurvivalistsSkill = nPartyMembersSkill;
                   }
                }
                // Get the next PC member of oPC's faction.
                oPartyMember = GetNextFactionMember(oPC, TRUE);
             }
             
             // make it easier for every PC over 1
             nAreaRestDC = nAreaRestDC - nPartySize + 1;
             
             if (GetIsObjectValid(oCampfire) && GetDistanceBetween(oPC, oCampfire) < 4.0)
             {
                // there is a campfire close, make it easier
                nAreaRestDC = nAreaRestDC -5;
             }
             
	     	 //check for surival skills
	       	 if ((d20() + nSurvivalistsSkill) >= nAreaRestDC) {
	      	    SendMessageToPC(oPC, "The fact that " + GetName(oSurvivalist) +" is keenly aware of any nearby threats was to your advantage");
	      	 } else {
			   
			location oTargetLocation = GetBehindLocation(oPC);
			string sWonderingMonster = GetLocalString(oArea, "WanderingMonster");

			object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sWonderingMonster, oTargetLocation);

			if (GetIsObjectValid(oSpawn)) {
				SendMessageToPC(oPC, "No one noticed the nearby threats and they attack.");
				SetIsTemporaryEnemy(oPC, oSpawn);
				AssignCommand(oSpawn, ActionAttack(oPC));
				AssignCommand(oSpawn, DetermineCombatRound(oPC));
			}
                	h2_SetAllowRest(oPC, FALSE);
                	return;
	         }     
        } else if (!GetIsObjectValid(oCampfire) || GetDistanceBetween(oPC, oCampfire) > 4.0)
        {
            h2_SetAllowRest(oPC, FALSE);
            return;
        }
    }

    if (nRemainingTime != 0)
    {
        if (!bSkipMessageBox)
        {
            string sWaittime = FloatToString(nRemainingTime / HoursToSeconds(1), 5, 2);
            string sMessage = H2_TEXT_RECOVER_WITH_REST_IN + sWaittime + H2_TEXT_HOURS;
            SendMessageToPC(oPC, sMessage);
        }
		
		object oPM = GetFirstFactionMember(oPC, FALSE);
		while (GetIsObjectValid(oPM))
		{		
			if (!GetIsPC(oPM) || oPM == oPC)
			{
				h2_SetAllowSpellRecovery(oPM, FALSE);
				h2_SetAllowFeatRecovery(oPM, FALSE);
        		h2_SetPostRestHealAmount(oPM, 0);
			}
			oPM = GetNextFactionMember(oPM, FALSE);
		}
    }
    else
    {
        if (H2_HP_HEALED_PER_REST_PER_LEVEL > -1)
        {
			object oPM = GetFirstFactionMember(oPC, FALSE);
			while (GetIsObjectValid(oPM))
			{
				if (!GetIsPC(oPM) || oPM == oPC)
				{
            		int nPostRestHealAmt = H2_HP_HEALED_PER_REST_PER_LEVEL * GetHitDice(oPM);            		
					h2_SetPostRestHealAmount(oPM, nPostRestHealAmt);
				}
				oPM = GetNextFactionMember(oPM, FALSE);
			}
        }
    }
}