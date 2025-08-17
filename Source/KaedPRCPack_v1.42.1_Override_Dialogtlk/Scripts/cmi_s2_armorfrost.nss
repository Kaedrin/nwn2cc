//::///////////////////////////////////////////////
//:: Armor of Frost (and all other Frost Mage abilities)
//:: cmi_s2_armorfrost
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
	
	int nSpellId = SPELLABILITY_ARMOR_FROST;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}		
	
	int nClassLevel = GetLevelByClass(CLASS_FROST_MAGE);
	int nFrostAC = 1;
	if (nClassLevel > 1)
		nFrostAC =  ( (nClassLevel - 1) / 3) + 1;
	
	if (GetHasFeat(490, OBJECT_SELF))
		nFrostAC++;	
	
	//SendMessageToPC(OBJECT_SELF,IntToString(nClassLevel));	
	//SendMessageToPC(OBJECT_SELF,IntToString(nAC));
	int nFrostMageArmorStacks = GetLocalInt(GetModule(), "FrostMageArmorStacks");
	if (nFrostMageArmorStacks)
	{
		int nAC = 0;
		
		object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
		
		//Amulet based AC
		if (GetItemHasItemProperty(oAmuletOld, ITEM_PROPERTY_AC_BONUS))
		{
			itemproperty ipLoop=GetFirstItemProperty(oAmuletOld);
			while (GetIsItemPropertyValid(ipLoop))
			{
			
				//SendMessageToPC(OBJECT_SELF, "InLoop");
			  	if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_AC_BONUS)
				{
				  nAC = GetItemPropertyParam1Value(ipLoop);
				}
			
			   	ipLoop=GetNextItemProperty(oAmuletOld);
			}		
		}
		//Spell based AC
		int nEffAC;
		int nType;
		effect eEffect = GetFirstEffect(OBJECT_SELF);
		while(GetIsEffectValid(eEffect))
	   	{
	      nType = GetEffectType(eEffect);
	      if(nType == EFFECT_TYPE_AC_INCREASE)
		  {

			if (GetEffectInteger(eEffect, 0) == 1)
				nEffAC = GetEffectInteger(eEffect, 1);			
	      }
	      eEffect = GetNextEffect(OBJECT_SELF);
	   	}	
		
		//Final AC	
		if (nEffAC > nAC)
			nAC = nEffAC;
		
		nAC += nFrostAC;	
	}
	
	effect eLink = EffectACIncrease(nFrostAC, AC_NATURAL_BONUS);
	
	if (nClassLevel == 10) //Cold Immun, Fire Vuln
	{
		effect eImmune = EffectDamageResistance(DAMAGE_TYPE_COLD, 9999, 0);		
		effect eVuln = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 50);	
		eLink = EffectLinkEffects(eLink, eImmune);
		eLink = EffectLinkEffects(eLink, eVuln);
	}
	else
	if (nClassLevel > 1) //Cold Resist
	{
		effect eDamRes = EffectDamageResistance(DAMAGE_TYPE_COLD, 10);
		eLink = EffectLinkEffects(eLink, eDamRes);
	}
	
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(48)));
	
}      