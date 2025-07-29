
#include "spawn_main"

void main()
{
	int nDoDamage = GetLocalInt(OBJECT_SELF, "hv_acid_damage");
	if (nDoDamage == 20) {
		ExecuteScript("hv_ooze_acid_damage", OBJECT_SELF);
		SetLocalInt(OBJECT_SELF, "hv_acid_damage", 0);
	}
	else {
		SetLocalInt(OBJECT_SELF, "hv_acid_damage", nDoDamage + 1);
	}
	
    Spawn();
}