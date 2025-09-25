//::///////////////////////////////////////////////
//:: Faerie Fire
//:: cmi_s0_faeriefire
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 19, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

  	//object oTarget = GetSpellTargetObject();
	location lLocation = GetSpellTargetLocation();
	
	int nColor = d3();
	effect eVis = EffectVisualEffect(1200 + nColor);
	effect eConcealNegated = EffectConcealmentNegated();
	effect eHide;
	effect eLink = EffectLinkEffects(eVis,eConcealNegated);
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	int nFeat = FALSE;
	
	if (GetSpellId() == SPELLABILITY_RACIAL_FAERIE_FIRE)
	{
		nCasterLvl = GetHitDice(OBJECT_SELF);
		nFeat = TRUE;
	}
		
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration); //Keep the minutes per CL
	float fDurationPC = ApplyMetamagicDurationMods(RoundsToSeconds(nCasterLvl)); //1 Rd/CL for pvp
	float fCurrentDuration;
	
    object oAreaTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lLocation);
    while(GetIsObjectValid(oAreaTarget))
    {
        if (spellsIsTarget(oAreaTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			if (oAreaTarget != OBJECT_SELF)
			{
				if (GetIsPC(oAreaTarget))
					fCurrentDuration = fDurationPC;
				else
					fCurrentDuration = fDuration;
				if (nFeat)
				{
					if(cmi_FeatResistSpell(OBJECT_SELF, oAreaTarget, 1) == 0)
					{
					    RemoveEffectsFromSpell(oAreaTarget, GetSpellId());	
						SignalEvent(oAreaTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oAreaTarget, fCurrentDuration));	
						eHide = EffectSkillDecrease(SKILL_HIDE, GetSkillRank(SKILL_HIDE, oAreaTarget));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oAreaTarget, fDuration));	
					}					
				}
				else
				{
					if(MyResistSpell(OBJECT_SELF, oAreaTarget) == 0)
					{
					    RemoveEffectsFromSpell(oAreaTarget, GetSpellId());	
						SignalEvent(oAreaTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oAreaTarget, fCurrentDuration));	
						eHide = EffectSkillDecrease(SKILL_HIDE, GetSkillRank(SKILL_HIDE, oAreaTarget));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oAreaTarget, fDuration));						
					}					
				}
			}
		}
	    oAreaTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lLocation);	
	}	
	
}