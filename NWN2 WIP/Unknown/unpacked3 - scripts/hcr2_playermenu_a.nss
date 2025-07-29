/*
Filename:           hcr2_playermenu_a
System:             core (hcr2_playermenuconv menu node action script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

Action script that is fired when a dialog choice in the 
player menu conversation is selected.

-----------------
Revision:

*/


#include "hcr2_core_i"

void main(int index)
{
    string convResRef = h2_GetModLocalString(H2_CONVERSATION_RESREF + IntToString(index));
    if (convResRef != "")
        AssignCommand(OBJECT_SELF, ActionStartConversation(OBJECT_SELF, convResRef, TRUE, FALSE));
}