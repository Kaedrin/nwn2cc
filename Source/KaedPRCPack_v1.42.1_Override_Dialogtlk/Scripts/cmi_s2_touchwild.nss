
#include "NW_I0_SPELLS"
#include "cmi_includes"

void main()
{

    object oTarget = GetSpellTargetObject();
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    if (nChr <= 0)
    {
        //nChr = 0;
		return;		// AFW-OEI 06/13/2006: Lay on Hands does nothing if you don't have a positive Cha mod. 
    }
    int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
    nLevel = nLevel + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION);
	nLevel = nLevel + GetLevelByClass(CLASS_HOSPITALER);
	nLevel = nLevel + GetLevelByClass(CLASS_CHAMPION_WILD);	

	int nHeal = nLevel * nChr;
    if(nHeal <= 0)
    {
        nHeal = 1;
    }
	
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDam;
    int nTouch;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_LAY_ON_HANDS, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}