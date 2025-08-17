// _opjf
void main()
{
	object oObj = GetObjectByTag("a01_scrolls");

	if (GetGlobalInt( "nx1_blessing_mystra_done") != TRUE)
	{
		SetGlobalInt( "nx1_blessing_mystra_done", TRUE);
		CreateItemOnObject( "nx1_blessing_mystra", oObj);
	}
	
	if (GetGlobalInt( "nx1_blessing_mystra_done") != TRUE)
	{
		SetGlobalInt( "nx1_blessing_mystra_done", TRUE);
		CreateItemOnObject( "nx1_blessing_mystra", oObj);
	}
	
	if (GetGlobalInt( "nx1_blessing_mystra_done") != TRUE)
	{
		SetGlobalInt( "nx1_blessing_mystra_done", TRUE);
		CreateItemOnObject( "nx1_blessing_mystra", oObj);
	}

}