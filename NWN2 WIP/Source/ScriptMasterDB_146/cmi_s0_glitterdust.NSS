//::///////////////////////////////////////////////
//:: Glitterdust
//:: cmi_s0_glitterdust
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Feb 20, 2012
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
	effect eHide = EffectSkillDecrease(SKILL_HIDE, 40);	
	effect eLink = EffectLinkEffects(eVis,eConcealNegated);
	eLink = EffectLinkEffects(eLink,eHide);
	int nSpellId = GetSpellId();
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    effect eBlind =  EffectBlindness();		
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration); //Keep the minutes per CL

	int nDC = GetSpellSaveDC();
	
    object oAreaTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocation);
    while(GetIsObjectValid(oAreaTarget))
    {
        if (spellsIsTarget(oAreaTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			if (oAreaTarget != OBJECT_SELF)
			{
			            if (!MySavingThrow(SAVING_THROW_WILL, oAreaTarget, nDC))
							DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oAreaTarget, fDuration));
			
					    DelayCommand(0.1f, RemoveEffectsFromSpell(oAreaTarget,nSpellId));	
						DelayCommand(0.15f, RemoveEffectsFromSpell(oAreaTarget, SPELL_INVISIBILITY));
						DelayCommand(0.2f, RemoveEffectsFromSpell(oAreaTarget, SPELL_GREATER_INVISIBILITY));	
						DelayCommand(0.25f, RemoveEffectsFromSpell(oAreaTarget, SPELL_I_WALK_UNSEEN));		
						DelayCommand(0.3f, RemoveEffectsFromSpell(oAreaTarget, SPELL_I_RETRIBUTIVE_INVISIBILITY));	
						DelayCommand(0.35f, RemoveEffectsFromSpell(oAreaTarget, SPELL_INVISIBILITY_SPHERE));																							
						SignalEvent(oAreaTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oAreaTarget, fDuration));									
			}
		}
	    oAreaTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocation);	
	}	
	
}