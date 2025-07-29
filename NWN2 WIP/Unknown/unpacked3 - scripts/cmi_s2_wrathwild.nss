//::///////////////////////////////////////////////
//:: Wrath of the Wild
//:: cmi_s2_wrathwild
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 23, 2008
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nSpellId = SPELLABILITY_CHAMPWILD_WRATH_WILD;	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		return;
		//RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nDuration = GetAbilityModifier(ABILITY_CHARISMA) + 4;
	if (nDuration < 1)
		nDuration = 1;
		
	float fDuration = RoundsToSeconds( nDuration );

	
    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();	
	int nItemVisual = ITEM_VISUAL_HOLY;				
	
    if(GetIsObjectValid(oMyWeapon) )
    {
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);//Make the sword glow	
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_HOLY_AID ),GetLocation(GetSpellTargetObject())));
    }
    else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
    }
	
	effect eAB = EffectAttackIncrease(2);
	effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_DIVINE);
	effect eLink = EffectLinkEffects(eAB, eDmg);	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
	
}