/*
Filename:           h2_resttrigext_e
System:             player rest (trigger on exit event script)
Author:             Edward Beck (0100010)
Date Created:       Nov 13th,  2006
Summary:

hcr2_resttriggerexit_e script. This script should be placed in the on exit event
of a trigger that acts as a canteen source of food or drink.

Paint the trigger on the ground and assign variables to it

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
    object oExitObj = GetExitingObject();
	if (GetIsPC(oExitObj))
    	DeleteLocalObject(oExitObj, H2_REST_TRIGGER);
}