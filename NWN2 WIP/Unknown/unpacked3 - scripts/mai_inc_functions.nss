//::///////////////////////////////////////////////
//:: Name mai_inc_functions
//:://////////////////////////////////////////////
/*
     This script is a library for Maiyin's scripts
*/
//:://////////////////////////////////////////////
//:: Created By: Maiyin
//:: Created On: july, 2007
//:://////////////////////////////////////////////

//
// Modified By: Terry Reinert
// Modified On: September 30, 2007
//
// Cleaned up code, added comments, changed format
// of displayed locations to make it shorter, and 
// optimized the various functions for the scry tool
// to make it faster.
//

/////////////////// Declarations /////////////////
int mai_hcr_checkforcorpse(string sItemtag);
void mai_scrt_hide();
void mai_scrt_show();
void mai_scrt_display();
int mai_scrt_hidden(object oPC);

/////////////////// functions ///////////////////

int mai_hcr_checkforcorpse(string sItemtag)
{
	return ( GetStringLeft(sItemtag, 9) == "H2_CORPSE" );
}

void mai_scrt_display()
{
	object oPC      = GetPCSpeaker();
	object oPlayer  = GetFirstPC();
	string sMessage = "";
	
	while (oPlayer != OBJECT_INVALID)
	{
		if( !GetIsDM(oPlayer) && 			// Is not DM
			!GetIsDMPossessed(oPlayer) && 	// Is not DM possessed
			!mai_scrt_hidden(oPlayer) )		// Does not have hidden flag set
		{
			//
			// Message format is: "FirstName LastName: AreaName"
			//
			sMessage = GetFirstName(oPlayer) + " " + GetLastName(oPlayer);
			sMessage += ": " + GetName(GetArea(oPlayer));
			SendMessageToPC(oPC, sMessage);
		}
		oPlayer = GetNextPC();
	}
}

void mai_scrt_hide()
{
	object oPC = GetPCSpeaker();
	SetLocalInt(oPC, "mai_scrt_hidden", TRUE);
}

void mai_scrt_show()
{
	object oPC = GetPCSpeaker();
	SetLocalInt(oPC, "mai_scrt_hidden", FALSE);
}

int mai_scrt_hidden(object oPC)
{
	return GetLocalInt(oPC, "mai_scrt_hidden");
}