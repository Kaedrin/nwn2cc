//::///////////////////////////////////////////////
//:: Caustic Web
//:: cmi_s0_causweb
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

#include "cmi_ginc_spells"

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

	//We need to make sure that this AOE isn't stackable, because it is super powerful
	//First we need to generate the string that serves as the object ID for this AOE object
	object oCaster = OBJECT_SELF;
	string sSelf = ObjectToString(oCaster) + IntToString(GetSpellId());
	//Now we need to see if anything with this tag already exists
	object oSelf = GetNearestObjectByTag(sSelf);
	//If it exists, kill it.
	if (GetIsObjectValid(oSelf))
	{
		DestroyObject(oSelf);
	}	


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(VFX_PER_CAUSTIC_WEB, "", "", "", sSelf );

    location lTarget = GetSpellTargetLocation();
    int nDuration = GetWarlockCasterLevel(OBJECT_SELF) / 2;

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}