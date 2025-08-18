//::///////////////////////////////////////////////
//:: Forest Hammer
//:: cmi_s2_forsthammr
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 12, 2008
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"
//#include "x0_i0_spells"

void main()
{
		object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();

		RemoveEffectsFromSpell(OBJECT_SELF, FOREST_MASTER_FOREST_HAMMER);	
					   	
		if(!GetIsObjectValid(oMyWeapon))
	    {
			SendMessageToPC(OBJECT_SELF,"Forest Hammer disabled.  You must use a warmace in your right hand for this ability to work.");			
	    	return;
	    }
		else
		{
			if (GetBaseItemType(oMyWeapon) != BASE_ITEM_WARMACE)
			{
				SendMessageToPC(OBJECT_SELF,"Forest Hammer disabled.  You must use a warmace in your right hand for this ability to work.");			
		    	return;			
			}
		}
			
		int nForestMaster = GetLevelByClass(CLASS_FOREST_MASTER);
	
		effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BLESS_WEAPON );	
		float fDuration = HoursToSeconds(24);	

		int nSpellId = GetSpellId();
		itemproperty ipFMWpn;
		itemproperty ipFMWpn_Cleave;
		itemproperty ipFMWpn_Crits;	
		
		int nItemVisual;
		int nEnhance;
		
		if (nForestMaster > 8)
			nEnhance = 3;
		else
			nEnhance = 2;
		
		ipFMWpn_Cleave = ItemPropertyBonusFeat(45); //Great Cleave
 		ipFMWpn_Crits = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d10);

		int DamageType;		
		if (nSpellId == FOREST_MASTER_FOREST_HAMMER_SHOCK)
		{
			nItemVisual = ITEM_VISUAL_ELECTRICAL;
			DamageType = DAMAGE_TYPE_ELECTRICAL;
		}
		else
		{
			nItemVisual = ITEM_VISUAL_COLD;		
			DamageType = DAMAGE_TYPE_COLD;		
		}
		
		effect DamageBonus = EffectDamageIncrease(DAMAGE_BONUS_1d6, DamageType);
		DamageBonus = SetEffectSpellId(DamageBonus, FOREST_MASTER_FOREST_HAMMER);
		DelayCommand(0.1f, cmi_ApplyEffectToObject(FOREST_MASTER_FOREST_HAMMER, DURATION_TYPE_TEMPORARY, DamageBonus, GetItemPossessor(oMyWeapon), fDuration));
			
	    SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		IPSafeAddItemProperty(oMyWeapon, ItemPropertyEnhancementBonus(nEnhance), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,FALSE);
		
		if (nForestMaster > 5)
			IPSafeAddItemProperty(oMyWeapon, ipFMWpn_Crits, fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
		if (nForestMaster > 8)
			IPSafeAddItemProperty(oMyWeapon, ipFMWpn_Cleave, fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
				
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
		DelayCommand(0.1f, cmi_ApplyEffectToObject(FOREST_MASTER_FOREST_HAMMER, DURATION_TYPE_TEMPORARY, eVis, GetItemPossessor(oMyWeapon), fDuration));
		return;

}