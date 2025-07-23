
//Creator: Xeneize
//Copyrights: Dalelands Beyond Scripting Team

//Casts lights and effects night time.


//
// CHANGE THESE TO YOUR REQUIREMENTS:
const string POINT	= "spawn_bluelight";			// tag of WayPoint(s) to spawn lights at
const string LIGHT	= "xen_md_nightlight";			// resref of the Light to spawn
const string EFFECT	= "fx_death_god_light_blue";	// resref of the Placed_Effect to spawn

// both LIGHT and EFFECT will spawn at POINT at dusk, and get destroyed at dawn.


//void Tell(string sTell) { SendMessageToPC(GetFirstPC(FALSE), sTell); }

void main()
{
//  Tell("\nrun HB ( " + GetTag(OBJECT_SELF) + ")");
    object oArea = OBJECT_SELF;

    int bDark = (GetIsNight() || GetIsDusk());
//  Tell(". isDark = " + IntToString(bDark));
    if (bDark == GetLocalInt(oArea, "bDark"))
        return;

    SetLocalInt(oArea, "bDark", bDark);


    if (bDark)
    {
//      Tell(". DARK");
//      int i = 0; // debug.
        object oPoint = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oPoint))
        {
//          Tell(". . iterate Objects : i = " + IntToString(++i));
            if (GetTag(oPoint) == POINT)
            {
//              Tell(". . . found one");
                location lPoint = GetLocation(oPoint);
                object oLight = CreateObject(OBJECT_TYPE_LIGHT, LIGHT,lPoint);
                object oEffect = CreateObject(OBJECT_TYPE_PLACED_EFFECT, EFFECT, lPoint);
                SetLocalInt(oLight, "bDestroy", TRUE);
                SetLocalInt(oEffect, "bDestroy", TRUE);
            }
            oPoint = GetNextObjectInArea(oArea);
        }
    }
    else
    {
//      Tell(". NOT Dark");
//      int i = 0; // debug.
        object oDestroy = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oDestroy))
        {
//          Tell(". . iterate Objects : i = " + IntToString(++i));
            if (GetLocalInt(oDestroy, "bDestroy"))
            {
//              Tell(". . . destroy Object");
                DestroyObject(oDestroy);
            }
            oDestroy = GetNextObjectInArea(oArea);
        }
    }
}