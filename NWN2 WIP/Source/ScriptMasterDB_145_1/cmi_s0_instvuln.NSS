//::///////////////////////////////////////////////
//:: Instill Vulnerability
//:: cmi_s0_instvuln
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////



#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"
#include "noc_warlock_corruption"

void main()
{


    if (!X2PreSpellCastCode())
    {
	    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	AddCorruption(OBJECT_SELF, 7);
	
	float fDuration = HoursToSeconds(24);
	int nDmgResType = DAMAGE_TYPE_ACID;
	int nSpellId = GetSpellId();
	
	if (nSpellId == Instill_Vuln_A)
		nDmgResType = DAMAGE_TYPE_ACID;
	else
	if (nSpellId == Instill_Vuln_C)
		nDmgResType = DAMAGE_TYPE_COLD;
	else
	if (nSpellId == Instill_Vuln_E)
		nDmgResType = DAMAGE_TYPE_ELECTRICAL;	
	else
	if (nSpellId == Instill_Vuln_F)
		nDmgResType = DAMAGE_TYPE_FIRE;
	else
	if (nSpellId == Instill_Vuln_S)
		nDmgResType = DAMAGE_TYPE_SONIC;	
		
    object	oTarget = GetSpellTargetObject();
	effect	eVuln = EffectDamageImmunityDecrease(nDmgResType, 50);
	eVuln = SetEffectSpellId(eVuln, Instill_Vulnerability);

	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
        //Signal spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(oTarget, nSpellId));
         
            //Make Will Save
            if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetWarlockDC(OBJECT_SELF, TRUE)) )
            {
				RemoveSpellEffects(Instill_Vulnerability, OBJECT_SELF, oTarget);
				effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
	            //Apply Effect and VFX
	            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVuln, oTarget, fDuration);
	            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
    }
}