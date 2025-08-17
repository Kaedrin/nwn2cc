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
		int nStalkDep = GetLevelByClass(CLASS_STALKER_DEPTHS);
		if (nStalkDep > 0)
		{
			nStalkDep = nStalkDep / 4;
		}		
		
		nDodge = nScout + nWildStalk + nStalkDep;
		
		if (nDodge > 0)
		{
			effect eLink;
			effect eScoutAC = EffectACIncrease(nDodge);
			
			if (GetHasFeat(FEAT_BATTLEFIELD_SURVEYOR))
			{
				nScout = GetLevelByClass(CLASS_SCOUT);
				nScout += GetLevelByClass(CLASS_WILD_STALKER);		
				nWildStalk = nScout / 3;
				if (nWildStalk > 0)
				{
					effect eSpot  = EffectSkillIncrease(SKILL_SPOT, nWildStalk);
					effect eListen = EffectSkillIncrease(SKILL_LISTEN, nWildStalk);
					eLink = EffectLinkEffects(eSpot, eListen);
					eLink = EffectLinkEffects(eLink, eScoutAC);
				}
				else
					eLink = eScoutAC;
			}	
			else
					eLink = eScoutAC;					
			
			eLink = SetEffectSpellId(eLink, nSpellId);
			eLink = SupernaturalEffect(eLink);		
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48));			
		}
}      