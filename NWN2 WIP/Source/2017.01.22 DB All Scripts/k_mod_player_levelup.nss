// k_mod_player_levelup
/*
    Module level up
*/
// ChazM 3/2/06

//::///////////////////////////////////////////////
//:: nw_O0_LevelUp.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 This script fires whenever a player levels up.
 If the henchmen is capable of going up a level, they do.
*/
//:://////////////////////////////////////////////
//:: Created By:     Brent
//:: Created On:     2002
//:://////////////////////////////////////////////

#include "nw_i0_henchman"
#include "nw_i0_generic"


void main()
{
    object oPC = GetPCLevellingUp();
	DelayCommand(6.0f, ExecuteScript("cmi_player_levelup", oPC));
	
	int nTWFeatsAllowed = GetGlobalInt("00_nTWFeatsAllowed");
	int nHighestPCLevel = GetGlobalInt("00_nHighestPCLevel");
	int nPCLevel = GetTotalLevels(oPC, FALSE);
	
	if(GetIsOwnedByPlayer(oPC))
	{
		if(nPCLevel > nHighestPCLevel)	//You earn new Teamwork Benefit feats by virtue of the highest level character in the party (or rather, in the game to that point).
		{
			SetGlobalInt("00_nHighestPCLevel", nPCLevel);
			if(nPCLevel % 3 == 1)	//This occurs every 3 levels after the first (so 4,7,11, etc). So if the PCs level mod 3 is equal to 1 we're good to go.
			{
				++nTWFeatsAllowed;
				SetGlobalInt("00_nTWFeatsAllowed", nTWFeatsAllowed);
			}
	
		}
	}
	
	return; // short circuiting for now

    if (GetIsObjectValid(oPC) == TRUE)
    {
        object oHench = GetHenchman(oPC);
        if (GetIsObjectValid(oHench) == TRUE)
        {
            if (GetCanLevelUp(oPC, oHench) == TRUE)
            {
                object oNew = DoLevelUp(oPC, oHench);
                if (GetIsObjectValid(oNew) == TRUE)
                {
                    DelayCommand(1.0,AssignCommand(oNew, EquipAppropriateWeapons(oPC)));
                }

            }
        }
    }
}