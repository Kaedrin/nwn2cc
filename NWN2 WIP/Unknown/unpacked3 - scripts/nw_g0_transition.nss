// -----------------------------------------------------------------------------
//  nw_g0_transition
// -----------------------------------------------------------------------------
/*
    A replacement for the default OnAreaTransitionClick door and OnClick area
    transition trigger event script to resolve issues with multiple henchmen and
    nested associates being left behind during intra-area transitions.

    This script is called when:

    - no OnClick event script has been specified for an Area Transition Trigger
    - no OnAreaTransitionClick event script has been specified for a Door which
      has a Destination Type other than None
*/
// -----------------------------------------------------------------------------
/*
    Version 1.01 - 25 Sep 2006 - Sunjammer
    - fixed issue caused by using JumpToLocation with door transitions

    Version 1.00 - 28 Aug 2006 - Sunjammer
    - rewritten

    Credits
    - Sydney Tang (BioWare)
*/
// -----------------------------------------------------------------------------
#include "ginc_transition"
#include "cwhit_tracking_core"

// -----------------------------------------------------------------------------
//  CONSTANTS
// -----------------------------------------------------------------------------

// number of associate types (including ASSOCIATE_TYPE_NONE)
const int NUM_ASSOCIATE_TYPES = 6;


// -----------------------------------------------------------------------------
//  PROTOTYPES
// -----------------------------------------------------------------------------

// Jumps all of the caller's associates to the location of an object. The action
// is added to the top of the action queue.
//  - oDestination:     object to jump to
void JumpAssociatesToObject(object oDestination);


// -----------------------------------------------------------------------------
//  FUNCTIONS
// -----------------------------------------------------------------------------

void JumpAssociatesToObject(object oDestination)
{
    int nType;

    // loop through every type of associate
    for(nType = 1; nType < NUM_ASSOCIATE_TYPES; nType++)
    {
        int nCount;

        // use pre-increment as associates are 1-based
        object oAssociate = GetAssociate(nType, OBJECT_SELF, ++nCount);
        while(GetIsObjectValid(oAssociate))
        {
            // jump the associate AND the associate's associates
            AssignCommand(oAssociate, JumpToObject(oDestination));
            AssignCommand(oAssociate, JumpAssociatesToObject(oDestination));

            // next associate of THIS type
            oAssociate = GetAssociate(nType, OBJECT_SELF, ++nCount);
        }
    }
}


// -----------------------------------------------------------------------------
//  MAIN
// -----------------------------------------------------------------------------

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
	if (GetIsPC(oClicker)) {
	    // first leave tracks up to the transition but suppress logging since we are leaving
		doTracking(oClicker, FALSE); 
	}
    if(GetIsObjectValid(oTarget))
    {

        SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

        // jump the clicker and all their associates
        // NOTE: will not effect another PC nor their associates
        AssignCommand(oClicker, JumpToObject(oTarget));
        AssignCommand(oClicker, JumpAssociatesToObject(oTarget));
    }
	
	if (GetIsPC(oClicker)) {
	    // then track at the destination... but wait for a Jump within an area to have occured
		// this way oClicker will have moved to the new location by the time we try to doTracking
		DelayCommand(0.1f, doTracking(oClicker, GetLocalInt(oClicker, "SHOW_TRACKING"), TRUE)); 
	}		
}