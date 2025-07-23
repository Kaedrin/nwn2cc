//::///////////////////////////////////////////////
//:: Darkling Weapon
//:: cmi_s2_darkwpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 18, 2007
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


	int nCasterLvl = GetLevelByClass(CLASS_VENGTAKE, OBJECT_SELF);
	//float fDuration = HoursToSeconds( nCasterLvl ) * 2;
	float fDuration = TurnsToSeconds(10);
	
    object oMyWeapon   =  IPGetTargetedOrEquippedWeapon();
	
	int nSpellId = SPELLABILITY_VENGTAKE_VAMP_BLADES;
	itemproperty ipDarkWpn;	
	int nItemVisual = ITEM_VISUAL_EVIL;	
		
	int nBonus = nCasterLvl / 3;
	if (nBonus < 1)
		nBonus = 1;
		
	ipDarkWpn = ItemPropertyVampiricRegeneration(nBonus);				
	
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

		IPSafeAddItemProperty(oMyWeapon, ipDarkWpn, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);//Make the sword glow	
   
		object oMyWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
		if (GetIsObjectValid(oMyWeapon2) && IPGetIsMeleeWeapon(oMyWeapon2))
		{
			IPSafeAddItemProperty(oMyWeapon2, ipDarkWpn, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
			IPSafeAddItemProperty(oMyWeapon2, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);//Make the sword glow	
 		}		
		
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_NEGATIVE_ENERGY ),GetLocation(GetSpellTargetObject())));
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}