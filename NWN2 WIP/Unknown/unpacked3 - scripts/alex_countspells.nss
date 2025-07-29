#include "nwnx_srvadmin"

int countPlayerSpells(object oPC)
{ 	
	int nSpellCount=0;
	int nSpell=0;
	
	while(nSpell<=2146)
	{
		if(GetSpellKnown(oPC, nSpell))
		{
			nSpellCount++;
		}
		nSpell++;
	}
	
	//SendMessageToPC(oPC, "You have "+ IntToString(nSpellCount)+" spells.");
	if (nSpellCount > 240)
	{	
		//BanPlayerIP(sPlayer);
		//BanPlayerCDKey(sPlayer);
	//	BootPC(oPC);
		return 1;
	}
	else
		return 0;
}