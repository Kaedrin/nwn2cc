#include "nwnx_sql"

void main(string sFeatID)
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);
	
	// FEAT_KNIGHT_OF_TIERDIAL_QUALIFICATION
	if (sFeatID == "1") {
		if (GetHasFeat(2260, oTarget) == FALSE)
			FeatAdd(oTarget, 2260, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2260);
	}
		
	// FEAT_SWIFTBLADE_QUALIFICATION
	if (sFeatID == "2") {
		if (GetHasFeat(2261, oTarget) == FALSE)
			FeatAdd(oTarget, 2261, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2261);
	}
		
	// FEAT_FOREST_MASTER_QUALIFICATION
	if (sFeatID == "3") {
		if (GetHasFeat(2262, oTarget) == FALSE)
			FeatAdd(oTarget, 2262, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2262);
	}
		
	// FEAT_CANAITH_LYRIST_QUALIFICATION
	if (sFeatID == "4") {
		if (GetHasFeat(2263, oTarget) == FALSE)
			FeatAdd(oTarget, 2263, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2263);
	}
		
	// FEAT_CHAMPION_OF_THE_WILD_QUALIFICATION
	if (sFeatID == "5") {
		if (GetHasFeat(2264, oTarget) == FALSE)
			FeatAdd(oTarget, 2264, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2264);
	}
		
	// FEAT_ELDRITCH_DISCIPLE_QUALIFICATION
	if (sFeatID == "6") {
		if (GetHasFeat(2265, oTarget) == FALSE)
			FeatAdd(oTarget, 2265, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2265);
	}
		
	// FEAT_HEARTWARDER_QUALIFICATION
	if (sFeatID == "7") {
		if (GetHasFeat(2266, oTarget) == FALSE)
			FeatAdd(oTarget, 2266, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2266);
	}
	
	// FEAT_DRAGON_DISCIPLE_QUALIFICATION
	if (sFeatID == "8") {
		if (GetHasFeat(2267, oTarget) == FALSE)
			FeatAdd(oTarget, 2267, FALSE, TRUE, TRUE);
		else
			FeatRemove(oTarget, 2267);
	}
	
	// FEAT_SURFACE_DROW_QUALIFICATION
	if (sFeatID == "9") {
		if(GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
		{
			if (GetHasFeat(2269, oTarget) == FALSE)
			{
				FeatAdd(oTarget, 2269, FALSE, TRUE, TRUE);
				SendMessageToPC(OBJECT_SELF, "Gave good drow qualifying feat to: " + GetName(oTarget));
			}
			else
			{
				FeatRemove(oTarget, 2269);
				SendMessageToPC(OBJECT_SELF, "Removed good drow qualifying feat from: " + GetName(oTarget));
			}
		}
		else
		{
			if (GetHasFeat(2268, oTarget) == FALSE)
			{
				FeatAdd(oTarget, 2268, FALSE, TRUE, TRUE);
				SendMessageToPC(OBJECT_SELF, "Gave surface drow qualifying feat to: " + GetName(oTarget));
			}
			else
			{
				FeatRemove(oTarget, 2268);
				SendMessageToPC(OBJECT_SELF, "Removed surface drow qualifying feat from: " + GetName(oTarget));
			}
		}
	}
	
	// FEAT_SPELL_FAILURE
	if (sFeatID == "10") {
		if(GetPersistentInt(oTarget, "SPELL_FAILURE") == 0)
		{
			SetPersistentInt(oTarget, "SPELL_FAILURE", 1);
			SendMessageToPC(OBJECT_SELF, "Gave deity spell failure to: " + GetName(oTarget));
			effect eSF = EffectSpellFailure(100);
			eSF = SupernaturalEffect(eSF);
			eSF = SetEffectSpellId(eSF, 1500);
    		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSF, oTarget);
			SendMessageToPC(oTarget, "Your deity no longer answers your prayers this day.");

		}
		else
		{
			DeletePersistentVariable(oTarget, "SPELL_FAILURE");
			SendMessageToPC(OBJECT_SELF, "Removed deity spell failure from: " + GetName(oTarget));
			effect eff = GetFirstEffect(oTarget);
    		while (GetEffectType(eff) != EFFECT_TYPE_INVALIDEFFECT)
    		{
				if(GetEffectSpellId(eff)==1500)
				{
        			RemoveEffect(oTarget, eff);
					return;
				}
       	 		eff = GetNextEffect(oTarget);
    		}
		}
	}
}