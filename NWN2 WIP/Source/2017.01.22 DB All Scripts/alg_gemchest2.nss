void main()
{
int nInt;
object GemDoor = GetObjectByTag("alg_gem_door");
object oGem2 = GetItemPossessedBy(OBJECT_SELF, "Gem2");
if (oGem2 != OBJECT_INVALID)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_BLUE_10), OBJECT_SELF);
DestroyObject(oGem2);

nInt = GetLocalInt(GemDoor, "gemchest");
nInt += 1;
SetLocalInt(GemDoor, "gemchest", nInt);
}
}