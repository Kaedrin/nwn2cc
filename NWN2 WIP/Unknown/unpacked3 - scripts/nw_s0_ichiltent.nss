//:://////////////////////////////////////////////////////////////////////////
//:: Warlock Greater Invocation: Chilling Tentacles
//:: nw_s0_chilltent.nss
//:: Created By: Brock Heinz - OEI
//:: Created On: 08/30/05
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//:://////////////////////////////////////////////////////////////////////////
/*
        Chilling Tentacles
        Complete Arcane, pg. 132
        Spell Level:	5
        Class: 		    Misc

        This functions identically to the Evard's black tentacles spell 
        (4th level wizard) except that each creature in the area of effect
        takes an additional 2d6 of cold damage per round regardless 
        if tentacles hit them or not.
	
		Upon entering the mass of "soul-chilling" rubbery tentacles the
		target is struck by 1d4 tentacles.  Each has a chance to hit of 5 + 1d20. 
		If it succeeds then it does 2d6 damage and the target must make
		a Fortitude Save versus paralysis or be paralyzed for 1 round.

*/
//:://////////////////////////////////////////////////////////////////////////


#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"
#include "noc_warlock_corruption"

void main()
{


    if (!X2PreSpellCastCode())
    {
	    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	AddCorruption(OBJECT_SELF, 5);

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
    effect      eAOE        = EffectAreaOfEffect(AOE_PER_CHILLING_TENTACLES, "", "", "", sSelf );
    location    lTarget     = GetSpellTargetLocation();
    int         nDuration   = GetWarlockCasterLevel(OBJECT_SELF);
    int         nMetaMagic  = GetMetaMagicFeat();

    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }

    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
	   nDuration = nDuration * 2;	//Duration is +100%
    }

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));

}