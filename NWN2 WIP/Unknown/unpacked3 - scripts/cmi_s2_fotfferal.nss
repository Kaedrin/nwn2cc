//::///////////////////////////////////////////////
//:: Fist of the Forest - Feral Stance
//:: cmi_s2_fotfferal
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Aug 16, 2009
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

void main()
{
	object oPC = OBJECT_SELF;
	int nSpellId = SPELLABILITY_FOTF_FERAL_STANCE;

	int nRageDuration = 3 + GetAbilityModifier(ABILITY_CONSTITUTION);
	if (GetHasFeat(FEAT_EXTEND_RAGE))
        {
            nRageDuration += 5;
			if (GetHasFeat(FEAT_EXTEND_RAGE_II))
			{
				nRageDuration += 5;
				if (GetHasFeat(FEAT_EXTEND_RAGE_III))
				{
					nRageDuration += 5;
					if (GetHasFeat(FEAT_EXTEND_RAGE_IV))
					{
						nRageDuration += 5;
					}						
				}				
			}
        }
	
	effect eAB = EffectAttackIncrease(2);
	effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
	effect eLink = EffectLinkEffects(eAB, eDex);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
				
	PlayVoiceChat(VOICE_CHAT_BATTLECRY1);	
	PlayCustomAnimation(OBJECT_SELF, "sp_warcry", 0);
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_FOTF_FERAL_STANCE, FALSE));
	       
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nRageDuration));

}