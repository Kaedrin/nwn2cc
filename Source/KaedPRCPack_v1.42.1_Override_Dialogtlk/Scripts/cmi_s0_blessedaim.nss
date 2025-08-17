//::///////////////////////////////////////////////
//:: Blessed Aim
//:: cmi_s0_blessedaim
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: June 28, 2007
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
    	
	effect eBonus = EffectAttackIncrease(2);	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_HEROISM);
	effect eLink = EffectLinkEffects(eVis, eBonus);	
	
	int nCasterLvl = GetPalRngCasterLevel();
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	float fDelay;
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GINORMOUS, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
				
		  object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
		  if (GetIsObjectValid(oWeapon) && GetWeaponRanged(oWeapon))
		  {
			    fDelay = GetRandomDelay(0.4, 1.1);
				
			    RemoveEffectsFromSpell(oTarget, GetSpellId());			
	            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));				
		  } 
  					
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GINORMOUS, GetLocation(OBJECT_SELF));
    }	
	
}      