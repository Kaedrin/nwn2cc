//::///////////////////////////////////////////////
//:: Blessing of Bahamut
//:: cmi_s0_blessbahamut
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 28, 2007
//:: Based on X2_S0_HolySwrd
//:://////////////////////////////////////////////


#include "x2_inc_toollib"

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
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);

    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_HOLY_SWORD);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration);

		IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,5), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );//Make the sword glow	
   
        TLVFXPillar(VFX_IMP_GOOD_HELP, GetLocation(GetSpellTargetObject()), 4, 0.0f, 6.0f);
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_SUNSTRIKE ),GetLocation(GetSpellTargetObject())));

        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}