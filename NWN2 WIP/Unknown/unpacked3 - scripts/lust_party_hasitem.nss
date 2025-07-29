int PartyItem(object oPC, string sItem)
{
	object oFM;

        oFM =  GetFirstFactionMember(oPC, FALSE);
        while( GetIsObjectValid(oFM) )
        {
            if(GetIsObjectValid(GetItemPossessedBy(oFM,sItem)) ) return TRUE;
            oFM = GetNextFactionMember(oPC, FALSE);
        }
 
    return FALSE;
}