//::///////////////////////////////////////////////
//:: NW_O2_GARGOYLE.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Turns the placeable into a gargoyle
   if a player comes near enough.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   January 17, 2002
//:://////////////////////////////////////////////
//modified for spawning in of a zombie by Bucephalus
//this goes on a placeables heartbeat script


void main()
{
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 10.0)
   {
    effect eMind = EffectVisualEffect( VFX_DUR_SPELL_BANE );
    object oHag = CreateObject(OBJECT_TYPE_CREATURE, "dh_nighthag", GetLocation(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oHag);
    SetPlotFlag(OBJECT_SELF, FALSE);
    DestroyObject(OBJECT_SELF, 0.5);
   }
}