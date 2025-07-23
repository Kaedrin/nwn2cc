//::///////////////////////////////////////////////
//:: Epic of the Lost King
//:: cmi_s2_sngepiclstking
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 29, 2009
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"


void main()
{
	if ( GetCanBardSing( OBJECT_SELF ) == FALSE )
	{
		return; // Awww :(	
	}

    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(STR_REF_FEEDBACK_NO_MORE_BARDSONG_ATTEMPTS,OBJECT_SELF); // no more bardsong uses left
        return;
    }
	
	int		nPerform	= GetSkillRank(SKILL_PERFORM);
	 
	if (nPerform < 6 ) //Checks your perform skill so nubs can't use this song
	{
		FloatingTextStrRefOnCreature ( 182800, OBJECT_SELF );
		return;
	}

	/*
    object oTarget = GetFirstFactionMember( OBJECT_SELF, FALSE );
    while ( GetIsObjectValid( oTarget ) )
    {
		if ( GetIsObjectValidSongTarget(oTarget) && GetArea(oTarget) == GetArea(OBJECT_SELF) )
		{
	            if(GetHasSpellEffect(FATIGUE,oTarget) || GetHasSpellEffect(EXHAUSTED,oTarget))
	            {
	                RemoveEffectsFromSpell(oTarget, FATIGUE);
					RemoveEffectsFromSpell(oTarget, EXHAUSTED);
	            }
		}
        oTarget = GetNextFactionMember( OBJECT_SELF, FALSE );
    }
	*/
	
	location lTarget = GetSpellTargetLocation();
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oTarget))
	{
    	if (spellsIsTarget( oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF ))
    		{
	            if(GetHasSpellEffect(FATIGUE,oTarget) || GetHasSpellEffect(EXHAUSTED,oTarget))
	            {
	                RemoveEffectsFromSpell(oTarget, FATIGUE);
					RemoveEffectsFromSpell(oTarget, EXHAUSTED);
	            }	
    		}        	
     	//Get the next target in the specified area around the caster
		oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
	}	
	
	DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);

}