//::///////////////////////////////////////////////
//:: Demoralize Opponent
//:: cmi_hx_demoppon
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 25, 2011
//:://////////////////////////////////////////////

#include "x2_i0_spells"
#include "cmi_ginc_chars"

void main()
{

    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
	
	

	
    //Declare major variables
	object oTarget = GetSpellTargetObject();
	
	float fDuration = HoursToSeconds(1);
	int nDC = d20(1) + GetSkillRank(SKILL_INTIMIDATE, OBJECT_SELF);

	if (GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY, OBJECT_SELF))	
		nDC += 1;
	if (GetHasFeat(FEAT_BG_ARCANE_SERVANT_DARKNESS,OBJECT_SELF))
		nDC += 1;
					
	int nPenalty = 2;
	effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nPenalty);
	effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, nPenalty);
    effect eAttack = EffectAttackDecrease(nPenalty);
    effect eDur  = EffectVisualEffect(VFX_DUR_SPELL_FEAR);    
	
	effect eLink = EffectLinkEffects(eSkill, eAttack);
	eLink = EffectLinkEffects(eLink,eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = SetEffectSpellId(eLink, SPELLABILITY_DEMORALIZE_OPPONENT);
	eLink = SupernaturalEffect(eLink);
	
	effect eImpactVis = EffectVisualEffect(VFX_HIT_WEAKEN_SPIRITS);

        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DEMORALIZE_OPPONENT)); 
			if ( GetAbilityScore(oTarget, ABILITY_INTELLIGENCE) > 3)
			{
				if ( (GetSubRace(oTarget) == RACIAL_SUBTYPE_CONSTRUCT) || (GetSubRace(oTarget) == RACIAL_SUBTYPE_UNDEAD) )
				{
					SendMessageToPC(OBJECT_SELF, "Constructs and the undead may not be intimidated.");
				}
				else
				if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
				{
	    			RemoveEffectsFromSpell(oTarget, SPELLABILITY_DEMORALIZE_OPPONENT);		
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactVis, oTarget));
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
				}
			}
			else
				SendMessageToPC(OBJECT_SELF, "The target lacks the intelligence to be intimidated.");
        }
}