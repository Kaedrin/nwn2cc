//::///////////////////////////////////////////////
//:: Favor of the Martyr
//:: cmi_s0_favormartyr
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////


#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "cmi_ginc_spells"


void main()
{
    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	effect eCharm = EffectImmunity(IMMUNITY_TYPE_CHARM);
	effect eDom = EffectImmunity(IMMUNITY_TYPE_DOMINATE);	
	effect eDaze = EffectImmunity(IMMUNITY_TYPE_CHARM);
	effect eStun = EffectImmunity(IMMUNITY_TYPE_STUN);
	effect eFati = EffectSpellImmunity(FATIGUE);			
	effect eExh = EffectSpellImmunity(EXHAUSTED);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );
		
	effect eLink = EffectLinkEffects(eCharm, eDom);
	eLink = EffectLinkEffects(eLink, eDaze);
	eLink = EffectLinkEffects(eLink, eStun);
	eLink = EffectLinkEffects(eLink, eFati);
	eLink = EffectLinkEffects(eLink, eExh);			
	eLink = EffectLinkEffects(eLink, eVis);
				
    int nCasterLvl = GetPalRngCasterLevel();
	object oTarget = GetSpellTargetObject();
	int nSpellId = GetSpellId(); 
			
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(92);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", oTarget, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
		DelayCommand(0.1, AssignCommand(oTarget, ActionEquipItem(oArmorNew, INVENTORY_SLOT_CARMOUR)));
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
	}
	
	RemoveEffectsFromSpell(oTarget, nSpellId);	
	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));	
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

}