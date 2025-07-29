/*
Filename:           hcr2_pccorpsesh
System:             pc corpse (spellhook event hook-in script)
Author:             Edward Beck (0100010)
Date Created:       Jun. 21st, 2007
Summary:

This script should be called via ExecuteScript from the
RunModuleEventScripts(H2_EVENT_ON_SPELLHOOK, oPC) function that is called from hcr2_spellhook_e.

To make this script execute, a string variable, named OnSpellHookX,
where X is a number that indicates the order in which you want this player death script to execute,
should be assigned the value "hcr2_pccorpsesh" under the variables section of Module properties.

-----------------
Created for Revision: v1.02

*/
#include "hcr2_pccorpse_i"
#include "x2_inc_switches"

void main()
{
	int nSpellID = GetSpellId();
	if (nSpellID == SPELL_RAISE_DEAD || nSpellID == SPELL_RESURRECTION)
	{
		object oTarget = GetSpellTargetObject();
		object oToken = GetLocalObject(oTarget, H2_PC_CORPSE_ITEM);
		if (GetIsObjectValid(oToken))
		{
			h2_RemoveCorpse(oTarget);
			h2_RaiseSpellCastOnCorpseToken(nSpellID, oToken);
		}			
	}		
	
}