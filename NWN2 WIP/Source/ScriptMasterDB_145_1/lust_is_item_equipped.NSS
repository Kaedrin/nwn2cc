 /*///////////////////////////////////////////////////////////////////////////////
//This function inspects the eqquipment of the character looking the item.
//
//sTarget is the creature tag, "" to use the GetLastSpeaker or "*" to use GetPCSpeaker
//sItemTag is the item tag to check for
//iItemSlot is where is the item eqquiped:
// 0: Head - 1: Chest - 2: Boots - 3: Arms - 4: R Hand - 5: L Hand - 6: Cloak
// 7: L Ring - 8: R Ring - 9: Neck - 10: Belt - 11: Arrows - 12: Bullets - 13: Bolts
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 17-05-2013 [DDMMYYYY]
//Webpage: www.lustabel.eu
//------------------------------------------------------------------------------*/
int StartingConditional(string sTarget, string sItemTag, int iItemSlot)
{
	object oTarget;
	if (sTarget=="") 
		oTarget = GetLastSpeaker();
	else
	if (sTarget=="*") 
		oTarget = GetPCSpeaker();
	else
		oTarget = GetObjectByTag(sTarget);
		
	return (GetTag(GetItemInSlot(iItemSlot, oTarget)) == sItemTag);
	SpeakString("Item: "+sItemTag);
}
//------------------------------------------------------------------------------//