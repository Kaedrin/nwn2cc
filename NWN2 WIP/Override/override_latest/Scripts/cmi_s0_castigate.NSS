//::///////////////////////////////////////////////
//:: Castigate
//:: cmi_s0_castigate
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On:  July 5, 2007
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

int AdjustAlignDamage(object oTarget, int nAlignDamage)
{
	if (GetAlignmentLawChaos(oTarget) != GetAlignmentLawChaos(OBJECT_SELF))
	{
		if (GetAlignmentGoodEvil(oTarget) != GetAlignmentGoodEvil(OBJECT_SELF))
		{
			// Full Damage
		}
		else
		{
			nAlignDamage = nAlignDamage / 2;
		}
	}
	else
	{
		if (GetAlignmentGoodEvil(oTarget) != GetAlignmentGoodEvil(OBJECT_SELF))
		{
			nAlignDamage = nAlignDamage / 2;
		}
		else
		{
			nAlignDamage = 0;
		}
	}
	return nAlignDamage;

}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	

	
	int nCasterLvl = GetPalRngCasterLevel();
	int nMetaMagic = GetMetaMagicFeat();
		
	int nNumDice = nCasterLvl;
	if (nNumDice > 10)
		nNumDice = 10;
	int nDamage = MaximizeOrEmpower(4, nNumDice, nMetaMagic);
	
	effect eDam;
	effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);	
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
			if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
		    {	
				int nSave = FortitudeSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SONIC, OBJECT_SELF);
				int nAdjustedDmg = AdjustAlignDamage(oTarget, nDamage);
				if (nSave == 1) // Succeeded
				{					
					if (nAdjustedDmg > 0)
					{
					    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
					    eDam = EffectDamage(nAdjustedDmg/2,DAMAGE_TYPE_SONIC);
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
					    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
					}
				}
				else // Failed Save
				{
					if (nAdjustedDmg > 0)
					{
						SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
						eDam = EffectDamage(nAdjustedDmg,DAMAGE_TYPE_SONIC);
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
					    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
					}		
				}
			}		
		}
	    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF));	
	}	
	
		
}      