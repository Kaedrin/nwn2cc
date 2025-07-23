/*
	nar_tryclear
	
	Checks if the area is empty of players. If so:
	 - the types and positions of all monsters in the area are remembered
	 - the area is cleared of monsters
	 
	This script probably will remember summoned monsters and persist them.
	Infact, it will remember every creature in the area. (friendly summons?)
	TODO: Need to fix this.
	 
	nar_bCleared must be set to FALSE - this is to prevent players from leaving
	and entering the area constantly to cause bad things to happen.
	
	Monsters are stored in this format:
	ResRef: nar_ClearedMonster#ResRef
	Location: nar_ClearedMonster#Location
	Where # is the index, starting from 0.
	
	IMPORTANT: Template Resref and Resource Name of the monster must be the same!
	Else GetResRef() will not work!
	
	18/01/2011 - Narks 
*/

void main()
{
	if (GetLocalInt(OBJECT_SELF, "nar_bCleared") != FALSE)
		return;

	int nPlayerCount = GetLocalInt(OBJECT_SELF, "nar_nPlayerCount");
	if (nPlayerCount == 0)
	{
		// Mark area as cleared, so the area is not attempted to be cleared again.
		SetLocalInt(OBJECT_SELF, "nar_bCleared", TRUE);
		
		// Remember all monsters and remove them.
		object oMonster = GetFirstObjectInArea(OBJECT_SELF);
		int nCount = 0;
		while (GetIsObjectValid(oMonster))
		{
			if (GetObjectType(oMonster) == OBJECT_TYPE_CREATURE)
			{
				string sResRef = GetResRef(oMonster);
				if (sResRef != "")
				{
					// This is a creature, remember the resref and location.
					string sKey = "nar_ClearedMonster" + IntToString(nCount);
				
					SetLocalString(OBJECT_SELF, sKey + "ResRef", sResRef);
					SetLocalLocation(OBJECT_SELF, sKey + "Location", GetLocation(oMonster));
				
					// Remove the creature.
					// AssignCommand(oMonster, SetIsDestroyable(TRUE));
					DestroyObject(oMonster, 0.0);
					nCount++;
				}
			}
			oMonster = GetNextObjectInArea(OBJECT_SELF);
		}
	}
}