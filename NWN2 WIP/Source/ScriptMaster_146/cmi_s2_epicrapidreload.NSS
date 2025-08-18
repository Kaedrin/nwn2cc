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
	
	int nSpellId = SPELLABILITY_EPIC_RAPID_RELOAD;
	int bHasEpicRapidReload = GetHasSpellEffect(nSpellId,OBJECT_SELF);				
	RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);	
	
	int bXbowValid = isXbowValid();
	if (bXbowValid)
	{		
	
		int nBonus = 1;
		if (GetHasFeat(FEAT_CROSSBOW_MASTERY))
			nBonus = 2;	
				
		if (!bHasEpicRapidReload)	
			SendMessageToPC(OBJECT_SELF,"Epic Rapid Reload enabled.");
			
		effect eAttacks = SupernaturalEffect(EffectModifyAttacks(nBonus));				
		eAttacks = SetEffectSpellId(eAttacks,nSpellId);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eAttacks, OBJECT_SELF, HoursToSeconds(24)));							
	}
	else
	{
		if (bHasEpicRapidReload)
			SendMessageToPC(OBJECT_SELF,"Epic Rapid Reload disabled, it is only valid when wielding a light or heavy crossbow.");			
	}		
}      