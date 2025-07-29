///////////////////////////////////////////////
//		      NPC_ACTIVINC 1.42			     //
//		      Uncle FB 05/2009				 //
///////////////////////////////////////////////
#include "npc_include"
#include "npc_speak"
#include "ginc_actions"
#include "x0_i0_position"
#include "x0_i0_anims"
#include "x2_inc_switches"
///////////////////////////////////////////////
//void NpcHidden			 
//void NpcActOne 			
//void NpcActTwo  		
//void NpcDinner 		
//void NpcWake				
//void NpcMidnightBed 		
//void NpcMidnight90 	
//void NpcSleepBed 			
//void NpcSleep90 			
//void NpcAgree 			
//void NpcAngry 		
//void NpcSad 			
//void NpcCook				
//void NpcDanceFemale 	
//void NpcDanceMale 		
//void NpcDrum			
//void NpcFlute			
//void NpcForge				
//void NpcGuitar		
//void NpcWoodsman			
//void NpcMeditate		
//void NpcPost				
//void NpcRead			
//void NpcSit				
//void NpcSitDinner			
//void NpcStandChat			
//void NpcTrainingOne		
//void NpcTrainingTwo		
//void NpcCheer				
//void NpcTrainerPace		
//void NpcWwp 			
//void NpcCookMulti			
//void NpcForgeMulti		
//void NpcTheif             
//void NpcTheif2           
//void NpcAssassin         
//void NpcHide              
//void NpcSeek              
//void NpcMerchantMulti		
//void NpcKneelTalk     
//void NpcLightKeeper    	
//void NpcBarmaid
//void NpcBartender
//void LocateWrapper		
//void LocateActivityOne	
//void LocateActivityTwo 	
//void LocateActivityThree	
//void ExecuteActivity 		
//void NpcTemplate			
//void NpcMultiTemplate     
///////////////////////////////////////////////
///////////////////////////////////////////////
//FUNCTION PROTOTYPES                        //
///////////////////////////////////////////////

//Use this behavior if you do not have a bed or
//activity in mind for this particular time of day
//waypoint is still required
void NpcHidden (object oNpc, object oWp1, int nSpeak);

/////////////////////////////////////////////////////////
//SETUP DEFAULT ACTION IN THE FOLLOWING FUNCTIONS BELOW//
/////////////////////////////////////////////////////////
//Use this command to set your favored default
//for activity one
void NpcActOne (object oNpc, object oWp1, int nSpeak);

//Use this command to set your favored default
//for activity two 
void NpcActTwo (object oNpc, object oWp1, int nSpeak);

//Use this command to set your favored default
//for dinner 
void NpcDinner (object oNpc, object oWp1, int nSpeak);

//Use this command to set your favored default
//for wake
void NpcWake (object oNpc, object oWp1, int nSpeak);
/////////////////////////////////////////////////////////
//SETUP DEFAULT ACTION IN THE PRECEDING FUNCTIONS ABOVE//
/////////////////////////////////////////////////////////

//sleeping midnight behavior for beds
void NpcMidnightBed (object oNpc, object oWp1, int nSpeak);

//sleeping midnight behavior for benches etc...
void NpcMidnight90 (object oNpc, object oWp1, int nSpeak);

//sleeping behavior for beds
void NpcSleepBed (object oNpc, object oWp1, int nSpeak);

//sleeping behavior for benches etc...
void NpcSleep90 (object oNpc, object oWp1, int nSpeak);

//Agreeable conversation behavior
void NpcAgree (object oNpc, object oWp1, int nSpeak);

//Angry conversation behavior
void NpcAngry (object oNpc, object oWp1, int nSpeak);

//Sad conversation behavior
void NpcSad (object oNpc, object oWp1, int nSpeak);

//Standard Cook Behavior
void NpcCook (object oNpc, object oWp1, int nSpeak);

//Standard Dancing Female Behavior
void NpcDanceFemale (object oNpc, object oWp1, int nSpeak);

//Standard Dancing Male Behavior
void NpcDanceMale (object oNpc, object oWp1, int nSpeak);

//Standard drumming behavior for NPC
void NpcDrum (object oNpc, object oWp1, int nSpeak);

//Standard flute behavior for NPC
void NpcFlute (object oNpc, object oWp1, int nSpeak);

//Standard forge behavior for NPC
void NpcForge (object oNpc, object oWp1, int nSpeak);

//Standard guitar behavior for NPC
void NpcGuitar (object oNpc, object oWp1, int nSpeak);

//Standard woodsman behavior for NPC
void NpcWoodsman (object oNpc, object oWp1, int nSpeak);

//Standard meditate behavior for NPC
void NpcMeditate (object oNpc, object oWp1, int nSpeak);

//Standard stand post behavior for NPC
void NpcPost (object oNpc, object oWp1, int nSpeak);

//Standard reading (sitting) behavior for NPC
void NpcRead (object oNpc, object oWp1, int nSpeak);

//standard sitting behavior (no eating)		
void NpcSit (object oNpc, object oWp1, int nSpeak);

//Standard dinner behavior (sitting)
void NpcSitDinner (object oNpc, object oWp1, int nSpeak);

//Standing behavior (chat, laugh, etc...)
void NpcStandChat (object oNpc, object oWp1, int nSpeak);

//Training routine for armed combatants
//REQUIRES: faction control NPC1
void NpcTrainingOne (object oNpc, object oWp1, int nSpeak);

//Training routine for armed combatants
//REQUIRES: faction control NPC2
void NpcTrainingTwo (object oNpc, object oWp1, int nSpeak);

//cheering and clapping behavior
void NpcCheer (object oNpc, object oWp1, int nSpeak);

//Trainer Pacing behavior
//Tag convention WP_NPC TAG_01 etc..
void NpcTrainerPace (object oNpc, int nSpeak);

//Standard WWP behavior
//Tag convention WP_NPC TAG_01 etc..
void NpcWwp (object oNpc, int nSpeak);

//Multiple location cooking behavior
void NpcCookMulti (object oNpc, object oWp1, int nSpeak);

//Multiple location forge behavior
void NpcForgeMulti (object oNpc, object oWp1, int nSpeak);

// standard theif behavior
// should be called through a locate wrapper unless you
// want the theif to rob the exact same place for the entire activity cycle
void NpcThief (object oNpc, object oWp1, int nSpeak);

//Thief behavior where the thief actually steals
//requires variable mark filled out with tags for victims
void NpcThief2 (object oNpc);

//Assassin behavior where the Assassin actually kills
//requires variable mark filled out with tags for victims
void NpcAssassin (object oNpc);

//standard hiding behavior no wp required
void NpcHide (object oNpc);

//standard seeking behavior no wp required
void NpcSeek (object oNpc);

//multi location merchant behavior
void NpcMerchantMulti (object oNpc, object oWp1, int nSpeak);

//multiple locatin worker behavior (moving bottles)
void NpcWorker1 (object oNpc, object oWp1, int nSpeak);

//kneel and talk animation
void NpcKneelTalk (object oNpc, object oWp1, int nSpeak);

//raking animation
void NpcRake (object oNpc, object oWp1, int nSpeak);

//NPC will activate/deactivate light objects
void NpcLightKeeper (object oNpc, object oWp1, int nSpeak);

//This function requires a NPC running the bartender activity at the same time as the barmaid 
//1 barmaid npc with the "npc_barmaid" script on the "on heartbeat" slot
//1 bartender with the "npc_bartender" script in the "on heartbeat" slot
//the bartender tag should be filled out at the beginning of the "npc_barmaid" script SEE NOTES in npc_barmaid
//the bar maid will refer to the bartender by name (listed in properties of bartender in toolset)
//1 generic waypoint with the tag "WP_BAR" for the bar maid to order from and rest at
//the bar maid will randomly choose a customer and take an order
//the drink list can be customized and will be used throughout the bar maid conversation (see npc_include)
//you can set up to 10 exclusions (other NPCs that the bar maid will not serve)
//among the exclusions should be the bar maid, and the bartender (maybe the innkeeper and/or musicians)
//exclusions should be filled out at on the variable list of the bar maid
void NpcBarmaid (object oNpc, object oWp1);

//This activity requires another NPC running the NpcBarmaid activity at the same time
//1 generic waypoint with the tag "WP_BARTENDER" for the bartender to stand at
//1 generic waypoint with the tag "WP_KEG" for the bartender to go to and fill drink orders
void NpcBartender (object oNpc, object oWp1);

//wrapper used to call LocateActivityOne, Two, and Three
//int nOn1 = toggle LocateActivityOne 1=on 0=off
//int nOn2 = toggle LocateActivityTwo 1=on 0=off
//int nOn3 = toggle LocateActivityThree 1=on 0=off
//int nActivity(n) = desired npc activity at new location
//int nDefault(n) = desired default activity
//int nResetspawn1 = destroy waypoint and recreate at 2 hours past time change
//int nResetspawn2 = destroy waypoint and recreate at 3 hours past time change
//int nSpeak = use speak file 0 = off 1 = on
//(see switch in heartbeat script)
void LocateWrapper (object oNpc, object oWp1, int nOn1, int nActivity1, int nOn2, int nActivity2, int nOn3, int nActivity3, int nDefault, int nResetspawn1, int nResetspawn2, int nSpeak);

//this function replaces the waypoint and activity at the first 
//hour past the normal change
//int nOn1 = toggle 1 for on 0 for off
//int nActivity1 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_ACTTAG_NPCTAG_01"
void LocateActivityOne (object oNpc, object oWp1, int nOn1, int nActivity1, int nDefault, int nSpeak);

//this function replaces the waypoint and activity at the second 
//hour past the normal change
//int nOn2 = toggle 1 for on 0 for off
//int nActivity2 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_ACTTAG_NPCTAG_02"
void LocateActivityTwo (object oNpc, object oWp1, int nOn2, int nActivity2, int nDefault, int nResetspawn1, int nSpeak);

//this function replaces the waypoint and activity at the third 
//hour past the normal change
//int nOn3 = toggle 1 for on 0 for off
//int nActivity2 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_ACTTAG_NPCTAG_03"
void LocateActivityThree (object oNpc, object oWp1, int nOn3, int nActivity3, int nDefault, int nResetspawn2, int nSpeak);

//used in locate wrapper to execute the default behavior for a NPC
//int nDefault =  set automatically in LocateWrapper
void ExecuteActivity (object oNpc, object oWp1, int nSpeak, int nDefault);

//Template for NPC activity
//void NpcTemplate (object oNpc, object oWp1, int nSpeak);

//Template for NPC  multi activity
//void NpcMultiTemplate (object oNpc, object oWp1, int nSpeak);

///////////////////////////////////////////////
//FUNCTION DEFINITIONS                       //
///////////////////////////////////////////////

//Use this behavior if you do not have a bed or
//activity in mind for this particular time of day
//waypoint is still required
void NpcHidden (object oNpc, object oWp1, int nSpeak)
{
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
if ((nUd2 == 1) && (fDwp1 <= 0.5))
{SetScriptHidden (oNpc,1,0);}
}

//Use this command to set your favored default
//for activity one
void NpcActOne (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookleft",0,1.0);
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookright",0,1.0);
			break;
			case 2:
			break;
			}
		}		
}

//Use this command to set your favored default
//for activity two
void NpcActTwo (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookleft",0,1.0);
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookright",0,1.0);
			break;
			case 2:
			break;
			}
		}		
}

//Use this command to set your favored default
//for activity dinner
void NpcDinner (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return; }
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
	{switch (iRand)
		{
		case 0:
		NpcSpeak (oNpc, nSpeak);
		PlayCustomAnimation (OBJECT_SELF, "siteat",1,6.0);
		break;
		case 1:
		NpcSpeak (oNpc, nSpeak);
		ActionPlayCustomAnimation(oNpc, "sitdrink", 0, 2.0);
		break;
		case 2:
		NpcSpeak (oNpc, nSpeak);
		PlayCustomAnimation (OBJECT_SELF, "sitidle",1,6.0);
		break;
		}
	}	
}	

//Use this command to set your favored default
//for activity wake
void NpcWake (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "siteat",1,6.0);
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "sitdrink",1,6.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "sitidle",1,6.0);
			break;
			}
		}		
}	

//sleeping midnight behavior for beds
void NpcMidnightBed (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
int nHour = GetTimeHour();
string sCheckd = "sDay";
string sChecks = "sSwing";
string sCheckn = "sNight";
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
object oWp1 = GetCurrentWp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
//
float fDwp2 = GetFacing (oWp1);
//
object oBed = GetObjectByTag("BED"+(sNpc2));
vector vBed=GetPosition(oBed);
object oArea=GetArea(oBed);
float fBed=GetFacing(oBed)+180.0;
location lBed = Location(oArea,vBed,fBed);
int nAwake = GetLocalInt (oNpc, "awake");
int nProne = GetLocalInt (oNpc, "prone");
float fBed2 = GetDistanceBetween (oBed,oNpc);
//SendMessageToPC (GetFirstPC(), "distance ="+FloatToString (fBed2));
		if (fBed2 >= 2.0) {SetLocalInt (oNpc, "prone", 0);}
		if (fDwp1 >= 2.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
		
		if (fDwp1 <= 2.5)
		{SetLocalInt (oNpc,"atloc",1);	
			{switch (nProne)
				{
				default:
				SetLocalInt(oNpc,"sleepcontrol",1);
				SetLocalInt (oNpc, "ud", 1);
				SetFacing (fDwp1);
				DelayCommand(1.8,ActionJumpToLocation(lBed));
				DelayCommand(1.3, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "laydownB", 0, 1.0)));
            	DelayCommand(3.0, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "proneB", 1, 1.0)));
				SetOrientOnDialog(oNpc, FALSE);
				SetLocalInt (oNpc, "prone", 1);
				SetLocalInt (oNpc, "ud", 0);
				break;
				case 1:	
				break;
				}
			}		
		}
	SetLocalInt(oNpc,"awake",0);			
}

//sleeping midnight behavior for benches etc...
void NpcMidnight90 (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
int nHour = GetTimeHour();
string sCheckd = "sDay";
string sChecks = "sSwing";
string sCheckn = "sNight";
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
object oWp1 = GetCurrentWp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
//
float fDwp2 = GetFacing (oWp1);
//
object oBed = GetObjectByTag("BED"+(sNpc2));
vector vBed=GetPosition(oBed);
object oArea=GetArea(oBed);
float fBed=GetFacing(oBed)+90.0;
location lBed = Location(oArea,vBed,fBed);
int nAwake = GetLocalInt (oNpc, "awake");
int nProne = GetLocalInt (oNpc, "prone");
float fBed2 = GetDistanceBetween (oBed,oNpc);

	if (fBed2 >= 2.0) {SetLocalInt (oNpc, "prone", 0);}	
	if (fDwp1 >= 2.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}

		if (fDwp1 <= 2.5)
		{SetLocalInt (oNpc,"atloc",1);	
			{switch (nProne)
				{
				default:
				SetLocalInt(oNpc,"sleepcontrol",1);
				SetLocalInt (oNpc, "ud", 1);
				SetFacing (fDwp1);
				DelayCommand(1.8,ActionJumpToLocation(lBed));
				DelayCommand(1.3, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "laydownB", 0, 1.0)));
            	DelayCommand(3.0, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "proneB", 1, 1.0)));
				SetOrientOnDialog(oNpc, FALSE);
				SetLocalInt (oNpc, "prone", 1);
				SetLocalInt (oNpc, "ud", 0);
				break;
				case 1:	
				break;
				}
			}		
		}
	SetLocalInt(oNpc,"awake",0);			
}

//sleeping  behavior for bed
void NpcSleepBed (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
int nHour = GetTimeHour();
string sCheckd = "sDay";
string sChecks = "sSwing";
string sCheckn = "sNight";
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
object oWp1 = GetCurrentWp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
//
float fDwp2 = GetFacing (oWp1);
//
object oBed = GetObjectByTag("BED"+(sNpc2));
vector vBed=GetPosition(oBed);
object oArea=GetArea(oBed);
float fBed=GetFacing(oBed)+180.0;
location lBed = Location(oArea,vBed,fBed);
int nAwake = GetLocalInt (oNpc, "awake");
int nProne = GetLocalInt (oNpc, "prone");
float fBed2 = GetDistanceBetween (oBed,oNpc);

	if (fBed2 >= 2.0) {SetLocalInt (oNpc, "prone", 0);}	
	if (fDwp1 >= 2.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
		if (fDwp1 <= 2.5)
		{SetLocalInt (oNpc,"atloc",1);	
			{switch (nProne)
				{
				default:
				SetLocalInt(oNpc,"sleepcontrol",1);
				SetLocalInt (oNpc, "ud", 1);
				SetFacing (fDwp1);
				DelayCommand(1.8,ActionJumpToLocation(lBed));
				DelayCommand(1.3, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "laydownB", 0, 1.0)));
            	DelayCommand(3.0, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "proneB", 1, 1.0)));
				SetOrientOnDialog(oNpc, FALSE);
				SetLocalInt (oNpc, "prone", 1);
				SetLocalInt (oNpc, "ud", 0);
				break;
				case 1:	
				break;
				}
			}		
		}
	SetLocalInt(oNpc,"awake",0);			
}

//sleeping  behavior for benches etc...
void NpcSleep90 (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
int nHour = GetTimeHour();
string sCheckd = "sDay";
string sChecks = "sSwing";
string sCheckn = "sNight";
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
object oWp1 = GetCurrentWp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
float fDwp2 = GetFacing (oWp1);
object oBed = GetObjectByTag("BED"+(sNpc2));
vector vBed=GetPosition(oBed);
object oArea=GetArea(oBed);
float fBed=GetFacing(oBed)+90.0;
location lBed = Location(oArea,vBed,fBed);
int nAwake = GetLocalInt (oNpc, "awake");
int nProne = GetLocalInt (oNpc, "prone");
float fBed2 = GetDistanceBetween (oBed,oNpc);
	if (fBed2 >= 2.0) {SetLocalInt (oNpc, "prone", 0);}	
	if (fDwp1 >= 2.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
		if (fDwp1 <= 2.5)
		{SetLocalInt (oNpc,"atloc",1);	
			{switch (nProne)
				{
				default:
				SetLocalInt(oNpc,"sleepcontrol",1);
				SetLocalInt (oNpc, "ud", 1);
				SetFacing (fDwp1);
				DelayCommand(1.8,ActionJumpToLocation(lBed));
				DelayCommand(1.3, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "laydownB", 0, 1.0)));
            	DelayCommand(3.0, ActionDoCommand(ActionPlayCustomAnimation(OBJECT_SELF, "proneB", 1, 1.0)));
				SetOrientOnDialog(oNpc, FALSE);
				SetLocalInt (oNpc, "prone", 1);
				SetLocalInt (oNpc, "ud", 0);
				break;
				case 1:	
				break;
				}
			}		
		}
	SetLocalInt(oNpc,"awake",0);			
}

//Agreeable conversation behavior
void NpcAgree (object oNpc, object oWp1, int nSpeak)
{
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
ClearFlags (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "flirt",0,5.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "chuckle",0,2.0));
			DelayCommand (3.7,ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5));
			break;
			case 3:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "chuckle",0,2.0));
			DelayCommand (3.7,ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5));
			break;
			}
		}
}				
		
//Angry conversation behavior
void NpcAngry (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "nodno",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "intimidate",0,4.5));
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayAnimation (10,1.0,0.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "talkshout",0,6.0);
			break;
			case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "intimidate", 0, 5.0);;
			break;
			}
		}
}		

//Sad conversation behavior
void NpcSad (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayAnimation (9, 1.0, 0.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "talksad",0,6.0);
			break;
			case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "tired",0,6.0);
			break;
			}
		}
}					

//standard cook behavior
void NpcCook (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemRight(oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 1.0))
		{switch (iRand)
			{
			case 0:	
            NpcSpeak (oNpc, nSpeak);		
			PlayAnimation (35, 1.0, 0.0);
			break;
			case 1:
            NpcSpeak (oNpc, nSpeak);			
			PlayAnimation (36, 1.0, 0.0);
			break;
			case 2:
            NpcSpeak (oNpc, nSpeak);		
			ActionPlayCustomAnimation (oNpc, "cooking02",0,4.0);
			DelayCommand (4.1,ActionPlayCustomAnimation (oNpc, "disablefront",0,1.8));
			break;
			}
		}
}

//Standard Dancing Female Behavior
void NpcDanceFemale (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayAnimation (27, 1.5, 6.0);
			break;
			case 2:
            NpcSpeak (oNpc, nSpeak);			
			ActionPlayCustomAnimation (oNpc, "dance01",0,4.4);
			DelayCommand (4.5,ActionPlayCustomAnimation (oNpc, "curtsey",0,1.4));
			break;
			}
		}		
}		

//Standard Dancing Male Behavior
void NpcDanceMale (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (oNpc, "dance01",0,4.0);
			DelayCommand (4.1,ActionPlayCustomAnimation (oNpc, "bow",0,1.8));
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (oNpc, "dance02",1,5.0);;
			break;
			case 2:
            NpcSpeak (oNpc, nSpeak);			
			PlayCustomAnimation (oNpc, "dance02",1,5.0);
			break;
			}
		}
}		

//Standard drumming behavior for NPC
void NpcDrum (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemLeft(oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (oNpc, "playdrum",0,3.8);
			DelayCommand (3.8,ActionPlayCustomAnimation (oNpc, "bow",0,2.2));
			break;
			case 1:
			case 2:
			case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "playdrum",1,1.0);
			break;
			}
		}
}			

//Standard flute behavior for NPC
void NpcFlute (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemLeft(oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
            NpcSpeak (oNpc, nSpeak);			
			ActionPlayCustomAnimation (oNpc, "playflute",0,2.0);
			DelayCommand (2.1,ActionPlayCustomAnimation (oNpc, "playflute",0,2.0));
			DelayCommand (4.2,ActionPlayCustomAnimation (oNpc, "curtsey",0,1.4));
			break;
			case 1: case 2:	case 3:	
            NpcSpeak (oNpc, nSpeak);				
			PlayCustomAnimation (OBJECT_SELF, "playflute",1,1.0);
			break;
			}
		}	
}		

//Standard forge behavior for NPC
void NpcForge (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemRight(oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "forge01",1,1.0);
			break;
			case 1: case 2:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "craft01",0,5.0);
			break;
			case 3:			
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "dustoff",0,6.0);
			break;
			}
		}		
}		

//Standard guitar behavior for NPC
void NpcGuitar (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemLeft(oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "playguitar",0,1.9);
			DelayCommand (2.0,ActionPlayCustomAnimation (oNpc, "bow",0,4.0));
			break;	
			case 1: case 2:	case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "playguitar",1,1.0);
			break;
			}
		}

}		

//Standard woodsman behavior for NPC
void NpcWoodsman (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemRight (oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (7);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0: case 1: case 2: case 3: case 4:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "*1attack01",1,2.0);
			break;
			case 5: case 6:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "kneelidle",1,2.0);			
			break;			
			}
		}	
}

//Standard meditate behavior for NPC
void NpcMeditate (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1);  return;}
if ((nUd2 == 1) && (fDwp1 <= 0.5))
{PlayCustomAnimation (OBJECT_SELF, "meditate",1,1.0);}
}

//Standard stand post behavior for NPC
void NpcPost (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcArm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookleft",0,2.0);
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookright",0,2.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			break;
			}
		}		
}		

//Standard reading (sitting) behavior for NPC
void NpcRead (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
	{PlayCustomAnimation(OBJECT_SELF, "sitidle", 1, 1.0);
	SetOrientOnDialog(oNpc, FALSE);	
		switch (iRand)
				{
				case 0: case 1: case 2:
				NpcSpeak (oNpc, nSpeak);
				PlayCustomAnimation(OBJECT_SELF, "sitread", 1, 3.0);
				break;
				case 3:
				NpcSpeak (oNpc, nSpeak);
				PlayCustomAnimation(OBJECT_SELF, "sitteat", 0, 1.0);
				break;
				}
	
			}
}		

//standard sitting behavior (no eating)		
void NpcSit (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (12);
	if ((nUd2 == 1) && (fDwp1 <= 0.2))
		{PlayCustomAnimation(oNpc, "sitidle", 1, 1.0);
		SetOrientOnDialog(oNpc, FALSE);			
		switch(iRand) 
			{
			case 0: case 1: case 2: case 3: case 4:
            NpcSpeak (oNpc, nSpeak); 			
			PlayCustomAnimation(OBJECT_SELF, "sittalk01", 0, 6.0);
			break;
			case 5: case 6: case 7:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "sitfidget", 0, 6.0);
			break;
			case 8: case 9:			
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "sittalk", 0, 6.0);
			break;
			case 10: case 11:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "sittalk02", 0, 6.0);
			break;
			}
		}	
}		

//standard dinner behavior (sitting)		
void NpcSitDinner (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc); 
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise(oNpc,oWp1); return;}
int iRand = Random (12);
	if ((nUd2 == 1) && (fDwp1 <= 0.2))
		{PlayCustomAnimation(oNpc, "sitidle", 1, 1.0);
		SetOrientOnDialog(oNpc, FALSE);			
		switch(iRand) 
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk", 0, 1.0);
			break;			
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk", 0, 1.0);
			break;			
			case 2:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk", 0, 1.0);
			break;			
			case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk", 0, 1.0);
			break;
			case 4: 	
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation(oNpc, "sitdrink", 0, 2.0);
			break;			
			case 5:		
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation(oNpc, "sitdrink", 0, 2.0);
			break;
			case 6:				
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "siteat", 0, 1.0);
			break;			
			case 7:				
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "siteat", 0, 1.0);
			break;			
			case 8:					
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "siteat", 0, 1.0);
			break;
			case 9:	
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk01", 0, 1.0);
			break;				
			case 10:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk01", 0, 1.0);
			break;
			case 11:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(oNpc, "sittalk02", 0, 1.0);
			break;
			}
		}
}

//Standing behavior (chat, laugh, etc...)
void NpcStandChat (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc); 
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (9);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))		
		{switch(iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "talklaugh", 0, 1.0);
			break;		
			case 1:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "chuckle",0,2.0));
			DelayCommand (3.7,ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5));
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "chuckle",0,2.0));
			DelayCommand (3.7,ActionPlayCustomAnimation (OBJECT_SELF, "nodyes",0,1.5));
			break;
			case 3:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "lookleft", 0, 1.0);
			break;
			case 4:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "nodno", 0, 5.0);
			break;
			case 5:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (OBJECT_SELF, "shrug",0,1.5);
			DelayCommand (1.6,ActionPlayCustomAnimation (OBJECT_SELF, "chuckle",0,2.0));
			DelayCommand (3.7,ActionPlayCustomAnimation (OBJECT_SELF, "shrug",0,1.5));
			break;
			case 6:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "lookright", 0, 1.0);
			break;
			case 7:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "talk01", 0, 1.0);
			break;
			case 8:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "talk02", 0, 1.0);
			break;	
			}
		SetOrientOnDialog(oNpc, FALSE);
		}
}	

//Training routine for armed combatants
//REQUIRES: faction control NPC1
void NpcTrainingOne (object oNpc, object oWp1, int nSpeak)
{
SetPlotFlag(oNpc,1);
NpcArm (oNpc); 
object oFactioncontrol = GetObjectByTag ("FACTION_NPC1");
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.6) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
	{NpcSpeak (oNpc, nSpeak);
	NpcAggroTraining (oNpc, oFactioncontrol);}
}		 

//Training routine for armed combatants
//REQUIRES: faction control NPC2
void NpcTrainingTwo (object oNpc, object oWp1, int nSpeak)
{
SetPlotFlag(oNpc,1);
NpcArm (oNpc); 
object oFactioncontrol = GetObjectByTag ("FACTION_NPC2");
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.6) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
	{NpcSpeak (oNpc, nSpeak);
	NpcAggroTraining (oNpc, oFactioncontrol);}
}		 
		
//cheering and clapping behavior
void NpcCheer (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fNpc = GetFacing (oNpc);
float fDwp2 = GetFacing (oWp1);
if (fNpc != fDwp2){SetFacing(fDwp2);}
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
int iRand = Random (7);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))		
		{switch (iRand)
			{
			case 0:
            NpcSpeak (oNpc, nSpeak);			
			ActionPlayCustomAnimation (OBJECT_SELF, "victory",0,5.0);
			break;			
			case 1: case 2: case 3:
            NpcSpeak (oNpc, nSpeak);			
			ActionPlayCustomAnimation (OBJECT_SELF, "clapping",0,3.4);
			DelayCommand (3.5,ActionPlayCustomAnimation (oNpc, "chuckle",0,2.0));
			break;
			case 4: case 5: case 6:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "talklaugh", 0, 1.0);			
			break;			
			}
		}	
}			

//Trainer Pacing behavior
void NpcTrainerPace (object oNpc, int nSpeak)
{
ClearFlags (oNpc);
NpcArm (oNpc); 
SetLocalInt (oNpc,"wpcontrol", 1);
object oWp1 = GetCurrentWwp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
NpcSpeak (oNpc, nSpeak);		 
	if (fDwp1 >= 1.0) {SetLocalInt (oNpc, "atloc", 0); DelayJump(oNpc, oWp1);}
		int iRand = Random(3);		
		if (fDwp1 <= 1.0 ) 
		IncrementWwp(oNpc);		
}

//Standard WWP behavior
void NpcWwp (object oNpc, int nSpeak)
{
ClearFlags (oNpc);
NpcArm (oNpc); 
SetLocalInt (oNpc,"wpcontrol", 1);
object oWp1 = GetCurrentWwp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);		 
	if (fDwp1 >= 2.0) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc, oWp1);}
	if (GetArea (oWp1) == GetArea (oNpc)){SetLocalInt (oNpc, "transactive", 0);}
	int nTransition = GetLocalInt (oNpc, "transactive");
	if (nTransition == 1){return;}
		int iRand = Random(3);
		if (fDwp1 <= 2.0 ) 
		{switch(iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation(OBJECT_SELF, "lookleft", 0, 1.0);	
			break;		
			case 1:
			NpcSpeak (oNpc, nSpeak);
		 	PlayCustomAnimation(OBJECT_SELF, "lookright", 0, 1.0);
			break;
			case 2:
			NpcSpeak (oNpc, nSpeak);
			ActionPlayCustomAnimation (oNpc, "kneelidle",1,1.0);			
			break;
			}
		IncrementWwp(oNpc);	
		}	
}

//Multiple location cooking behavior
void NpcCookMulti (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemRight (oNpc); 
if (oWp1 == OBJECT_INVALID) SetLocalInt (oNpc, "wptag", 1);
int nWptag = GetLocalInt (oNpc,"wptag");
int nUd2 = GetLocalInt (oNpc ,"ud2");
int nRand = Random (3)+1;
float fDwp1 = GetDistanceToObject (oWp1);
int nAction = GetLocalInt (oNpc, "actioncounter");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))			
		{switch (nWptag)
			{
			case 1:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "cooking01",0,5.9);	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "cooking02",0,4.0);
					DelayCommand (4.1,ActionPlayCustomAnimation (oNpc, "disablefront",0,1.8));
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "cooking01",0,5.9);                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }
			break;
			case 2:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneelidle",1,3.0);
					DelayCommand (3.0,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));
					DelayCommand (4.5,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);	
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "dustoff",0,5.9);	                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			case 3:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "forge01",0,3.4);   
					DelayCommand (3.5, ActionPlayCustomAnimation (oNpc, "scratchhead",0,1.7));	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "craft01",1,5.8);
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "forge01",0,3.4);   
					DelayCommand (3.5, ActionPlayCustomAnimation (oNpc, "scratchhead",0,1.7));                 
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			}			
		}				
}

//Multiple location forge behavior
void NpcForgeMulti (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcEquipItemRight (oNpc); 
if (oWp1 == OBJECT_INVALID) SetLocalInt (oNpc, "wptag", 1);
int nWptag = GetLocalInt (oNpc,"wptag");
int nUd2 = GetLocalInt (oNpc ,"ud2");
int nRand = Random (3)+1;
float fDwp1 = GetDistanceToObject (oWp1);
int nAction = GetLocalInt (oNpc, "actioncounter");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))			
		{switch (nWptag)
			{
			case 1:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "forge02",1,1.0);	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "forge01",1,1.0);
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "craft01",1,5.9);                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }
			break;
			case 2:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneelidle",1,3.0);
					DelayCommand (3.0,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));
					DelayCommand (4.5,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);	
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "dustoff",0,5.9);	                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			case 3:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneeldown",0,1.4);
					DelayCommand (1.5,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));
					DelayCommand (3.2,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneeldown",0,1.4);
					DelayCommand (1.5,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));
					DelayCommand (3.2,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));                    
					SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			}			
		}				
}

// standard theif behavior
// should be called through a locate wrapper unless you
// want the theif to rob the exact same place for the entire activity cycle
void NpcThief (object oNpc, object oWp1, int nSpeak)
{
NpcArm (oNpc); 
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
int nVisible = GetLocalInt (oNpc, "invisible");
object oSeek = GetNearestObject (OBJECT_TYPE_CREATURE, oNpc);
float fSeek = GetDistanceToObject (oSeek);
int nAction = GetLocalInt (oNpc, "actioncounter");
	if (nVisible != 1) 
		{
		SetActionMode(oNpc, ACTION_MODE_STEALTH, TRUE);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNWN2SpecialEffectFile("fx_invisibility"), oNpc);
		SetLocalInt (oNpc, "invisible", 1);
		}
    if (fSeek <= 5.0) {ActionMoveAwayFromObject (oSeek, 0, 10.0);}
   		else
        if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5) && (fSeek >=5.1))       	
        	   {switch (nAction)
        	       {
                    default:
					ActionPlayCustomAnimation (oNpc, "openlock", 0,2.4);
					DelayCommand (2.5, ActionPlayCustomAnimation (oNpc, "gettable", 0,2.0));
                    DelayCommand (4.6, ActionPlayCustomAnimation (oNpc, "chuckle", 0,1.4)); 
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
					ActionPlayCustomAnimation (oNpc, "openlock", 0,2.4);
					DelayCommand (2.5, ActionPlayCustomAnimation (oNpc, "getground", 0,2.0));
                    DelayCommand (4.6, ActionPlayCustomAnimation (oNpc, "chuckle", 0,1.4)); 
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
					ActionPlayCustomAnimation (oNpc, "openlock", 0,2.4);
					DelayCommand (2.5, ActionPlayCustomAnimation (oNpc, "gettable", 0,2.0));
                    DelayCommand (4.6, ActionPlayCustomAnimation (oNpc, "chuckle", 0,1.4));                     
                    SetLocalInt (oNpc, "actioncounter",0);                  
                    break;
                    }	
                }
}  


//Thief behavior where the thief actually steals
//requires variable mark filled out with tags for victims
void NpcThief2 (object oNpc)
{
ClearAllActions();
ClearFlags(oNpc);
object oWp1 = GetCurrentWp (oNpc);
if (GetArea (oWp1) != GetArea (oNpc)){return;}
NpcArm (oNpc); 
object oNpc = OBJECT_SELF;
object oTarget = AcquireTarget(oNpc);
int nType = GetObjectType (oTarget);//OBJECT_TYPE_CREATURE  OBJECT_TYPE_PLACEABLE
float fWitnessRange = GetLocalFloat (oNpc, "witness");
int nWitnesscheck = CheckForWitnesses (oNpc, oTarget, fWitnessRange);
object oFaction1 = GetObjectByTag ("FACTION_NPC1");
object oFaction2 = GetObjectByTag ("FACTION_NPC2");
float fTarget = GetDistanceToObject (oTarget);
string sTarget = GetTag (oTarget);
//SendMessageToPC (GetFirstPC(), "target = "+(sTarget));
int nCanSee = GetObjectSeen (oNpc, oTarget);
int nFacing = IsFacingMe (75.0, oTarget);
int nSleeping = GetTimeActivity (oTarget);
int nVisible = GetLocalInt (oNpc, "invisible");
int nHidden = GetScriptHidden (oNpc);
location lFollow;
float fDelay;
	if ((nHidden == TRUE) && (oTarget != OBJECT_INVALID))
		{SetScriptHidden (oNpc, 0, 0);}
	if (nVisible != 1) 
		{
		SetActionMode(oNpc, ACTION_MODE_STEALTH, TRUE);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNWN2SpecialEffectFile("fx_invisibility"), oNpc);
		SetLocalInt (oNpc, "invisible", 1);
		ActionUseSkill (SKILL_MOVE_SILENTLY,oNpc,0);
		}
	    if (nWitnesscheck == TRUE)
        {
        ActionUseSkill (SKILL_MOVE_SILENTLY,oNpc,0,OBJECT_INVALID);
		fDelay = GetDelay (oNpc, oTarget);	
			if (fDelay >= 6.0)
				{
				ActionMoveToObject (oTarget,0,1.0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",1,1.0));
				}
			if ((fTarget >= 1.6) && (fDelay <= 5.9))
				{	
				ActionMoveToObject (oTarget,0,1.0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",0,6.0));
				}
		}
		else
		{ 
		//DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",1,1.0));
		ActionMoveAwayFromObject (oTarget, 0, 5.0);
		//ActionRandomWalk ();
		}
        if ((nWitnesscheck == TRUE) && (fTarget <= 1.5))
        {
			{switch (nType)
				{
				case OBJECT_TYPE_PLACEABLE:
				ClearAllActions();
				ActionInteractObject (oTarget);
				ActionPlayCustomAnimation (oNpc, "disableground" , 1, 1.0);
				GiveAllInventory (oTarget, oNpc);
				break;
				case OBJECT_TYPE_CREATURE:
				ClearAllActions();
				ActionPlayCustomAnimation (oNpc, "sleightofhand" , 1, 1.0);
				GiveAllInventory (oTarget, oNpc);
				break;
				}
			}					
        }
	object oContractComplete = GetFirstItemInInventory (oTarget);
	if (oContractComplete == OBJECT_INVALID)
	{
	SetLocalInt (oNpc, "targetacquired", 0);
	SetLocalInt (oNpc, "invisible", 0);
	}		
	if (oTarget == OBJECT_INVALID)
	{
	SetScriptHidden (oNpc, TRUE, FALSE);
	}	
		
}


void NpcAssassin (object oNpc)
{
ClearAllActions();
ClearFlags(oNpc);
object oWp1 = GetCurrentWp (oNpc);
if (GetArea (oWp1) != GetArea (oNpc)){return;}
NpcArm (oNpc); 
object oTarget = AcquireTarget(oNpc);
int nContractComplete = GetIsDead (oTarget);
if (nContractComplete == TRUE){SetLocalInt (oNpc, "targetacquired", 0);}
string sTarget = GetTag (oTarget);
float fWitnessRange = GetLocalFloat (oNpc, "witness");
float fTarget = GetDistanceToObject (oTarget);
float fDelay;
int nWitnesscheck = CheckForWitnesses (oNpc, oTarget, fWitnessRange);
object oFaction1 = GetObjectByTag ("FACTION_NPC1");
object oFaction2 = GetObjectByTag ("FACTION_NPC2");
location lFollow;
location lTarget = GetLocation (oTarget);
location lNpc = GetLocation (oNpc);

int nCanSee = GetObjectSeen (oNpc, oTarget);
int nFacing = IsFacingMe (75.0, oTarget);
int nSleeping = GetTimeActivity (oTarget);
int nVisible = GetLocalInt (oNpc, "invisible");
int nHidden = GetScriptHidden (oNpc);
int nCheck = GetLocalInt (oNpc, "actioncounter");	
	if ((nHidden == TRUE) && (oTarget != OBJECT_INVALID))
		{SetScriptHidden (oNpc, FALSE, FALSE);}
	if ((nHidden == FALSE) && (oTarget == OBJECT_INVALID))
		{SetScriptHidden (oNpc, TRUE, FALSE);}		
	if (nVisible != 1) 
		{
		SetActionMode(oNpc, ACTION_MODE_STEALTH, TRUE);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNWN2SpecialEffectFile("fx_invisibility"), oNpc);
		SetLocalInt (oNpc, "invisible", 1);
		}
	if ((nSleeping == 4) || (nSleeping == 5))
	{nCanSee = FALSE; nFacing =FALSE;}
    if ((nCanSee == TRUE) && (nFacing == TRUE))
    {
//    SendMessageToPC (GetFirstPC(), "target cannot see me");
	lFollow = CheckActivity (oTarget);
	fDelay = GetDelay (oNpc, oTarget);
			if (fDelay >= 6.0)
				{
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",1,1.0));
				}
			if ((fTarget >= 3.1) && (fDelay <= 5.9))
				{	
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",0,6.0));
				}
			}
	    else
//	    SendMessageToPC (GetFirstPC(), "target can see me");
		ActionUseSkill (SKILL_MOVE_SILENTLY,oNpc,0,OBJECT_INVALID);
		lFollow = CheckActivity (oTarget);
		fDelay = GetDelay (oNpc, oTarget);	
			if (fDelay >= 6.0)
				{
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",1,1.0));
				}
			if ((fTarget >= 3.1) && (fDelay <= 5.9))
				{	
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",0,6.0));
				}
	    if (nWitnesscheck == TRUE)
        {
//        SendMessageToPC (GetFirstPC(), "no witnesses");
        ActionUseSkill (SKILL_MOVE_SILENTLY,oNpc,0,OBJECT_INVALID);
		lFollow = CheckActivity (oTarget);
		fDelay = GetDelay (oNpc, oTarget);	
			if (fDelay >= 6.0)
				{
//				SendMessageToPC (GetFirstPC(), "trying to move to "+LocationToString (lFollow));
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",1,1.0));
				}
			if ((fTarget >= 3.1) && (fDelay <= 5.9))
				{	
				ActionMoveToLocation (lFollow, 0);
				DelayCommand (0.2, ActionPlayCustomAnimation (oNpc, "sneak",0,6.0));
				}
		}
           if ((fTarget <= 3.0) && (nWitnesscheck == TRUE))
            {
//            SendMessageToPC (GetFirstPC(), "in range");
            ChangeFaction (oNpc, oFaction1);
            ChangeFaction (oTarget, oFaction2);
            ActionAttack (oTarget);			
            }
if (oTarget == OBJECT_INVALID){SetScriptHidden (oNpc,TRUE,FALSE);}	
}


//Npc hiding behavior (from Seeker only)
void NpcHide (object oNpc)
{
ClearAllActions ();
object oWp1 = GetCurrentWp (oNpc);
if ((GetArea (oWp1) != GetArea (oNpc))){return;}
string sTarget = GetLocalString (oNpc, "target");
object oSeek = GetObjectByTag (sTarget);
float fRange = GetLocalFloat (oNpc, "search");
int nCheck = IsCreatureInViewInRange (oSeek, fRange);
int nAction = GetLocalInt (oSeek, "actioncounter");
int nAction2 = GetLocalInt (oNpc, "actioncounter");
int nHider = GetLocalInt (oNpc, "hiderseeker");
int nHider2 = GetLocalInt (oSeek, "hiderseeker");
	if (nHider2 == 1){SetLocalInt (oNpc, "hiderseeker", 1);}
    {switch (nHider)
        {
        default: //hiding
            {switch (nAction)
                {
                default:
                if (nCheck == TRUE)
                {
                ActionMoveAwayFromObject (oSeek, 1,((fRange)*1.3));
                }
                else
                ActionRandomWalk();
                break;
                case 3:
                DelayCommand (10.0, SetLocalInt (oNpc, "hiderseeker", 1));
                break;
                }
            }
        break;
        case 1: //seeking
            {switch (nAction2)
                {
                default:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 1);
	            ActionMoveToObject(oSeek, 1 ,((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;
                case 1:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 2);
	            ActionMoveToObject(oSeek, 1 , ((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;
                case 2:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 3);
	            ActionMoveToObject(oSeek, 1 ,((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;   
                case 3:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "You're It");
	            SetLocalInt (oNpc, "actioncounter", 0);
	            DelayCommand (6.0, SetLocalInt (oNpc, "hiderseeker", 0));
	            ActionMoveToObject(oSeek, 1 , 0.0);
	            }
	            else
	            ActionRandomWalk();
	            break; 
                }
            }
        break;
        }
    }                            	                           
} 

//Npc seeking behavior (not seeking very hard I know)
void NpcSeek (object oNpc)
{
ClearAllActions ();
object oWp1 = GetCurrentWp (oNpc);
if ((GetArea (oWp1) != GetArea (oNpc))){return;}
string sTarget = GetLocalString (oNpc, "target");
object oHide = GetObjectByTag (sTarget);
float fRange = GetLocalFloat (oNpc, "search");
int nCheck = IsCreatureInViewInRange (oHide, fRange);
int nAction = GetLocalInt (oHide, "actioncounter");
int nAction2 = GetLocalInt (oNpc, "actioncounter");
int nHider = GetLocalInt (oNpc, "hiderseeker");

    {switch (nHider)
        {
        case 1: //hiding
            {switch (nAction)
                {
                default:
                if (nCheck == TRUE)
                {
                ActionMoveAwayFromObject (oHide, 1,((fRange)*1.3));
                }
                else
                ActionRandomWalk();
                break;
                case 3:
                DelayCommand (10.0, SetLocalInt (oNpc, "hiderseeker", 0));
                break;
                }
            }
        break;
        default: //seeking
            {switch (nAction2)
                {
                default:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 1);
	            ActionMoveToObject(oHide, 1 , ((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;
                case 1:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 2);
	            ActionMoveToObject(oHide, 1 , ((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;
                case 2:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "I see you");
	            SetLocalInt (oNpc, "actioncounter", 3);
	            ActionMoveToObject(oHide, 1 , ((fRange)*0.6));
	            }
	            else
	            ActionRandomWalk();
	            break;   
                case 3:
                if (nCheck == TRUE)
	            {
	            SpeakString ( "You're It");
	            SetLocalInt (oNpc, "actioncounter", 0);
	            DelayCommand (6.0,SetLocalInt (oNpc, "hiderseeker", 1));
	            ActionMoveToObject(oHide, 1 , 0.0);
	            }
	            else
	            ActionRandomWalk();
	            break; 
                }
            }
        break;
        }
    }                            	                           
} 
 
//multi location merchant behavior
void NpcMerchantMulti (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
if (oWp1 == OBJECT_INVALID) SetLocalInt (oNpc, "wptag", 1);
int nWptag = GetLocalInt (oNpc,"wptag");
int nUd2 = GetLocalInt (oNpc ,"ud2");
int nRand = Random (3)+1;
float fDwp1 = GetDistanceToObject (oWp1);
int nAction = GetLocalInt (oNpc, "actioncounter");
object oTarget = GetNearestObject (OBJECT_TYPE_CREATURE, oNpc);
float fTarget = GetDistanceToObject (oTarget);
if (fDwp1 >= 0.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
if (fTarget >= 5.0)
	{
	if ((nUd2 == 1) && (fDwp1 <= 0.5))			
		{switch (nWptag)
			{
			case 1:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "yawn", 0, 3.0));
                    SetLocalInt (oNpc, "actioncounter",1);				
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "sleightofhand", 0, 1.8));
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "yawn", 0, 3.0));              
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }
			break;
			case 2:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "bored",1,1.0);						
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);			
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "gettable",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "sleightofhand", 0, 1.8));
					DelayCommand (3.5, ActionPlayCustomAnimation (oNpc, "gettable", 0, 1.7));			                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			case 3:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "yawn", 0, 3.0));
                    SetLocalInt (oNpc, "actioncounter",1);				
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "sleightofhand", 0, 1.8));
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "getground",0,1.7); 
					DelayCommand (1.8, ActionPlayCustomAnimation (oNpc, "yawn", 0, 3.0));              
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }
			break;
			}			
		}
	}
	int nCustomer = IsFacingMe (45.0, oTarget);
	int nGender = GetGender (oTarget);
	if ((fTarget <= 3.0) && (nCustomer == TRUE))
	{
	ActionMoveToObject (oTarget);
		{switch (nGender)
			{
			case 1:
			SpeakString ("Would you like to take a look around miss?");	
			break;
			case 0:
			SpeakString ("Can I help you Sir?");
			break;
			}
		}					
	}
}

//Multiple location work behavior (moving bottles)
void NpcWorker1 (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
if (oWp1 == OBJECT_INVALID) SetLocalInt (oNpc, "wptag", 1);
int nWptag = GetLocalInt (oNpc,"wptag");
int nUd2 = GetLocalInt (oNpc ,"ud2");
int nRand = Random (3)+1;
float fDwp1 = GetDistanceToObject (oWp1);
int nAction = GetLocalInt (oNpc, "actioncounter");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))			
		{switch (nWptag)
			{
			case 1:
                {switch (nAction)
        	        {
                    default:
                    /*DelayCommand (0.9,*/ EquipNewItem(oNpc, "npc_longsword" , 4);
                    ActionPlayCustomAnimation (oNpc, "getground" ,0 ,2.0);
                    SetLocalInt (oNpc, "actioncounter" ,1);
                    SetLocalInt (oNpc, "wptag" ,2);
                    SpawnDestroyCreate (oNpc, oWp1, fDwp1);
                    break;
                    case 1:
                    break;
                    }
                }
			break;
			case 2:
                {switch (nAction)
        	        {
                    default:
                    break;
                    case 1:
                    DelayCommand (0.9,DestroyItemInSlot(oNpc, 4));
                    ActionPlayCustomAnimation (oNpc, "getground", 0, 2.0);
                    SetLocalInt (oNpc, "actioncounter" ,0);
                    SetLocalInt (oNpc, "wptag" ,1);
                    SpawnDestroyCreate (oNpc, oWp1, fDwp1);                    
                    break;
                    }
                }			
			break;
			}			
		}				
}

//Kneel and talk animation
void NpcKneelTalk (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
NpcDisarm (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJumpPrecise (oNpc,oWp1);return;}

int iRand = Random (3);
	if ((nUd2 == 1) && (fDwp1 <= 0.5))
		{switch (iRand)
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "kneelidle",1,1.0);
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "kneeltalk",1,5.0);
			DelayCommand (5.0, ActionPlayCustomAnimation (oNpc, "kneelidle", 1,1.0));
			break;
			case 2:
			break;
			}
		}		
}


void NpcLightKeeper (object oNpc, object oWp1, int nSpeak)
{
if (GetArea (oWp1) != GetArea (OBJECT_SELF)){return;}
NpcEquipItemLeft (oNpc);
int nHour = GetTimeHour();
int nDefault = GetLocalInt (oNpc, "default");
string sTag = GetLocalString (oNpc, "sTag");
object oInteract;
	if ((nHour >= 7) && (nHour <= 18))
		{oInteract = GetInteractiveDay (oNpc, sTag);}
	else
		{oInteract = GetInteractiveNight (oNpc, sTag);}	
float fDoi = GetDistanceToObject (oInteract);
string sNewact = GetTimeString (oNpc);
	if (fDoi >= 3.1)
		{ActionMoveToObject (oInteract,0,2.9);return;}
	if (fDoi <= 3.0)
		{//ActionInteractObject (oInteract);}	
		ExecuteScript ("bb_onused", oInteract);}
	if (oInteract == OBJECT_INVALID)
		{
		StoreOriginalWp (oNpc);
		NpcDisarm (oNpc);
		SetLocalInt (oNpc, sNewact, nDefault);
		}		
}


//This function requires a NPC running the bartender activity at the same time as the barmaid 
//1 barmaid npc with the "npc_barmaid" script on the "on heartbeat" slot
//1 bartender with the "npc_bartender" script in the "on heartbeat" slot
//the bartender tag should be filled out at the beginning of the "npc_barmaid" script SEE NOTES in npc_barmaid
//the bar maid will refer to the bartender by name (listed in properties of bartender in toolset)
//1 generic waypoint with the tag "WP_BAR" for the bar maid to order from and rest at
//the bar maid will randomly choose a customer and take an order
//the drink list can be customized and will be used throughout the bar maid conversation (see npc_include)
//you can set up to 10 exclusions (other NPCs that the bar maid will not serve)
//among the exclusions should be the bar maid, and the bartender (maybe the innkeeper and/or musicians)
//exclusions should be filled out at on the variable list of the bar maid
void NpcBarmaid (object oNpc, object oWp1)
{
int nPatrons = GetCreatureCount (oNpc);
int nRandom = Random(nPatrons);
int nMaidState = GetLocalInt (oNpc, "barmaid");
object oCustomer = GetLocalObject (oNpc, "customer");
float fCustomer = GetDistanceToObject (oCustomer);
string sQuery;	string sResponse1;	string sResponse2;	string sResponse3; string sResponse4;
string sResponse5;	string sResponse6;	string sResponse7; string sResponse8; string sResponse9;
string scust;
object oBar = GetWaypointByTag("WP_BAR");
float fBar = GetDistanceToObject (oBar);
object oRest = GetWaypointByTag("WP_REST");
object oBartender = GetObjectByTag (GetLocalString (oNpc, "bartender"));
int nBusy = GetLocalInt (oBartender, "busy");
	{switch (nMaidState)
		{
//default = bar maid has no target and is searching for new target to serve
//once target acquired move to within 2.1 of taget before proceeding		  
		default:		
		if (oCustomer == OBJECT_INVALID)
		oCustomer = GetCustomer (oNpc,nPatrons);
        SetLocalInt (oNpc, "barmaid", 1);
        SetLocalObject (oNpc, "customer", oCustomer);	
		ActionMoveToObject(oCustomer);
		if	(fCustomer >= 1.1){ActionMoveToObject (oCustomer,0,1.0);return;}
			else
			{SetLocalInt (oNpc, "barmaid",1);}
		break;
//1. check distance to customer and make sure is less then 1.1 proceed		
		case 1:
		AreaCheck (oCustomer, oNpc);
		if (fCustomer >= 1.1) {ActionMoveToObject (oCustomer,0,1.0); return;}
			else
			TakeOrder(oNpc);
			sQuery = GetLocalString (oNpc, "query");
			ActionSpeakString (sQuery);
			SetLocalInt (oNpc, "barmaid", 2);
		break;		
//2. take order = set random strings on barmaid for future conversation
//take order from npc and have short conversation and then move towards wp marked WP_BAR	
		case 2:	
			AreaCheck (oCustomer, oNpc);
			sResponse1 = GetLocalString (oNpc, "response1");
			sResponse2 = GetLocalString (oNpc, "response2");
			ClearAllActions();
			AssignCommand (oCustomer, ClearAllActions());
			ActionDoCommand (DelayCommand(0.5, AssignCommand (oCustomer, SpeakString (sResponse1))));
			DelayCommand (4.0, ActionSpeakString (sResponse2));
			DelayCommand (5.0, ActionMoveToObject (oBar));
			SetLocalInt (oNpc, "barmaid", 3);		
		break;
//3. check distance to wp marked WP_BAR if not within 1.0 keep moving to bar and return
//if within 1.0 of bar converse with bartender to order drinks and them proceed		
		case 3:
		AreaCheck (oCustomer, oNpc);
		if (fBar >= 1.0) {ActionMoveToObject (oBar,0,0.0); return;}
			else
			{
			sResponse3 = GetLocalString (oNpc, "response3");
			sResponse4 = GetLocalString (oNpc, "response4");
			ActionSpeakString (sResponse3);
			AssignCommand (oBartender, ClearAllActions());
			DelayCommand (1.5, AssignCommand (oBartender, ActionSpeakString (sResponse4)));
			SetLocalInt (oBartender, "busy", 1);
			SetLocalInt (oNpc, "barmaid", 4);
			}
		break;
//4. wait for bartender to get drinks and check the bartender status
//once the bartender is done getting the drinks proceed		
		case 4:	
		AreaCheck (oCustomer, oNpc);
		if (nBusy != 0){return;}
			else
			{
			sResponse7 = GetLocalString (oNpc, "response7");
			AssignCommand (oBartender, ClearAllActions());
			AssignCommand (oBartender, ActionSpeakString (sResponse7));
			SetLocalInt (oNpc, "barmaid", 5);
			}
		break;
//5. move to customer, check distance if less then or equal to 2.0 proceed		
		case 5:
		AreaCheck (oCustomer, oNpc);
		ActionMoveToObject (oCustomer);
		if (fCustomer <=2.0) 
			{
			sResponse5 = GetLocalString (oNpc, "response5");
			ActionSpeakString (sResponse5);
			SetLocalInt (oNpc, "barmaid", 6);}
		break;
//6. deliver drinks to customer and converse, wait, then proceed		
		case 6:
		AreaCheck (oCustomer, oNpc);
			sResponse6 = GetLocalString (oNpc, "response6");

			DelayCommand (1.5,AssignCommand (oCustomer, ActionSpeakString (sResponse6)));
			ActionWait (3.0);
			SetLocalInt (oNpc, "barmaid", 7);
		break;
//7. move back to wp tagged WP_BAR
//once within 1.0 of bar converse with bartender
//delete local object customer and local integer barmaid (start over)		
		case 7:
		ActionMoveToObject (oBar,0,0.0);
		if (fBar <= 1.0) 
			{
			sResponse8 = GetLocalString (oNpc, "response8");
			sResponse9 = GetLocalString (oNpc, "response9");	
			ActionSpeakString (sResponse8);
			DelayCommand (1.5,AssignCommand (oBartender, ActionSpeakString (sResponse9)));		
			DeleteLocalInt (oNpc, "barmaid");
			DeleteLocalObject (oNpc, "customer");
			SetLocalInt (oNpc,"patrons", 0);}
		break;			
		}
	}		
}

//This activity requires another NPC running the NpcBarmaid activity at the same time
//1 generic waypoint with the tag "WP_BARTENDER" for the bartender to stand at
//1 generic waypoint with the tag "WP_KEG" for the bartender to go to and fill drink orders
void NpcBartender (object oNpc, object oWp1)
{
object oBar = GetWaypointByTag ("WP_BARTENDER");
float fDirbar = GetFacing (oBar);
float fBar = GetDistanceToObject (oBar);
object oKeg = GetWaypointByTag ("WP_KEG");
float fKeg = GetDistanceToObject (oKeg);
int nRandom = Random(4);
int nBusy = GetLocalInt (oNpc, "busy");
	{switch (nBusy)
		{
//default =  stay near the wp labeled "WP_BARTENDER" and do random animations		  
		default:
		if (fBar >=0.5) {ActionMoveToObject (oBar, 0,0.4); return;}
		else
		{switch (nRandom)
			{
			case 1:
			PlayCustomAnimation (oNpc, "yawn", 0,5.0);
			break;
			case 2:
			PlayCustomAnimation (oNpc, "lookright", 0, 5.0);
			break;
			default:
			PlayCustomAnimation (oNpc, "gettable", 0, 3.5);
			break;
			}
		}
		break;
//1. move to the keg and fill the drink order		
		case 1:
		ActionMoveToObject (oKeg,0,0.0);
		if (fKeg <= 1.0)
			{switch (Random (2))
				{
				default:
				PlayCustomAnimation (oNpc, "gettable", 0, 2.1);
				SetLocalInt (oNpc, "busy", 2);
				break;
				case 1:
				PlayCustomAnimation (oNpc, "openlock", 0, 3.0);
				SetLocalInt (oNpc, "busy", 2);
				break;
				}
			}
		break;		
//2. after filling order move back to the bar and deliver		
		case 2:
		ActionMoveToObject (oBar,0,0.0);
		if (fBar <= 1.0)
			{
			SetFacing (fDirbar);
			PlayCustomAnimation (oNpc, "gettable", 0, 3.5);
			SetLocalInt (oNpc, "busy", 0);
			}			
		break;
		}
	}
}	

//This function is a wrapper for LocateActivity-n-
void LocateWrapper (object oNpc, object oWp1, int nOn1, int nActivity1, int nOn2, int nActivity2, int nOn3, int nActivity3,  int nDefault, int nResetspawn1, int nResetspawn2, int nSpeak,)
{
SetLocalInt (oNpc, "resetspawn1", nResetspawn1);
SetLocalInt (oNpc, "resetspawn2", nResetspawn2);
SetLocalInt (oNpc, "spawn", 1);
int nHour = GetTimeHour ();
    {switch (nHour)
        {
        case 0: case 4: case 8: case 12: case 16: case 20:
		LocateActivityOne (oNpc, oWp1, nOn1, nActivity1, nDefault, nSpeak);
        break; 
        case 1: case 5: case 9: case 13: case 17: case 21: 
 		LocateActivityTwo (oNpc, oWp1, nOn2, nActivity2, nDefault, nResetspawn1, nSpeak);
        break;  
        case 2: case 6: case 10: case 14: case 18: case 22: 
		LocateActivityThree (oNpc, oWp1, nOn3, nActivity3, nDefault,  nResetspawn2, nSpeak);
        break;
        default:
        ExecuteActivity (oNpc,oWp1,nSpeak, nDefault);
        break;                                  
        }
	}
}



//this function replaces the waypoint and activity at the first 
//hour past the normal change
//int nOn1 = toggle 1 for on 0 for off
//int nActivity1 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_NPCTAG_01"
void LocateActivityOne (object oNpc, object oWp1, int nOn1, int nActivity1, int nDefault, int nSpeak)
{
float fDwp1 = GetDistanceToObject (oWp1);
int nWriteprotect = GetLocalInt (oNpc, "writeprotect");
int nActivityone = GetLocalInt (oNpc, "updateactone");
string sNewact = GetTimeString (oNpc);
	{switch (nOn1)
		{
		default:
		ExecuteActivity (oNpc,oWp1,nSpeak,nDefault);
		break;
		case 1:
			{switch (nWriteprotect)
				{
				case 0:
				StoreOriginalWp (oNpc);
				break;
				default:
				break;
				}
			}
			{switch (nActivityone)
				{
				case 1:	
				break;
				default:
				SetLocalInt (oNpc, "wptag", 1);
				WrapperDestroyCreate (oNpc, oWp1);
				SetLocalInt (oNpc, sNewact, nActivity1);
				SetLocalInt (oNpc, "updateactone", 1);	
                SetLocalInt (oNpc, "spawnact1behavior", nActivity1);			
				break;
				}
			}
		}		
	}
}

//this function replaces the waypoint and activity at the second 
//hour past the normal change
//int nOn2 = toggle 1 for on 0 for off
//int nActivity2 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_NPCTAG_02"
void LocateActivityTwo (object oNpc, object oWp1, int nOn2, int nActivity2, int nDefault,int nResetspawn1, int nSpeak)
{
float fDwp1 = GetDistanceToObject (oWp1);
int nWriteprotect = GetLocalInt (oNpc, "writeprotect");
int nActivitytwo = GetLocalInt (oNpc, "updateacttwo");
int nActivity1 = GetLocalInt (oNpc, "spawnact1behavior");
string sNewact = GetTimeString (oNpc);
	{switch (nOn2)
		{
		default:
		ExecuteActivity (oNpc,oWp1,nSpeak,nDefault);
		break;
		case 1:
			{switch (nWriteprotect)
				{
				case 0:
				StoreOriginalWp (oNpc);
				break;
				default:
				break;
				}
			}
			{switch (nActivitytwo)
				{
				case 1:	
				break;
				default:
					{switch (nResetspawn1)
						{
						case 0:
						SetLocalInt (oNpc, sNewact, nActivity1);
						SetLocalInt (oNpc, "updateacttwo", 1);
						SetLocalInt (oNpc, "spawnact2behavior", nActivity1);
						break;
						case 1:
						SetLocalInt (oNpc, "wptag", 2);
						WrapperDestroyCreate (oNpc, oWp1);
						SetLocalInt (oNpc, sNewact, nActivity2);
						SetLocalInt (oNpc, "updateacttwo", 1);
						SetLocalInt (oNpc, "spawnact2behavior", nActivity2);
						break;
						}
					}	
				break;
				}
			}
		}		
	}
}

//this function replaces the waypoint and activity at the third 
//hour past the normal change
//int nOn3 = toggle 1 for on 0 for off
//int nActivity2 = set using locate wrapper replacement activity (see switch in heartbeat script)
//convention for spawn tag "SPAWN_NPCTAG_03"
void LocateActivityThree (object oNpc, object oWp1, int nOn3, int nActivity3, int nDefault, int nResetspawn2, int nSpeak)
{
float fDwp1 = GetDistanceToObject (oWp1);
int nWriteprotect = GetLocalInt (oNpc, "writeprotect");
int nActivitythree = GetLocalInt (oNpc, "updateactthree");
int nActivity2 = GetLocalInt (oNpc, "spawnact2behavior");
string sNewact = GetTimeString (oNpc);
	{switch (nOn3)
		{
		default:
		ExecuteActivity (oNpc,oWp1,nSpeak,nDefault);
		break;
		case 1:
			{switch (nWriteprotect)
				{
				case 0:
				StoreOriginalWp (oNpc);
				break;
				default:
				break;
				}
			}
			{switch (nActivitythree)
				{
				case 1:	
				break;
				default:
					{switch (nResetspawn2)
						{
						case 0:
						SetLocalInt (oNpc, sNewact, nActivity2);
						SetLocalInt (oNpc, "updateactthree", 1);
						break;
						case 1:				
						SetLocalInt (oNpc, "wptag", 3);
						WrapperDestroyCreate (oNpc, oWp1);
						SetLocalInt (oNpc, sNewact, nActivity3);
						SetLocalInt (oNpc, "updateactthree", 1);
						break;
						}
					}	
				break;
				}
			}
		}		
	}
}

//internal execute activity used with the Locate Wrapper to cover the default activity
void ExecuteActivity (object oNpc, object oWp1, int nSpeak, int nDefault)	
{
    {switch (nDefault)
            {
	case 0: NpcHidden (oNpc, oWp1, nSpeak); break;
	case 1: NpcActOne (oNpc, oWp1, nSpeak); break;
	case 2: NpcActTwo (oNpc, oWp1, nSpeak); break;
	case 3: NpcDinner (oNpc, oWp1, nSpeak); break;
	case 4: NpcMidnightBed (oNpc, oWp1, nSpeak); break;
	case 5: NpcSleepBed (oNpc, oWp1, nSpeak); break;
	case 6: NpcWake (oNpc, oWp1, nSpeak); break;
	case 7: NpcAgree (oNpc, oWp1, nSpeak); break;
	case 8: NpcAngry (oNpc, oWp1, nSpeak); break;
	case 9: NpcSad (oNpc, oWp1, nSpeak); break;
	case 10: NpcCook (oNpc, oWp1, nSpeak); break;
	case 11: NpcDanceFemale (oNpc, oWp1, nSpeak); break;
	case 12: NpcDanceMale (oNpc, oWp1, nSpeak); break;
	case 13: NpcDrum (oNpc, oWp1, nSpeak); break;
	case 14: NpcFlute (oNpc, oWp1, nSpeak); break;
	case 15: NpcForge (oNpc, oWp1, nSpeak); break;
	case 16: NpcGuitar (oNpc, oWp1, nSpeak); break;
	case 17: NpcWoodsman (oNpc, oWp1, nSpeak); break;
	case 18: NpcMeditate (oNpc, oWp1, nSpeak); break;
	case 19: NpcPost (oNpc, oWp1, nSpeak); break;	
	case 20: NpcRead (oNpc, oWp1, nSpeak); break;
	case 21: NpcSit (oNpc, oWp1, nSpeak); break;
	case 22: NpcSitDinner (oNpc, oWp1, nSpeak); break;
	case 23: NpcStandChat (oNpc, oWp1, nSpeak); break;
	case 24: NpcTrainingOne (oNpc, oWp1, nSpeak); break;
	case 25: NpcTrainingTwo (oNpc, oWp1, nSpeak); break;
	case 26: NpcTrainerPace (oNpc, nSpeak); break;
	case 27: NpcWwp (oNpc, nSpeak); break;
	case 28: NpcCheer (oNpc, oWp1, nSpeak); break;	
	case 29: NpcCookMulti (oNpc, oWp1, nSpeak); break;
	case 30: NpcForgeMulti (oNpc, oWp1, nSpeak);break;
	case 31: NpcMidnight90 (oNpc, oWp1, nSpeak); break;
	case 32: NpcSleep90 (oNpc, oWp1, nSpeak); break;	
	case 33: NpcThief (oNpc, oWp1, nSpeak); break; //use wrapper	
	case 34: NpcHide (oNpc); break;
	case 35: NpcSeek (oNpc); break;
	case 36: NpcThief2 (oNpc); break;
	case 37: NpcAssassin (oNpc); break;
	case 38: NpcMerchantMulti (oNpc, oWp1, nSpeak); break;
	case 39: NpcKneelTalk (oNpc, oWp1, nSpeak); break;
	default: NpcDisarm (oNpc); NpcMeditate (oNpc, oWp1, nSpeak); break;    	    }
        }
}

/*
void NpcTemplate (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
int nUd2 = GetLocalInt (oNpc,"ud2");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc, "atloc", 0);DelayJump(oNpc,oWp1); return;}/*DelayJumpPrecise (oNpc,oWp1);}*/

// change the number iRand number to the number of different animations you want
/*
int iRand = Random (4);
	if ((nUd2 == 1) && (fDwp1 <= 0.5)) //----set <= 0.2 for DelayJumpPrecise <=0.5 for DelayJump
		{switch (iRand)
		
		    //place animations here  1 in each case
		    
			{
			case 0:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookleft",0,1.0);<----Animation goes here
			break;
			case 1:
			NpcSpeak (oNpc, nSpeak);
			PlayCustomAnimation (OBJECT_SELF, "lookright",0,1.0);<----Animation goes here
			break;
			case 2:
			break;
			}
		}		
}*/

/*
void NpcMultiTemplate (object oNpc, object oWp1, int nSpeak)
{
ClearFlags (oNpc);
if (oWp1 == OBJECT_INVALID) SetLocalInt (oNpc, "wptag", 1);
int nWptag = GetLocalInt (oNpc,"wptag");
int nUd2 = GetLocalInt (oNpc ,"ud2");
int nRand = Random (3)+1;
float fDwp1 = GetDistanceToObject (oWp1);
int nAction = GetLocalInt (oNpc, "actioncounter");
if (fDwp1 >= 0.5) {SetLocalInt (oNpc,"atloc",0);DelayJump(oNpc,oWp1); return;}
	if ((nUd2 == 1) && (fDwp1 <= 0.5))			
		{switch (nWptag)
			{
			case 1:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation(oNpc, "forge02",1,1.0); 	<-------first action	
                    SetLocalInt (oNpc, "actioncounter",1);				
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "forge01",1,1.0);	<-------second action
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "craft01",1,5.9);	<-------third action                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }
			break;
			case 2:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneeldown",0,1.4);					<-------fourth action
					DelayCommand (1.5,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));	<-------fifth action
					DelayCommand (3.2,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));	<-------sixth action	
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);		<-------seventh action	
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "dustoff",0,5.9);		<-------eighth action	                   
                    SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			case 3:
			SetLocalInt (oNpc,"atloc",1);
			     {switch (nAction)
        	       {
                    default:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneeldown",0,1.4);					<-------ninth action
					DelayCommand (1.5,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));	<-------tenth action
					DelayCommand (3.2,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));	<-------eleventh action
                    SetLocalInt (oNpc, "actioncounter",1);
                    break;	   
                    case 1:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "openlock",1,1.0);		<-------twelth action
                    SetLocalInt (oNpc, "actioncounter",2);
                    break;	  
                    case 2:
			        NpcSpeak (oNpc, nSpeak);
			        ActionPlayCustomAnimation (oNpc, "kneeldown",0,1.4);					<-------thirteenth action					
					DelayCommand (1.5,ActionPlayCustomAnimation (oNpc, "kneelup",0,1.4));	<-------fourteenth action
					DelayCommand (3.2,ActionPlayCustomAnimation (oNpc, "gettable",0,1.4));  <-------fifteenth action      
					SetLocalInt (oNpc, "actioncounter",0); 
                    SetLocalInt (oNpc, "wptag" ,nRand);
			        SpawnDestroyCreate (oNpc, oWp1, fDwp1);                 
                    break;
                    }	
                }			
			break;
			}			
		}				
}
*/