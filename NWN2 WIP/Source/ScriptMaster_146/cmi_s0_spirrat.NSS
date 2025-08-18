//::///////////////////////////////////////////////
//:: Spirit of the Rat
//:: cmi_s0_spirrat
//:: Purpose:
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
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
	
	    effect ePoly = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(ePoly))
        {
            //If the effect was created by the spell then remove it
            if(GetEffectType(ePoly) == EFFECT_TYPE_POLYMORPH)
            {
				SendMessageToPC(OBJECT_SELF, "You are may not use this spell while wildshaped or under any kind of polymorph effect.");
				return;
            }
			else       //Get next effect on the target
            	ePoly = GetNextEffect(OBJECT_SELF);
        }	
		
	int nSpellId = SPELL_SPIRIT_BEAR;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	

	effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 6);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
	effect eAC = EffectACIncrease(3, AC_NATURAL_BONUS);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_PREMONITION );		
		
	effect eLink = EffectLinkEffects(eDex, eCon);
	eLink = EffectLinkEffects(eLink, eAC);
	eLink = EffectLinkEffects(eLink, eVis);	
	eLink = SetEffectSpellId(eLink, nSpellId);
		
	itemproperty iBonusFeat1 = ItemPropertyBonusFeat(19); //Weapon Finesse
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat1,oArmorNew,fDuration);		
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat1, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
	}
	
	RemoveEffectsFromSpell(OBJECT_SELF, nSpellId);	
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);		  	
	if ( GetCurrentHitPoints(OBJECT_SELF) > GetMaxHitPoints(OBJECT_SELF))
	{	
		effect eHeal = EffectHeal(1);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);	
	}
}