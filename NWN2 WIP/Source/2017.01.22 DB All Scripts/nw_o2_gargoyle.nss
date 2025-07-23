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
//:: January 2009: Qk: comp for my nwn2 gargoyle pack
//:://////////////////////////////////////////////


void main()
{
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 10.0)
   {
    
    object oGargoyle = CreateObject(OBJECT_TYPE_CREATURE, "c_gargoyle_c", GetLocation(OBJECT_SELF));
	effect eMind = EffectNWN2SpecialEffectFile("fx_global_earth_elemental_arise", oGargoyle);
    ApplyEffectToObject(2, eMind, oGargoyle);
    SetPlotFlag(OBJECT_SELF, FALSE);
    DestroyObject(OBJECT_SELF, 0.5);
   }
}