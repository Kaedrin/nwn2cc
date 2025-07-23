//::///////////////////////////////////////////////
//:: Oak Heart
//:: cmi_s2_oakheart
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 13, 2008
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
	
	int nSpellId = FOREST_MASTER_OAK_HEART;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	

	effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
	effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
	effect eSleep = EffectImmunity(IMMUNITY_TYPE_SLEEP);
	effect eParalysis = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
	effect eStun = EffectImmunity(IMMUNITY_TYPE_STUN);
	effect eCrit = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
	effect eSneak = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
	effect eVuln = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 50);
	
	effect eLink = EffectLinkEffects(eMind,ePoison);
	eLink = EffectLinkEffects(eLink, eSleep);
	eLink = EffectLinkEffects(eLink, eParalysis);
	eLink = EffectLinkEffects(eLink, eStun);
	eLink = EffectLinkEffects(eLink, eCrit);
	eLink = EffectLinkEffects(eLink, eSneak);
	eLink = EffectLinkEffects(eLink, eVuln);						
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	
}      