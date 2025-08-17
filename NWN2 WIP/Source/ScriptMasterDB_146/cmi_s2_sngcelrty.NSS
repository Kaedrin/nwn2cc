//::///////////////////////////////////////////////
//:: Song of Celerity
//:: cmi_s2_sngcelrty
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 19, 2008
//:: Based on nw_s0_haste
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
	int nSpellId = BLADESINGER_SONG_CELERITY;
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    // Create the Effects
    effect eHaste = EffectHaste();
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
    effect eLink = EffectLinkEffects(eHaste, eDur);
	eLink = SetEffectSpellId(eLink,nSpellId);
    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect( 647, oTarget ) == TRUE)
    {
        RemoveSpellEffects( 647, OBJECT_SELF, oTarget );
    }

	//Favored Soul?
	//Warpriest?

    int nCasterLvl = GetLevelByClass(CLASS_BLADESINGER) * 3;
	float fDuration = RoundsToSeconds( nCasterLvl );
	float fDelay;
	
	object oTarget2 = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oTarget2))
	{
    	if (spellsIsTarget( oTarget2, SPELL_TARGET_ALLALLIES, OBJECT_SELF ))
    		{
				fDelay = GetRandomDelay(0.1, 1.0);
        		SignalEvent( oTarget2, EventSpellCastAt( OBJECT_SELF, SPELL_HASTE, FALSE ));
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, fDuration));
				
    		}        	
     	//Get the next target in the specified area around the caster
		oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}	
}      