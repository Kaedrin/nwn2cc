//::///////////////////////////////////////////////
//:: Anoint Weapon
//:: cmi_s2_anointwpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 23, 2008
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


	int nCasterLvl = GetLevelByClass(CLASS_ANOINTED_KNIGHT);
	//float fDuration = HoursToSeconds( nCasterLvl ) * 2;	
	float fDuration = RoundsToSeconds(4 * nCasterLvl);

    object oMyWeapon   =  IPGetTargetedOrEquippedWeapon();
	
	int nSpellId = GetSpellId();
	itemproperty ipAnointWpn;	
	int nItemVisual = ITEM_VISUAL_HOLY;
	
	int bUseItemProp = FALSE;
	effect eDmgIncrease;
	
	if (nSpellId == AKNIGHT_ANOINT_WEAPON || nSpellId == AKNIGHT_ANOINT_WEAPON_FLAMING)
	{
		nItemVisual = ITEM_VISUAL_FIRE;
		eDmgIncrease = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
		//ipAnointWpn = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d6);
		
	}
	else if (nSpellId == AKNIGHT_ANOINT_WEAPON_FROST)
	{
		nItemVisual = ITEM_VISUAL_COLD;	
		eDmgIncrease = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_COLD);
		//ipAnointWpn = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6);		
	}
	else if (nSpellId == AKNIGHT_ANOINT_WEAPON_SHOCK)
	{
		nItemVisual = ITEM_VISUAL_ELECTRICAL;
		eDmgIncrease = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_ELECTRICAL);
		//ipAnointWpn = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGEBONUS_1d6);			
	}
	else if (nSpellId == AKNIGHT_ANOINT_WEAPON_VAMP)
	{
		//ipAnointWpn = ItemPropertyBonusFeat(45); //Great Cleave
		ipAnointWpn = ItemPropertyVampiricRegeneration(2);
		bUseItemProp = TRUE;
	}	
	else if (nSpellId == AKNIGHT_ANOINT_WEAPON_CRITS)
	{
		ipAnointWpn = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d10);
		bUseItemProp = TRUE;
	}				
	
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		if (bUseItemProp) // Add Vamp/Crits
			IPSafeAddItemProperty(oMyWeapon, ipAnointWpn, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		else // Apply Elem Dmg to Char
        	DelayCommand(0.8f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmgIncrease, OBJECT_SELF, fDuration)); 
					
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);//Make the sword glow	
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_HOLY_AID ),GetLocation(GetSpellTargetObject())));

        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}