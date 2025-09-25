//::///////////////////////////////////////////////
//:: Greater Wild Shape, Humanoid Shape
//:: x2_s2_gwildshp
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the character to shift into one of these
    forms, gaining special abilities

    Credits must be given to mr_bumpkin from the NWN
    community who had the idea of merging item properties
    from weapon and armor to the creatures new forms.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-02
//:://////////////////////////////////////////////
// AFW-OEI 05/04/2007: Handle Plant Wild Shape, too.

#include "x2_inc_itemprop"
#include "nwn2_inc_spells"
#include "cmi_ginc_spells"
#include "cmi_ginc_polymorph"

void main()
{
    // AFW-OEI 02/28/2007: Early-out if you have no wildshape uses left.
    if (!GetHasFeat(FEAT_WILD_SHAPE, OBJECT_SELF))
    {
        SpeakStringByStrRef(STR_REF_FEEDBACK_NO_MORE_FEAT_USES);
        return;
    }
	
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
		IncrementRemainingFeatUses(OBJECT_SELF, 305);
	}	
		
	RemoveEffectsFromSpell(OBJECT_SELF, SPELL_SPIRIT_BEAR);		
	int nSubrace = GetSubRace(OBJECT_SELF);
	
	int nWisBonus = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, TRUE);
	int nIntBonus = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, TRUE);
	int nChaBonus = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, FALSE) - GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, TRUE);
		

    //--------------------------------------------------------------------------
    // Declare major variables
    //--------------------------------------------------------------------------
    int    nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_POLYMORPH);
    //int    nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER);
    effect ePoly;
    int    nPoly;

    // Feb 13, 2004, Jon: Added scripting to take care of case where it's an NPC
    // using one of the feats. It will randomly pick one of the shapes associated
    // with the feat.
    switch(nSpell)
    {
        // Greater Wildshape I
        case 646: nSpell = Random(5)+658; break;
        // Greater Wildshape II
        case 675: switch(Random(3))
                  {
                    case 0: nSpell = 672; break;
                    case 1: nSpell = 678; break;
                    case 2: nSpell = 680;
                  }
                  break;
        // Greater Wildshape III
        case 676: switch(Random(3))
                  {
                    case 0: nSpell = 670; break;
                    case 1: nSpell = 673; break;
                    case 2: nSpell = 674;
                  }
                  break;
        // Greater Wildshape IV
        case 677: switch(Random(3))
                  {
                    case 0: nSpell = 679; break;
                    case 1: nSpell = 691; break;
                    case 2: nSpell = 694;
                  }
                  break;
        // Humanoid Shape
        case 681:  nSpell = Random(3)+682; break;
        // Undead Shape
        case 685:  nSpell = Random(3)+704; break;
        // Dragon Shape
        case 725:  nSpell = Random(3)+707; break;
        // Outsider Shape
        case 732:  nSpell = Random(3)+733; break;
        // Construct Shape
        case 737:  nSpell = Random(3)+738; break;
        // Magical Beast Wild Shape
        case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE:
            nSpell = Random(3)+SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_CELESTIAL_BEAR; break;
		// Plant Wild Shape
		case SPELLABILITY_PLANT_WILD_SHAPE:
			nSpell = Random(2) + SPELLABILITY_PLANT_WILD_SHAPE_SHAMBLING_MOUND; break;	// 2 forms to choose from
    }
	
	int nFeatId = 0;
	int nSR = 0;

    //--------------------------------------------------------------------------
    // Determine which form to use based on spell id, gender and level
    //--------------------------------------------------------------------------
    switch (nSpell)
    {
       
       //-----------------------------------------------------------------------
       // Dragon Shape - Red, Blue, and Black Dragons
       //-----------------------------------------------------------------------
       case 707: 
	   {
	   int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
	   int nHD = GetWildShapeLevel(OBJECT_SELF);
		if (nDruid > 29)
		{
			nPoly = DRAGONSHAPE_RED_DRAGON_30;
			nSR = 26;
		}
		else
		if (nHD > 27)
		{
			nPoly = DRAGONSHAPE_RED_DRAGON_28;
			nSR = 24;
		}
		else
		{
			nPoly = DRAGONSHAPE_RED_DRAGON_25;	
			nSR = 23;
		}		
	   }		break;    // Red Dragon
	   
       case 708: 
	   {
	   int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
	   int nHD = GetWildShapeLevel(OBJECT_SELF);
		if (nDruid > 29)
		{
			nPoly = DRAGONSHAPE_BLUE_DRAGON_30;
			nSR = 25;
		}
		else
		if (nHD > 26)
		{
			nPoly = DRAGONSHAPE_BLUE_DRAGON_27;
			nSR = 24;
		}
		else
		{
			nPoly = DRAGONSHAPE_BLUE_DRAGON_24;	
			nSR = 22;
		}		
	   }		break;    // Blue Dragon
	   
       case 709: 
	   {
	   int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
	   int nHD = GetWildShapeLevel(OBJECT_SELF);
		if (nDruid > 29)
		{
			nPoly = DRAGONSHAPE_BLACK_DRAGON_30;
			nSR = 25;
		}
		else
		if (nHD > 27)
		{
			nPoly = DRAGONSHAPE_BLACK_DRAGON_28;
			nSR = 23;
		}
		else
		{	
			nPoly = DRAGONSHAPE_BLACK_DRAGON_25;
			nSR = 22;
		}			
	   }		break;    // Black Dragon
	   
	   
       case Greater_Wild_Shape_Bronze_Dragon: 
	   {
	   int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
	   int nHD = GetWildShapeLevel(OBJECT_SELF);
		if (nDruid > 29)
		{
			nPoly = DRAGONSHAPE_BRNZE_DRAGON_30;
			nSR = 25;
		}
		else
		if (nHD > 26)
		{
			nPoly = DRAGONSHAPE_BRNZE_DRAGON_27;
			nSR = 24;
		}
		else
		{
			nPoly = DRAGONSHAPE_BRNZE_DRAGON_24;	
			nSR = 22;
		}		
	   }		break;    // Bronze  Dragon
	   	   
       case Greater_Wild_Shape_White_Dragon: 
	   {
	   int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
	   int nHD = GetWildShapeLevel(OBJECT_SELF);
		if (nDruid > 29)
		{
			nPoly = DRAGONSHAPE_WHITE_DRAGON_30;
			nSR = 25;
		}
		else
		if (nHD > 27)
		{
			nPoly = DRAGONSHAPE_WHITE_DRAGON_28;
			nSR = 23;
		}
		else
		{	
			nPoly = DRAGONSHAPE_WHITE_DRAGON_25;
			nSR = 22;
		}			
	   }		break;    // White Dragon
	   
	   	   

       //-----------------------------------------------------------------------
       // Magical Beast Wild Shape - Celestial Leopard, Phase Spider, Winter Wolf
       //-----------------------------------------------------------------------
       case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_CELESTIAL_BEAR: 
            nPoly = POLYMORPH_TYPE_CELESTIAL_LEOPARD; break;    // Celestial Leopard; yes, everything says bear, but we don't have a bear in NX1
       case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_PHASE_SPIDER:
            nPoly = POLYMORPH_TYPE_PHASE_SPIDER; break;      // Phase Spider
       case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_WINTER_WOLF:
            nPoly = POLYMORPH_TYPE_WINTER_WOLF; break;       // Winter Wolf
			
	   //-----------------------------------------------------------------------
       // Plant Wild Shape -- Shambling Mound, Treant
       //-----------------------------------------------------------------------
       case SPELLABILITY_PLANT_WILD_SHAPE_SHAMBLING_MOUND: 
            nPoly = POLYMORPH_TYPE_SHAMBLING_MOUND; break;    // Shambling Mound
       case SPELLABILITY_PLANT_WILD_SHAPE_TREANT:
            nPoly = POLYMORPH_TYPE_TREANT; break;      // Treant

    }		


    //--------------------------------------------------------------------------
    // Determine which items get their item properties merged onto the shifters
    // new form.
    //--------------------------------------------------------------------------
    /* AFW-OEI 02/28/2007: No more shifter stuff
    int bWeapon = ShifterMergeWeapon(nPoly);
    int bArmor  = ShifterMergeArmor(nPoly);
    int bItems  = ShifterMergeItems(nPoly);
    */
    
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


    //--------------------------------------------------------------------------
    // Here the actual polymorphing is done
    //--------------------------------------------------------------------------
    ePoly = EffectPolymorph(nPoly, FALSE, TRUE);	// AFW-OEI 06/06/2007: Use 3rd boolean to say this is a wildshape polymorph.
    if (nSR > 0)
	{
		effect eSR = EffectSpellResistanceIncrease(nSR);
		ePoly = EffectLinkEffects(ePoly, eSR);
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
				
	
	if (!GetHasFeat(FEAT_NATURAL_SPELL))
	{
		effect eSpellFailure = EffectSpellFailure(100);
		ePoly = EffectLinkEffects( ePoly, eSpellFailure );
	}		
	
	ePoly = SupernaturalEffect(ePoly);
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
		
	

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

    //--------------------------------------------------------------------------
    // Set artificial usage limits for special ability spells to work around
    // the engine limitation of not being able to set a number of uses for
    // spells in the polymorph radial
    //--------------------------------------------------------------------------
    //ShifterSetGWildshapeSpellLimits(nSpell);  // AFW-OEI 02/28/2007: No more shifter stuff

	
	
	
	float fDuration =  HoursToSeconds(72);	

	
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
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_WILD_SHAPE);
}