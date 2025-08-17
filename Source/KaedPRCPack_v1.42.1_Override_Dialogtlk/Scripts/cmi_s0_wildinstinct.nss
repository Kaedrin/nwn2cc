//::///////////////////////////////////////////////
//:: Wild Instinct
//:: cmi_s0_wildinstinct
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 27, 2007
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
	
    int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
		
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_UNCANNYDODGE1); // Uncanny Dodge	
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);		
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );	
	}
		
	effect eSkillListen = EffectSkillIncrease(SKILL_LISTEN,10);
	effect eSkillSpot = EffectSkillIncrease(SKILL_SPOT,10);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
 		
	effect eLink = EffectLinkEffects(eSkillListen, eSkillSpot);
	eLink = EffectLinkEffects(eLink, eVis);	
		
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
}      