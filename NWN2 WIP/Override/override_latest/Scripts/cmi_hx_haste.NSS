//::///////////////////////////////////////////////
//:: Haste
//:: cmi_hx_haste
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 4, 2013
//:://////////////////////////////////////////////

#include "cmi_ginc_chars"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nSpellId = Hex_Haste;
		
    //Declare major variables
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = RoundsToSeconds(nCasterLvl);	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
		
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();
	
    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect( 647, oTarget ) == TRUE)
    {
        RemoveSpellEffects( 647, OBJECT_SELF, oTarget );
    }
	
	RemoveEffectsFromSpell(oTarget, SPELL_HASTE);	
	RemoveEffectsFromSpell(oTarget, Hex_Haste);		
	
    // Create the Effects
    effect eHaste = EffectHaste();
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
    effect eLink = EffectLinkEffects(eHaste, eDur);	
	eLink = SetEffectSpellId(eLink, nSpellId);
		
	//Determine how many targets per cast
	int nNumTargets = nCasterLvl;
	
	object oTarget2 = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oTarget2) && (nNumTargets > 0))
	{
    	if (spellsIsTarget( oTarget2, SPELL_TARGET_ALLALLIES, OBJECT_SELF ))
    		{
        		SignalEvent( oTarget2, EventSpellCastAt( OBJECT_SELF, SPELL_HASTE, FALSE ));
				//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, RoundsToSeconds(nDuration));			
		
					if (!GetHasFeatEffect(FEAT_FRENZY_1))
					{
						if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
						{				
							ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, fDuration);
						}
						else
							nNumTargets++; //Didn't count, move on
					}
				
				nNumTargets--;
					
    		}        	
     	//Get the next target in the specified area around the caster
		oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}	
}