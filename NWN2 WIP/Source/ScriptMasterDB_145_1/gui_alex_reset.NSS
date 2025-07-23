#include "ginc_param_const"
#include "nwnx_system"
#include "nwnx_srvadmin"
#include "nwnx_clock"
#include "alex_constants"

void SendServerShout(string message)
{
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC) == TRUE)
	{
		//SendChatMessage(OBJECT_INVALID, oPC, CHAT_MODE_SHOUT, message);
		SendMessageToPC(oPC, message);
		oPC = GetNextPC();
	}
}

void AttemptReset()
{
	if(GetGlobalInt("ManualReset") == 1)
	{
		SendServerShout("The server will be restarting in 1 minute.");
		BroadcastServerMessage("The server will be restarting in 1 minute.");
		AssignCommand(GetModule(), DelayCommand(60.0, ResetServer( )));
	}
	else
	{
		SendMessageToAllDMs( "Server reset was aborted." );	
	}
}


void main(string extend)
{
	// Get the PC Speaker - if used from command line, then use OBJECT_SELF
	// In a conversation, OBJECT_SELF refers to the NPC.
	// From the command line, OBJECT_SELF refers to the currently possesed character.
    object oPC = OBJECT_SELF;

	// Do stuff here
	if ( GetIsDM(oPC) && extend == "0" && RESET_ENABLED) {
		SendMessageToAllDMs( "[" + GetPCPlayerName(oPC) + "] initiate server reset." );
		WriteTimestampedLogEntry("[" + GetPCPlayerName(oPC) + "] initiate server reset." );
		BroadcastServerMessage("The server will be restarting in 10 minutes.");
		SendServerShout("The server will be restarting in 10 minutes.");
		//DelayCommand(540.0, SendServerShout("The server will be restarting in 1 minute."));
		//DelayCommand(540.0, BroadcastServerMessage("The server will be restarting in 1 minute."));
		//DelayCommand(600.0, ResetServer( ));
		SetGlobalInt("ManualReset", 1);
		AssignCommand(GetModule(), DelayCommand(540.0, AttemptReset()));
	}
	else if ( GetIsDM(oPC) && extend == "1" && RESET_ENABLED) {
		int expire = GetGlobalInt("expire");
		int originalTime = GetGlobalInt("reset");
		int currentTime = GetUNIXTime();
		expire = expire + 3600;
		SetGlobalInt("expire", expire);
		int reset = (expire - (currentTime-originalTime))/3600; 
		SendMessageToAllDMs( "[" + GetPCPlayerName(oPC) + "] initiate server extend reset by 1 hour." );
		SendMessageToAllDMs( "The server will be resetting in " + IntToString(reset) + " hours.");
		//SendMessageToAllDMs( "Expire is " + IntToString(expire));
		WriteTimestampedLogEntry("[" + GetPCPlayerName(oPC) + "] initiate server extend reset by 1 hour." );
		//int originalTime = GetGlobalInt("reset");
		//SetGlobalInt("reset", (originalTime-1));
		if(GetGlobalInt("ManualReset") == 1)
		{
			SetGlobalInt("ManualReset", 0);
			SendMessageToAllDMs( "Server reset was aborted." );	
		}
	}
}