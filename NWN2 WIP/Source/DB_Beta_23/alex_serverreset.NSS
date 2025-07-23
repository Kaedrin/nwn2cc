#include "nwnx_clock"
#include "nwnx_srvadmin"
#include "nwnx_system"
#include "alex_constants"
#include "hcr2_mysqldb_c"

void SendServerShout(string message)
{
	object oPC = GetFirstPC();
	while(GetIsObjectValid(oPC) == TRUE)
	{
		SendMessageToPC(oPC, message);
		oPC = GetNextPC();
	}
}

void AttemptReset()
{
	int originalTime = GetGlobalInt("reset");
	int currentTime = GetUNIXTime();
	int expire = GetGlobalInt("expire");
	int resetTimer = currentTime - originalTime;
	if(resetTimer > expire)
	{
		SendServerShout("The server will be restarting in 1 minute.");
		BroadcastServerMessage("The server will be restarting in 1 minute.");
		DelayCommand(60.0, ResetServer( ));
	}
}

void main()
{
	int originalTime = GetGlobalInt("reset");
	int currentTime = GetUNIXTime();
	//int startTime = GetGlobalInt("startTime");
	//int upTime = StringToInt(GetSystemTime());
	
	if(originalTime==0)
	{
		originalTime = GetUNIXTime();
		SetGlobalInt("reset", originalTime);
		DelayCommand(10.0, SetPlayerPassword(""));
		SetGlobalInt("expire", RESET_EXPIRE);
	}
	int resetTimer = currentTime - originalTime;
	int chatTimer = resetTimer / 3600;
	
	if(chatTimer>0)
	{
		BroadcastServerMessage("The server has been up for " + IntToString(chatTimer) + " hours.");
		SendServerShout("The server has been up for " + IntToString(chatTimer) + " hours.");
		
		//if(h2_GetPlayerCount() >= 50)
		//{
		//	DelayCommand(10.0, SetPlayerPassword("Elminster"));
		//}
		//else
		//{
		//	DelayCommand(10.0, SetPlayerPassword(""));
		//}
	}
	
	int expire = GetGlobalInt("expire");
	
	if(resetTimer > expire)
	{
		BroadcastServerMessage("The server will be restarting in 10 minutes.");
		SendServerShout("The server will be restarting in 10 minutes.");
		DelayCommand(540.0, AttemptReset());
		//DelayCommand(540.0, SendServerShout("The server will be restarting in 1 minute."));
		//DelayCommand(540.0, BroadcastServerMessage("The server will be restarting in 1 minute."));
		//DelayCommand(600.0, ResetServer( ));
		//DelayCommand(600.0, ShutdownNwn2server());
	}
}