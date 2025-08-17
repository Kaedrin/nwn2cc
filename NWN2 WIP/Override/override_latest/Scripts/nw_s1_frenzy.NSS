//::///////////////////////////////////////////////
//:: Frenzy
//:: NW_S1_Frenzy
//:://////////////////////////////////////////////
/*
    Similar to Barbarian Rage
    Gives +6 Str, -4 AC, extra attack at highest
    Base Attack Bonus (BAB), doesn't stack with Haste/etc.,
    receives 2 points of non-lethal dmg a round.
    Lasts 3+ Con Mod rounds.
    Greater Frenzy starts at level 8.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: July 22, 2005
//:://////////////////////////////////////////////
//:: AFW-OEI 08/07/2006: Now inflicts 12 points of
//::	damage per round.
//:: AFW-OEI 10/30/2006: Changed to 6 pts./rnd.

#include "x2_i0_spells"
#include "nwn2_inc_spells"

#include "cmi_ginc_chars"

void main()
{
    if(!GetHasFeatEffect(FEAT_FRENZY_1))
    {
        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_FRENZIEDBERSERKER);
        int nIncrease;
        int nSave;

        if (GetHasFeat(FEAT_GREATER_FRENZY, OBJECT_SELF, TRUE))
        {
            nIncrease = 10;
        }
        else
        {
            nIncrease = 6;
        }

        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Determine the duration by getting the con modifier after being modified
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION);

		// JLR - OEI 06/03/05 NWN2 3.5
        if (GetHasFeat(FEAT_EXTEND_RAGE))
        {
            nCon += 5;
			if (GetHasFeat(FEAT_EXTEND_RAGE_II))
			{
				nCon += 5;
				if (GetHasFeat(FEAT_EXTEND_RAGE_III))
				{
					nCon += 5;
					if (GetHasFeat(FEAT_EXTEND_RAGE_IV))
					{
						nCon += 5;
					}						
				}				
			}
        }
		
		int isPC = GetIsPC(OBJECT_SELF);

		int nDamage = 6;
		if (GetLevelByClass(CLASS_TYPE_BARBARIAN) > 0)
			nDamage = 2;			

        effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
        effect eAC = EffectACDecrease(4, AC_DODGE_BONUS);
        effect eDot = EffectDamageOverTime(nDamage, RoundsToSeconds(1), DAMAGE_TYPE_ALL);	// 2 points of damage per round
        effect eDur = EffectVisualEffect( VFX_DUR_SPELL_RAGE );
        effect eAttackMod = EffectModifyAttacks(1);

        effect eLink = EffectLinkEffects(eStr, eAC);
		if (!isPC)
		{
			nCon = nCon*10;
		}
		else
		{
			eLink = EffectLinkEffects(eLink, eDot);
		}
		
        eLink = EffectLinkEffects(eLink, eDur);
        //eLink = EffectLinkEffects(eLink, eAttackMod);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nCon > 0)
        {
			float fDuration = RoundsToSeconds(nCon);
			fDuration		=	fDuration + 2.0;
		
				if (!GetHasSpellEffect(SPELL_HASTE,OBJECT_SELF))
				{			
					eLink = EffectLinkEffects(eLink, eAttackMod);
				}
				
	        //Make effect extraordinary
	        eLink = ExtraordinaryEffect(eLink);
		
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);											
			
			effect eDeathless;
			int nHasDeathless = 0;
			if (GetHasFeat(FEAT_DEATHLESS_FRENZY)) //Deathless frenzy check
			{
				nHasDeathless = 1;
				effect eDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
				effect eNeg = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, 9999, 0);		
    			effect eLevel = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
    			//effect eAbil = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
				
				eDeathless = EffectLinkEffects(eDeath, eDur);
			 	eDeathless = EffectLinkEffects(eDeathless, eNeg);
    			eDeathless = EffectLinkEffects(eDeathless, eLevel);
				
				int nUseDeathwardFix = GetLocalInt(GetModule(), "UseDeathwardFix");	
				if (nUseDeathwardFix)
				{
					effect eImmuneAbilDmg = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
					eDeathless = EffectLinkEffects(eDeathless, eImmuneAbilDmg);	
				}				

				eDeathless = ExtraordinaryEffect(eDeathless);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeathless, OBJECT_SELF, fDuration);
			}
			// Start the fatigue logic half a second before the frenzy ends
			if (nLevel < 10)
			{
				if (!GetHasFeat(FEAT_TIRELESS))
					DelayCommand(fDuration - 0.5f, ApplyCMIFatigue(OBJECT_SELF, RoundsToSeconds(5), 0.6f));	// Fatigue duration fixed to 5 rounds
			}
			
			if (GetHasFeat(FEAT_SHARED_FURY, OBJECT_SELF))
			{
				object oMyPet = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);	
				if (GetIsObjectValid(oMyPet))
				{
            		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oMyPet, fDuration));	
					if (nHasDeathless)
            		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeathless, oMyPet, fDuration));									
				}
			}	
					
        }
    }
}