//::///////////////////////////////////////////////
//:: Elemental Shape
//:: NW_S2_ElemShape
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the Druid to change into elemental forms.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////
//:: AFW-OEI 07/29/2006:
//::	Default to fire elemental

#include "x2_inc_itemprop"
#include "cmi_ginc_spells"
#include "cmi_ginc_polymorph"

void main()
{

	if (GetHasSpellEffect(SPELL_Plant_Body))	
	{
		SendMessageToPC(OBJECT_SELF, "Wildshape failed.  The spell Plant Body prevents shifting forms.");
		int nFeatId = GetSpellFeatId();
		IncrementRemainingFeatUses(OBJECT_SELF, nFeatId);
		return;
	}
	IsModuleSupported(FALSE);	
	if (GetLocalInt(GetModule(), "UnlimitedWildshapeUses"))
	{
		IncrementRemainingFeatUses(OBJECT_SELF, 304);
	}	
	RemoveEffectsFromSpell(OBJECT_SELF, SPELL_SPIRIT_BEAR);	
	int nSubrace = GetSubRace(OBJECT_SELF);
	//int	nBonus = StringToInt(Get2DAString("racialsubtypes.2da", "WisAdjust", nSubrace));
	int nWisBonus = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, TRUE);
	int nIntBonus = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, TRUE);
	int nChaBonus = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, TRUE);
	
	
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect( VFX_DUR_POLYMORPH );
	eVis = SupernaturalEffect(eVis);	// AFW-OEI 12/07/2006: Make it so you can't dispel the visual effect, which was dispelling wildshape.
    effect ePoly;
    int nPoly;
    int nDuration = GetWildShapeLevel(OBJECT_SELF);
		
    int bElder = FALSE;
    if(nDuration >= 20)
    {
        bElder = TRUE;
    }
    //Determine Polymorph subradial type
	
	int nElement;
	
    if(bElder == FALSE)
    {
		if (nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_FIRE;
        }	
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_WATER;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_EARTH;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_AIR;
        }
        else
        {
			//nPoly = POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
            nPoly = POLYMORPH_TYPE_EMBER_GUARD;
			nElement = ELEMENTAL_TYPE_FIRE;
			DecrementRemainingFeatUses(OBJECT_SELF, 304);
        }
    }
    else
    {
		if (nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_FIRE;
        }		
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_WATER;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_EARTH;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL;
			nElement = ELEMENTAL_TYPE_AIR;
        }
        else
        {
            //nPoly = POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL;
			nPoly = POLYMORPH_TYPE_EMBER_GUARD;
			nElement = ELEMENTAL_TYPE_FIRE;
			DecrementRemainingFeatUses(OBJECT_SELF, 304);			
        }
    }
	
	if (nPoly == POLYMORPH_TYPE_EMBER_GUARD)
	{
		if (nDuration < 25)
			nPoly = POLYMORPH_TYPE_LESS_EMBER_GUARD;
	}

    ePoly = EffectPolymorph(nPoly, FALSE, TRUE);	// AFW-OEI 11/27/2006: Use 3rd boolean to say this is a wildshape polymorph.
	ePoly = EffectLinkEffects( ePoly, eVis );
	
	
	if (!GetHasFeat(FEAT_NATURAL_SPELL))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}		

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_ELEMENTAL_SHAPE, FALSE));

    int bWeapon = StringToInt(Get2DAString("polymorph","MergeW",nPoly)) == 1;
    int bArmor  = StringToInt(Get2DAString("polymorph","MergeA",nPoly)) == 1;
    int bItems  = StringToInt(Get2DAString("polymorph","MergeI",nPoly)) == 1;

    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
	object oBracer = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
		
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }

	int iAC;
	int iEnhanceAC;
	int iDeflAC;
	int iNatAC;
	int iDodgeAC;
	//int iShieldAC;
	
	//Armor Enhance
	iEnhanceAC = GetItemACValue(oBracer);
	iAC = IPGetWeaponEnhancementBonus(oArmorOld, ITEM_PROPERTY_AC_BONUS);
	if (iAC > iEnhanceAC)
		iEnhanceAC = iAC;

	//Defl
	iDeflAC = GetItemACValue(oRing1Old);
	iAC = GetItemACValue(oRing2Old);
	if (iAC > iDeflAC)
		iDeflAC = iAC;
	iAC = GetItemACValue(oCloakOld);
	if (iAC > iDeflAC)
		iDeflAC = iAC;
	iAC = GetItemACValue(oHelmetOld);
	if (iAC > iDeflAC)
		iDeflAC = iAC;	
	iAC = GetItemACValue(oBeltOld);
	if (iAC > iDeflAC)
		iDeflAC = iAC;
			
	//Nat AC	
	iNatAC = GetItemACValue(oAmuletOld);	

	//Dodge
	iDodgeAC = GetItemACValue(oBootsOld);
	
	//Shield AC
	//iShieldAC = IPGetWeaponEnhancementBonus(oShield, ITEM_PROPERTY_AC_BONUS);
		
	if (iEnhanceAC > 0)
	{
		effect eEnhAC = EffectACIncrease(iEnhanceAC, AC_ARMOUR_ENCHANTMENT_BONUS);
		ePoly = EffectLinkEffects(ePoly, eEnhAC);
	}
	if (iDeflAC > 0)
	{
		effect eDefAC = EffectACIncrease(iDeflAC, AC_DEFLECTION_BONUS);
		ePoly = EffectLinkEffects(ePoly, eDefAC);
	}
	if (iNatAC > 0)
	{
		effect eNatAC = EffectACIncrease(iNatAC, AC_NATURAL_BONUS);
		ePoly = EffectLinkEffects(ePoly, eNatAC);
	}
	if (iDodgeAC > 0)
	{
		effect eDodAC = EffectACIncrease(iDodgeAC, AC_DODGE_BONUS);
		ePoly = EffectLinkEffects(ePoly, eDodAC);
	}
	//if (iShieldAC > 0)
	//{
	//	effect eShiAC = EffectACIncrease(iShieldAC, AC_SHIELD_ENCHANTMENT_BONUS);
	//	ePoly = EffectLinkEffects(ePoly, eShiAC);
	//}	
	
	
	int nHeal = GetMaxHitPoints() - GetCurrentHitPoints();
	if (nHeal > 0 && (GetLocalInt(GetModule(), "AllowWildshapeHeal")))
	{
		effect eHeal = EffectHeal(nHeal);
	    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));		
	}
	else
	{
		effect eHeal = EffectHeal(1);
	    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));		
	}	
				
	ePoly = SupernaturalEffect(ePoly);
    //Apply the VFX impact and effects
    ClearAllActions(); // prevents an exploit
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));

	
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);

    if (bWeapon)
    {
            IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }
    if (bArmor)
    {
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
    }
    if (bItems)
    {
        IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
        IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
        IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
        IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
    }
	
	float fDuration =  HoursToSeconds(72);		
	//Allow jewelery to affect wildshape per pnp	

	
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
		
		//eLink = SetEffectSpellId(eLink,nSpellId);
		eLink = SupernaturalEffect(eLink);
	
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);		
		
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
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,HoursToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, nIntBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,HoursToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

	ipNewEnhance = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, nChaBonus);  	  
	IPSafeAddItemProperty(oCursedPolyItem, ipNewEnhance,HoursToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);

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
			
		if (GetHasFeat(490, OBJECT_SELF))
			nAC++;	
						
		nAC = nAC + GetLevelByClass(CLASS_NATURES_WARRIOR);
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
	
	if (nElement == ELEMENTAL_TYPE_AIR && GetHasFeat(FEAT_NATWARR_NATARM_CLOUD))
	{
		effect eConceal = EffectConcealment(20);
		eConceal = SetEffectSpellId(eConceal,-FEAT_NATWARR_NATARM_CLOUD);
		eConceal = ExtraordinaryEffect(eConceal);
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConceal, OBJECT_SELF, fDuration));		
				
	}
	
	if (nElement == ELEMENTAL_TYPE_FIRE && nPoly == POLYMORPH_TYPE_EMBER_GUARD)
	{
		effect eShield = EffectDamageShield(0, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
		effect eSR = EffectSpellResistanceIncrease(24);
		effect eDR = EffectDamageReduction(15, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
		effect eLink = EffectLinkEffects(eShield, eSR);
		eLink = EffectLinkEffects(eLink, eDR);
		eLink = ExtraordinaryEffect(eLink);	
		eLink = SetEffectSpellId(eLink,-FEAT_NATWARR_NATARM_BLAZE);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));		
		
	}	
	else
	if (nElement == ELEMENTAL_TYPE_FIRE && nPoly == POLYMORPH_TYPE_LESS_EMBER_GUARD)
	{
		effect eShield = EffectDamageShield(0, DAMAGE_BONUS_1d4, DAMAGE_TYPE_FIRE);
		effect eSR = EffectSpellResistanceIncrease(24);
		effect eDR = EffectDamageReduction(10, GMATERIAL_METAL_ADAMANTINE, 0, DR_TYPE_GMATERIAL);
		effect eLink = EffectLinkEffects(eShield, eSR);
		eLink = EffectLinkEffects(eLink, eDR);
		eLink = ExtraordinaryEffect(eLink);	
		eLink = SetEffectSpellId(eLink,-FEAT_NATWARR_NATARM_BLAZE);		
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));			
	}	
	else
	if (nElement == ELEMENTAL_TYPE_FIRE && GetHasFeat(FEAT_NATWARR_NATARM_BLAZE))
	{
		effect eShield = EffectDamageShield(0, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
		eShield = SetEffectSpellId(eShield,-FEAT_NATWARR_NATARM_BLAZE);
		eShield = ExtraordinaryEffect(eShield);	
		DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShield, OBJECT_SELF, fDuration));		
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

}