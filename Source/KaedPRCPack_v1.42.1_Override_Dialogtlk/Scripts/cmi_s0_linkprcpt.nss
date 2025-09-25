//::///////////////////////////////////////////////
//:: Blessed Aim
//:: cmi_s0_blessedaim
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 28, 2007
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
    	
	int nBonus;
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
  			nBonus++;			
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }		
	nBonus = nBonus * 2;
	if (nBonus > 20) //Sanity check
		nBonus = 20;
	
	effect eSkill1 = EffectSkillIncrease(SKILL_SPOT, nBonus);
	effect eSkill2 = EffectSkillIncrease(SKILL_LISTEN, nBonus);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
	effect eLink = EffectLinkEffects(eSkill1, eSkill2);	
	eLink = EffectLinkEffects(eLink, eVis);
	
	int nSpellId = GetSpellId();
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	float fDelay;
	
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
			fDelay = GetRandomDelay(0.4, 1.1);
				
			RemoveEffectsFromSpell(oTarget, nSpellId);			
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,nSpellId, FALSE));
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));				
		
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }			
}      