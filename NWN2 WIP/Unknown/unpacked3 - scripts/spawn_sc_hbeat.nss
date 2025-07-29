//
// Heartbeat Scripts
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
    int nHeartbeatScript = GetLocalInt(OBJECT_SELF, "HeartbeatScript");

    // Invalid Script
    if (nHeartbeatScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nHeartbeatScript == 0)
    {
        if (d2() == 2)
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
        }
    }
    //

    //
    if (nHeartbeatScript == 2)
    {
        object oCentralObject;
        location lCentralObject, lLocation;
        vector vCentralObject, vLocation;
        float fAngle, fRadius, fLocationX, fLocationY;

        // Add Multiple Actions per HeartbeatScript
        int nNth;
        for (nNth = 1; nNth <= 10; nNth++)
        {
            // Central Object
            oCentralObject = GetObjectByTag("CentralObject");
            lCentralObject = GetLocation(oCentralObject);
            vCentralObject = GetPositionFromLocation(lCentralObject);

            // Retreive and Increment Angle by 10 Degrees
            fAngle = GetLocalFloat(OBJECT_SELF, "Angle");
            fAngle = fAngle + 5.0;
            if (fAngle >= 360.0)
            {
                fAngle = 0.0;
            }

            // Create New Location
            fRadius = 5.0;
            fLocationX = fRadius * cos(fAngle);
            fLocationY = fRadius * sin(fAngle);
            vLocation = Vector(fLocationX, fLocationY, 0.0);
            lLocation = Location(GetArea(OBJECT_SELF), vCentralObject + vLocation, 0.0);

            // Move to New Location
            ActionMoveToLocation(lLocation, TRUE);

            // Record New Angle
            SetLocalFloat(OBJECT_SELF, "Angle", fAngle);
        }
    }
    //

    // Script 001 - Flavor text for dockworkers
    if (nHeartbeatScript == 1)
    {
        ActionSpeakString("Hand me that rope, would ya?");
    }
    //

    // Check if a Placeable was Used
    if (nHeartbeatScript == 5)
    {
        object oPC = GetLastUsedBy();
        SendMessageToPC(oPC, "You were the last user.");
    }
    //

    // Prowling Predator
    if (nHeartbeatScript == 10)
    {
        string sState;
        int nCurrentHungerState = GetLocalInt(OBJECT_SELF, "CurrentHungerState");
        nCurrentHungerState--;
        SetLocalInt(OBJECT_SELF, "Predator", TRUE);

        if (GetLocalInt(OBJECT_SELF, "Sleeping") == FALSE)
        {
            // Hungry Yet?
            if (nCurrentHungerState <= 0)
            {
                if (nCurrentHungerState < -10)
                {
                    // Death Comes to Those who Cannot Hunt
                    sState = "Dead from Starvation";
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF);
                }
                else
                {
                    if (nCurrentHungerState > -5)
                    {
                        // Hungry!
                        sState = "Hungry and Prowling";
                    }
                    else
                    {
                        // Dying of Starvation!
                        sState = "Starving";
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(OBJECT_SELF)/6), OBJECT_SELF);
                    }
                    // Prowl
                    if (GetIsInCombat(OBJECT_SELF) == FALSE)
                    {
                        ClearAllActions();
                        ActionMoveAwayFromLocation(GetLocation(OBJECT_SELF), TRUE, 20.0);
                    }
                }
            }
            else
            {
                if (nCurrentHungerState < 10)
                {
                    if (nCurrentHungerState > 5)
                    {
                        // Happy and Healing.
                        sState = "Fat and Happy";
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)/6), OBJECT_SELF, 0.0);
                    }
                    else
                    {
                        // Happy
                        sState = "Happy";
                    }
                }
                else
                {
                    sState = "Fat and Sleeping";
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSleep(), OBJECT_SELF, 12.0);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_SLEEP), OBJECT_SELF, 0.0);
                    SetLocalInt(OBJECT_SELF, "Sleeping", TRUE);
                    DelayCommand(10.0, SetLocalInt(OBJECT_SELF, "Sleeping", FALSE));
                }
            }
        }
        else
        {
            sState = "Fat and Sleeping";
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_SLEEP), OBJECT_SELF, 0.0);
        }
        SendMessageToAllDMs(sState + " (" + IntToString(nCurrentHungerState) + ").");
        SpeakString("I am " + sState + ".");
        SetLocalInt(OBJECT_SELF, "CurrentHungerState", nCurrentHungerState);
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

}
