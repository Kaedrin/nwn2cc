//::///////////////////////////////////////////////
//:: Energy Protection
//:: cmi_hx_resenergy
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"
#include "x2_inc_spellhook" 

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = GetHexbladeCasterLevel();
	
    int nResistance = 10;
	if (nDuration > 23)
		nResistance = 30;
	else
	if (nDuration > 17)
		nResistance = 20;
		
    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, nResistance);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, nResistance);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, nResistance);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, nResistance);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nResistance);
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_RESIST_ENERGY );

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, Hex_Protection_from_Energy, FALSE));	// JLR - OEI 07/11/05 -- Name Changed

    //Link Effects
    effect eLink = EffectLinkEffects(eCold, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = SetEffectSpellId(eLink, Hex_Protection_from_Energy);
	eLink = SupernaturalEffect(eLink);
	    
    RemoveEffectsFromSpell(oTarget, Hex_Protection_from_Energy);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}