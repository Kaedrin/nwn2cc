// Declare function.
void DoEffect(object oPC, int nVisual, string sType, object oTarget);

// sType - "D" for Duration, "I" for instant, "R" to remove effect.
void main(string sEffect, string sType)
{
	return; // disabled
	object oPC = OBJECT_SELF;
	object oTarget = GetPlayerCurrentTarget(oPC);
	
	// If target invalid - set it to oPC
	if (!GetIsObjectValid(oTarget))
		oTarget = oPC;
	
	// Get VFX number.
	int nVisual = StringToInt(sEffect);
	
	// Apply effect on target
	DoEffect(oPC, nVisual, sType, oTarget);
	
}

void DoEffect(object oPC, int nVisual, string sType, object oTarget)
{
	// Create effect	
	effect eVisual = EffectVisualEffect(nVisual);
	
	// Duration or Instant?
	if (sType == "I")
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
	else if (sType == "D") {
		float fDuration = 99999.0;
		// Duration - check if one is running
		int nDurRunning = GetLocalInt(oPC, "hv_dur_vfx");
		if (nDurRunning == 1) // Already one running.
			SendMessageToPC(oPC, "Already running one effect.");
		else {
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oTarget, fDuration);
			SetLocalInt(oPC, "hv_dur_vfx", 1);
			SetLocalInt(oPC, "hv_vfx_int", nVisual);
		}
	}
	// Remove effect
	else if	(sType == "R") {	
		
		// Loop through all effects on oTarget
        effect eCheck = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eCheck))
        {
            // Check creator
            if ((GetEffectCreator(eCheck) == oPC) && (GetEffectInteger(eCheck,0)== GetLocalInt(oPC, "hv_vfx_int"))) {
			
                // Remove the effect..
                RemoveEffect(oTarget, eCheck);
				SetLocalInt(oPC, "hv_dur_vfx", 0);
				return;
            }
            eCheck = GetNextEffect(oTarget);
        }
	}
}