int GetPartySize(object oEntObj) 
{
	int nPartySize = 0;
 
 	// Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oEntObj, TRUE);
	
    // We stop when there are no more valid PC's in the party.
	while(GetIsObjectValid(oPartyMember) == TRUE)
	{
		if(GetLocation(oPartyMember) == GetLocation(oEntObj))
		{
     		// Increment size by one.
			// If they are in same area.
        	nPartySize++;
		}
        // Get the next PC member of oPC's faction.
        oPartyMember = GetNextFactionMember(oEntObj, TRUE);
    }
	
	return nPartySize;
}