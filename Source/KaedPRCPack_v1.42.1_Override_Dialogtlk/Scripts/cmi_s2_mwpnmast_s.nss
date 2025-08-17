//::///////////////////////////////////////////////
//:: Melee Weapon Mastery (Slashing)
//:: cmi_s2_mwpnmast_s
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
		object oPC = OBJECT_SELF;
		int nSpellId = SPELLABILITY_MELEE_WEAPON_MASTERY_S;
		int nMWM_SValid = IsMWM_SValid();
		int bHasMWM_S = GetHasSpellEffect(nSpellId,oPC);
		
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_P,oPC))
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_P, oPC, oPC);
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_B,oPC))			
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_B, oPC, oPC);
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_S,oPC))		
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_S, oPC, oPC);			

		if (nMWM_SValid)
		{		
			effect eAB = EffectAttackIncrease(2);
			effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_SLASHING);
			effect eLink = EffectLinkEffects(eAB, eDmg);
			eLink = SetEffectSpellId(eLink,nSpellId);
			eLink = SupernaturalEffect(eLink);
				
			if (!bHasMWM_S)
				SendMessageToPC(oPC,"Melee weapon mastery bonus enabled.");			
			DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));																		
			
		}
		else
		{
			if (bHasMWM_S)
			{
				SendMessageToPC(oPC,"Melee weapon mastery bonus disabled, you must wield the correct weapon type in your main hand.");			
			}
		}		
}