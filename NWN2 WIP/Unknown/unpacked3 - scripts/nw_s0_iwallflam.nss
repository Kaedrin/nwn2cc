//:://////////////////////////////////////////////////////////////////////////
//:: Warlock Greater Invocation: 
//:: nw_s0_iwallflam.nss
//:: Created By: Brock Heinz - OEI
//:: Created On: 08/30/05
//:: Copyright (c) 2005 Obsidian Entertainment Inc.
//:://////////////////////////////////////////////////////////////////////////
/*
        Wall of Perilous Flame
        Complete Arcane, pg. 136
        Spell Level:	5
        Class: 		    Misc

        The warlock can conjure a wall of fire (4th level wizard spell). 
        It behaves identically to the wizard spell, except half of the damage 
        is considered magical energy and fire resistance won't affect it.

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


    //Declare Area of Effect object using the appropriate constant
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALL_PERILOUS_FLAME, "", "", "", sSelf );
    //Get the location where the wall is to be placed.
    location lTarget = GetSpellTargetLocation();
    //int nDuration = 3;
	int nDuration = GetWarlockCasterLevel(OBJECT_SELF);
    //if(nDuration == 0)
    //{
    //    nDuration = 1;
    //}
	
	//Check fort metamagic
	if (GetMetaMagicFeat() == METAMAGIC_EXTEND)
	{
		nDuration = nDuration *2;	//Duration is +100%
	}

    //Create the Area of Effect Object declared above.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}