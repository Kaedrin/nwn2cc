void main()
{
	object pc = GetLastOpenedBy();
	object chest = OBJECT_SELF;
	
	// player never opened it before
	if (GetLocalInt(chest, ObjectToString(pc)) == 0) {
		CreateItemOnObject("NW_IT_TORCH001", chest);
		CreateItemOnObject("AMR_IT_BRASS_LANTERN", chest);
		CreateItemOnObject("AMR_IT_LANTERN02", chest);
		CreateItemOnObject("AMR_IT_LANTERN03", chest);
		
		SetLocalInt(chest, ObjectToString(pc), 1);
	}
	
	// already opened chest
	else {
		SendMessageToPC(pc, "Chest already opened by you.");
	}
}