/*
Author: 		DM_Nocturne
Created: 		October 22, 2013
Last Modified:	October 23, 2013
Description:

System for slowly shifting the alignment of PC towards Evil for using Evil spells.
To use, modify any spell to include this script, and add 
AddEvilCorruption(OBJECT_SELF, GetSpellLevel(GetSpellID)) to the spell's main() method.
*/

#include "nwnx_sql"
#include "cmi_ginc_spells"

const float CORRUPTION_THRESHOLD = 10.0; //How many "corruption points" a PC needs to acquire before
										 //having their alignment shifted towards Evil by one point.
										 //The maximum number of corruption points that can be gained
										 //at once is 1, when a player casts Vampiric Feast. 

void AddEvilCorruption (object oCaster, int spellLvl)
{

	//If the caster is not a PC (NPC or item), don't add corruption points.
	if(!GetIsPC(oCaster))
	{
		return;
	}
	
	//Use 'floats' to allow for decimals and fractions when doing division later
	float spellLevel = IntToFloat(spellLvl); //Converts Spell Level from an Int to a Float
	
	//Get PC's data
    string toon = GetName(oCaster); //Get PC name
	string player = GetPCPlayerName(oCaster); //Get player login
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT currentEvil, totalEvil FROM corruption "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player + "'";
	SQLExecDirect(sSQL);
	
	float current;
	float total;
	int row_exists = FALSE;
    if (SQLFetch() == SQL_SUCCESS) //Caster has used an evil spell before.
	{
         current = StringToFloat(SQLGetData(1)); //Current corruption
		 total =  StringToFloat(SQLGetData(2)); //Total corruption
		 row_exists = TRUE;
	}
	else //Caster has never used an Evil spell before
	{	
		current = 0.0;
		total = 0.0;
	}
	
	current += spellLevel/10.0;
	total += spellLevel/10.0;
				  
	if (row_exists)
    {
        //Row exists, update total corruption     
		sSQL = "UPDATE corruption SET totalEvil='" + FloatToString(total)
		 +"' WHERE toon='" + toon
         +"' AND player='" + player + "'";
        SQLExecDirect(sSQL); //Total corruption updated
		
		//Check to see if the caster's current corruption has reached/execeeded the threshold
		if(current >= CORRUPTION_THRESHOLD)
		{
			SendMessageToPC(oCaster, "Your use of Evil magic has taken a toll on your spirit.");
			AdjustAlignment(oCaster, ALIGNMENT_EVIL, 1); 
			current = 0.0; //Reset current corruption, start the count of the threshold over
		}
		
		//Now update current corruption in the database
		sSQL = "UPDATE corruption SET currentEvil='" + FloatToString(current)
		 +"' WHERE toon='" + toon
         +"' AND player='" + player + "'";
		 SQLExecDirect(sSQL); //Current corruption updated
    }
    else
    {
        // row doesn't exist, create a new row for this PC and login
        sSQL = "INSERT INTO corruption (toon,player,currentEvil,totalEvil) VALUES" 
				+ "('" + toon + "','" + player + "','" + FloatToString(current) 
				+ "','" + FloatToString(total) + "')";
		SQLExecDirect(sSQL);
    }
}