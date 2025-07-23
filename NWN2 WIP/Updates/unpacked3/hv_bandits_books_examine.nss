#include "hv_bandits_inc"

// On Use of security books, show player her password
void main()
{
	object oPC = GetLastUsedBy();
	UpdateSecurityBooks(OBJECT_SELF, oPC);
}