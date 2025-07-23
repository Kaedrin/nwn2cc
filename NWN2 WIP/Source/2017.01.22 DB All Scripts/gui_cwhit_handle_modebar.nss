// gui_cwhit_handle_modebar

// This handler is intended to limit HIPS abuse from low dex PC's
// what it does it remove HIPS for a fixed period of time.

void main()
{
	object oPC  = OBJECT_SELF;
	
	// subject to HIPS cooldown?
	if (GetLocalInt(oPC, "HAS_HIPS")) {
	   // the pc is a hipster.  
	   if ( GetStealthMode( oPC ) == STEALTH_MODE_ACTIVATED && 
	        GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, oPC)) {
		  // determine how long they will have to wait before they can HIPS again
	      int nEffectiveDexScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
	      int nDexBonus = GetAbilityScore(oPC, ABILITY_DEXTERITY) - nEffectiveDexScore;
	      if (nDexBonus > 0) nEffectiveDexScore++;
	      if (nDexBonus > 1) nEffectiveDexScore++; // at most +2 Dex bonus from buffs
	      
	      int nHiPSCooldown = 0; // at 22 + EffectiveDex there is no delay
	      if (nEffectiveDexScore == 21) nHiPSCooldown = 2; 
	      if (nEffectiveDexScore < 21) nHiPSCooldown = 3;
		  
		  SetLocalInt(oPC, "HIPS_COOLDOWN_HEARTBEATS", nHiPSCooldown);
	    
	      if (nHiPSCooldown > 0) {
		      FeatRemove (oPC, FEAT_HIDE_IN_PLAIN_SIGHT);
		      FloatingTextStringOnCreature("HIPS used", oPC, FALSE);	
		  }
	   }
	}
}