//::///////////////////////////////////////////////
//:: NW_C2_GARGOYLE.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   on gargoyle's heartbeat, if no PC nearby then become a statue
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 17, 2001
//:://////////////////////////////////////////////
//:: Noel made the orientation correct, May 2002
//:: January 2003: Yaron: Made it look cooler
//:: January 2009: Qk: comp for my nwn2 gargoyle pack
void CreateGargoyle(object oPC)
{
    object oGargoyle = CreateObject(OBJECT_TYPE_PLACEABLE, "c_gargoyle_s", GetLocation(OBJECT_SELF));
    //DelayCommand(0.1, AssignCommand(oGargoyle, ActionAttack(oPC)));
}

void main()
{
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   object oGargoyle;
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) > 10.0)
   {
    //effect eMind = EffectVisualEffect( VFX_DUR_SPELL_AID );
    DelayCommand(0.1, CreateGargoyle(oCreature));
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oGargoyle);
    SetPlotFlag(OBJECT_SELF, FALSE);
    //effect eDam = EffectDamage(500);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
	DestroyObject(OBJECT_SELF,1.9);
   }
}