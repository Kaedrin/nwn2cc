// To put On Used for the recharger lever
void main()
{
	object oRecharger = GetNearestObjectByTag("hv_wand_recharger");
	//object oRecharger = GetObjectByTag(GetLocalString(OBJECT_SELF, "RECHARGER"));
	object oItem = GetFirstItemInInventory(oRecharger);
	object oPC = GetLastUsedBy();
	
	if (GetIsObjectValid(oItem) && 
		(GetBaseItemType(oItem) == BASE_ITEM_ENCHANTED_WAND
 		|| GetBaseItemType(oItem) ==  BASE_ITEM_MAGICROD
		)
	) {
	
		// Higher price for wands
		int nModifier = 750;
		if (GetBaseItemType(oItem) == BASE_ITEM_ENCHANTED_WAND){ // 106 = wand
			nModifier = 1125;
		}
		
		// Check number of charges left on item
		int nChargesLeft = GetItemCharges(oItem);
		int nChargesNeeded = 50 - nChargesLeft;		
				
		// Get spell row in 2DA
		itemproperty iProp = GetFirstItemProperty(oItem);
		int nInfoRow = GetItemPropertySubType(iProp);
		
		// Get caster level and Innate level of spell
		string sCasterLevel = Get2DAString("iprp_spells", "CasterLvl", nInfoRow);
		string sInnateLevel = Get2DAString("iprp_spells", "InnateLvl", nInfoRow);
		int nCasterLevel = StringToInt(sCasterLevel);
		int nInnateLevel = StringToInt(sInnateLevel);
		
		// Calculate price for 1 charge
		int nWandValue = nCasterLevel * nInnateLevel * nModifier;
		
		if (nWandValue < 50)
			nWandValue = 50;
		
		int nOneChargeValue = nWandValue / 50;
		
		// Calculate value for current wand
		int nCurrentItemCost = nOneChargeValue * nChargesNeeded;
		
		// Display cost on lever
		//object oLever = GetObjectByTag("hv_charger_lever");
		object oLever = OBJECT_SELF;
		SetFirstName(oLever, "Cost: " + IntToString(nCurrentItemCost));
		
		if(GetGold(oPC)>=nCurrentItemCost)
		{
			// Take gold and inform PC
			TakeGoldFromCreature(nCurrentItemCost, oPC);
			SendMessageToPC(oPC, "Wand recharged successfully.");
		}
		else
		{
			SendMessageToPC(oPC, "You do not currently possess enough gold to recharge your wand.");
			return;
		}
			
		// Charge wand with awesome VFX
		location lTarget = GetLocation(oRecharger);
    	effect eAOE = EffectVisualEffect(VFX_FNF_CRAFT_ALCHEMY);
    	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eAOE, lTarget);
		SetItemCharges(oItem, 50);
	}
}