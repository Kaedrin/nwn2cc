#include "elu_functions_i"

void main(string sButtonMovedFrom)
{
	object oChar = GetControlledCharacter(OBJECT_SELF);
	string sButtonMovedTo = GetLocalString(oChar, LAST_HOTBARBUTTON_DROP);
	SetLocalString(oChar, HOTBAR_BUTTON_ID, sButtonMovedTo);	
	string sButtonMovedToData = GetHotBarButtonData();
	SetLocalString(oChar, HOTBAR_BUTTON_ID, sButtonMovedFrom);	
	string sButtonMovedFromData = GetHotBarButtonData();
	SetHotBarButtonData(sButtonMovedFromData);	
	SetLocalString(oChar, LAST_HOTBARBUTTON_DROP, sButtonMovedFrom);
	SetHotBarButtonData(sButtonMovedToData);
}