//::///////////////////////////////////////////////
//:: Entropic Shield
//:: cmi_hx_entrshld
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "cmi_ginc_spells"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

     //Declare major variables
    object oTarget = OBJECT_SELF;
	
	// AFW-OEI 08/07/2007: If you're casting it as a Svirfneblin racial, use HD.
	int nDuration = GetHexbladeCasterLevel();
    float fDuration = TurnsToSeconds(nDuration);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set the four unique armor bonuses
    effect eShield =  EffectConcealment(20, MISS_CHANCE_TYPE_VS_RANGED);
    effect eDur = EffectVisualEffect(VFX_DUR_SPELL_ENTROPIC_SHIELD);

    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = SetEffectSpellId(eLink, Hex_Entropic_Shield);
	eLink = SupernaturalEffect(eLink);

    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}