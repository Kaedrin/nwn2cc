//::///////////////////////////////////////////////
//:: Skald: Inspire Heroism
//:: cmi_s2_insphero
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 7, 2013
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"

void cmi_ApplyFriendlySongEffectsToArea( object oCaster, int nSpellId, float fDuration, float fRadius, effect eLink )
{
	//SendMessageToPC(OBJECT_SELF, "Test 1");
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oCaster));
		
	// AFW-OEI 07/17/2006: Because the caster will already have the EFFECT_BARDSONG_SINGING
	//	effect on him, we need to do some shenanigans to see if that's the only effect
	//	w/ that bardsong ID.  If it is, we need to apply the bonuses for the first time.
	int bCasterAlreadyHasBardsongEffects = FALSE;
	effect eCheck = GetFirstEffect(oCaster);
	while(GetIsEffectValid(eCheck))
	{
		if (GetEffectSpellId(eCheck) == nSpellId &&
			GetEffectType(eCheck) != EFFECT_TYPE_BARDSONG_SINGING)
		{
			bCasterAlreadyHasBardsongEffects = TRUE;
			break;
		}
		eCheck = GetNextEffect(oCaster);
	}
	
    while(GetIsObjectValid(oTarget))
    {
		int nRacialType = GetRacialType(oTarget);
			
		// AFW-OEI 07/02/2007: Inspire Regen does not affect undead or constructs
		if ( GetIsObjectValidSongTarget(oTarget) &&
			 !( (nSpellId == SPELLABILITY_SONG_INSPIRE_REGENERATION) && 
			    (nRacialType == RACIAL_TYPE_CONSTRUCT || nRacialType == RACIAL_TYPE_UNDEAD ) ) )
		{
        	if( (!GetHasSpellEffect(nSpellId,oTarget)) || 
				(oTarget == oCaster && !bCasterAlreadyHasBardsongEffects) )
	        {
				if ( spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster) )
                {
	                //Fire cast spell at event for the specified target
	                SignalEvent(oTarget, EventSpellCastAt(oCaster, nSpellId, FALSE));
                    eLink = SetEffectSpellId( eLink, nSpellId );
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                }
	        }
	        else
	        {
	            // Refresh the duration
	            RefreshSpellEffectDurations(oTarget, nSpellId, fDuration);
	        }
		}
	    oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oCaster));
    }
}


void RunPersistentSong(object oCaster, int nSpellId)
{
	//SendMessageToPC(OBJECT_SELF, "Test 2");
	if ( GetCanBardSing( oCaster ) == FALSE )
	{
		return; // Awww :(	
	}
	//SendMessageToPC(OBJECT_SELF, "Test 3");
	

    int nSingingSpellId = FindEffectSpellId(EFFECT_TYPE_BARDSONG_SINGING);
    if(nSingingSpellId == nSpellId)
	{
		SendMessageToPC(OBJECT_SELF, "Inspire Defense does not stack with Inspire Heroics.");
		return;
	}	
	
    if (GetHasSpellEffect(-SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF) == TRUE)
    {
		//SendMessageToPC(OBJECT_SELF, "Test 4");	
        RemoveSpellEffects(-SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF, OBJECT_SELF);		
		RemoveBardSongSingingEffect(OBJECT_SELF, nSingingSpellId);		
        return;
    }	
		
    // Verify that we are still singing the same song...
    //int nSingingSpellId = FindEffectSpellId(EFFECT_TYPE_BARDSONG_SINGING);
    //if(nSingingSpellId == nSpellId)
    {
		//SendMessageToPC(OBJECT_SELF, "Test 5");	
        float fDuration = 6.0; 
					
		int nSkald = GetLevelByClass(CLASS_SKALD, oCaster);
		
		int nDexStr = 2 + (nSkald/5);
		if (nDexStr > 6)
			nDexStr = 6;
			
		effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nDexStr);
		effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, nDexStr);
		effect eLink = EffectLinkEffects(eStr,eDex);
		
		int nBonus = 1;
		
		if (nSkald > 5) // Health
		{		
			if (nSkald > 25)
				nBonus = 3;
			else
			if (nSkald > 15)
				nBonus = 2;
				
			effect eHeal = EffectRegenerate(nBonus, 6.0f);
			eLink = EffectLinkEffects(eLink, eHeal);
		}	
		
		if (nSkald > 10) // Protection
		{
			nBonus = 1;
			
			if (nSkald > 24)
				nBonus = 3;
			else
			if (nSkald > 17)
				nBonus = 2;			
			
			effect eDodgeAC = EffectACIncrease(nBonus);
			eLink = EffectLinkEffects(eLink, eDodgeAC);
		}

		if (nSkald > 15) // Clarity
		{
			nBonus = (nSkald/5);
				
			effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nBonus);
			effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, nBonus);
			effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, nBonus);	
			eLink = EffectLinkEffects(eLink, eInt);
			eLink = EffectLinkEffects(eLink, eWis);
			eLink = EffectLinkEffects(eLink, eCha);					
		}
		
		if (nSkald > 20) // Cover
		{
			nBonus = 5;
			if (nSkald > 27)
				nBonus = 10;
				
			effect eConceal = EffectConcealment(nBonus);
			eLink = EffectLinkEffects(eLink, eConceal);			
		}
		
		if (nSkald > 25) // Excellence
		{
			nBonus = 2;
			
			if (nSkald == 30)
				nBonus = 3;
			
			effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
			eLink = EffectLinkEffects(eLink,eSkill);
			
		}
												      
        effect eDur = EffectVisualEffect(VFX_HIT_BARD_INS_COURAGE);
        eLink = EffectLinkEffects(eLink, eDur);

		eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
					
        cmi_ApplyFriendlySongEffectsToArea( oCaster, nSpellId, fDuration, RADIUS_SIZE_COLOSSAL, eLink );
        // Schedule the next ping
        DelayCommand(4.5f, RunPersistentSong(oCaster, nSpellId));
    }
}


void main()
{
	//SendMessageToPC(OBJECT_SELF, "Test 6");
	if ( GetCanBardSing( OBJECT_SELF ) == FALSE )
	{
		return; // Awww :(	
	}
	
	//SendMessageToPC(OBJECT_SELF, "Test 7");
	int nSpellId = SPELLABILITY_SONG_INSPIRE_DEFENSE;
	
	/*
    if (GetHasSpellEffect(SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF) == TRUE)
    {
		//SendMessageToPC(OBJECT_SELF, "Test 9");	
        RemoveSpellEffects(SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF, OBJECT_SELF);
    }
	else
	{
		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
		eVis = SetEffectSpellId(eVis,nSpellId);
		eVis = SupernaturalEffect(eVis);		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, HoursToSeconds(24));		
	}
	*/
	
    if (GetHasSpellEffect(SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF) == TRUE)
    {
		//SendMessageToPC(OBJECT_SELF, "Test 8");	
        RemoveSpellEffects(SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF, OBJECT_SELF);
        RemoveSpellEffects(-SPELLABILITY_SONG_INSPIRE_DEFENSE, OBJECT_SELF, OBJECT_SELF);		
		RemoveBardSongSingingEffect(OBJECT_SELF, SPELLABILITY_SONG_INSPIRE_DEFENSE);				
		effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);	
		eVis = SetEffectSpellId(eVis,-nSpellId);
		eVis = SupernaturalEffect(eVis);		
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, HoursToSeconds(24));			
		return;
    }	
	else
	{
			RemoveBardSongSingingEffect(OBJECT_SELF, SPELLABILITY_SONG_INSPIRE_DEFENSE);				
	}
	
    if(AttemptNewSong(OBJECT_SELF, TRUE))
    {
		//SendMessageToPC(OBJECT_SELF, "Test 9");	
		effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
	    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

		DelayCommand(0.1f, RunPersistentSong(OBJECT_SELF, nSpellId));
    }
}