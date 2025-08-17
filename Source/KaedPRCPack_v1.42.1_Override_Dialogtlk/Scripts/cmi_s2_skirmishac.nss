//::///////////////////////////////////////////////
//:: Skirmish AC
//:: cmi_s2_skirmishac
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 23, 2009
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = SPELLABILITY_SCOUT_SKIRMISHAC;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}		
	
		int nDodge = 0;
		int nScout = GetLevelByClass(CLASS_SCOUT);
		if (nScout > 0)
		{
			nScout = (nScout + 1) / 4;
		}
		int nWildStalk = GetLevelByClass(CLASS_WILD_STALKER);		
		if (nWildStalk > 0)
		{
			nWildStalk = nWildStalk / 4;
		}
		nDodge = nScout + nWildStalk;
		
		if (nDodge > 0)
		{
			effect eScoutAC = EffectACIncrease(nDodge);
			eScoutAC = SetEffectSpellId(eScoutAC, nSpellId);
			eScoutAC = SupernaturalEffect(eScoutAC);		
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eScoutAC, OBJECT_SELF, HoursToSeconds(48));			
		}
}      