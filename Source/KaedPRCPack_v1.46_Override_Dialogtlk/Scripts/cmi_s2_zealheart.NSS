//::///////////////////////////////////////////////
//:: Blessing of Bahumut
//:: cmi_s0_blessbahumut
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 28, 2007
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
	 	
	effect eZealHeart = EffectImmunity(IMMUNITY_TYPE_FEAR);
	eZealHeart = SupernaturalEffect(eZealHeart);	
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eZealHeart, OBJECT_SELF);
	
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_HOLY); 	
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);	
	
}      