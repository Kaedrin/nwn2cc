#include "dmfi_inc_const"
#include "dmfi_inc_tool"

void main(string sEvent, string sDesc)
{
	object oPC = OBJECT_SELF;
	
	// Clear text
	if (sEvent == "1") {
		SetGUIObjectText(oPC, "hvchange_item_desc", "descbox", -1, "");
		return;
	}
	
	// Set new description
	object oTool = DMFI_GetTool(oPC);
	object oItem = GetLocalObject(oTool, DMFI_TARGET);
	SetDescription(oItem, sDesc);
	SendMessageToPC(oPC, "Description changed.");
}