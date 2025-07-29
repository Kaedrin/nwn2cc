//
// SpawnBanner : Sample OnActivateItem Script
//
#include "x2_inc_switches"
#include "spawnb_main"
void main()
{
    int nResult = X2_EXECUTE_SCRIPT_END;

    if ( GetUserDefinedItemEventNumber() == X2_ITEM_EVENT_ACTIVATE )
    {
       object oPC = GetItemActivator();
       object oItem = GetItemActivated();
       object oTarget = GetItemActivatedTarget();
       location lTarget = GetItemActivatedTargetLocation();
       SpawnBanner(oPC, oItem, oTarget, lTarget);
    }
    SetExecutedScriptReturnValue(nResult);
}

