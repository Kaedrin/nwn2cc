#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
		object oPC = OBJECT_SELF;
		
		int nSpellId = SPELLABILITY_CHAMPWILD_ELEGANT_STRIKE;
    	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);			
		int bElegantStrikeValid = isValidElegantStrikeWeapon(oWeapon);
		int bHasElegantStrike = GetHasSpellEffect(nSpellId,oPC);
		
		if (bElegantStrikeValid)
		{

			RemoveSpellEffects(nSpellId, oPC, oPC);		
			int nBoost = GetAbilityModifier(ABILITY_DEXTERITY);
			nBoost = GetDamageBonusByValue(nBoost);
			
			effect eDmg = EffectDamageIncrease(nBoost);
			
			eDmg = SetEffectSpellId(eDmg,nSpellId);
			eDmg = SupernaturalEffect(eDmg);
					
			if (!bHasElegantStrike)
				SendMessageToPC(oPC,"Elegant Strike enabled.");			
			DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eDmg, oPC, HoursToSeconds(48)));			
		}
		else
		{
	    	RemoveSpellEffects(nSpellId, oPC, oPC);
			if (bHasElegantStrike)
				SendMessageToPC(oPC,"Elegant Strike disabled, you must wield a longsword, rapier, scimitar, or silver sword");			
		}		
}