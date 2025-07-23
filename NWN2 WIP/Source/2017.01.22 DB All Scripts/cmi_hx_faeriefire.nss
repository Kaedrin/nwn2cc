//::///////////////////////////////////////////////
//:: Faerie Fire
//:: cmi_hx_faeriefire
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
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
    eLink = SetEffectSpellId(eLink, SPELL_Faerie_Fire);
	eLink = SupernaturalEffect(eLink);
		
	int nCasterLvl = GetHexbladeCasterLevel();
	int nFeat = FALSE;
			
	float fDuration = TurnsToSeconds( nCasterLvl );
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }		
	
	float fDurationPC = RoundsToSeconds(nCasterLvl); //1 Rd/CL for pvp
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
					eHide = EffectSkillDecrease(SKILL_HIDE, GetSkillRank(SKILL_HIDE, oAreaTarget));
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oAreaTarget, fDuration));	
				
					RemoveEffectsFromSpell(oAreaTarget, SPELL_Faerie_Fire);	
					SignalEvent(oAreaTarget, EventSpellCastAt(OBJECT_SELF, SPELL_Faerie_Fire, TRUE));
					DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oAreaTarget, fCurrentDuration));				
			}
		}
	    oAreaTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lLocation);	
	}	
	
}