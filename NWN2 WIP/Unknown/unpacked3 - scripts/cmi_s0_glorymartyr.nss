//::///////////////////////////////////////////////
//:: Glory of the Martyr
//:: cmi_s0_glorymartyr
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
		
    int nCasterLvl = GetPalRngCasterLevel();
	
	float fDuration = HoursToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_RESCUE);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
	}

}