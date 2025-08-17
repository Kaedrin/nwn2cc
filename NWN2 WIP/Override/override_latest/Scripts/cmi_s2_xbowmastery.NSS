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
	
	int nSpellId = SPELLABILITY_CROSSBOW_MASTERY;
	int bHasXbowMastery = GetHasSpellEffect(nSpellId,OBJECT_SELF);				
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	
	if (GetHasFeat(FEAT_EPIC_RAPID_RELOAD))
		return; // Epic Rapid will acount for this
	
	int bXbowValid = isXbowValid();
	if (bXbowValid)
	{		
				
		if (!bHasXbowMastery)	
			SendMessageToPC(OBJECT_SELF,"Crossbow Mastery enabled.");
			
			
		effect eAttacks = SupernaturalEffect(EffectModifyAttacks(1));				
		eAttacks = SetEffectSpellId(eAttacks,nSpellId);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eAttacks, OBJECT_SELF, HoursToSeconds(24)));							
	}
	else
	{
		if (bXbowValid)
			SendMessageToPC(OBJECT_SELF,"Crossbow Mastery disabled, it is only valid when wielding a light or heavy crossbow.");			
	}		
}      