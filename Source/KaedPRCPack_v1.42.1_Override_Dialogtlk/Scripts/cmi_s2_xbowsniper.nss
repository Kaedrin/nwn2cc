//::///////////////////////////////////////////////
//:: Crossbow Sniper
//:: cmi_s2_xbowsniper
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Feb 11, 2008
//:://////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Bladesong Style
//:: cmi_s2_bladesong
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 19, 2008
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }	
	
	int nSpellId = SPELLABILITY_Crossbow_Sniper;
	int bHasXbowSniper = GetHasSpellEffect(nSpellId,OBJECT_SELF);				
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	
	int bXbowSniperValid = IsXbowSniperValid();
	if (bXbowSniperValid)
	{		
	
		int nBonus = 0;
		nBonus = GetDamageBonusByValue(GetAbilityModifier(ABILITY_DEXTERITY,OBJECT_SELF));
		
		if (GetLocalInt(GetModule(), "CrossbowSniper50PercentDexCap"))
			nBonus = nBonus/2;
		
		if (nBonus == 0)
			return;
				
		if (!bHasXbowSniper)	
			SendMessageToPC(OBJECT_SELF,"Crossbow Sniper enabled.");
			
		effect eDam = SupernaturalEffect(EffectDamageIncrease(nBonus,DAMAGE_TYPE_PIERCING));				
		eDam = SetEffectSpellId(eDam,nSpellId);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eDam, OBJECT_SELF, HoursToSeconds(24)));							
	}
	else
	{
		if (bHasXbowSniper)
			SendMessageToPC(OBJECT_SELF,"Crossbow Sniper disabled, it is only valid when wielding a light or heavy crossbow which you have the weapon focus feat with.");			
	}		
}      