void main()
{
int nInt;
object GemDoor = GetObjectByTag("alg_gem_door");
object oGem1 = GetItemPossessedBy(OBJECT_SELF, "Gem1");
if (oGem1 != OBJECT_INVALID)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_BLUE_10), OBJECT_SELF);
DestroyObject(oGem1);

nInt = GetLocalInt(GemDoor, "gemchest");
nInt += 1;
SetLocalInt(GemDoor, "gemchest", nInt);
}
}