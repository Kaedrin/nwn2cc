/*
Filename:           gui_hcr2_restcancel
System:             core (executed script on cancel rest from gui)
Author:             Edward Beck (0100010)
Date Created:       Dec 9th, 2006.
Summary:

This script is called via the Cancel button of the RestMessageBox.

-----------------
Revision:

*/
#include "hcr2_constants_i"

void main()
{
	DeleteLocalInt(OBJECT_SELF, H2_OK_TO_REST);	
}