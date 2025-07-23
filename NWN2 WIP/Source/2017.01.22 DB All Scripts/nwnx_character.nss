// Name     : NWNX Character include
// Purpose  : Functions that modify character (BIC) files.
// Authors  : Ingmar Stieger (Papillon)
// Modified : 12/19/06 (kfw)  : Initial release.
// Modified : 01/18/07 (kfw)  : Added function, SetSkillRank( ).
// Modified : 07/14/07 (kfw)  : Support for NWNX4 1.08.
// Modified : 07/15/07 (kfw)  : SetBaseSkillRank( ) added.
// Modified : 07/16/07 (kfw)  : DeleteCharacter( ) added.
// Modified : 07/16/07 (kfw)  : GetBICFilename( ) tweaked.
// Modified : 08/03/07 (kfw)  : SaveCharacter( ) wrapper added.
// Modified : 10/11/08 (kfw)  : GetBICFilename( ) updated as wrapper to GetBicFilename( ) - Thank you JWR (Obsidian!).
// Modified : 08/06/09 (f4ba) : Added SetHair and SetHead.

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Constants                        */
/************************************/
const string PLUGIN_NAME	= "CHARACTER";
const string BIC_COMMANDS	= "BIC_Commands";
const string BIC_FILE		= "BIC_File";


// Wing Types.
const int	WING_NONE			=	0;
const int	WING_GARGOYLE		=	7;
const int	WING_PITFIEND		=	8;
const int	WING_BALOR			=	9;
const int	WING_IMP			=	10;
const int	WING_IMPFIRE		=	11;
const int	WING_IMPICE			=	12;
const int	WING_HORNDEVIL		=	13;
const int	WING_ERINYES		=	14;
const int	WING_SUCCUBUS		=	15;
const int	WING_HEZEBEL		=	16;
const int	WING_LICHCLOAK		=	17;
const int	WING_TANNCLOAK		=	18;
const int	WING_KINGSHADOWS	=	19;
const int	WING_ZHJAEVECLOAK	=	20;

// Tail Types.
const int	TAIL_NONE			=	0;
const int	TAIL_REDDRAGON		=	4;
const int	TAIL_SUCCUBUS		=	5;
const int	TAIL_HEZEBEL		=	6;
const int	TAIL_BLACKDRAGON	=	7;
const int	TAIL_TIEFLINGMALE	=	8;
const int	TAIL_TIEFLINGFEMALE	=	9;
const int	TAIL_BRONZEDRAGON	=	11;


/************************************/
/* Function prototypes              */
/************************************/

// Get the servervault location.
string GetServervaultLocation();
string SERVERVAULT = "C:\\Users\\Alex\\Documents\\Neverwinter Nights 2\\servervault\\"; //Replaced old path of: "C:|nwn|servervault|"

// This method the player's character to his or her vault.
void SaveCharacter( object oPC );

// This method will update the player's character with the changes.
void BootAndUpdateCharacter( object oPC );

// This method will get the player's BIC filename.
string GetBICFilename( object oPC );

// This method parses the integer ability into a string.
string ParseAbility( int nAbility );

// This method sets the character's ability score.
void SetAbilityScore( object oPC, int nAbility, int nScore );

// This method sets the character's base skill rank.
// void SetBaseSkillRank( object oPC, int nSkill, int nRank );

// This method deletes the player character object.
void DeleteCharacter( object oPC );

// This method archives the player character object.
void ArchiveCharacter( object oPC );

// This method sets the character's head type.
void SetHead( object oPC, int iHeadID );

// This method sets the character's hair type.
void SetHair( object oPC, int iHairID );

// This method sets the character's wing type.
// Wing type given by WING_*.
void SetWing( object oPC, int nWingType );

// This method sets the character's tail type.
// Tail type given by TAIL_*.
void SetTail( object oPC, int nTailType );

// Retints the limbs.
void Retint( object oPC );

// This method sets the character's hair tint, Part1 = hair accessory, Part2 = hair highlight 1, Part3 = hair highlight 2, RGB values.
void SetHairTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B );

// This method sets the character's head tint, Part1 = face, Part2 = eyes, Part3 = eyebrows, RGB values.
void SetHeadTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B );

// This method sets the character's body tint, Part1 = misc, Part2 = torso, Part3 = limbs, RGB values.
void SetBodyTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B );

// This method transforms an integer matrix to a string with padding.
string TransformMatrix( int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B );


/************************************/
/* Implementation                   */
/************************************/

string GetServervaultLocation() {
	// First call?
	if ( SERVERVAULT == "" ) {
		SendMessageToAllDMs( "Attempting to find servervault." );
		string sv = NWNXGetString( PLUGIN_NAME, "GETSERVERVAULT", "", 0 );
		SERVERVAULT = GetSubString( sv, 1, GetStringLength( sv ) - 2 );
		SendMessageToAllDMs( "Servervault: " + SERVERVAULT );
	}
	
	// Return location.
	return SERVERVAULT;
}

// This method will save the player's character to his or her vault.
void SaveCharacter( object oPC ){

	ExportSingleCharacter( oPC );
	
	return;
	
}


// This method will update the player's character with the changes.
void BootAndUpdateCharacter( object oPC ){

	// Variables.
	object oModule			= GetModule( );
	string sBIC_Filename	= GetBICFilename( oPC );
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );

	// Purge the BIC commands off of the character file.
	DeleteLocalString( oPC, BIC_COMMANDS );
	// Persist the character.
	SaveCharacter( oPC );
	// Boot the player from the Server to ensure that the changes are saved.
	BootPC( oPC );
	// Save the changes.
	DelayCommand( 1.5, NWNXSetString( PLUGIN_NAME, "UPDATE", sBIC_Filename, 0, sBIC_Commands ) );
		
	return;
	
}	


// This method will get the player's BIC filename.
// Uses Obsidian's new function (Thank you JWR!)
// Returns the full path to the BIC file.
string GetBICFilename( object oPC ) {
	// Variables.
	string sPath = GetBicFileName( oPC );	// Get the character's relative path.
	int nSize = GetStringLength( sPath );	// Length of the string path.
	int iTrim = GetStringLength( GetPCPlayerName( oPC ) ) + 13;

	// Trim the returned path.
	sPath = GetSubString( sPath, iTrim, nSize - iTrim );

	// Prefix with the servervault's path and append the file type.
	sPath = GetServervaultLocation() + "/" + GetPCPlayerName( oPC ) + "/" + sPath + ".bic";

	// Return the full path to the player's Bic file.
	return( sPath );
}

	
// This method parses the integer ability into a string.
string ParseAbility( int nAbility ){

	switch( nAbility ){
		case ABILITY_STRENGTH:		return( "Str" );
		case ABILITY_DEXTERITY:		return( "Dex" );
		case ABILITY_CONSTITUTION:	return( "Con" );
		case ABILITY_WISDOM:		return( "Wis" );
		case ABILITY_INTELLIGENCE:	return( "Int" );
		case ABILITY_CHARISMA:		return( "Cha" );
		default:					return( "" );
	}
	
	return( "" );
	
}


// This method sets the character's ability score.
void SetAbilityScore( object oPC, int nAbility, int nScore ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	string sAbility			= ParseAbility( nAbility );
	string sScore			= IntToString( nScore );
	
	
	// Invalid parameters.
	if( sAbility == "" || sScore == "" )
		return;
		
	// Form the BIC command.
	sBIC_Command = "SetAbilityScore " + sAbility + " " + sScore + " ";
		
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
		
	return;
	
}


/* This method sets the character's base skill rank.
void SetBaseSkillRank( object oPC, int nSkill, int nRank ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );
	string sBIC_Command		= "";
	string sSkill			= IntToString( nSkill );
	string sRank			= IntToString( nRank );
	
	
	// Invalid parameters.
	if( sSkill == "" || sRank == "" )
		return;
		
	// Form the BIC command.
	sBIC_Command =
		"SetBaseSkillRank "			+
		sSkill						+
		" "							+
		sRank						+
		" ";
		
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
} */


// This method deletes the player character object.
void DeleteCharacter( object oPC ){
	
	// Variables.
	string sBicFilename	= GetBICFilename( oPC );
	
	
	// Persist the character.
	SaveCharacter( oPC );
	// Boot the player from the game to unlock the file.
	BootPC( oPC );
	// Delete the player's BIC file.
	DelayCommand( 2.5, NWNXSetString( PLUGIN_NAME, "DEL", sBicFilename, 0, "" ) );
	
	return;
	
}


// This method archives the player character object.
void ArchiveCharacter( object oPC ){
	
	// Variables.
	string sBicFilename = GetBICFilename( oPC );
	
	
	// Persist the character.
	SaveCharacter( oPC );
	// Boot the player from the game to unlock the file.
	BootPC( oPC );
	// Delete the player's BIC file.
	DelayCommand( 1.5, NWNXSetString( PLUGIN_NAME, "ARCHIVE", sBicFilename, 0, "" ) );
	
	return;
	
}


// This method entry-tints the player character object.
void EnterCharacter( object oPC ){
	// Variables.
	string sBicFilename = GetBICFilename( oPC );

	// Persist the character.
	SaveCharacter( oPC );
	
	// Boot the player from the game to unlock the file.
	BootPC( oPC );
	
	// Delete the player's BIC file.
	DelayCommand( 1.5, NWNXSetString( PLUGIN_NAME, "ENTRY", sBicFilename, 0, "" ) );
	
	return;
}


// This method sets the character's head type.
void SetHead( object oPC, int iHeadID ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	string sHeadID			= IntToString( iHeadID );
	
	
	// Form the BIC command.
	sBIC_Command = "SetHead " + sHeadID + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method sets the character's hair type.
void SetHair( object oPC, int iHairID ) {
	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	string sHairID			= IntToString( iHairID );
	
	
	// Form the BIC command.
	sBIC_Command = "SetHair " + sHairID + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method sets the character's wing type.
// Wing type given by WING_*.
void SetWing( object oPC, int nWingType ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	string sWingType		= IntToString( nWingType );
	
	// Form the BIC command.
	sBIC_Command = "SetWing " + sWingType + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method sets the character's tail type.
// Tail type given by TAIL_*.
void SetTail( object oPC, int nTailType ) {

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	string sTailType		= IntToString( nTailType );
	
	// Form the BIC command.
	sBIC_Command = "SetTail " + sTailType + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	SendMessageToPC( oPC, "SetTail( oPC, " + IntToString( nTailType ) + " );" );
	
	return;
	
}


// This method retints the character.
void Retint( object oPC ) {
	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	
	// Form the BIC command.
	sBIC_Command = "Retint";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}

// This method sets the character's hair tint, Part1 = hair accessory, Part2 = hair highlight 1, Part3 = hair highlight 2, RGB values.
void SetHairTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	
	// Parse the integer argument into a string for this tint.
	string sTint			= TransformMatrix(
								part1R, part1G, part1B,
								part2R, part2G, part2B,
								part3R, part3G, part3B );
	
	
	// Form the BIC command.
	sBIC_Command = "SetHairTint " + sTint + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method sets the character's head tint, Part1 = face, Part2 = eyes, Part3 = eyebrows, RGB values.
void SetHeadTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	
	// Parse the integer argument into a string for this tint.
	string sTint			= TransformMatrix(
								part1R, part1G, part1B,
								part2R, part2G, part2B,
								part3R, part3G, part3B );
	
	// Form the BIC command.
	sBIC_Command = "SetHeadTint " + sTint + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method sets the character's body tint, Part1 = misc, Part2 = torso, Part3 = limbs, RGB values.
void SetBodyTint( object oPC, int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B ){

	// Variables.
	string sBIC_Commands	= GetLocalString( oPC, BIC_COMMANDS );	
	string sBIC_Command		= "";
	
	// Parse the integer argument into a string for this tint.
	string sTint			= TransformMatrix(
								part1R, part1G, part1B,
								part2R, part2G, part2B,
								part3R, part3G, part3B );
	
	// Form the BIC command.
	sBIC_Command = "SetBodyTint " + sTint + " NULL ";
	
	// Append the BIC command to the player object.
	sBIC_Commands += sBIC_Command;
	SetLocalString( oPC, BIC_COMMANDS, sBIC_Commands );
	
	return;
	
}


// This method transforms an integer matrix to a string with padding.
string TransformMatrix( int part1R, int part1G, int part1B, int part2R, int part2G, int part2B, int part3R, int part3G, int part3B ){

	// Variables.
	string sPart1R = "", sPart1G = "", sPart1B = "";
	string sPart2R = "", sPart2G = "", sPart2B = "";
	string sPart3R = "", sPart3G = "", sPart3B = "";
	
	int nPadding = 0;
	
	
	// Invalid parameters.
	if( ( part1R < 0 || part1R > 255 ) || ( part1G < 0 || part1G > 255 ) || ( part1B < 0 || part1B > 255 ) ||
		( part2R < 0 || part2R > 255 ) || ( part2G < 0 || part2G > 255 ) || ( part2B < 0 || part2B > 255 ) ||
		( part3R < 0 || part3R > 255 ) || ( part3G < 0 || part3G > 255 ) || ( part3B < 0 || part3B > 255 ) ){
		return( "" );
	}
	
	// Convert the integer tints to string values.
	sPart1R = IntToString( part1R ); nPadding = 3 - GetStringLength( sPart1R );
	if( nPadding == 1 ){ sPart1R = InsertString( sPart1R, "0", 0 ); }
	else if( nPadding == 2 ){ sPart1R = InsertString( sPart1R, "00", 0 ); }
	sPart1G = IntToString( part1G ); nPadding = 3 - GetStringLength( sPart1G );
	if( nPadding == 1 ){ sPart1G = InsertString( sPart1G, "0", 0 ); }
	else if( nPadding == 2 ){ sPart1G = InsertString( sPart1G, "00", 0 ); }
	sPart1B = IntToString( part1B ); nPadding = 3 - GetStringLength( sPart1B );
	if( nPadding == 1 ){ sPart1B = InsertString( sPart1B, "0", 0 ); }
	else if( nPadding == 2 ){ sPart1B = InsertString( sPart1B, "00", 0 ); }
	
	sPart2R = IntToString( part2R ); nPadding = 3 - GetStringLength( sPart2R );
	if( nPadding == 1 ){ sPart2R = InsertString( sPart2R, "0", 0 ); }
	else if( nPadding == 2 ){ sPart2R = InsertString( sPart2R, "00", 0 ); }
	sPart2G = IntToString( part2G ); nPadding = 3 - GetStringLength( sPart2G );
	if( nPadding == 1 ){ sPart2G = InsertString( sPart2G, "0", 0 ); }
	else if( nPadding == 2 ){ sPart2G = InsertString( sPart2G, "00", 0 ); }
	sPart2B = IntToString( part2B ); nPadding = 3 - GetStringLength( sPart2B );
	if( nPadding == 1 ){ sPart2B = InsertString( sPart2B, "0", 0 ); }
	else if( nPadding == 2 ){ sPart2B = InsertString( sPart2B, "00", 0 ); }
	
	sPart3R = IntToString( part3R ); nPadding = 3 - GetStringLength( sPart3R );
	if( nPadding == 1 ){ sPart3R = InsertString( sPart3R, "0", 0 ); }
	else if( nPadding == 2 ){ sPart3R = InsertString( sPart3R, "00", 0 ); }
	sPart3G = IntToString( part3G ); nPadding = 3 - GetStringLength( sPart3G );
	if( nPadding == 1 ){ sPart3G = InsertString( sPart3G, "0", 0 ); }
	else if( nPadding == 2 ){ sPart3G = InsertString( sPart3G, "00", 0 ); }
	sPart3B = IntToString( part3B ); nPadding = 3 - GetStringLength( sPart3B );
	if( nPadding == 1 ){ sPart3B = InsertString( sPart3B, "0", 0 ); }
	else if( nPadding == 2 ){ sPart3B = InsertString( sPart3B, "00", 0 ); }
	
	// Create the return string.
	return( sPart1R + sPart1G + sPart1B + sPart2R + sPart2G + sPart2B + sPart3R + sPart3G + sPart3B );
	
}