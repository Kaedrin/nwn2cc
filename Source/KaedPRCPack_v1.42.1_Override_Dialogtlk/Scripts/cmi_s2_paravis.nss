//::///////////////////////////////////////////////
//:: Paragon Visionary
//:: cmi_s2_paravis
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"


void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    float fDuration = HoursToSeconds(24);
    int nBonus = GetAbilityModifier(ABILITY_WISDOM, OBJECT_SELF) * 2;
	if (6 > nBonus)
		nBonus = 6;
	if (nBonus > 20)
		nBonus = 20;

	int nSpellId = SPELLABILITY_PARAGON_VISIONARY;
	RemoveSpellEffects(SPELLABILITY_PARAGON_VISIONARY, OBJECT_SELF, OBJECT_SELF);	
	
    effect eSkill1 = EffectSkillIncrease(SKILL_SPOT, nBonus);
	effect eSkill2 = EffectSkillIncrease(SKILL_LISTEN, nBonus);
	effect eTrueSight = EffectTrueSeeing();
   
	effect eDur = EffectVisualEffect(VFX_DUR_INVOCATION_DARKONESLUCK);
    effect eLink = EffectLinkEffects(eTrueSight, eDur);
    eLink = EffectLinkEffects(eLink, eSkill1);
    eLink = EffectLinkEffects(eLink, eSkill2);		
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);	
	
	itemproperty iBonusFeat = ItemPropertyBonusFeat(810);	//Darkvision
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);	
	if (oArmorNew == OBJECT_INVALID)
	{
		oArmorNew = CreateItemOnObject("x2_it_emptyskin", OBJECT_SELF, 1, "", FALSE);
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);		
		ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR);			
		DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));		
	}
	else
	{
        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
	}			

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PARAGON_VISIONARY, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
 
}