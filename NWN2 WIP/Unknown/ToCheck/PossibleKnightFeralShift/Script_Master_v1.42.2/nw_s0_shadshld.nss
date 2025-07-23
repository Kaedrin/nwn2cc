//::///////////////////////////////////////////////
//:: Shadow Shield
//:: NW_S0_ShadShld.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants the caster +5 AC and 10 / +3 Damage
    Reduction and immunity to death effects
    and negative energy damage for 3 Turns per level.
    Makes the caster immune Necromancy Spells
    
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 22, 2001
//:://////////////////////////////////////////////


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
    RemoveEffectsFromSpell(oTarget, GetSpellId());		
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Do metamagic extend check
	if (nMetaMagic == METAMAGIC_EXTEND)
    {
	   nDuration *= 2;	//Duration is +100%
    }
	
	int nDRMax = nDuration * 10;
	if (nDRMax > 250)
		nDRMax = 250;
		
    effect eStone = EffectDamageReduction( 10, GMATERIAL_METAL_ADAMANTINE, nDRMax, DR_TYPE_GMATERIAL );	// 3.5 DR approximation
    
	if (nDRMax > 150)
		nDRMax = 150;
		
	effect eAC = EffectACIncrease(5, AC_NATURAL_BONUS);
    effect eShadow = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
	effect eImmNeg = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, 9999,  nDRMax);	

    //Link major effects
    effect eLink = EffectLinkEffects(eAC, eShadow);
    eLink = EffectLinkEffects(eLink, eImmDeath);
    //eLink = EffectLinkEffects(eLink, eImmNeg);

	effect eHit = EffectVisualEffect(VFX_HIT_SPELL_EVIL);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHADOW_SHIELD, FALSE));
    //Apply linked effect
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
    DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStone, oTarget, TurnsToSeconds(nDuration)));	
    DelayCommand(0.4f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmNeg, oTarget, TurnsToSeconds(nDuration)));		
}