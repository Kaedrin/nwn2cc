/*
Filename:           hcr2_destroyempty_e
System:             stand-alone script (generic placeable on disturbed event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2_destroyempty_e script. This script should be placed in the
OnDisturbed event of an inventory placeable that is to be destoyed when its
contents are empty.

-----------------
Revision:

*/

void main()
{
	if (!GetIsObjectValid(GetFirstItemInInventory(OBJECT_SELF)))
        DestroyObject(OBJECT_SELF);
}