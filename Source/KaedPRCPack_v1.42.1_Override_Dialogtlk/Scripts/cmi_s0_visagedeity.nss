//::///////////////////////////////////////////////
//:: Visage of the Deity
//:: cmi_s0_visagedeity
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 25, 2007
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
	
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	
	
	effect eDR = EffectDamageReduction(10,DR_TYPE_GMATERIAL,0,GMATERIAL_METAL_ADAMANTINE);
	effect eSR = EffectSpellResistanceIncrease(20);
	effect eDarkVision = EffectDarkVision();
	effect eDamResistAcid = EffectDamageResistance(DAMAGE_TYPE_ACID,20);
	effect eDamResistCold = EffectDamageResistance(DAMAGE_TYPE_COLD,20);
	effect eDamResistElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,20);
	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	effect eLink = EffectLinkEffects(eDamResistAcid, eDamResistCold);
	
	eLink = EffectLinkEffects(eLink, eDamResistElec);
	eLink = EffectLinkEffects(eLink, eDR);
	eLink = EffectLinkEffects(eLink, eSR);
	eLink = EffectLinkEffects(eLink, eDarkVision);		
	eLink = EffectLinkEffects(eLink, eVis);		
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(810);	//Darkvision
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