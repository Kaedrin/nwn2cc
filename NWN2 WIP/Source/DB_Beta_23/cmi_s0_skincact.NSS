//::///////////////////////////////////////////////
//:: Skin of the Cactus
//:: cmi_s0_skincact
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
	int nSpellId = GetSpellId();  
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl ) * 10;
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	int nBonus = 3;
	nBonus += (nCasterLvl - 7) / 3;
	if (nBonus > 5)
		nBonus = 5;	
			
	effect eAC = EffectACIncrease(nBonus, AC_NATURAL_BONUS);
	effect eDS = EffectDamageShield(0, DAMAGE_BONUS_1d6, DAMAGE_TYPE_PIERCING);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
	effect eLink = EffectLinkEffects(eAC, eDS);
	eLink = EffectLinkEffects(eLink, eVis);	
			
    RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
	
}      