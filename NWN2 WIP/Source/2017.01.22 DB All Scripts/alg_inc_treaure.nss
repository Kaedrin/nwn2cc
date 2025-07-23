void Main()

 
{
	SetLocalInt(oChest, "IsInitialized", 1);
	SetPlotFlag(oChest, TRUE);
	SetLocalInt(oChest, "IsTrapped", GetIsTrapped(oChest));
	SetLocalInt(oChest, "IsLocked", GetLocked(oChest));
	SetLocalInt(oChest, "CurHP", GetMaxHitPoints(oChest));

}