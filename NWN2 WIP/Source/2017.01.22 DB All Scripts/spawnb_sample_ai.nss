//
// SpawnBanner : Sample OnActivateItem Script
//
#include "spawnb_main"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();

    // Rod of Spawn Banners
    if (GetTag(oItem) == "RodofSpawnBanners")
    {
        SpawnBanner(oPC, oItem, oTarget, lTarget);
    }
}
