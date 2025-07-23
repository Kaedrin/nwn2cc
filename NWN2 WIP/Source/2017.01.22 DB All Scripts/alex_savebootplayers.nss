void SaveAndBootPlayers()
{
	object oModule				= GetModule( );
	object oPC				= GetFirstPC( );
	// Boot all the players from the server first, so they don't timeout.
	while( GetIsPC( oPC ) ){
		//Save this player
		ExportSingleCharacter(oPC);
		// Boot this player.
		BootPC( oPC );
		// Get the next player in our server player list.
		oPC = GetNextPC( );
	}
	return;
}