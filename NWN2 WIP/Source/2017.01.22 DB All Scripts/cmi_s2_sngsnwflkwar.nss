//::///////////////////////////////////////////////
//:: Snowflake Wardance
//:: cmi_s2_sngsnwflkwar
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

	int bValid = IsSnowflakeValid(OBJECT_SELF);	
	
	if (bValid)
	{

		int nChaBonus = GetAbilityModifier(ABILITY_CHARISMA);
		if (nChaBonus < 1)
			nChaBonus = 1;
		effect eAB = EffectAttackIncrease(nChaBonus);
		eAB = SupernaturalEffect(eAB);
		eAB = SetEffectSpellId(eAB, SONG_SNOWFLAKE_WARDANCE );
			
		int nDuration = 1 + GetSkillRank(SKILL_PERFORM);
		
		effect eDur  = EffectVisualEffect( VFX_DUR_SPELL_RAGE );
		float nFatigueDuration = RoundsToSeconds(nDuration + 2);
		eDur = SupernaturalEffect(eDur);
		eDur = SetEffectSpellId(eDur, SONG_SNOWFLAKE_WARDANCE );
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, nFatigueDuration));		
		
    	RemoveEffectsFromSpell(OBJECT_SELF, SONG_SNOWFLAKE_WARDANCE);
		
		if (!GetHasFeat(FEAT_TIRELESS, OBJECT_SELF))
		{			
			ApplyCMIFatigue(OBJECT_SELF, TurnsToSeconds(10), ( RoundsToSeconds(nDuration + 1) ), SONG_SNOWFLAKE_WARDANCE );
		}	
									
		ApplyCMIFatigue(OBJECT_SELF, TurnsToSeconds(10), ( RoundsToSeconds(nDuration + 1) ), SONG_SNOWFLAKE_WARDANCE );
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, RoundsToSeconds(nDuration)));		
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
	}
	else
	{
		SendMessageToPC(OBJECT_SELF, "You must be wearing light or no armor and wielding a one-handed slashing weapon (both must be slashing if two weapons are used).");
	}
}