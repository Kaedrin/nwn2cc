//::///////////////////////////////////////////////
//:: Primal Senses
//:: cmi_s0_primalsense
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
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
	int nSpellId = GetSpellId(); 
			
	float fDuration = HoursToSeconds(24);
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	effect eSkill1 = EffectSkillIncrease(SKILL_SPOT, 5);
	effect eSkill2 = EffectSkillIncrease(SKILL_LISTEN, 5);	
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );		
	effect eLink = EffectLinkEffects(eSkill1, eSkill2);	
	eLink = EffectLinkEffects(eLink, eVis);
		
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);		  	
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_LOWLIGHTVISION);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
		DelayCommand(0.1, AssignCommand(oTarget, ActionEquipItem(oArmorNew, INVENTORY_SLOT_CARMOUR)));
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
	}	
}      