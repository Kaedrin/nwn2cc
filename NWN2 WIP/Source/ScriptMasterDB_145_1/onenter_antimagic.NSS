void RemoveCreatureEffects(object creature)
{
	effect eEffect = GetFirstEffect(creature);
	while(GetIsEffectValid(eEffect))
	{
		int effectDur = GetEffectDurationType(eEffect);
		
		if(effectDur == DURATION_TYPE_TEMPORARY)
		{
			RemoveEffect(creature, eEffect);
		}
	
		eEffect = GetNextEffect(creature);
	}
}

void RemoveEffectsOnItem(object oItem)
{
	itemproperty ipLoop=GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipLoop))
	{
		int durType = GetItemPropertyDurationType(ipLoop);
		if (durType == DURATION_TYPE_TEMPORARY)
		{
			RemoveItemProperty(oItem, ipLoop);
		}
		ipLoop = GetNextItemProperty(oItem);
	}
}

void RemoveEffectsOnSlotItem(int slot, object creature)
{
	object oItem = GetItemInSlot(slot, creature);
	if(GetIsObjectValid(oItem))
	{
		RemoveEffectsOnItem(oItem);
	}
}

void RemoveItemEffects(object creature)
{
	RemoveEffectsOnSlotItem(INVENTORY_SLOT_CHEST, creature);
	RemoveEffectsOnSlotItem(INVENTORY_SLOT_LEFTHAND, creature);
	RemoveEffectsOnSlotItem(INVENTORY_SLOT_RIGHTHAND, creature);
	
	// check the PCs inventory and remove temporary effects on items there
	// to avoid casting on them before they enter and then simply reequipping
	if (GetIsPC(creature))
	{
	    object oItem = GetFirstItemInInventory(creature);
	    
		//While the item is a valid object
    	while(GetIsObjectValid(oItem))
    	{
			RemoveEffectsOnItem(oItem);
	    
		    // get the next item in the players inventory
    	    oItem = GetNextItemInInventory(creature);
		}
	}
}

void DoAntimagic(object creature)
{
	RemoveCreatureEffects(creature);
	RemoveItemEffects(creature);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellFailure(), creature);
	
	// create a supernatural silence effect that is not removed by resting
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSilence()), creature);
	
	// Optionally:
	// Set remaining uses of wildshape to zero to disable all related druid abilities
	// These abilities seem to be hardcoded and can't be intercepted
/*
	int i = 0;
	for (i = 0; i < 20; i++)
		DecrementRemainingFeatUses(creature, FEAT_WILD_SHAPE);
*/
	
	SetLocalInt(creature, "ps_anti_magic_zone", 1);
}

void main()
{
	object oPC = GetEnteringObject();
	string sDeityFail;
	string sDeityOnly;
	object oArea;
	string sDeity;
	
	if(oPC != OBJECT_INVALID)
	{
		oArea = GetArea(oPC);
		sDeity = GetDeity(oPC);
		if(oArea != OBJECT_INVALID)
		{
			sDeityFail = GetLocalString(oArea, "DeityFail");
			sDeityOnly = GetLocalString(oArea, "DeityOnly");
		}
		
		if(sDeityOnly != "" && sDeity != sDeityOnly)
			DoAntimagic(oPC);
		else if(sDeityFail != "" && sDeity == sDeityFail)
			DoAntimagic(oPC);
	}
}