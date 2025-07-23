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
	(GetItemPossessedBy(oPC, "bd_cotd_key2")!=OBJECT_INVALID))
   {
   oTarget = GetWaypointByTag("WP_Forgotten_Halls_In");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());
   SendMessageToPC(oPC, "The dirt opens up to swallow you");


   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else
   {
   SendMessageToPC(oPC, "A pile of dirt.");

   }
 
}