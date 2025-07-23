////////////////////////////////////////////////////////////////////////////////
// gui_dmfi_batui - DM Friendly Initiative - GUI script for DMFI Battle UI
// Original Scripter:  Demetrious      Design: DMFI Design Team
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           1/27/7
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

// YEA - This simple script took far too long to get working!!

#include "dmfi_inc_sendtex"
#include "dmfi_inc_tool"
#include "hv_npc_modify_inc"

void main(string sInput)
{
	int n, nStr, nDex, nCon, nDR, nSR, nAC;
	int nDexEffect, nConEffect, nStrEffect, nDREffect, nSREffect, nACEffect;
	string sMess;
	effect eEffect, eStrEffect, eDexEffect, eConEffect, eDREffect, eSREffect, eACEffect;
	object oTool = DMFI_GetTool(OBJECT_SELF);
	object oSpeaker = DMFI_UITarget(OBJECT_SELF, oTool);
	object oTarget = GetLocalObject(oTool, DMFI_TARGET);
	
	// Fire up NPC Modification Tool
	if (FindSubString(sInput, "NPCModify") != -1) {
		DisplayGuiScreen(OBJECT_SELF, "hv_npc_modify", FALSE, "dmfimngtool.xml");
		InitializeUIPanel(OBJECT_SELF);
		return;
	}
		
	
	// Add 50 HP
	if (FindSubString(sInput, "HPinc") != -1) {
		
		// Get current HP Bonus
		int nHPBonus = GetLocalInt(oTarget, "hv_hp_bonus");
		
		// Add 50 to it
		nHPBonus += 50;
		
		// Create new effect
		effect eHPBonus = SupernaturalEffect(EffectBonusHitpoints(50));
		
		// Apply new effect
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHPBonus, oTarget);
		
		// Heal 50 points to complete bonus
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(50), oTarget);
		
		// Store new value
		SetLocalInt(oTarget, "hv_hp_bonus", nHPBonus);
		
		// Announce new value
		SendMessageToPC(oSpeaker, "<C=lightgreen>Bonus HP: " + IntToString(nHPBonus));
		return;
	}
	
	// Deal 50 damage (without killing)
	if (FindSubString(sInput, "HPdec") != -1) {
	
		// Make sure we're not killing the target
		if (GetCurrentHitPoints(oTarget) <= 50) {
			
			SendMessageToPC(oSpeaker, "<C=lightgreen>Target has less than 50 HP.");
			return;
		}
		
		// Do damange
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(50, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE) , oTarget);
		
		return;
	}
		
	nStr = GetAbilityScore(oTarget, ABILITY_STRENGTH);
	nDex = GetAbilityScore(oTarget, ABILITY_DEXTERITY);
	nCon = GetAbilityScore(oTarget, ABILITY_CONSTITUTION);
	
	nSR = GetSpellResistance(oTarget);
	
	nStrEffect = GetLocalInt(oTarget, DMFI_STR_EFFECT);
	nDexEffect = GetLocalInt(oTarget, DMFI_DEX_EFFECT);
	nConEffect = GetLocalInt(oTarget, DMFI_CON_EFFECT);
	nSREffect = GetLocalInt(oTarget, DMFI_SR_EFFECT);
	nACEffect = GetLocalInt(oTarget, "hv_ac_effect");
	
	eEffect = GetFirstEffect(oTarget);
	while (GetIsEffectValid(eEffect))
	{
		if ((GetEffectType(eEffect)==EFFECT_TYPE_ABILITY_INCREASE) || (GetEffectType(eEffect)==EFFECT_TYPE_ABILITY_DECREASE) || (GetEffectType(eEffect)==EFFECT_TYPE_SPELL_RESISTANCE_DECREASE) || (GetEffectType(eEffect)==EFFECT_TYPE_SPELL_RESISTANCE_INCREASE) || (GetEffectType(eEffect)==EFFECT_TYPE_AC_INCREASE) || (GetEffectType(eEffect)==EFFECT_TYPE_AC_DECREASE))
			RemoveEffect(oTarget, eEffect);
		eEffect = GetNextEffect(oTarget);
	}			
			
 	if (FindSubString(sInput, "R_")!=-1)		n=-4;
	else 										n=-1;
				
	if (FindSubString(sInput, "inc")!=-1)		n=abs(n);
				
	if (FindSubString(sInput, "STR")!=-1)		nStrEffect = nStrEffect + n;
	else if (FindSubString(sInput, "DEX")!=-1)	nDexEffect = nDexEffect + n;
	else if (FindSubString(sInput, "CON")!=-1)	nConEffect = nConEffect + n;
	else if (FindSubString(sInput, "AC") != -1) nACEffect += n;
	else 
	  nSREffect = nSREffect +5*n;
	
	// code for engine caps
	if (nStrEffect>12) nStrEffect=12;
	if (nDexEffect>12) nDexEffect=12;
	if (nConEffect>12) nConEffect=12;
	if (nSREffect>50) nSREffect=50;
	if (nStrEffect<-12) nStrEffect=-12;
	if (nDexEffect<-12) nDexEffect=-12;
	if (nConEffect<-12) nConEffect=-12;	
	if (nSREffect<-50) nSREffect=-50;	
	if (nACEffect > 20) nACEffect = 20;
	if (nACEffect < -20) nACEffect = -20;
		
	if (nStrEffect>0)			eStrEffect = EffectAbilityIncrease(ABILITY_STRENGTH, nStrEffect);
	else 						eStrEffect = EffectAbilityDecrease(ABILITY_STRENGTH, -nStrEffect);
		
	if (nDexEffect>0)			eDexEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, nDexEffect);
	else 						eDexEffect = EffectAbilityDecrease(ABILITY_DEXTERITY, -nDexEffect);	
		
	if (nConEffect>0)			eConEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, nConEffect);
	else 						eConEffect = EffectAbilityDecrease(ABILITY_CONSTITUTION, -nConEffect);			

	if (nSREffect>0)			eSREffect = EffectSpellResistanceIncrease(nSREffect);
	else 						eSREffect = EffectSpellResistanceDecrease(-nSREffect);			
	
	if (nACEffect > 0)			eACEffect = SupernaturalEffect(EffectACIncrease(nACEffect));
	else						eACEffect = SupernaturalEffect(EffectACDecrease(-nACEffect)); 

	SetLocalInt(oTarget, DMFI_STR_EFFECT, nStrEffect);
	SetLocalInt(oTarget, DMFI_DEX_EFFECT, nDexEffect);
	SetLocalInt(oTarget, DMFI_CON_EFFECT, nConEffect);
	SetLocalInt(oTarget, DMFI_SR_EFFECT, nSREffect);
	SetLocalInt(oTarget, "hv_ac_effect", nACEffect);
		
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStrEffect, oTarget);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDexEffect, oTarget);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConEffect, oTarget);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSREffect, oTarget);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eACEffect, oTarget);
	
	if (GetIsPC(oTarget))
		SendText(oSpeaker,TXT_IS_A_PC + GetName(oTarget),FALSE,COLOR_BLUE);
	SendText(oSpeaker, TXT_BATTLE_STR + IntToString(nStrEffect) + TXT_BATTLE_DEX + IntToString(nDexEffect) + TXT_BATTLE_CON + IntToString(nConEffect) + TXT_BATTLE_SR + IntToString(nSREffect));
	SendMessageToPC(oSpeaker, "<C=lightgreen>Modified AC: " + IntToString(nACEffect));
		
}	
	
	
	
	
	
	
	