// Name     : NWNX Clock include
// Purpose  : Various functions for accessing the Clock plugin
// Authors  : Ingmar Stieger (Papillon)
// Modified : 01/11/07 (kfw) : Initial release.
// Modified : 08/11/07 (CarterDC) : Support for NWNX4 1.08.
// Modified : 08/18/07 (kfw) : Syntax check.
// Modified : 08/18/07 (kfw) : Mapsize fix to NWNX4Clock module.
// Modified : 10/12/08 (kfw) : Compiled for NWNX4 1.09 and NWN2 1.13.

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Constants                        */
/************************************/
const string PLUGIN_NAME	= "CLOCK";

// This method gets the system's date in the format (mm.dd.yyyy).
string GetSystemDate( );

// This method gets the system's time in the format (hh:mm:ss).
string GetSystemTime( );

// This method gets the number of seconds since midnight Jan 1st 1970.
int GetUNIXTime( );

/************************************/
/* Implementation                   */
/************************************/

// This method gets the system's date in the format (mm.dd.yyyy).
string GetSystemDate( ){

	// Get the system's date.
	return( NWNXGetString( PLUGIN_NAME, "DATE", "", 0 ) );
	
}

// This method gets the system's time in the format (hh:mm:ss).
string GetSystemTime( ){

	// Get the system's time.
	return( NWNXGetString( PLUGIN_NAME, "TIME", "", 0 ) );
	
}

// This method gets the number of seconds since midnight Jan 1st 1970.
int GetUNIXTime( ){

	// Get the epoch.
	return( StringToInt( NWNXGetString( PLUGIN_NAME, "UNIXTIME", "", 0 ) ) );
	
}