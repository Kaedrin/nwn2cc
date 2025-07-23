//waypoint jump requires a waypoint tagged WP_(transitions tag)

void main()
{
 object oPC=GetEnteringObject();
 string sTag=GetTag(OBJECT_SELF);
 object oDest=GetObjectByTag("WP_"+sTag);
 location lDest=GetLocation(oDest);
 AssignCommand(oPC,JumpToLocation(lDest));
}  