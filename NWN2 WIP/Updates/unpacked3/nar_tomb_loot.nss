/*
	nar_tomb_loot
	
	Called from On Open
	
	Script called when some poor fool opens a sacrophagus.
	Spawns loot inside the sacrophagus, as well as causing
	random bad things to happen.
	
	Local variable nTreasureRating controls the level of loot
	(and bad things) the sacrophagus has.
		1 = low
		
	Local variable bTriggered controls if the sarcophagus has already
	been opened.
	
	16/01/2011 - Narks 
*/

// #include "hv_create_vein_loot"

string GetGemTag(string sCategory)
{
	// TODO: cannot use hyper-v's vein loot
	// this is replacement function

	int nRandom = Random(5) + 1;
	switch (nRandom) 
	{
		case 1 : return "cft_gem_04";
		case 2 : return "cft_gem_21";
		case 3 : return "cft_gem_18";
		case 4 : return "cft_gem_19";
		case 5 : return "cft_gem_20";
		case 6 : return "cft_gem_23";
	}
	return "";
}

void main()
{
	if (GetLocalInt(OBJECT_SELF, "bTriggered") == TRUE)
		return;
	
	SetLocalInt(OBJECT_SELF, "bTriggered", TRUE);
	
	int nTreasureRating = GetLocalInt(OBJECT_SELF, "nTreasureRating");
	
	// Low treasure.
	if (nTreasureRating == 1)
	{
		// Gold in loot
		int nGold = 10 + Random(40);
		CreateItemOnObject("NW_IT_GOLD001", OBJECT_SELF, nGold);
		
		// Chance of gem in loot
		int nGemRandom = Random(20);
		if (nGemRandom == 0)
			CreateItemOnObject(GetGemTag("less common"), OBJECT_SELF); 
		
		// Chance of cursing the player and hurting them
		// 75% chance, and allows will save
		int nBadThing = d20();
		if (nBadThing >= 6)
		{
			object oPC = GetLastOpenedBy();
			int nSave = WillSave(oPC, 13, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF);
			
			if (nSave == 0)
			{
				effect eCurse = EffectCurse(Random(2), Random(2), Random(2), 
					Random(2), Random(2), Random(2));
					
				int nDamage = 4 + d4();
				effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
				
				ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oPC);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
			}
		}
	}
}