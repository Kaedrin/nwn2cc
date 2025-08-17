//::///////////////////////////////////////////////
//:: Mark of Justice
//:: cmi_s0_markjustice
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 25, 2007
//:://////////////////////////////////////////////
//Mark of Justice based on Bestow Curse by Obsidian/Bioware

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BESTOW_CURSE );//
	effect eCurse = EffectCurse(d6(),d6(),d6(),d6(),d6(),d6());
    eCurse = SupernaturalEffect(eCurse);

		effect eLink = EffectLinkEffects( eCurse, eVis );

	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
        SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BESTOW_CURSE));
         if (!MyResistSpell(OBJECT_SELF, oTarget))
         {
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
            }
        }
    }
}