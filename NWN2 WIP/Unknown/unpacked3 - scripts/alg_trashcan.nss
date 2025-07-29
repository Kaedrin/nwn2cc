void main()
{
   object oItem = GetFirstItemInInventory(OBJECT_SELF);
   while (GetIsObjectValid(oItem) == TRUE)
   {
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(OBJECT_SELF);

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("RECYCLER");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DESTRUCTION), GetLocation(oTarget));

   }
}