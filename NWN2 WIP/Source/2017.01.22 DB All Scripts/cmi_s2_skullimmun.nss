//::///////////////////////////////////////////////
//:: Hunter's Immunity (and all other Skullclan Hunter abilities)
//:: cmi_s2_skullimmun
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 26, 2008
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
	
	int nSpellId = SPELLABILITY_SKULLCLAN_HUNTERS_IMMUNITIES;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}		
	
	int nClassLevel = GetLevelByClass(CLASS_SKULLCLAN_HUNTER);
		
	
	effect eLink = EffectImmunity(IMMUNITY_TYPE_FEAR); //3rd level


	
	
	if (nClassLevel > 9)
	{
		effect eImmuneEnrgyDrn = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);		
		eLink = EffectLinkEffects(eLink, eImmuneEnrgyDrn);
	}
	if (nClassLevel > 7)
	{
		effect eImmuneAbilDmg = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
		eLink = EffectLinkEffects(eLink, eImmuneAbilDmg);		
	}
	if (nClassLevel > 6)
	{	
		effect eImmunePara = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
		eLink = EffectLinkEffects(eLink, eImmunePara);
	}
	if (nClassLevel > 3)
	{	
		effect eImmuneDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);
		eLink = EffectLinkEffects(eLink, eImmuneDisease);
	}
		
	if (nClassLevel > 8) //Sword of Dark
	{
		effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_DIVINE);
		eDmg = VersusRacialTypeEffect(eDmg, RACIAL_TYPE_UNDEAD);
		eLink = EffectLinkEffects(eLink, eDmg);
	}
	else
	if (nClassLevel > 4) //Sword of Light
	{
		effect eDmg = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_DIVINE);
		eDmg = VersusRacialTypeEffect(eDmg, RACIAL_TYPE_UNDEAD);		
		eLink = EffectLinkEffects(eLink, eDmg);		
	}	
	
	if (nClassLevel > 3) //Protection
	{
		effect eProtEvil;
	    effect eAC = EffectACIncrease(2, AC_DEFLECTION_BONUS);
	    eAC = VersusAlignmentEffect(eAC,ALIGNMENT_ALL, ALIGNMENT_EVIL);
	    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
	    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, ALIGNMENT_EVIL);

    effect eImmune1 = EffectImmunity(IMMUNITY_TYPE_CHARM);
    effect eImmune2 = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
    effect eImmune3 = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eImmune4 = EffectImmunity(IMMUNITY_TYPE_CONFUSED);		
    eImmune1 = VersusAlignmentEffect(eImmune1,ALIGNMENT_ALL, ALIGNMENT_EVIL);
    eImmune2 = VersusAlignmentEffect(eImmune2,ALIGNMENT_ALL, ALIGNMENT_EVIL);
    eImmune3 = VersusAlignmentEffect(eImmune3,ALIGNMENT_ALL, ALIGNMENT_EVIL);
    eImmune4 = VersusAlignmentEffect(eImmune4,ALIGNMENT_ALL, ALIGNMENT_EVIL);		

    effect eLink = EffectLinkEffects(eImmune1, eSave);
    eLink = EffectLinkEffects(eLink, eImmune2);
    eLink = EffectLinkEffects(eLink, eImmune3);
    eLink = EffectLinkEffects(eLink, eImmune4);			
    eLink = EffectLinkEffects(eLink, eAC);
				    
		eLink = SetEffectSpellId(eProtEvil,nSpellId);
		eLink = SupernaturalEffect(eProtEvil);
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));					
	}
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);

	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
	
}      