/*
Filename:           hcr2_resttriggerenter_e
System:             player rest (trigger on enter event script)
Author:             Edward Beck (0100010)
Date Created:       Nov 13th,  2006
Summary:

hcr2_resttriggerenter_e script. This script should be placed in the on enter event
of a trigger that defines an allowable resting zone.

Paint the trigger on the ground and assign variables to it
as covered in the player rest documentation.

Setting an integer variable named H2_IGNORE_MINIMUM_REST_TIME to TRUE
will cause the minimum rest time restrictin to be ignored.

Set a string variable named H2_REST_FEEDBACK to a text message that you want displayed
to the PC when they rest in within that trigger.

-----------------
Revision:

*/


#include "hcr2_playerrest_i"

void main()
{
    object oEntObj = GetEnteringObject();
	if (GetIsPC(oEntObj))
	SendMessageToPC(oEntObj, "This looks like a safe place to rest.");
	SetLocalObject(oEntObj, H2_REST_TRIGGER, OBJECT_SELF);
}