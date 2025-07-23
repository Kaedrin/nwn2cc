//
// SpawnBanner v1.0
//
void SpawnBanner(object oPC, object oItem, object oTarget, location lTarget)
{
    object oArea = GetArea(oPC);

    if (GetTag(oTarget) == "SpawnBanner")
    {
        object oSpawn = GetLocalObject(oTarget, "ParentSpawn");

        SetCustomToken(999, "\n");
        SetCustomToken(1000, GetLocalString(oSpawn, "f_Flags"));
        SetCustomToken(1001, GetLocalString(oSpawn, "f_Template"));

        AssignCommand(oPC, ActionStartConversation(oTarget, "spawn_banner"));
    }
    else
    {
        int nState = GetLocalInt(oArea, "SpawnBannerState");
        if (nState == 0)
        {
            // Show Spawn Banners
            SendMessageToAllDMs("showing banners");

            int nNth;
            string sSpawnNum, sSpawnName;
            object oSpawn, oBanner;
            location lSpawn;

            int nSpawns = GetLocalInt(oArea, "Spawns");

            for (nNth = 1; nNth <= nSpawns; nNth++)
            {
                sSpawnNum = "Spawn";
                if (nNth < 10)
                {
                    sSpawnNum = sSpawnNum + "0";
                }
                sSpawnNum = sSpawnNum + IntToString(nNth);
                oSpawn = GetLocalObject(oArea, sSpawnNum);
                lSpawn = GetLocation(oSpawn);
                if (GetLocalInt(oSpawn, "SpawnDeactivated") == FALSE)
                {
                    oBanner = CreateObject(OBJECT_TYPE_PLACEABLE, "spawn_ban_a", lSpawn);
                }
                else
                {
                    oBanner = CreateObject(OBJECT_TYPE_PLACEABLE, "spawn_ban_d", lSpawn);
                }
                SetLocalObject(oBanner, "ParentSpawn", oSpawn);
            }
            SetLocalInt(oArea, "SpawnBannerState", 1);
        }
        else
        {
            // Hide Spawn Banners
            int nNth = 1;
            object oBanner = GetNearestObjectByTag("SpawnBanner", oPC, nNth);
            while (oBanner != OBJECT_INVALID)
            {
                DestroyObject(oBanner);
                nNth++;
                oBanner = GetNearestObjectByTag("SpawnBanner", oPC, nNth);
            }
            SetLocalInt(oArea, "SpawnBannerState", 0);
        }
    }
}
