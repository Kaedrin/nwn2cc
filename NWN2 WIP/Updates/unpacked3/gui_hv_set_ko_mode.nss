#include "nwnx_sql"
void main()
{
	int nMode = GetLocalInt(OBJECT_SELF, "hv_ko_mode");
	if (nMode == 0) {
		SetLocalInt(OBJECT_SELF, "hv_ko_mode", 1);
		SetPersistentInt(OBJECT_SELF, "hv_ko_mode", 1, 0, "dbtools");
		SendMessageToPC(OBJECT_SELF, "Knockdown Mode Disabled.");
	}
	else {
		SetLocalInt(OBJECT_SELF, "hv_ko_mode", 0);
		SetPersistentInt(OBJECT_SELF, "hv_ko_mode", 0, 0, "dbtools");
		SendMessageToPC(OBJECT_SELF, "Knockdown Mode Activated.");
	}			
}