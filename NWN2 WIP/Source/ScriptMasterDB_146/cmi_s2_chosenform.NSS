




#include "x2_inc_itemprop"
#include "cmi_includes"
#include "cmi_ginc_spells"
#include "cmi_ginc_polymorph"

void main()
{

    //Declare major variables
    int nSpell = GetSpellId();
    effect eVis = EffectVisualEffect(VFX_DUR_POLYMORPH);
	eVis = SupernaturalEffect(eVis);	// AFW-OEI 12/07/2006: Make it so you can't dispel the visual effect, which was dispelling wildshape.
    effect ePoly;
	
    int nPoly = 191;
    int nDuration = 24;			

    ePoly = EffectPolymorph(nPoly, FALSE, TRUE);	// AFW-OEI 11/27/2006: Use 3rd boolean to say this is a wildshape polymorph.
	ePoly = EffectLinkEffects( ePoly, eVis );
	ePoly = SupernaturalEffect(ePoly);
			
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_WILD_SHAPE, FALSE));

    //Apply the VFX impact and effects
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));

	
	/*
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
	effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
	effect eRegen = EffectRegenerate(1, 6.0f);
	eRegen = ExtraordinaryEffect(eRegen);
	eRegen = SetEffectSpellId(eRegen,-FEAT_NATWARR_NATARM_GROWTH);			
	eLink = SupernaturalEffect(eLink);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);		
	*/

}