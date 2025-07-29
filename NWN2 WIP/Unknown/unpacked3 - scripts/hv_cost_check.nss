// To place On Inventory Interrupted for the recharger.
void main()
{
	object oItem = GetFirstItemInInventory();
	if (GetIsObjectValid(oItem)) {
	
		// Higher price for wands
		int nModifier = 750;
		if (GetBaseItemType(oItem) == 106){ // 106 = wand
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
		object oLever = GetNearestObjectByTag("hv_charger_lever");
		AssignCommand(oLever, SpeakString("Cost to recharge: " + IntToString(nCurrentItemCost)));
		SetFirstName(oLever, "Cost: " + IntToString(nCurrentItemCost));
	}		
}