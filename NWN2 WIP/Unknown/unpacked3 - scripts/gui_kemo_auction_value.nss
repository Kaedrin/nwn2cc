#include "kemo_auction_includes"

void main(string sItemNumber)
{
	object oPC = OBJECT_SELF;
	object oItem = GetItemFromList(oPC, sItemNumber); //find the sale item from the list
	int iValue = GetGoldPieceValue(oItem);
	int iCommission = FloatToInt(iValue * COMMISSION_PERCENTAGE);
		if (iCommission < COMMISSION_MINIMUM) iCommission = COMMISSION_MINIMUM;
		if (iCommission > COMMISSION_MAXIMUM) iCommission = COMMISSION_MAXIMUM;
	int iCommissionPct = FloatToInt(COMMISSION_PERCENTAGE * 100.0f);
	
	string sValue = IntToString(iValue);
	string sCommission = IntToString(iCommission);
	string sCommissionPct = IntToString(iCommissionPct);
	string sCommissionConst = IntToString(COMMISSION_SET_VALUE);
	string sCommissionMin = IntToString(COMMISSION_MINIMUM);
	
	SendMessageToPC(oPC,THIS_ITEM_VALUED + sValue + GOLD_ABBREVIATION);
	
	switch (COMMISSION_USE_VALUE)
	{
		case 0:
		{
			if (COMMISSION_PERCENTAGE >= 0.01f)
				SendMessageToPC(oPC,POSTING_COMMISSION_WOULD_BE + sCommissionPct + PERCENT_OF_SALE_PRICE + sCommissionMin + GOLD_ABBREVIATION);
			else SendMessageToPC(oPC,LESS_THAN_ONE_PERCENT + sCommissionMin + GOLD_ABBREVIATION);
		} break;
		case 1: SendMessageToPC(oPC,POSTING_COMMISSION_WOULD_BE + sCommission + GOLD_ABBREVIATION); break;
		case 2: SendMessageToPC(oPC,POSTING_COMMISSION_AT_LEAST + sCommission + GOLD_ABBREVIATION); break;
		case 3: SendMessageToPC(oPC,POSTING_COMMISSION_WOULD_BE + sCommissionConst + GOLD_ABBREVIATION); break;
	}
}