//::///////////////////////////////////////////////
//:: Stormsingers Storm of Vengeance
//:: cmi_s2_stormveng
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 16, 2008
//:://////////////////////////////////////////////

//Based on Storm of Vengeance by OEI

#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

	int nCasterLvl = GetStormSongCasterLevel(OBJECT_SELF);
	if (nCasterLvl < 18) //Short circuit
	{
		SendMessageToPC(OBJECT_SELF, "Insufficient Perform skill, you need 15 or more to use this ability.");
		return;
	}
	if (!GetHasFeat(257))
	{
		SpeakString("No uses of the Bard Song ability are available");
		return;
	}
	else
	{
		DecrementRemainingFeatUses(OBJECT_SELF, 257);
		DecrementRemainingFeatUses(OBJECT_SELF, 257);
		DecrementRemainingFeatUses(OBJECT_SELF, 257);
		DecrementRemainingFeatUses(OBJECT_SELF, 257);				
	}	


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(VFX_PER_STORMSINGER_STORM);
    location lTarget = GetSpellTargetLocation();
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(10));
}