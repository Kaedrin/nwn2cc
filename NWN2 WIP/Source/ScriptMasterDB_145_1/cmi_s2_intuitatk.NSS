//::///////////////////////////////////////////////
//:: Intuitive Attack
//:: cmi_s2_intuitatk
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 11, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
		object oPC = OBJECT_SELF;
		int nSpellId = SPELLABILITY_INTUITIVE_ATTACK;
		int nIntuiteAttackValid = IsIntuitiveAttackValid();
		int bHasIntuitiveAttack = GetHasSpellEffect(nSpellId,oPC);
		
		if (nIntuiteAttackValid)
		{
			RemoveSpellEffects(nSpellId, oPC, oPC);		
			
			int nBoost = 0;
			int nStr = GetAbilityModifier(ABILITY_STRENGTH);
			int nWis = GetAbilityModifier(ABILITY_WISDOM);
			
			if (GetHasFeat(FEAT_WEAPON_FINESSE, oPC)) //Weapon Finesse
			{
				int nDex = GetAbilityModifier(ABILITY_DEXTERITY);
				if (nDex > nStr)
				{
					nBoost = nWis - nDex;
				}
				else
				{
					nBoost = nWis - nStr;
				}			
			}
			else
			{
				nBoost = nWis - nStr;
			}
			if (GetHasFeat(FEAT_ZEN_ARCHERY, oPC))
			{
			    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
				if	(GetIsObjectValid(oWeapon) && GetWeaponRanged(oWeapon))
				{
					SendMessageToPC(oPC,"Intuitive Attack does not stack with Zen Archery.");
					return;
				}
			}
			
			if (!(nBoost > 0))
				return; //No bonus
				
			int nCap = GetLocalInt(GetModule(), "CapIntuitiveIfNotPureMonk");
			if (nCap > 0)
			{
				if ( (nBoost > nCap) && (GetHitDice(oPC) != GetLevelByClass(CLASS_TYPE_MONK, oPC)) )
					nBoost = nCap;
			}
							
			//Return Codes
			//0 FALSE
			//1 Character Bonus
			//2 Mainhand Only
			//3 Offhand Only	
			if (nIntuiteAttackValid == 1)
			{
			
				effect eAB = EffectAttackIncrease(nBoost);
				eAB = SetEffectSpellId(eAB,nSpellId);
				eAB = SupernaturalEffect(eAB);
						
				if (!bHasIntuitiveAttack)
					SendMessageToPC(oPC,"Intuitive Attack enabled.");			
				DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(48)));			
			}
			else 
			if (nIntuiteAttackValid == 2)
			{
				if (!bHasIntuitiveAttack)
					SendMessageToPC(oPC,"Intuitive Attack enabled.");				
				object oMain = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
				itemproperty ipAB = ItemPropertyAttackBonus(nBoost);
				IPSafeAddItemProperty(oMain, ipAB, HoursToSeconds(48),X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,FALSE,FALSE);
			}
			else //3
			{
				if (!bHasIntuitiveAttack)
					SendMessageToPC(oPC,"Intuitive Attack enabled.");				
				object oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
				itemproperty ipAB = ItemPropertyAttackBonus(nBoost);
				IPSafeAddItemProperty(oOffhand, ipAB, HoursToSeconds(48),X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,FALSE,FALSE);
			}			
		}
		else
		{
	    	RemoveSpellEffects(nSpellId, oPC, oPC);
			if (bHasIntuitiveAttack)
				SendMessageToPC(oPC,"Intuitive Attack disabled, you must wield a simple or natural weapon.");			
		}		
}