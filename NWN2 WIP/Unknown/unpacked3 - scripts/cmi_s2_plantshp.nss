





#include "x2_inc_itemprop"
#include "nwn2_inc_spells"
#include "cmi_ginc_spells"
#include "cmi_ginc_polymorph"

void main()
{

	int nSubrace = GetSubRace(OBJECT_SELF);
	
	int nWisBonus = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, TRUE);
	int nIntBonus = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, TRUE);
	int nChaBonus = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, TRUE);
		
	int nLevel = GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF);
	nLevel += GetLevelByClass(CLASS_VERDANT_GUARDIAN, OBJECT_SELF);
	
    //--------------------------------------------------------------------------
    // Declare major variables
    //--------------------------------------------------------------------------
    int    nSpell = SPELLABILITY_VGUARD_PLANT_SHAPE;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_POLYMORPH);
    effect ePoly;
    int    nPoly = POLYMORPH_TYPE_TREANT;
    
    //--------------------------------------------------------------------------
    // Determine which items get their item properties merged onto the new form.
    //--------------------------------------------------------------------------
    int bWeapon = StringToInt(Get2DAString("polymorph","MergeW",nPoly)) == 1;
    int bArmor  = StringToInt(Get2DAString("polymorph","MergeA",nPoly)) == 1;
    int bItems  = StringToInt(Get2DAString("polymorph","MergeI",nPoly)) == 1;

    //--------------------------------------------------------------------------
    // Store the old objects so we can access them after the character has
    // changed into his new form
    //--------------------------------------------------------------------------
    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld  = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old  = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old  = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld   = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);

    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }


    //--------------------------------------------------------------------------
    // Here the actual polymorphing is done
    //--------------------------------------------------------------------------
    ePoly = EffectPolymorph(nPoly, FALSE, TRUE);	// AFW-OEI 06/06/2007: Use 3rd boolean to say this is a wildshape polymorph.
    ePoly = ExtraordinaryEffect(ePoly);
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
	
	int nHeal = GetMaxHitPoints() - GetCurrentHitPoints();
	if (nHeal > 0)
	{
		effect eHeal = EffectHeal(nHeal);
	    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));		
	}	

    //--------------------------------------------------------------------------
    // This code handles the merging of item properties
    //--------------------------------------------------------------------------
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);

    //identify weapon
    SetIdentified(oWeaponNew, TRUE);

    //--------------------------------------------------------------------------
    // ...Weapons
    //--------------------------------------------------------------------------
    if (bWeapon)
    {
        IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }

    //--------------------------------------------------------------------------
    // ...Armor
    //--------------------------------------------------------------------------
    if (bArmor)
    {
        //----------------------------------------------------------------------
        // Merge item properties from armor and helmet...
        //----------------------------------------------------------------------
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
    }

    //--------------------------------------------------------------------------
    // ...Magic Items
    //--------------------------------------------------------------------------
    if (bItems)
    {
        //----------------------------------------------------------------------
        // Merge item properties from from rings, amulets, cloak, boots, belt
        //----------------------------------------------------------------------
        IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
        IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
        IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
        IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
    }

	float fDuration =  HoursToSeconds(nLevel);	
	object oBracer = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);	

	
	int nUseWildshapeTiers = GetLocalInt(GetModule(), "UseWildshapeTiers");
	if (nUseWildshapeTiers)
	{
		if (nUseWildshapeTiers > 2)
		{
        	IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);	
		}
		if (nUseWildshapeTiers > 1)
		{
	        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
	        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);	
		    if (GetIsObjectValid(oBracer))	
			{
				if (GetBaseItemType(oBracer) == BASE_ITEM_GLOVES)
					IPWildShapeCopyItemProperties(oBracer,oArmorNew);
			}					
		}
		if (nUseWildshapeTiers > 0)
		{
		    IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
		    IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
		    IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
		    if (GetIsObjectValid(oBracer))	
			{
				if (GetBaseItemType(oBracer) == BASE_ITEM_BRACER)
					IPWildShapeCopyItemProperties(oBracer,oArmorNew);
			}		
		}		
	}
		
	WildshapeAbilityBuffs(OBJECT_SELF, fDuration, oWeaponOld, oShield);
	
	itemproperty ipNaturalSpell = ItemPropertyBonusFeat(125);
	AddItemProperty(DURATION_TYPE_TEMPORARY, ipNaturalSpell, oArmorNew, fDuration);
	
	
	int nHD = GetTotalLevels(OBJECT_SELF,FALSE);	
	
	//FEAT_EXALTED_WILD_SHAPE
	if (GetHasFeat(FEAT_EXALTED_WILD_SHAPE))
	{
		
			
		int nDR = 0;
		int nResist = 0;
		int nSR = 5 + nHD;
		
		if (nHD > 7)
			nResist = 10;
		else
			nResist = 5;
			
		if (nHD > 11)
			nDR = 10;
		else
			nDR = 5;			
		
		effect eDarkVis = EffectDarkVision();
		effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
		effect eSR = EffectSpellResistanceIncrease(nSR);
		effect eLink;
					
		if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
		{
			//Fiendish
			effect eDmgRes1 = EffectDamageResistance(DAMAGE_TYPE_FIRE,nResist);
			effect eDmgRes2 = EffectDamageResistance(DAMAGE_TYPE_COLD,nResist);
			
			eLink = EffectLinkEffects(eDmgRes1, eDmgRes2);
	
		}
		else
		{	
			//Celestial
			effect eDmgRes1 = EffectDamageResistance(DAMAGE_TYPE_ACID,nResist);
			effect eDmgRes2 = EffectDamageResistance(DAMAGE_TYPE_COLD,nResist);
			effect eDmgRes3 = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,nResist);
			
			eLink = EffectLinkEffects(eDmgRes1, eDmgRes2);
			eLink = EffectLinkEffects(eLink, eDmgRes3);						
		}				
			
		eLink = EffectLinkEffects(eLink, eDarkVis);	
		eLink = EffectLinkEffects(eLink, eSR);		
		eLink = EffectLinkEffects(eLink, eDR);
		
		eLink = SetEffectSpellId(eLink,SPELLABILITY_EXALTED_WILD_SHAPE);
		eLink = SupernaturalEffect(eLink);
	
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));		
		
		itemproperty iBonusFeat = ItemPropertyBonusFeat(810);	//Darkvision
		AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);		
					
	}	
	
	
	//Fix for Spell Slot loss	
	object oCursedPolyItem = CreateItemOnObject("cmi_cursedpoly",OBJECT_SELF,1,"",FALSE);
	if (oCursedPolyItem == OBJECT_INVALID)
		SendMessageToPC(OBJECT_SELF, "Your Inventory was full so bonus spell slots from items and racial spellcasting stat modifiers will not survive the transition to your new form.");
	
	AddSpellSlotsToObject(oWeaponOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oArmorOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oRing1Old,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oRing2Old,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oAmuletOld,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oCloakOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oBootsOld,oCursedPolyItem, fDuration);			
	AddSpellSlotsToObject(oBeltOld,oCursedPolyItem, fDuration);
	AddSpellSlotsToObject(oHelmetOld,oCursedPolyItem, fDuration);	
	AddSpellSlotsToObject(oShield,oCursedPolyItem, fDuration);
	
	if (nWisBonus > 12)
		nWisBonus = 12;	
	if (nIntBonus > 12)
		nIntBonus = 12;	
	if (nChaBonus > 12)
		nChaBonus = 12;	
						
	itemproperty ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, nWisBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nIntBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nChaBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);							
		
	if (GetHasFeat(FEAT_NATWARR_NATARM_CROC))
	{
		int nAC = 0;
		
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
		nAC = nAC + GetLevelByClass(CLASS_NATURES_WARRIOR);
		
		if (GetHasFeat(490, OBJECT_SELF))
			nAC++;	
				
		effect eAC = EffectACIncrease(nAC, AC_NATURAL_BONUS);
		eAC = ExtraordinaryEffect(eAC);	
		eAC = SetEffectSpellId(eAC,-FEAT_NATWARR_NATARM_CROC);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, fDuration));				
	}
	if (GetHasFeat(FEAT_NATWARR_NATARM_GRIZZLY))
	{
		effect eDmg = EffectDamageIncrease(3);
		eDmg = ExtraordinaryEffect(eDmg);
		eDmg = SetEffectSpellId(eDmg,-FEAT_NATWARR_NATARM_GRIZZLY);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmg, OBJECT_SELF, fDuration));		
	
	}
	if (GetHasFeat(FEAT_NATWARR_NATARM_GROWTH))
	{
		effect eRegen = EffectRegenerate(1, 6.0f);
		eRegen = ExtraordinaryEffect(eRegen);
		eRegen = SetEffectSpellId(eRegen,-FEAT_NATWARR_NATARM_GROWTH);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, fDuration));		
		
	}
			
	if (GetHasFeat(FEAT_NATWARR_NATARM_EARTH))
	{
		int nDR = 3;
		if (GetHasFeat(494))
		{
			nDR += 9;
		}
		else
		if (GetHasFeat(493))
		{
			nDR += 6;
		}	
		else
		if (GetHasFeat(492))
		{
			nDR += 3;
		}
		
		if (GetHasFeat(1253))
			nDR++;		
	
		effect eDR = EffectDamageReduction(nDR, DR_TYPE_NONE, 0, DR_TYPE_NONE);
		eDR = SetEffectSpellId(eDR,-FEAT_NATWARR_NATARM_EARTH);
		eDR = ExtraordinaryEffect(eDR);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDR, OBJECT_SELF, fDuration));		
		
	}   
	
	if (GetHasFeat(FEAT_SILVER_FANG))
	{
		ApplySilverFangEffect(OBJECT_SELF);	
	}	
	
	if (GetHasSpellEffect(SPELLABILITY_FOTF_AC_BONUS,OBJECT_SELF))
	{
		RemoveSpellEffects(SPELLABILITY_FOTF_AC_BONUS, OBJECT_SELF, OBJECT_SELF);	
	}	
	    
	WildshapeCheck (OBJECT_SELF,oCursedPolyItem);
	if (GetLocalInt(GetModule(), "UnarmedPolymorphFeatFix"))
		DelayCommand(2.0f, WildShape_Unarmed(oTarget, fDuration));			
    //--------------------------------------------------------------------------
    // Decrement wildshape uses
    //--------------------------------------------------------------------------
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_VGUARD_PLANT_SHAPE1);
}