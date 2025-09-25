//::///////////////////////////////////////////////
//:: Opportunistic Piety
//:: cmi_s2_opppiety
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 8, 2013
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "cmi_includes"
#include "cmi_inc_sneakattack"

void main()
{

    int nLevel = GetLevelByClass(CLASS_HEXBLADE);
	nLevel = nLevel * 2;
	
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
	effect eDam = EffectDamage(nLevel, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);	

	//Fire cast spell at event for the specified target
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

	IncrementRemainingFeatUses(OBJECT_SELF, FEAT_HEX_AURUNLCK_1);	
	IncrementRemainingFeatUses(OBJECT_SELF, FEAT_HEXCURSE_1);

}