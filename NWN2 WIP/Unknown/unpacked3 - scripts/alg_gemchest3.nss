void main()
{
int nInt;
object GemDoor = GetObjectByTag("alg_gem_door");
object oGem3 = GetItemPossessedBy(OBJECT_SELF, "Gem3");
if (oGem3 != OBJECT_INVALID)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_BLUE_10), OBJECT_SELF);
DestroyObject(oGem3);

nInt = GetLocalInt(GemDoor, "gemchest");
nInt += 1;
SetLocalInt(GemDoor, "gemchest", nInt);
}
}