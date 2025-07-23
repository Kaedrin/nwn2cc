object oItem;
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

if (GetIsSkillSuccessful(oPC, SKILL_BLUFF, 35))
   {
   RewardPartyXP(500, oPC, FALSE);

   SendMessageToPC(oPC, "Well, tough luck I can't reward you without proof.");

   }
else
   {
   oItem = GetFirstItemInInventory(oPC);

   while (GetIsObjectValid(oItem))
      {
      if (GetTag(oItem)=="shar_dagger") DestroyObject(oItem);

      oItem = GetNextItemInInventory(oPC);
      }

   SendMessageToPC(oPC, "The Captian doesn't belive you and frisks you. 'Ah hah! Get out of my face you dirty liar before I have you hung!'");

   }

}