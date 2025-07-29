//::///////////////////////////////////////////////
//:: Child of Night, Night Form
//:: cmi_s2_nightfrm
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 3, 2009
//:://////////////////////////////////////////////



#include "x2_inc_spellhook"
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"

void main()
{


    if (!X2PreSpellCastCode())
    {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    //Declare major variables
		
    int nSpell = SPELLABILITY_CHLDNIGHT_NIGHT_FORM;
    effect eVis = EffectVisualEffect(VFX_INVOCATION_WORD_OF_CHANGING);
    effect ePoly = EffectPolymorph(POLYMORPH_TYPE_NIGHTWALKER, FALSE, TRUE);
    ePoly = EffectLinkEffects(ePoly, eVis);
	
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));

    DelayCommand(0.4, AssignCommand(OBJECT_SELF, ClearAllActions())); // prevents an exploit
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, TurnsToSeconds(1)));
	
	if (GetHasFeat(FEAT_GUTTURAL_INVOCATIONS))
	{

	}	
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(125);	    
    DelayCommand(2.0f, IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF), iBonusFeat, TurnsToSeconds(1),X2_IP_ADDPROP_POLICY_KEEP_EXISTING));				
	iBonusFeat = ItemPropertyBonusFeat(814);
    DelayCommand(2.0f, IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF), iBonusFeat, TurnsToSeconds(1),X2_IP_ADDPROP_POLICY_KEEP_EXISTING));						
}


