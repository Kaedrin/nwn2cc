/*
Author: 		DM_Nocturne
Created: 		October 10, 2013
Last Modified:	October 17, 2013
Description:

System for "corrupting" Warlocks to be more like their pact source the more they use their
powers. To use, modify warlock spells to include this script, and add 
AddCorruption(OBJECT_SELF, ESL) to the spell's main() method. All Shape and Essences run 
through one script (nw_i0_invocatns), while other Invocations need to be modified seperately.
*/

#include "nwnx_sql"
#include "cmi_ginc_spells"

const float CORRUPTION_THRESHOLD = 30.0; //How many "corruption points" a PC needs to acquire before
										 //having their alignment shifted by one point. The maximum number
										 //of corrupttion points that can be gained at once is 1, when a
										 //CL 30 Warlock casts an ESL 9 invocation. 

// Shifts a PC's alignment one point in the direction(s) that align with their pact.
void corrupt (object oPC)
{
	if(GetHasFeat(2300, oPC)) // Abyssal
	{
		SendMessageToPC(oPC,"Giving in to the siren call of your Abyssal pact you slip further, corrupting your soul and twisting your mind to be more like the power you wield.");
		AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
		AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);		
	}
	if(GetHasFeat(2301, oPC)) // Seelie Fey
	{
		SendMessageToPC(oPC,"Giving in to the siren call of your Seelie pact you slip further, corrupting your soul and twisting your mind to be more like the power you wield.");
		AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);	
	}
	if(GetHasFeat(2302, oPC)) // Unseelie Fey
	{
		SendMessageToPC(oPC,"Giving in to the siren call of your Unseelie pact you slip further, corrupting your soul and twisting your mind to be more like the power you wield.");
		AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
		AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);
	}
	if(GetHasFeat(2303, oPC)) // Infernal
	{
		SendMessageToPC(oPC,"Giving in to the siren call of your Infernal pact you slip further, corrupting your soul and twisting your mind to be more like the power you wield.");
		AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
		AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 1);
	}
	if(GetHasFeat(2304, oPC)) // Star
	{
		SendMessageToPC(oPC,"Giving in to the siren call of your Star pact you slip further, corrupting your soul and twisting your mind to be more like the power you wield.");
		AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
	}
}

//
void AddCorruption (object oCaster, int ESL)
{

	//If the caster is not a PC (NPC or item), don't add corruption points.
	if(!GetIsPC(oCaster))
	{
		return;
	}
	
	//Use 'floats' to allow for decimals and fractions when doing division later
	float casterLevel = IntToFloat(GetWarlockCasterLevel(oCaster)); //Gets Warlock CL
	float powerLevel = IntToFloat(ESL); //Converts Invocation ESL from an int to a float
	
	//Get PC's data
    string toon = GetName(oCaster); //Get PC name
	string player = GetPCPlayerName(oCaster); //Get player login
	
	toon = SQLEncodeSpecialChars(toon);
	player = SQLEncodeSpecialChars(player);
	
	string sSQL = "SELECT current, total FROM corruption "
				  +"WHERE toon='" + toon 
				  +"' AND player='" + player + "'";
	SQLExecDirect(sSQL);
	
	float current;
	float total;
	int row_exists = FALSE;
    if (SQLFetch() == SQL_SUCCESS) //Warlock has used their powers before
	{
         current = StringToFloat(SQLGetData(1)); //Current corruption
		 total =  StringToFloat(SQLGetData(2)); //Total corruption
		 row_exists = TRUE;
	}
	else //Warlock has never used their powers before
	{	
		current = 0.0;
		total = 0.0;
	}
	
	current += 0.5*(casterLevel/30.0 + powerLevel/9.0);
	total += 0.5*(casterLevel/30.0 + powerLevel/9.0);
				  
	if (row_exists)
    {
        //Row exists, update total corruption     
		sSQL = "UPDATE corruption SET total='" + FloatToString(total)
		 +"' WHERE toon='" + toon
         +"' AND player='" + player + "'";
        SQLExecDirect(sSQL); //Total corruption updated
		
		//Check to see if the caster's current corruption has reached/execeeded the threshold
		if(current >= CORRUPTION_THRESHOLD)
		{
			corrupt(oCaster);
			current = 0.0; //Rest current corruption, start the count ot the threshold over
		}
		
		//Now update current corruption in the database
		sSQL = "UPDATE corruption SET current='" + FloatToString(current)
		 +"' WHERE toon='" + toon
         +"' AND player='" + player + "'";
		 SQLExecDirect(sSQL); //Current corruption updated
    }
    else
    {
        // row doesn't exist, create a new row for this PC and login
        sSQL = "INSERT INTO corruption (toon,player,current,total) VALUES" 
				+ "('" + toon + "','" + player + "','" + FloatToString(current) 
				+ "','" + FloatToString(total) + "')";
		SQLExecDirect(sSQL);
    }
}