/*
Filename:           gui_hcr2_makepcrest
System:             core (executed script that makes pc rest)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:

This script is called via the OK button of the RestMessageBox.
It makes the PC rest without bringing up the messagebox again.

-----------------
Revision: v1.05
Fix so companions can now initiate rest

*/
#include "hcr2_core_i"

void main()
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	int bOkToRest = GetLocalInt(oChar, H2_OK_TO_REST);
	if (bOkToRest)
    	h2_MakePCRest(oChar);
}