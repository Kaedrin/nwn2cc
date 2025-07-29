/*Quaxo's Chochirorin Script Version 2
Last Updated: August 2, 2004
Status: SCRIPT REWRITE

This script was rewritten to compile the 20+ original smaller scripts into one.
In this script, all three rolls are made at the same time. I found this more practical then running the script for each roll.
"If" statements are used to determind if a previous roll was a winning roll or not.

This script DOES NOT include payout functions yet, but currently compiles without errors.
*/
int StartingConditional()
{
 object oPC = GetPCSpeaker();
 int pBet = GetLocalInt(oPC, "pBet"); //Get amount bet
 int nRoll = 1; //For the number of the roll check(1st, 2nd, 3rd)
 int nDie1, nDie2, nDie3, nScore;
 string sMsg, sNoScore;

 //NPC Rolls
 //Begin NPC Roll Checks
 while (nRoll <= 3 && sMsg == "")
 {
  nDie1 = d6();
  nDie2 = d6();
  nDie3 = d6();
  if (nDie1 == nDie2 && nDie1 == nDie3) //Check Storms
  {
   if (nDie1 == 1)
   {
    sMsg = sNoScore + "I have rolled a " + IntToString(nDie1) + ", " + IntToString(nDie2) + ", and " + IntToString(nDie3) + ". It's a Storm in your favor! You win three times the bet.";
    GiveGoldToCreature(oPC, 3 * pBet);
    DeleteLocalInt(oPC, "pBet");
   }
   else
   {
    sMsg = sNoScore + "I have rolled a " + IntToString(nDie1) + ", " + IntToString(nDie2) + ", and " + IntToString(nDie3) + ". It's a Storm in my favor! I win three times the bet.";
    TakeGoldFromCreature(3 * pBet, oPC);
    DeleteLocalInt(oPC, "pBet");
   }
  }
  else if (nDie1 == nDie2 || nDie1 == nDie3 || nDie2 == nDie3) //Check Doubles
  {
   nScore = nDie1 == nDie2 || nDie1 == nDie3?(nDie2 == nDie1?nDie3:nDie2):nDie1;
   sMsg = sNoScore + "I have rolled a " + IntToString(nDie1) +", " + IntToString(nDie2) + ", and " + IntToString(nDie3) + ". My score is " + IntToString(nScore) +".";
  }
  else if ((nDie1 == 1 || nDie1 == 2 || nDie1 == 3) && (nDie2 == 1 || nDie2 == 2 || nDie2 == 3) && (nDie3 == 1 || nDie3 == 2 || nDie3 == 3)) //Check Combos
  {
   sMsg = sNoScore + "I have rolled a 1, 2, and 3. You win two times the bet.";
   GiveGoldToCreature(oPC, 2 * pBet);
   DeleteLocalInt(oPC, "pBet");
  }
  else if ((nDie1 == 4 || nDie1 == 5 || nDie1 == 6) && (nDie2 == 4 || nDie2 == 5 || nDie2 == 6) && (nDie3 == 4 || nDie3 == 5 || nDie3 == 6)) //Check Combos
  {
   sMsg = sNoScore + "I have rolled a 4, 5, and 6. I win two times the bet.";
   TakeGoldFromCreature(2 * pBet, oPC);
   DeleteLocalInt(oPC, "pBet");
  }
  else //No score
  {
   sNoScore += "I have rolled a " + IntToString(nDie1) + ", " + IntToString(nDie2) + ", and " + IntToString(nDie3) + ". No score.\n";
  }
  nRoll++;
 }
 if (sMsg == "") sMsg = sNoScore;
 SetCustomToken(101, sMsg);
 SetLocalInt(oPC, "Score", nScore);
 return TRUE;
}

