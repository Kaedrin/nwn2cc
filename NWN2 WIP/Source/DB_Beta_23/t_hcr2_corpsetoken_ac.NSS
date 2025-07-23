/*
Filename:           hcr2_corpsetoken
System:             pc corpse (token corpse item script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:
pccorpse item event script.
This script fires whenever the hcr2_corpsetoken items are aquired, unaquired, activated
or had a spell cast at it.

-----------------
Revision: v1.01
Removed some debug messages.

*/

#include "hcr2_pccorpse_i"
#include "x2_inc_switches"

void main()
{
    object oPC;
    object oItem;	

	h2_CorpseTokenActivatedOnNPC();
}