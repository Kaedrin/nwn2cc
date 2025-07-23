// k_mod_start
/*
    Module start
*/
// ChazM 3/2/06

#include "ginc_debug"

#include "cmi_ginc_chars"

void main()
{
//	PrintString("Module start fired for module " + GetName(OBJECT_SELF));

	//SendMessageToPC(GetFirstPC(), "k_mod_start");

	IsModuleSupported(TRUE);
	ExecuteScript("ccs_pc_loaded",GetFirstPC());
	return;
}