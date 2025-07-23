//::///////////////////////////////////////////////
//:: Invocation: Eldritch Blast (Warlock Spelllike effect)
//:: NW_S0_IEldBlast.nss
//:://////////////////////////////////////////////
/*
    Does 1d6 Dmg per "ranking" of Eldritch Blast.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: June 20, 2005
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001


#include "nw_i0_invocatns"
#include "x2_inc_spellhook" 

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    //Declare major variables
    object oTarget = GetSpellTargetObject();

	//Need to do the faux ASF check here
	int ASF = GetArcaneSpellFailure(OBJECT_SELF);
	int nRandom = d100();
	if (nRandom <= ASF)
	{
    	object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
		if (GetIsObjectValid(oArmor))
		{
			int nRank = GetArmorRank(oArmor);
			int nArmorRules = GetArmorRulesType(oArmor);
			string sASF = Get2DAString("armorrulestats", "ARCANEFAILURE%", nArmorRules);
			int nASF = StringToInt(sASF);
			int nNoArmorASF = ASF - nASF;
			
			if (nRank > 2)
			{
				SendMessageToPC(OBJECT_SELF,"Eldritch Blast failed due to arcane spell failure." +  " ASF Roll: " + IntToString(nRandom));
				return;			
			}
			else
			if (nRank == 2 && !GetHasFeat(1766)) // Battle Caster
			{
				if (nRandom <= nNoArmorASF)
				{
					SendMessageToPC(OBJECT_SELF,"Eldritch Blast failed due to arcane spell failure." +  " ASF Roll: " + IntToString(nRandom));
					return;		
				}
			}
			else
			if (nRank == 1) // Armored Caster
			{
				if (nRandom <= nNoArmorASF)
				{
					SendMessageToPC(OBJECT_SELF,"Eldritch Blast failed due to arcane spell failure." +  " ASF Roll: " + IntToString(nRandom));
					return;		
				}
			}
		}
		else // No armor, shield
		{
			// Failed the ASF check
			SendMessageToPC(OBJECT_SELF,"Eldritch Blast failed due to arcane spell failure." +  " ASF Roll: " + IntToString(nRandom));
			return;
		}
	}
	
    // Note: Eldritch Blast is not affected by Metamagic (not a spell!)
    DoEldritchBlast(OBJECT_SELF, oTarget);
	
	/*
	int nRoll;
	int nRoll1;
	int nRoll2;
	int nRoll3;
	int nRoll4;
	int nRoll5;
	int nRoll6;
	int nRoll7;
	int nRoll8;
	int nRoll9;
	int nRoll10;
	int nRoll11;
	int nRoll12;
	int nRoll13;
	int nRoll14;
	int nRoll15;
	int nRoll16;
	int nRoll17;
	int nRoll18;
	int nRoll19;
	int nRoll20;
	int nRoll50Pct;
	int nSpellId = GetSpellId();
	SendMessageToPC(OBJECT_SELF, "SpellId: " + IntToString(nSpellId));
	
	int nCount = 1;
	while (nCount < 1000)
	{
		nRoll = d20();
		
		if (nRoll == 1)
			nRoll1 ++;
		if (nRoll == 2)
			nRoll2 ++;
		if (nRoll == 3)
			nRoll3 ++;
		if (nRoll == 4)
			nRoll4 ++;
		if (nRoll == 5)
			nRoll5 ++;
		if (nRoll == 6)
			nRoll6 ++;
		if (nRoll == 7)
			nRoll7 ++;
		if (nRoll == 8)
			nRoll8 ++;
					if (nRoll == 9)
			nRoll9 ++;
					if (nRoll == 10)
			nRoll10 ++;
					if (nRoll == 11)
			nRoll11++;
					if (nRoll == 12)
			nRoll12++;
					if (nRoll == 13)
			nRoll13++;
					if (nRoll == 14)
			nRoll14++;
					if (nRoll == 15)
			nRoll15++;
					if (nRoll == 16)
			nRoll16++;
					if (nRoll == 17)
			nRoll17++;
					if (nRoll == 18)
			nRoll18++;
					if (nRoll == 19)
			nRoll19++;
					if (nRoll == 20)
			nRoll20++;			
			
			if (nRoll > 10)
				nRoll50Pct++;																	
	
		nCount ++;
	}
	
SendMessageToPC(OBJECT_SELF, "nRoll50Pct: " + IntToString(nRoll50Pct));
SendMessageToPC(OBJECT_SELF, "nRoll1: " + IntToString(nRoll1));	
SendMessageToPC(OBJECT_SELF, "nRoll2: " + IntToString(nRoll2));	
SendMessageToPC(OBJECT_SELF, "nRoll3: " + IntToString(nRoll3));	
SendMessageToPC(OBJECT_SELF, "nRoll4: " + IntToString(nRoll4));	
SendMessageToPC(OBJECT_SELF, "nRoll5: " + IntToString(nRoll5));	
SendMessageToPC(OBJECT_SELF, "nRoll6: " + IntToString(nRoll6));	
SendMessageToPC(OBJECT_SELF, "nRoll7: " + IntToString(nRoll7));	
SendMessageToPC(OBJECT_SELF, "nRoll8: " + IntToString(nRoll8));	
SendMessageToPC(OBJECT_SELF, "nRoll9: " + IntToString(nRoll9));	
SendMessageToPC(OBJECT_SELF, "nRoll10: " + IntToString(nRoll10));	
SendMessageToPC(OBJECT_SELF, "nRoll11: " + IntToString(nRoll11));	
SendMessageToPC(OBJECT_SELF, "nRoll12: " + IntToString(nRoll12));	
SendMessageToPC(OBJECT_SELF, "nRoll13: " + IntToString(nRoll13));	
SendMessageToPC(OBJECT_SELF, "nRoll14: " + IntToString(nRoll14));	
SendMessageToPC(OBJECT_SELF, "nRoll15: " + IntToString(nRoll15));	
SendMessageToPC(OBJECT_SELF, "nRoll16: " + IntToString(nRoll16));	
SendMessageToPC(OBJECT_SELF, "nRoll17: " + IntToString(nRoll17));	
SendMessageToPC(OBJECT_SELF, "nRoll18: " + IntToString(nRoll18));	
SendMessageToPC(OBJECT_SELF, "nRoll19: " + IntToString(nRoll19));	
SendMessageToPC(OBJECT_SELF, "nRoll20: " + IntToString(nRoll20));	
	*/
}