// Make summoners speak strings,
// and attack player
void main()
{	
	// Change var so we don't run this again 
	// and again
	if (GetLocalInt(GetArea(OBJECT_SELF), "hv_hostile_summoners") == 0)
		return;
		
	SetLocalInt(GetArea(OBJECT_SELF), "hv_hostile_summoners", 0);
	
	// Remove visual effects from ritual
	object oBoss = GetObjectByTag("hv_temple_boss");
	if (GetIsObjectValid(oBoss)) {
		effect eEffect = GetFirstEffect(oBoss);
		while (GetIsEffectValid(eEffect)) {
			RemoveEffect(oBoss, eEffect);
			eEffect = GetNextEffect(oBoss);
		}
	}

	// Go through each summoner and make it hostile
	int i;
	object oSummoner;
	for (i = 0; i < 4; i++) {
		
		// Get summoner
		oSummoner = GetObjectByTag("hv_temple_summoner", i);
		
		if (GetIsObjectValid(oSummoner)) {	
			// Make first one speak
			if (i == 3)
				AssignCommand(oSummoner, SpeakString("Get the intruders!"));
		
			// Make it hostile
			DelayCommand(2.0f, ChangeToStandardFaction(oSummoner, STANDARD_FACTION_HOSTILE));
		}
	}
}