location lTarget;
object oTarget;

//Put this script OnUsed
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
	(GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)>0)||
	(GetLevelByClass(149, oPC)>0)||
	(GetItemPossessedBy(oPC, "alg_naturestone")!=OBJECT_INVALID))
   {
   oTarget = GetWaypointByTag("WP_Druidgrove");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());
   SendMessageToPC(oPC, "The bush glows strangely at your touch.");


   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else
   {
   SendMessageToPC(oPC, "The leaves of the bush smell pleasing when you touch them.");

   }
 
}