/*
Filename:           cwhit_randomloottest
System:            
Author:             Chris Whitaker
Date Created:       Feb 15, 2011
Summary:
*/

#include "fw_random_loot_util"

void main()
{

    object oPC = GetLastPCRested();
	int nCR = d20();
	int nCounter = 10;
	
	SendMessageToPC(oPC, "Generating and Destroying 10 items at CR:" + IntToString(nCR));
	while (nCounter > 0) {
	   FW_FakeGenerateLogAndDestroy(oPC, nCR);
	   nCounter--;
	}
}