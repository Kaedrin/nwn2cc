//::///////////////////////////////////////////////
//:: Trackless Step (Allies)
//:: cmi_s2_grptrackstep
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
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
	float fDuration = HoursToSeconds( 24 );
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_TRACKLESSSTEP);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
		    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
			if (oArmorNew == OBJECT_INVALID)
			{
				oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
				AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
				DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
				DelayCommand(0.1, AssignCommand(oTarget, ActionEquipItem(oArmorNew, INVENTORY_SLOT_CARMOUR)));
			}
			else
			{
		        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
			}				
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }	
	
}      