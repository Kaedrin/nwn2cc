//::///////////////////////////////////////////////
//:: Haste
//:: nw_s0_haste
//:: Purpose: 
//:: Altered By: Kaedrin (Matt)
//:: Based on script: nw_s0_haste
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "ginc_henchman"

#include "cmi_includes"
#include "cmi_ginc_chars"

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


	int nSwiftblade = GetLevelByClass(CLASS_SWIFTBLADE);
	

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    // Create the Effects
    effect eHaste = EffectHaste();
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_HASTE );
    effect eLink = EffectLinkEffects(eHaste, eDur);

    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect( 647, oTarget ) == TRUE)
    {
        RemoveSpellEffects( 647, OBJECT_SELF, oTarget );
    }
	
	RemoveEffectsFromSpell(oTarget, SPELL_HASTE);	

    int nCasterLvl = GetCasterLevel( OBJECT_SELF );
	float fDuration = RoundsToSeconds( nCasterLvl );
	
    //Check for metamagic extension
	fDuration = ApplyMetamagicDurationMods( fDuration );
    int nDurType = ApplyMetamagicDurationTypeMods( DURATION_TYPE_TEMPORARY );

	//Determine how many targets per cast
	int nNumTargets = nCasterLvl;
	
	object oTarget2 = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oTarget2) && (nNumTargets > 0))
	{
    	if (spellsIsTarget( oTarget2, SPELL_TARGET_ALLALLIES, OBJECT_SELF ))
    		{
        		SignalEvent( oTarget2, EventSpellCastAt( OBJECT_SELF, SPELL_HASTE, FALSE ));
				//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget2, RoundsToSeconds(nDuration));
				
				
				if ( (oTarget2 == OBJECT_SELF) && (nSwiftblade > 0) )
				{
					float fSwiftbladeDuration = fDuration;
					fSwiftbladeDuration = GetSwiftbladeHasteDuration(nSwiftblade, fSwiftbladeDuration);
					effect eSwiftbladeLink = eLink;
					eSwiftbladeLink = GetSwiftbladeHasteEffect(nSwiftblade, eSwiftbladeLink);
					ApplyEffectToObject(nDurType, eSwiftbladeLink, oTarget2, fSwiftbladeDuration);
				
				}
				else
				{				
					if (!GetHasFeatEffect(FEAT_FRENZY_1))
					{
						if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
						{				
							ApplyEffectToObject(nDurType, eLink, oTarget2, fDuration);
						}
						else
							nNumTargets++; //Didn't count, move on
					}
				}
				
				nNumTargets--;
					
    		}        	
     	//Get the next target in the specified area around the caster
		oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}
	
}