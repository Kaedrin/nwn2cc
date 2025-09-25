//::///////////////////////////////////////////////
//:: Sonic Might
//:: cmi_s2_sncmight
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 23, 2008
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
	
	int nSpellId = FEAT_LYRIC_THAUM_SONIC_MIGHT;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}
		
	float fDuration = RoundsToSeconds( GetLevelByClass(CLASS_LYRIC_THAUMATURGE, OBJECT_SELF) ); // Seconds
		
	effect eVis =  EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	eVis = SetEffectSpellId(eVis,nSpellId);
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration));	
	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
}      