//:://////////////////////////////////////////////////////////////////////////
//:: Bard Song: Inspire Courage
//:: NW_S2_SngInCour
//:: Created By: Jesse Reynolds (JLR-OEI)
//:: Created On: 04/06/06
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//:://////////////////////////////////////////////////////////////////////////
/*
    This spells applies bonuses to all of the
    bard's allies within 30ft for as long as
    it is kept up.
*/
//:: PKM-OEI 07.13.06 VFX Pass
//:: PKM-OEI 07.20.06 Added Perform skill check

#include "x0_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"

void cmi_ApplyFriendlySongEffectsToArea( object oCaster, int nSpellId, float fDuration, float fRadius, effect eLink )
{
    //int nLevel      = GetLevelByClass(CLASS_TYPE_BARD);
    //SpeakString("Level: " + IntToString(nLevel) + " Ranks: " + IntToString(nRanks));

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
			//SpeakString("nwn2_inc_spells::ApplyFriendlySongEffectToArea(): Has bardsong effects other than BARDSONG_SINGING.");	// DEBUG
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
					if (GetHasSpellEffect(SPELLABILITY_DRPIRATE_RALLY_THE_CREW, oTarget))
						RemoveEffectsFromSpell(oTarget,SPELLABILITY_DRPIRATE_RALLY_THE_CREW);
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
	if ( GetCanBardSing( oCaster ) == FALSE )
	{
		return; // Awww :(	
	}
	
	int		nPerform	= GetSkillRank(SKILL_PERFORM);
	 
	if (nPerform < 3 ) //Checks your perform skill so nubs can't use this song
	{
		FloatingTextStrRefOnCreature ( 182800, OBJECT_SELF );
		return;
	}

    // Verify that we are still singing the same song...
    int nSingingSpellId = FindEffectSpellId(EFFECT_TYPE_BARDSONG_SINGING);
    if(nSingingSpellId == nSpellId)
    {
        //Declare major variables
        //int nLevel      = GetLevelByClass(CLASS_TYPE_BARD, oCaster);
		
		//cmi change
		int nLevel = GetBardicClassLevelForUses(oCaster);
		
        float fDuration = 4.0; //RoundsToSeconds(5);
        //int nAttack;
        //int nDamage;

        /* AFW-OEI 02/09/2007: switch to a formula instead of a hard-coded list.
        if(nLevel >= 20)       { nAttack = 4; nDamage = 4; }
        else if(nLevel >= 14)  { nAttack = 3; nDamage = 3; }
        else if(nLevel >= 8)   { nAttack = 2; nDamage = 2; }
        else                   { nAttack = 1; nDamage = 1; }
        */
        int nBonus = 1; // Default to +1
        if (nLevel >= 8)
        {   // +1 every six levels starting at level 2.
            nBonus = nBonus + ((nLevel - 2) / 6);
        }
		

		if (GetHasFeat(FEAT_EPIC_INSPIRATION, oCaster))
			nBonus = nBonus+2;		
		if (GetHasSpellEffect(SPELL_Inspirational_Boost, oCaster))
			nBonus += 1;
		if (GetHasFeat(FEAT_SONG_OF_THE_HEART, oCaster))
			nBonus += 1;
		if (GetHasFeat(FEAT_LEADERSHIP, oCaster))
			nBonus += 1;			
		
		//Dread Pirate
		int nPirate = GetLevelByClass(CLASS_DREAD_PIRATE,oCaster);	
		if (nPirate > 6)
			nBonus += 2;
		else 
		if (nPirate > 2)
			nBonus += 1;
				       
        int nDamage = IPGetDamageBonusConstantFromNumber(nBonus);   // Map raw bonus to a DAMAGE_BONUS_* constant.

        effect eAttack = ExtraordinaryEffect( EffectAttackIncrease(nBonus) );
        effect eDamage = ExtraordinaryEffect( EffectDamageIncrease(nDamage, DAMAGE_TYPE_MAGICAL) );
        effect eLink   = ExtraordinaryEffect( EffectLinkEffects(eAttack, eDamage) );
        effect eDur    = ExtraordinaryEffect( EffectVisualEffect(VFX_HIT_BARD_INS_COURAGE) );
        eLink          = ExtraordinaryEffect( EffectLinkEffects(eLink, eDur) );

        cmi_ApplyFriendlySongEffectsToArea( oCaster, nSpellId, fDuration, RADIUS_SIZE_COLOSSAL, eLink );
        // Schedule the next ping
        DelayCommand(2.5f, RunPersistentSong(oCaster, nSpellId));
    }
}


void main()
{
	if ( GetCanBardSing( OBJECT_SELF ) == FALSE )
	{
		return; // Awww :(	
	}
    if(AttemptNewSong(OBJECT_SELF, TRUE))
    {
		effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
	    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

		DelayCommand(0.1f, RunPersistentSong(OBJECT_SELF, GetSpellId()));
    }
}