// To put on recipe chest on close, to destroy
// stored recipes in chest's inventory
void main()
{
	// do nothing if the closer isn't the user
	object oUser = GetLocalObject(OBJECT_SELF, "hv_recipe_storage_user");
	object oCloser = GetLastClosedBy();
	
	if (oCloser != oUser)
		return;

	object oItem = GetFirstItemInInventory(OBJECT_SELF);
	
	while (GetIsObjectValid(oItem)) {
		
		DestroyObject(oItem);
		
		oItem = GetNextItemInInventory(OBJECT_SELF);
	}
	
	// Clear user
	SetLocalObject(OBJECT_SELF, "hv_recipe_storage_user", OBJECT_INVALID);
}