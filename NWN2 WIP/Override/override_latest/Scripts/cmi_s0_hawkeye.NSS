//::///////////////////////////////////////////////
//:: Hawkeye
//:: cmi_s0_hawkeye
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
		
	object oTarget = GetSpellTargetObject(); 
	
	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
	if (GetIsObjectValid(oWeapon) && GetWeaponRanged(oWeapon))
	{
		int nSpellId = GetSpellId(); 
			
		int nCasterLvl = GetPalRngCasterLevel();
		float fDuration = TurnsToSeconds( nCasterLvl ) * 10;
		fDuration = ApplyMetamagicDurationMods(fDuration);
		
		effect eSkill = EffectSkillIncrease(SKILL_SPOT, 5);
		effect eAB = EffectAttackIncrease(1);
		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);			
		effect eLink = EffectLinkEffects(eSkill, eAB);
		eLink = EffectLinkEffects(eLink, eVis);	
		
	    RemoveEffectsFromSpell(oTarget, nSpellId);	
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  
	} 	
	else
		SendMessageToPC(OBJECT_SELF, "You must use a ranged weapon for this spell to work");
	
	
}      