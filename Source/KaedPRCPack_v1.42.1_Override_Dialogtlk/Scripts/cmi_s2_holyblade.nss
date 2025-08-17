//::///////////////////////////////////////////////
//:: Sacred Flame
//:: cmi_s2_sacredflame
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 3, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
	
	int nDur = GetLevelByClass(CLASS_SHINING_BLADE, OBJECT_SELF);
	
	if (nDur > 8)
	{
		effect eAB = EffectAttackIncrease(2);
		eVis = EffectLinkEffects(eVis, eAB);
	}
		
	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	nDur = nDur + nCha;
	
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
		
   	if(GetIsObjectValid(oMyWeapon) )
	{
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6), RoundsToSeconds(nDur),X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
	   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), RoundsToSeconds(nDur));
	   	DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SB_HOLY_BLADE1);
		DecrementRemainingFeatUses(OBJECT_SELF,FEAT_SB_SHOCK_BLADE1);
		return;
    }
    else
    {
    	FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    	return;
    }

	
}      