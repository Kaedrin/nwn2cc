//::///////////////////////////////////////////////
//:: Heartfire
//:: cmi_s0_heartfire
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 19, 2007
//:: NOTE: This needs to be revised with a custom DoT
//:: 	that accounts for half damage Fortitude Saves
//:://////////////////////////////////////////////

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
	
	effect eVis = EffectVisualEffect(VFXSC_DUR_FAERYAURA_RED);
	effect eConcealNegated = EffectConcealmentNegated();
	effect eDoT = EffectDamageOverTime(d4(1),5.5f);
	effect eDoT_half = EffectDamageOverTime(d2(1),5.5f);	
	effect eLink = EffectLinkEffects(eVis,eConcealNegated);
	effect eListen = EffectSkillDecrease(SKILL_LISTEN, 10);	
	effect eHide;

	eLink = EffectLinkEffects(eLink,eListen);		
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);


    object oAreaTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget));
    while(GetIsObjectValid(oAreaTarget))
    {
        if (spellsIsTarget(oAreaTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
			if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
			{
			
                if(!MySavingThrow(SAVING_THROW_FORT, oAreaTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE)) //, OBJECT_SELF, 3.0))
				{
					eLink = EffectLinkEffects(eLink,eDoT);
				}
				else
					eLink = EffectLinkEffects(eLink,eDoT_half);
								
			    RemoveEffectsFromSpell(oTarget, GetSpellId());	
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
				DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));	
				
				eHide = EffectSkillDecrease(SKILL_HIDE, GetSkillRank(SKILL_HIDE, oTarget));
				DelayCommand(0.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oTarget, fDuration));	
			}		
		}
	    oAreaTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget));	
	}	
			

	
}