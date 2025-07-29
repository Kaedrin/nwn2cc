#include "slots"

void main()
  {
  // Check to see if the player has 5 gold
  object oPC = GetPCSpeaker();
  if (GetGold(oPC) > 249)
    {
    // Remove some gold from the player
    TakeGoldFromCreature(250, GetPCSpeaker(), TRUE);
    DoSlots (250);
    }
  else
    {
    SendMessageToPC (oPC, "You do not have enough gold to play.");
    }
  }


