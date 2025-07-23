//::///////////////////////////////////////////////
//:: Augment Familiar
//:: cmi_hx_augfam
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
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

	int nSpellId = -4000; // THIS MUST BE UPDATED Hex_Augment_Familliar

	object oMyPet1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
    RemoveEffectsFromSpell(oMyPet1, nSpellId);
	
	object oMyPet2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
    RemoveEffectsFromSpell(oMyPet2, nSpellId);			
		
    //Declare major variables
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl);	
	
	effect eStr =  EffectAbilityIncrease(ABILITY_STRENGTH,4);
	effect eDex =  EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
	effect eCon =  EffectAbilityIncrease(ABILITY_DEXTERITY,4);		
	effect eDR = EffectDamageReduction(5, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
	effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
	effect eLink = EffectLinkEffects(eStr, eDex);
	eLink = EffectLinkEffects(eLink, eCon);
	eLink = EffectLinkEffects(eLink, eDR);
	eLink = EffectLinkEffects(eLink, eSave);		
    eLink = SetEffectSpellId(eLink, nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	if (GetIsObjectValid(oMyPet1))
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oMyPet1, fDuration));	
	if (GetIsObjectValid(oMyPet2))		
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oMyPet2, fDuration));	
		
}