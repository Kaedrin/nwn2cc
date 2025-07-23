//::///////////////////////////////////////////////
//:: Nixie's Grace
//:: cmi_s0_nixiegrce
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 8, 2007
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
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	
	float fDuration = 10 * TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eChaBonus = EffectAbilityIncrease(ABILITY_CHARISMA, 8);
	effect eDexBonus = EffectAbilityIncrease(ABILITY_DEXTERITY, 6);
	effect eWisBonus = EffectAbilityIncrease(ABILITY_WISDOM, 2);
	effect eDR = EffectDamageReduction(5, GMATERIAL_METAL_COLD_IRON, 0, DR_TYPE_GMATERIAL);
	//effect eVision = EffectLowLightVision();
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	
	effect eLink = EffectLinkEffects(eWisBonus, eDexBonus);
	eLink = EffectLinkEffects(eLink, eChaBonus);
	//eLink = EffectLinkEffects(eLink, eVision);
	eLink = EffectLinkEffects(eLink, eVis);	
	eLink = EffectLinkEffects(eLink, eDR);	
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_LOWLIGHTVISION);	
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);	
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);		
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);			
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
	}		
		
}  