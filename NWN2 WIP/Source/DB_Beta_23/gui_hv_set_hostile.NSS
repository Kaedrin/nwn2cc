void main()
{
	// Get PC's target
	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);
	//SendMessageToPC(OBJECT_SELF, "Ella is awesome.");
	
	if ((GetIsPC(oTarget)) && (!GetIsDM(oTarget))) {
		
		// if hostile make friendly,
		// if friendly make hostile
		if (GetIsEnemy(oTarget)) {
			SendMessageToPC(OBJECT_SELF, "Setting to friendly.");
			SetPCLike(OBJECT_SELF, oTarget);
			SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " set you to friendly.");
		}
		else {
			SendMessageToPC(OBJECT_SELF, "Setting to hostile.");
			SetPCDislike(OBJECT_SELF, oTarget);
			SendMessageToPC(oTarget, GetName(OBJECT_SELF) + " set you to hostile.");
		}
	}
}