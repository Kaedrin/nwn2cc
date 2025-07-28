//::///////////////////////////////////////////////
//:: Delayed Blast Fireball
//:: NW_S0_DelFirebal.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster creates a trapped area which detects
    the entrance of enemy creatures into 3 m area
    around the spell location.  When tripped it
    causes a fiery explosion that does 1d6 per
    caster level up to a max of 20d6 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 27, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

int GetColdReserveLevel()
{

	if ( GetHasSpell(158) || GetHasSpell(1045))
		return 9;
			
	if (GetHasSpell(886))
		return 8;
			
	if (GetHasSpell(25))
		return 5;
			
	if ( GetHasSpell(47) || GetHasSpell(368) || GetHasSpell(1043) || GetHasSpell(1825) || GetHasSpell(1206) || GetHasSpell(2098) )
		return 4;	
															
	if ( GetHasSpell(1031) || GetHasSpell(1753) || GetHasSpell(1814) )
		return 3;		
		
	return 0;
}

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
	
	if (GetColdReserveLevel() == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
		return;
	}
	
	if (GetHasFeat(FEAT_RESERVE_RUNE_FLAME, OBJECT_SELF, TRUE))
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_RESERVE_RUNE_FLAME);
	if (GetHasFeat(FEAT_RESERVE_RUNE_STORMS, OBJECT_SELF, TRUE))
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_RESERVE_RUNE_STORMS);
	if (GetHasFeat(FEAT_RESERVE_RUNE_THUNDER, OBJECT_SELF, TRUE))
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_RESERVE_RUNE_THUNDER);
	if (GetHasFeat(FEAT_RESERVE_RUNE_VITRIOL, OBJECT_SELF, TRUE))
		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_RESERVE_RUNE_VITRIOL);		

	//First we need to generate the string that serves as the object ID for this AOE object
	//Rune of Flame is re-used to limit it to one rune per caster regardless of how many rune feats they have.
	string sSelf = ObjectToString(OBJECT_SELF) + IntToString(SPELLABILITY_RUNE_FLAME);
	//Now we need to see if anything with this tag already exists
	object oSelf = GetNearestObjectByTag(sSelf);
	//If it exists, kill it.
	if (GetIsObjectValid(oSelf))
	{
		DestroyObject(oSelf);
	}
	
// End of Spell Cast Hook

    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_RUNE_ICE, "", "", "", sSelf );
    location lTarget = GetSpellTargetLocation();
    int nDuration = 6;
	
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
	
			
}