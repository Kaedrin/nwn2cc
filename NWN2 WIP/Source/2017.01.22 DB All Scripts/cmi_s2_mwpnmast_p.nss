//::///////////////////////////////////////////////
//:: Melee Weapon Mastery (Piercing)
//:: cmi_s2_mwpnmast_p
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
		int nSpellId = SPELLABILITY_MELEE_WEAPON_MASTERY_P;
		int nMWM_PValid = IsMWM_PValid();
		int bHasMWM_P = GetHasSpellEffect(nSpellId,oPC);
		
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_P,oPC))
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_P, oPC, oPC);
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_B,oPC))			
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_B, oPC, oPC);
		if (GetHasSpellEffect(SPELLABILITY_MELEE_WEAPON_MASTERY_S,oPC))		
			RemoveSpellEffects(SPELLABILITY_MELEE_WEAPON_MASTERY_S, oPC, oPC);			
		
		if (nMWM_PValid)
		{	
				effect eAB = EffectAttackIncrease(2);
				effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_PIERCING);
				effect eLink = EffectLinkEffects(eAB, eDmg);
				eLink = SetEffectSpellId(eLink,nSpellId);
				eLink = SupernaturalEffect(eLink);
				if (!bHasMWM_P)
					SendMessageToPC(oPC,"Melee weapon mastery bonus enabled.");			
				DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));																		
			
		}
		else
		{
			if (bHasMWM_P)
			{
				SendMessageToPC(oPC,"Melee weapon mastery bonus disabled, you must wield the correct weapon type in your main hand.");			
			}
		}		
}