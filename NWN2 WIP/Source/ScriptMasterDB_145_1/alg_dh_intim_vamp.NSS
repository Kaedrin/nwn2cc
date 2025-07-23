object oTarget;

#include "nw_i0_tool"
#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

if (GetIsSkillSuccessful(oPC, SKILL_INTIMIDATE, 25))
   {
   AssignCommand(GetObjectByTag("D_amy_antagonist"), ActionSpeakString("Ok ok..here just take gold!"));

   RewardPartyGP(1500, oPC, FALSE);
   AddJournalQuestEntry("alg_babe", 820, oPC, TRUE, FALSE);


   }
else
   {
   SendMessageToPC(oPC, "Hah! ..die fool!");

   oTarget = OBJECT_SELF;

   SetIsTemporaryEnemy(oPC, oTarget);

ActionAttack(oPC);

DetermineCombatRound(oPC);

   }

}
