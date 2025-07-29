void main()
{
    if (GetIsPC(GetExitingObject()))
    {
        int playercount = GetLocalInt(OBJECT_SELF, "hv_pc_count");
        SetLocalInt(OBJECT_SELF, "hv_pc_count", playercount - 1);
    }
	
	// Run clean script
	ExecuteScript("alg_playerareaexit", OBJECT_SELF);
}