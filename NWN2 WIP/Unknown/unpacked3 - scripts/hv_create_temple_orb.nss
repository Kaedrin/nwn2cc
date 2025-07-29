// Here I want to choose a random glowing pillar.
// Create an orb at its location.
// Make the orb move to the Boss location.
// Explode orb and make boss speak.

// Returns a random pillar object.
object GetRandomPillar();

void main()
{
	// Get Boss object - without it don't bother
	// do anything.
	object oBoss = GetObjectByTag("hv_temple_boss");
	if (GetIsObjectValid(oBoss)) {
	
		// Get location of random pillar
		location lPillar = GetLocation(GetRandomPillar());
	
		// Create energy orb at location
		object oOrb = CreateObject(OBJECT_TYPE_CREATURE, "hv_temple_orb", lPillar);
	
		// Move orb towards boss
		AssignCommand(oOrb, ActionForceFollowObject(oBoss)); 
		
		// Once we get there, destroy orb.
		float fDelay = GetDistanceBetween(oOrb, oBoss)/4;
		DelayCommand(fDelay - 0.5, ExecuteScript("hv_temple_orb_visual", oBoss));
		DestroyObject(oOrb, fDelay);
		// Aaand make boss shout something.
		AssignCommand(oBoss, DelayCommand(fDelay + 1.0, SpeakString("Yessss! I grow closer to entering your realm!")));
	}
}

object GetRandomPillar()
{
	// Get how many pillars there are from var
	int nPillarsCount  = GetLocalInt(OBJECT_SELF, "hv_pillars_count");
	
	// Get one randomly
	object oPillar = GetObjectByTag("hv_green_pillar", Random(nPillarsCount));
	return oPillar;
}