#include "ginc_debug"
#include "ginc_transition"

void main(string sDestTag)
{
	object oPC = GetLastUsedBy();
	object oDestination = GetObjectByTag(sDestTag);
	AssignCommand(oPC, JumpToObject(oDestination));
}