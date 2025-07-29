#include "slots"

void main()
  {
  // Check to see if the player has 5 gold
  object oPC = GetPCSpeaker();
  if (GetGold(oPC) > 9)
    {
    // Remove some gold from the player
    TakeGoldFromCreature(10, GetPCSpeaker(), TRUE);
    DoSlots (10);
    }
  else
    {
    SendMessageToPC (oPC, "You do not have enough gold to play.");
    }
  }


