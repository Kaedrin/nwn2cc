/*

	Grenades spells script.
	Determines strength of effects based on the vars which
	were stored on the item in the time of its creation.

*/

#include "ev_alch_grenades_inc"

void main()
{
	// Determine which grenade was used
	object oItem     = GetSpellCastItem();
	int nSpell = GetLocalInt(oItem, "ev_spellid");
	
	switch (nSpell) {
		case 1500: DoAcidGrenade();		break;
		case 1501: DoFireGrenade();		break;
		case 1502: DoColdGrenade();		break;
		case 1503: DoElectGrenade();	break;
		case 1504: DoSonicGrenade();	break;
		case 1505: DoEntangleGrenade();	break;
		case 1506: DoSickenGrenade();	break;
		case 1507: DoHolyGrenade();		break;
		case 1508: DoFlashGrenade();	break;
		case 1509: DoCinderFire();		break;
		
		
		default: break;
	}
}