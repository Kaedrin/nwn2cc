int GetRandomSpell()
{
	int nSpell = 0;
	
	// 27 options
	int nRand = Random(27) + 1;
	
	switch (nRand) {
		case 1:
			nSpell = SPELL_BLADE_BARRIER_WALL;
			break;
		case 2:
			nSpell = SPELL_BLESS;
			break;
		case 3:
			nSpell = SPELL_CLOUDKILL;
			break;
		case 4:
			nSpell = SPELL_CONFUSION;
			break;
		case 5:
			nSpell = SPELL_EARTHQUAKE;
			break;
		case 6:
			nSpell = SPELL_ENTANGLE;
			break;
		case 7:
			nSpell = SPELL_FIREBALL;
			break;
		case 8:
			nSpell = SPELL_GREASE;
			break;
		case 9:
			nSpell = SPELL_HAMMER_OF_THE_GODS;
			break;
		case 10:
			nSpell = SPELL_HISS_OF_SLEEP;
			break;
		case 11:
			nSpell = SPELL_I_CHILLING_TENTACLES;
			break;
		case 12:
			nSpell = SPELL_MASS_BEAR_ENDURANCE;
			break;
		case 13:
			nSpell = SPELL_MASS_BULL_STRENGTH;
			break;
		case 14:
			nSpell = SPELL_MASS_CHARM;
			break;
		case 15:
			nSpell = SPELL_MASS_CAT_GRACE;
			break;
		case 16:
			nSpell = SPELL_MASS_CONTAGION;
			break;
		case 17:
			nSpell = SPELL_MASS_CURE_SERIOUS_WOUNDS;
			break;
		case 18:
			nSpell = SPELL_MASS_FOX_CUNNING;
			break;
		case 19:
			nSpell = SPELL_MASS_CURE_CRITICAL_WOUNDS;
			break;
		case 20:
			nSpell = SPELL_MASS_HEAL;
			break;
		case 21:
			nSpell = SPELL_MASS_HOLD_MONSTER;
			break;
		case 22:
			nSpell = SPELL_MASS_INFLICT_SERIOUS_WOUNDS;
			break;
		case 23:
			nSpell = SPELL_MASS_LESSER_VIGOR;
			break;
		case 24:
			nSpell = SPELL_MASS_OWL_WISDOM;
			break;
		case 25:
			nSpell = SPELL_CLOUD_OF_BEWILDERMENT;
			break;
		case 26:
			nSpell = SPELL_MASS_DEATH_WARD;
			break;
		case 27:
			nSpell = SPELL_ISAACS_GREATER_MISSILE_STORM;
			break;
			
	}
	return nSpell;
}

#include "hv_arena_inc"

// casts random spell at random location
void main()
{
	object oArea = GetArea(OBJECT_SELF);
	if (GetLocalInt(oArea, CHALLENGE_RUNNING) == 0)
		return;	

	// 50% to cast a spell
	int nRand = Random(2);
	if (nRand == 0)
		return;
	
	location lLocation = GetRandomArenaLocation();
	
	// Get random int for delaying, 5 to 15 seconds
	int nDelay = Random(11) + 5;
	int nSpell = GetRandomSpell();
	//SpeakString("Casting " + IntToString(nSpell) + " in " + IntToString(nDelay) + " seconds.");
	DelayCommand(IntToFloat(nDelay), ActionCastSpellAtLocation(nSpell, lLocation, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, FALSE, 25));
}