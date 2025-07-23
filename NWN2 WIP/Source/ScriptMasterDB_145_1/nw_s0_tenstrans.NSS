//::///////////////////////////////////////////////
//:: Tensor's Transformation
//:: NW_S0_TensTrans.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster the following bonuses:
        +1 Attack per 2 levels
        +4 Natural AC
        20 STR and DEX and CON
        1d6 Bonus HP per level
        +5 on Fortitude Saves
        -10 Intelligence
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
//: Sep2002: losing hit-points won't get rid of the rest of the bonuses
// 10/2/06-BDF: modified STR and DEX bonuses from d2(4) to d4(2), as per description
// 10/18/16-BDF(OEI): restored most of original implementation now that polymorphing
//	to the Tenser's appearance type is supported for this spell again.
#include "x2_inc_spellhook"
#include "nw_i0_spells"

#include "cmi_ginc_spells"

void main()
{

  /*
    Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */

    if (!X2PreSpellCastCode())
    {
        return;
    }
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());	

	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);

	int nAB = GetHitDice(OBJECT_SELF) - GetBaseAttackBonus(OBJECT_SELF);
	if (nAB == 0)
		nAB = 1;
	
    //Declare effects
    effect eAttack = EffectAttackIncrease(nAB); 
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_FORT, 5);
	effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
	effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
	effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
	effect eAC = EffectACIncrease(4, AC_NATURAL_BONUS);
	effect eSF = EffectSpellFailure(100);
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_TENSERS_TRANSFORM );	
	
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);

    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eStr);
    eLink = EffectLinkEffects(eLink, eDex);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eSF);
    eLink = EffectLinkEffects(eLink, eDur);
					
	itemproperty iBonusFeat1 = ItemPropertyBonusFeat(22); //Martial
	itemproperty iBonusFeat2 = ItemPropertyBonusFeat(23); //Simple	
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat1,oArmorNew,fDuration);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat2,oArmorNew,fDuration);		
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat1, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
        IPSafeAddItemProperty(oArmorNew, iBonusFeat2, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING );			
	}
    ClearAllActions();		
	ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);	
	DelayCommand(fDuration, DestroyObject(oArmorNew, 2.0f, FALSE)); 
		
    //Signal Spell Event
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TENSERS_TRANSFORMATION, FALSE));
	
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);	
							
}