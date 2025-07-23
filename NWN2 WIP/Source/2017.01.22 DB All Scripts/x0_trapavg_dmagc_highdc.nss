//::///////////////////////////////////////////////////
//:: X0_TRAPAVG_DMAGC
//:: OnTriggered script for a projectile trap
//:: Spell fired: SPELL_DISPEL_MAGIC
//:: Spell caster level: 5
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/17/2002
//:: Edited by Bucephalus for higher dc
//::///////////////////////////////////////////////////

#include "x0_i0_projtrap"
#include "x0_i0_spells"
#include "x2_inc_spellhook"

#include "cmi_ginc_spells"

void main()

{
	object oPC = GetEnteringObject();

	if (!GetIsPC(oPC)) return;

	if (GetItemPossessedBy(oPC, "zhent")!=OBJECT_INVALID)
   		return;  

	//TriggerProjectileTrap(SPELL_GREATER_DISPELLING, GetEnteringObject(), 25);
	
	
	/*
	effect   eVis         = EffectVisualEffect( VFX_HIT_SPELL_ABJURATION );
	effect   eImpact; // Now handled by spells.2da, the ImpactSEF column, but effect required for spellsDispelMagic
    int      nCasterLevel = 25;
    object   oTarget      = oPC;;
    location lLocal   =     GetLocation(oPC);

	int nSpellId = SPELL_GREATER_DISPELLING;
	if (nSpellId == SPELL_I_CASTERS_LAMENT)
	{
	    effect eRemove = GetFirstEffect(oPC);
	    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
	    //Fire cast spell at event for the specified target
	    SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_REMOVE_CURSE, FALSE));
	    //Get the first effect on the target
	    while(GetIsEffectValid(eRemove))
	    {
	        //Check if the current effect is of correct type
	        if (GetEffectType(eRemove) == EFFECT_TYPE_CURSE)
	        {
	            //Remove the effect and apply VFX impact
	            RemoveEffect(oPC, eRemove);
	            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
	        }
	        //Get the next effect on the target
	        GetNextEffect(oPC);
	    }	
	}
	
	if (GetIsObjectValid(oTarget))
    {
        //----------------------------------------------------------------------
        // Targeted Dispel - Dispel all
        //----------------------------------------------------------------------
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact);
    }
	*/
	
}