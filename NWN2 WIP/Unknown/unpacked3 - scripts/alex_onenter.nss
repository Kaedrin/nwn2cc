#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "nwnx_sql"

void main()
{
	object oPC = GetEnteringObject();
	
	int nSpellId = 1500;

	if(GetPersistentInt(oPC, "SPELL_FAILURE") == 1)
	{
		effect eSF = EffectSpellFailure(100);
		eSF = SupernaturalEffect(eSF);
		eSF = SetEffectSpellId(eSF, nSpellId);
    	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSF, oPC);
		SendMessageToPC(oPC, "Your deity no longer answers your prayers this day.");
	}
	//else
	//{	
   	// 	effect eff = GetFirstEffect(oPC);
    //	while (GetEffectType(eff) != EFFECT_TYPE_INVALIDEFFECT)
    //	{
	//		if(GetEffectSpellId(eff)==nSpellId)
	//		{
    //    		RemoveEffect(oPC, eff);
	//			return;
	//		}
    //    	eff = GetNextEffect(oPC);
    //	}
	//}
}