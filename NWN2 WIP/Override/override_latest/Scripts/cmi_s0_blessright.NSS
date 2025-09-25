//::///////////////////////////////////////////////
//:: Blessing of the Righteous
//:: cmi_s0_blessright
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 1, 2007
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
	
	float fDuration = RoundsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);	

	effect eDmgBonus = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_DIVINE);	
	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );
	effect eLink = EffectLinkEffects(eDmgBonus,eVis);
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
			
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			/*
			object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);		
		   	if(GetIsObjectValid(oWeapon) )
			{
		     
				IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
				IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
			   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oWeapon), fDuration);
		    }
			object oWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);		
		   	if(GetIsObjectValid(oWeapon2) )
			{
		     
				IPSafeAddItemProperty(oWeapon2, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
				IPSafeAddItemProperty(oWeapon2, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
			   	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oWeapon2), fDuration);
		    }
			*/			
			
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
			
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, GetLocation(OBJECT_SELF));
    }	
		
}      