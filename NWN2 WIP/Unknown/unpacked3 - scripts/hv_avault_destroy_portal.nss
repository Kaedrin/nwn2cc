void main()
{
	if (GetLocalInt(OBJECT_SELF, "hv_avault_destroy_portal") == 1) {
		DestroyObject(GetNearestObjectByTag("hv_avault_portal"));
		SetLocalInt(OBJECT_SELF, "hv_avault_destroy_portal", 0);
	}
}