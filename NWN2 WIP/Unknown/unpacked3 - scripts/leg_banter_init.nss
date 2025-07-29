/*

    Script:			The Initialization script for the BANTER system.  This script needs to be executed during module
					initialization.  That may be during load, when the first player enters or anywhere the end user
					chooses as long as it is run only during that time.  It will obtain all BANTER messages from the
					database during load and store them on local variables so when used during runtime, database hits
					are removed increasing performance.
	Version:		1.0
	Plugin Version: 1.5
	Last Update:	11/26/2010
	Author:			Marshall Vyper
	Parameters:		None

*/

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// INCLUDES
// /////////////////////////////////////////////////////////////////////////////////////////////////////
#include "leg_banter_include"




// /////////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN ROUTINE
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
	// Initialize some variables
	string sID = "";
	string sOldID = "";
	string sOneliner = "";
	int iCounter = 0;
	
	// Execute the SQL database SELECT.
	SQLExecDirect("SELECT * FROM `" + LEG_BANTER_TABLE + "` ORDER BY `BanterID`");
	while (SQLFetch())
	{
		iCounter++;
		sOldID = sID;
		sID = SQLGetData(1);
		sOneliner = SQLGetData(2);

		// As this one table will contain all messages for all ID's, we
		// reset the counter when the ID changes.  As there is a one to
		// many relationship between ID's and messages.
		if (sID != sOldID)
			iCounter = 1;

		// Store the message in a variable prefixing the variable name with the ID.
		// Store how many messages are associated with the ID.			
		SetLocalString(GetModule(), sID + IntToString(iCounter), sOneliner);
		SetLocalInt(GetModule(), sID + "_Count", iCounter);
	}
}