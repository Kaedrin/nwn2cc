//::///////////////////////////////////////////////
//:: Inntervated Speed
//:: cmi_s2_inrvtspd
//:: Purpose: 
//:: Altered By: Kaedrin (Matt)
//:: Created On: March 23, 2008
//:: Based on script: nw_s0_slow
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

#include "cmi_includes"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oTarget;
    effect eSlow = EffectSlow();
    effect eVis = EffectVisualEffect(VFX_DUR_SPELL_SLOW);
	eSlow = EffectLinkEffects( eSlow, eVis );
    int nMetaMagic = GetMetaMagicFeat();
    //Determine spell duration as an integer for later conversion to Rounds, Turns or Hours.
    int nDuration = 10;
    int nLevel = nDuration;
    int nCount = 0;
    location lSpell = GetSpellTargetLocation();
	//int nDC = GetSpellSaveDC();
	int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE);
	int nWis = GetAbilityModifier(ABILITY_WISDOM);
	int nDCMod;
	if (nCha > nInt)
		nDCMod = nCha;
	else
	{
		if (nInt > nWis)
			nDCMod = nInt;
		else
			nDCMod = nWis;
	}	
	
	int nDC = 10 + 9 + nDCMod;

    //Metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_INNERVATE_SPEED, lSpell);
    //Cycle through the targets within the spell shape until an invalid object is captured or the number of
    //targets affected is equal to the caster level.
    while(GetIsObjectValid(oTarget) && nCount < nLevel)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLOW));
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
            {
                //Apply the slow effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, RoundsToSeconds(nDuration));
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                //Count the number of creatures affected
                nCount++;
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_INNERVATE_SPEED, lSpell);
    }
}