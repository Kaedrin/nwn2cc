//
// Spawn and Despawn Scripts
//
#include "spawn_functions"
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void main()
{
    // Retrieve Script Number
    int nSpawnScript = GetLocalInt(OBJECT_SELF, "SpawnScript");
    int nDespawnScript = GetLocalInt(OBJECT_SELF, "DespawnScript");

    // Invalid Script
    if (nSpawnScript == -1 || nDespawnScript == -1)
    {
        return;
    }

    if (nSpawnScript > 0)
    {

//
// Only Make Modifications Between These Lines
// -------------------------------------------


        // Script 00
        // Dummy Script - Never Use
        if (nSpawnScript == 0)
        {
            return;
        }
        //

        if (nSpawnScript == 1)
        {
            // lamplighter
            int nLit = GetLocalInt(OBJECT_SELF, "torchesLit");
            if (! nLit)
            {
                //SendMessageToPC(GetFirstPC(), "lighting torches");
                SetLocalInt(OBJECT_SELF, "torchesLit", 1);

                // find all objects in area with tag lightableTorch
                object oArea = GetArea(OBJECT_SELF);
                object oTorch = GetFirstObjectInArea(oArea);
                int nCount = 0;
                string sTorchTag = "lightableTorch";

                while (oTorch != OBJECT_INVALID)
                {
                    if (GetTag(oTorch) == sTorchTag)
                    {
                        nCount++;
                        AssignCommand(oTorch, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
                        DelayCommand(0.4, SetPlaceableIllumination(oTorch, TRUE));
                        SetLocalInt(oTorch,"NW_L_AMION",1);
                    }

                    oTorch = GetNextObjectInArea(oArea);
                }

                if (nCount > 0)
                {
                    DelayCommand(0.1,RecomputeStaticLighting(oArea));
                }

                return;
            }
		
        }// end spawn script 1

// -------------------------------------------
// Only Make Modifications Between These Lines
//

    }

    if (nDespawnScript > 0)
    {

//
// Only Make Modifications Between These Lines
// -------------------------------------------


        // Script 00
        // Dummy Script - Never Use
        if (nDespawnScript == 0)
        {
            return;
        }
        //

        if (nDespawnScript == 1)
        {

            // lampdouser
            //SendMessageToPC(GetFirstPC(), "dousing torches");

            // find all objects in area with tag lightableTorch
            object oArea = GetArea(OBJECT_SELF);
            object oTorch = GetFirstObjectInArea(oArea);
            int nCount = 0;
            string sTorchTag = "lightableTorch";

            while (oTorch != OBJECT_INVALID)
            {
                if (GetTag(oTorch) == sTorchTag)
                {
                    nCount++;
                    AssignCommand(oTorch,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                    DelayCommand(0.4, SetPlaceableIllumination(oTorch, FALSE));
                    SetLocalInt(oTorch,"NW_L_AMION",0);
                }

                oTorch = GetNextObjectInArea(oArea);
            }

            if (nCount > 0)
            {
                DelayCommand(0.1,RecomputeStaticLighting(oArea));
            }

            return;
        }

        // Area Cleanup Example
        if (nDespawnScript == 999)
        {
            // Settings
            int nMerchantPrefixLetters = 3;
            string sMerchantPrefix = "MC_";
            int nChestPrefixLetters = 3;
            string sChestPrefix = "CH_";

            // Create an Area Merchant List
            int nMerchantNum;
            string sMerchantNum;
            int nNth = 1;
            object oMerchant = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, nNth);
            while (oMerchant != OBJECT_INVALID)
            {
                if (GetStringLeft(GetTag(oMerchant), nMerchantPrefixLetters) == sMerchantPrefix)
                {
                    nMerchantNum++;
                    sMerchantNum = "Merchant" + PadIntToString(nMerchantNum, 2);
                    SetLocalObject(OBJECT_SELF, sMerchantNum, oMerchant);
                }
                nNth++;
                oMerchant = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, nNth);
            }

            // Create an Area Chest List
            int nChestNum;
            string sChestNum;
            nNth = 1;
            object oChest = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            while (oChest != OBJECT_INVALID)
            {
                if (GetStringLeft(GetTag(oChest), nChestPrefixLetters) == sChestPrefix)
                {
                    nChestNum++;
                    sChestNum = "Chest" + PadIntToString(nChestNum, 2);
                    SetLocalObject(OBJECT_SELF, sChestNum, oChest);
                }
                nNth++;
                oChest = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            }

            // Cleanup Creatures
            nNth = 1;
            object oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nNth);
            while (oCreature != OBJECT_INVALID)
            {
                // Destroy Creatures NOT Spawned by Spawner
                if (GetLocalObject(oCreature, "ParentSpawn") == OBJECT_INVALID)
                {
                    DestroyObject(oCreature);
                }

                // Cleanup Corpses
                if (GetIsDead(oCreature) == TRUE)
                {
                    AssignCommand(oCreature, SetIsDestroyable(TRUE, TRUE));
                    DestroyObject(oCreature);
                }

                nNth++;
                oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nNth);
            }

            // Cleanup All Items in Area
            string sItemTag;
            int nStack;
            int nCurrentMerchant = 0;
            int nCurrentChest = 0;
            nNth = 1;
            object oItem = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nNth);
            while (oItem != OBJECT_INVALID)
            {
                // Retrieve Item Information
                sItemTag = GetTag(oItem);
                nStack = GetNumStackedItems(oItem);

                // Destroy Item
                DestroyObject(oItem);

                // Place Items on Merchants
                if (nMerchantNum > 0)
                {
                    if (nCurrentMerchant = nMerchantNum - 1)
                    {
                        nCurrentMerchant = 0;
                    }
                    oMerchant = GetLocalObject(OBJECT_SELF, "Merchant" +  PadIntToString(nCurrentMerchant, 2));
                    CreateItemOnObject(sItemTag, oMerchant, nStack);
                    nCurrentMerchant++;
                }
                // Place Items in Chests
                else if (nChestNum > 0)
                {
                    if (nCurrentChest = nChestNum -1)
                    {
                        nCurrentChest = 0;
                    }
                    oChest = GetLocalObject(OBJECT_SELF, "Chest" +  PadIntToString(nCurrentChest, 2));
                    CreateItemOnObject(sItemTag, oChest, nStack);
                    nCurrentChest++;
                }

                nNth++;
                oItem = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nNth);
            }

            // Cleanup 'Body Bags'
            nNth = 1;
            oItem = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            while (oItem != OBJECT_INVALID)
            {
                if(GetTag(oItem) == "Body Bag")
                {
                    // Check for Inventory
                    if (GetHasInventory(oItem) == TRUE)
                    {
                        object oInventoryItem = GetFirstItemInInventory(oItem);
                        while (oInventoryItem != OBJECT_INVALID)
                        {
                            // Retrieve Item Information
                            sItemTag = GetTag(oInventoryItem);
                            nStack = GetNumStackedItems(oInventoryItem);

                            // Destroy Item
                            DestroyObject(oInventoryItem);

                            // Place Items on Merchants
                            if (nMerchantNum > 0)
                            {
                                if (nCurrentMerchant = nMerchantNum - 1)
                                {
                                    nCurrentMerchant = 0;
                                }
                                oMerchant = GetLocalObject(OBJECT_SELF, "Merchant" +  PadIntToString(nCurrentMerchant, 2));
                                CreateItemOnObject(sItemTag, oMerchant, nStack);
                                nCurrentMerchant++;
                            }
                            // Place Items in Chests
                            else if (nChestNum > 0)
                            {
                                if (nCurrentChest = nChestNum -1)
                                {
                                    nCurrentChest = 0;
                                }
                                oChest = GetLocalObject(OBJECT_SELF, "Chest" +  PadIntToString(nCurrentChest, 2));
                                CreateItemOnObject(sItemTag, oChest, nStack);
                                nCurrentChest++;
                            }
                            oInventoryItem = GetNextItemInInventory(oItem);
                        }
                    }

                    // Destroy Body Bag
                    DestroyObject(oItem);
                }
                nNth++;
                oItem = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            }
        }
        //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    }

    // Clean Up
    SetLocalInt(OBJECT_SELF, "SpawnScript", 0);
    SetLocalInt(OBJECT_SELF, "DespawnScript", 0);
}