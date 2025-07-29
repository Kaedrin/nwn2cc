//-----------------------------------------------------------------------------
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
//  Script Name: vn_inc_debug
//  Description: debug support for the systems within Fournoi.  This is a GUI
// 			debug system.
//------------------------------------------------------------------------------

// Use: if (TEST) Debug(); in performace critical code. Hopefully the compiler
//      can then optimize out these lines
// Use: Debug(); in non perfomance critical code, so debugging can be turned
//      on/off at run time.
const int TEST = 0; // production or performance test.
//const int TEST = 1; // development / debugging.

#include "vn_inc_constants"

const int DEBUG_SYSTEM_COUNT = 9;
const int RCS = 1;   // Region control system
const int TRE = 2;   // Treasure system
const int MER = 3;   // Merchants
const int SPELL = 4; // Spells
const int MDP = 5; // Item Modification
const int XP = 6;    // XP
const int QS = 7; 	 // Quests
const int AI = 8;	 // AI
const int MISC = 9;  // Non-systems
// debuggin levels
const int DEBUG_LEVEL_NONE     = 0;
const int DEBUG_LEVEL_SYSTEM   = 1;
const int DEBUG_LEVEL_FUNCTION = 2;
const int DEBUG_LEVEL_TRACE    = 3;

// called to send a message to the debugger, if debugging is on.
void Debug(string sMsg, int nSystem = 0, int nLevel = 0);
void Error(string sMsg, int nSystem = 0);

// sMsg - The debuging message. Usual format is "script: function() - information."
// nSystem - Identifies the system the message belongs to, alowing messages to be filtered.
// nLevel - Depth of debugging information. 1: Sytem level decision. 2: Function start/end and major branches. 3: Full trace
void Debug(string sMsg, int nSystem = 6, int nLevel = 0)
{
	object oModule = GetModule();
	object oDebugger = GetLocalObject(oModule, "Debugger");
	if ( ! GetIsObjectValid(oDebugger) ) return;
	
	int nDebugLevel;
	if (nSystem)
		nDebugLevel = GetLocalInt(oModule, "DebugSystem" + IntToString(nSystem));
	else
		nDebugLevel = DEBUG_LEVEL_TRACE;
			
	if (nDebugLevel >= nLevel)
	{	
		PrintString(sMsg);
		SendMessageToPC(oDebugger, sMsg);
	}
}

void Error(string sMsg, int nSystem = 0)
{
	
	object oDebugger = GetLocalObject(GetModule(), "Debugger");
	WriteTimestampedLogEntry(sMsg);
	SendMessageToPC(oDebugger, sMsg);
}

string EncodeGUIDebugState(int nDebugState)
{
	string sDebugState;
	switch(nDebugState)
	{
		case 0 : sDebugState="Off";break;
		case 1 : sDebugState="System";break;
		case 2 : sDebugState="Function";break;
		case 3 : sDebugState="Trace";break;

		default: sDebugState="Error"; break;
	}
	return sDebugState;
}

int DecodeGUIDebugState(string sDebugState)
{
	if (sDebugState=="Off")
		return 0;
	if (sDebugState == "System")
		return 1;
	if (sDebugState=="Function")
		return 2;
	if (sDebugState == "Trace")
		return 3;

	return 99;
}


void ToggleDebugGUIObjectVisibility(string sDebugSystemName,string sDebugSystemState,object oPC)
{

	string sOffChecked = sDebugSystemName + "_Off_Ch";
	string sOffUnchecked = sDebugSystemName + "_Off_Un";
	string sSystemChecked = sDebugSystemName + "_System_Ch";
	string sSystemUnchecked = sDebugSystemName + "_System_Un";
	string sFunctionChecked = sDebugSystemName + "_Function_Ch";
	string sFunctionUnchecked = sDebugSystemName + "_Function_Un";
	string sTraceChecked = sDebugSystemName + "_Trace_Ch";
	string sTraceUnchecked = sDebugSystemName + "_Trace_Un";

	if (sDebugSystemState == "Off")
	{
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffChecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceUnchecked,FALSE));

		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffUnchecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceChecked,TRUE));
	
	}
	else if (sDebugSystemState == "System")
	{
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemChecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceUnchecked,FALSE));
		
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemUnchecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceChecked,TRUE));	
	}
	else if (sDebugSystemState == "Function")
	{
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionChecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceUnchecked,FALSE));
		
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionUnchecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceChecked,TRUE));	
	}
	else if (sDebugSystemState == "Trace")
	{
	
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceChecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemUnchecked,FALSE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionUnchecked,FALSE));
		
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sTraceUnchecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sOffChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sSystemChecked,TRUE));
		DelayCommand(0.1,SetGUIObjectHidden(oPC,"SCREEN_VN_DEBUG",sFunctionChecked,TRUE));

	}

}

void UpdateDebugger(object oDebugger)
{
	int nCount =1;
	int bDebugger = FALSE;
	object oModule = GetModule();

	while (nCount <= DEBUG_SYSTEM_COUNT)
	{
		string sModVarDebugSystem = "DebugSystem" + IntToString(nCount);
		int nModVarDebugState = GetLocalInt(oModule,sModVarDebugSystem);
			if (nModVarDebugState != 0)
				bDebugger = TRUE;	
		nCount++;
	}

	if (bDebugger)
	{	
		DelayCommand(0.1,SetLocalObject(oModule,"Debugger",oDebugger));		
		string sDebuggerName = GetName(oDebugger);
		DelayCommand(0.1,SetLocalGUIVariable(oDebugger,"SCREEN_VN_DEBUG",0,sDebuggerName));
	}
	else
	{
		DeleteLocalObject(oModule,"Debugger");	
		DelayCommand(0.1,SetLocalGUIVariable(oDebugger,"SCREEN_VN_DEBUG",0,""));
	}	
}