///////////////////////////////////////////////
//			 NPC_INCLUDE	v1.42			 //
//		      Uncle FB 05/2009				 //
///////////////////////////////////////////////
#include "ginc_item"
#include "ginc_combat"
#include "ginc_actions"
#include "x0_i0_position"

//
///////////////////////////////////////////////
//object GetCurrentWp		       
//object GetCurrentWwp		       
//object GetCurrentSp		       
//void DelayJump 			       
//void DelayJumpPrecise             
//void SpawnDestroyCreate 	      
//void WrapperDestroyCreate 	   
//void VariableSwitcher 	       
//void GlobalSet 			      
//void NpcReset				      
//int GetTimeActivity 		      
//string GetTimeString 		       
//string GetItemString 		       
//string GetArmorString 	       
//void ClearFlags 			      
//void IncrementWwp			       
//void StoreOriginalWp 		       
//void NpcArm  				      
//void NpcDisarm			       
//void NpcEquipItemRight	      
//void NpcEquipItemLeft		      
//void NpcWakeUp 			       
//void NpcAggroTraining 	      
//void ActionPlayCustomAnimation  
//void ClearInventory             
//void KickStart                   
//int IsCreatureInViewInRange     
//object AcquireTarget            
//int IsFacingMe                   
//int CheckForWitnesses           
//object CheckHitList             
//float GetDelay                   
//float CheckActivity              
//void AreaTransition              
//void ActionSetLocalInt           
//void HeartbeatCheck             
//object GetLeader                
//int CheckWwpArea                 
//object GetInteractiveDay        
//object GetInteractiveNight      
//object GetCustomer
//void AreaCheck 
///////////////////////////////////////////////

///////////////////////////////////////////////
//FUNCTION PROTOTYPES                        //
///////////////////////////////////////////////

//This command uses the tag of the NPC and global
//info to generate the correct WP tag
object GetCurrentWp (object oNpc);

//This command uses the tag of the npc and naming convention
//info to generate the correct WWP
object GetCurrentWwp (object oNpc);

//This command uses the tag of the npc and naming convention
//info to generate the correct spawn point
//No longer used left in for possible future use//
object GetCurrentSp (object oNpc, int nSpawn);


//This function uses orient to object
//Main move function used anywhere high precision
//is not required. Checks oNpc movement rate and factor
//to determine the correct delay before orient.
void DelayJump (object oNpc, object oWp1);

//This function Delays Jump to object until the distance
//is less than 0.5
void DelayJumpPrecise (object oNpc, object oWp1);

//This function compares time and shift values to return the correct
//activity integer
int GetTimeActivity (object oNpc);

//This function compares time and shift values to return the correct
//activity string
string GetTimeString (object oNpc);

//This function gets the "wepleft" or "wepright" variable
//off of the NPC depending on the activity being called
string GetItemString (object oNpc, int nAct);

//this function get the "armor" variable
//off of the NPC depending on the activity being called
string GetArmorString (object oNpc, int nAct);

//This function grabs wp definition and spawn definition
//then destroys wp and recreates wp at spawn int
//REQUIRES: valid NPC, valid WP, valid Spawn WP
//LocalString on NPC named "wptag"
//spawn tag naming convention "SPAWN_ACTTAG_"NPC TAG HERE"_01" etc...
void SpawnDestroyCreate (object oNpc, object oWp1, float fDwp1);

//this function is the same as SpawnDestroyCreate without the 
//distance check
void WrapperDestroyCreate (object oNpc, object oWp1);

//This function checks various local integers and executes
//other commands based on the location, time, reset status, and 
//sleep status of NPC's who call it
void VariableSwitcher (object oNpc, object oWp1, int nReset);

//This function sets global integers and strings based on the
//time of day
void GlobalSet (object oMod);

//This function resets stored variables at the change of activity
//and runs the VariableSwitcher(); function
void NpcReset(object oNpc);

//Clears NPC plot, hidden, and aggressive faction flags
void ClearFlags (object oNpc);

//This function grabs the wptag variable off of the NPC and
//increments by 1 and then stores the new wptag
void IncrementWwp (object oNpc);

//Use this function to store the original wp paramaters
//and NPC paramaters for later restoration in the NpcReset(); function
void StoreOriginalWp (object oNpc);

//Call before armed activities (post, wwp, etc...)
void NpcArm (object oNpc);

//Call before disarmed activities (sleep etc...)
void NpcDisarm (object oNpc);

//equips items in right hand of NPC (spoon, hammer, etc...)
//NOTE: still working this out a bit
void NpcEquipItemRight(object oNpc);

//equips items in left hand of NPC (lute, flute, drum, etc...)
//NOTE: still working this out a bit
void NpcEquipItemLeft(object oNpc);

//function for getting the NPC's out of bed
void NpcWakeUp (object oNpc);

//sets faction to aggro against other training NPC's
void NpcAggroTraining (object oNpc, object oFactioncontrol);

//Action wrapper for PlayCustomAnimation to allow dealay and assign
void ActionPlayCustomAnimation(object oNpc, string sAnimationName, int nLooping, float fSpeed = 1.0f);

//clear inventory out of npc at disarm
//Thanks Kaldor Silverwand
void ClearInventory (object oNpc);

//Kickstart any stuck NPCs 
void KickStart();

//wrapper for IsCreatureInView adds range argument
int IsCreatureInViewInRange (object oViewObj, float fRange);

//checks NPC mark strings and activity integers for targets.
object AcquireTarget (object oNpc);

//Check to see if a target is facing the caller of 
//this command
//float fdegrees 1/2 float range 75.0 = 150 degree facing arc
//object oTarget = target to check if is facing caller
int IsFacingMe(float fDegrees, object oTarget);

//Checks for witnesses and returns TRUE if the coast is clear
//returns FALSE if witnesses are within sight range
int CheckForWitnesses (object oNpc, object oTarget, float fWitnessRange);

//cycle through the assassin's hitlist 
//for valid targets
object CheckHitList (object oNpc);

//use distance divided by movement rate and rate factor to return
//a float in seconds to delay
float GetDelay (object oNpc, object oTarget);

//use to return location of MIDNIGHTWP instead of target
//if the target is sleeping
location CheckActivity (object oTarget);

//check area for wp and npc and perform transition if not equal
//general transitioin tag in current area = TRANS_areatag
//general transition tag in next area = TRANS_areatag
//specific transition tag in current area = TRANS_npctag_areatag
//specific transition tag in next area = TRANS_npctag_areatag
void AreaTransition (object oNpc);

//action wrapper for setlocalint
void ActionSetLocalInt (object oNpc, string sVarname, int nValue);

//interrupts normal heartbeat script execuation
//for cross area travel
void HeartbeatCheck (object oNpc);

//Experimental - Not currently used
object GetLeader (object oNpc);

//checks through a NPC wp set for wwp's in same area as PC
int CheckWwpArea (object oNpc);

//this function returns an object which meets the criteria
//object tag = string tag passed paramater
//object state is currently off //NPC will turn state to on
object GetInteractiveNight (object oNpc, string sTag);

//this function returns an object which meets the criteria
//object tag = string tag passed paramater
//object state is currently on //NPC will turn state to off
object GetInteractiveDay (object oNpc, string sTag);

//this function randomly generates conversation which
//is stored on the bar maid to be used throughout the
//order and fulfillment process
void  TakeOrder(object oNpc);

//this function checks the bar maid for exclusions and
//returns an object customer
object GetCustomer(object oNpc, int nPatrons);

//this function checks the customer verses the bar maid
//and resets her behavior if not in the same area
void AreaCheck (object oCustomer, object oNpc);
///////////////////////////////////////////////
//FUNCTION DEFINITIONS                       //
///////////////////////////////////////////////


//This command gets the prefix from the global int set
//and the postfix from the npc tag
//after concatenation returns correct wp tag
object GetCurrentWp (object oNpc)
{
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
string sWayset = GetGlobalString (sShift);
return GetObjectByTag ((sWayset)+(sNpc2));
}

//This command uses the tag of the npc and naming convention
//info to generate the correct WWP
object GetCurrentWwp (object oNpc)
{
string sNpc = GetTag (oNpc);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
string sWayset = GetGlobalString (sShift);
int nWptag = GetLocalInt (oNpc,"wptag");
string sWptag = IntToString (nWptag);
return GetObjectByTag ("WP_"+(sNpc)+"_0"+(sWptag));
}

//This command uses the tag of the npc and naming convention
//info to generate the correct spawn point
//No longer used left in for possible future use//
object GetCurrentSp (object oNpc, int nSpawn)
{
string sNpc = GetTag (OBJECT_SELF);
string sShift = GetLocalString (oNpc, "sShift");
string sWayset = GetGlobalString (sShift);
return GetObjectByTag ("SPAWN_"+(sWayset)+"_"+(sNpc)+"_0"+(IntToString (nSpawn)));
}


//This function compares the current distance to the acceptable
//jump distance and orients after a delay based on distance from waypoint
void DelayJump (object oNpc, object oWp1)
{	

float fDwp1 = GetDistanceToObject (oWp1);
float fDwp2 = GetFacing (oWp1);
float fFactor = GetMovementRateFactor(oNpc);
float fRateVS = (0.75 * fFactor); float fDVS = (fDwp1 / fRateVS);
float fRateS = (1.25 * fFactor); float fDS = (fDwp1 / fRateS);
float fRateN = (1.75 * fFactor); float fDN = (fDwp1 / fRateN);
float fRateF = (2.25 * fFactor); float fDF = (fDwp1 / fRateF);
float fRateVF = (2.75 * fFactor); float fDVF = (fDwp1 / fRateVF);
int nRate = GetMovementRate (oNpc);
int nLocation = GetLocalInt (oNpc, "atloc");
	{switch (nLocation)
		{
		case 1:
		break;
		default:
		  {switch (nRate)
		      {
		      default:
              break;
              case 2:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDVS)+0.2), ActionOrientToObject(oWp1,ORIENT_FACE_SAME_AS_TARGET));
	          SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 3:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDS)+0.2), ActionOrientToObject(oWp1,ORIENT_FACE_SAME_AS_TARGET));
	          SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 4:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDN)+0.2), ActionOrientToObject(oWp1,ORIENT_FACE_SAME_AS_TARGET));
	          SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 5:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDF)+0.2), ActionOrientToObject(oWp1,ORIENT_FACE_SAME_AS_TARGET));
	          SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;  
              case 6:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDVF)+0.2), ActionOrientToObject(oWp1,ORIENT_FACE_SAME_AS_TARGET));
	          SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              }
           }                                         		      
		break;
		}
	}		
}


//This function compares the current distance to the acceptable
//jump distance and jumps after a delay based on distance from waypoint
//Use this for precision placement otherwise use  DelayJump (smoother)!!
void DelayJumpPrecise (object oNpc, object oWp1)
{	

float fDwp1 = GetDistanceToObject (oWp1);
float fFactor = GetMovementRateFactor(oNpc);
float fRateVS = (0.75 * fFactor); float fDVS = (fDwp1 / fRateVS);
float fRateS = (1.25 * fFactor); float fDS = (fDwp1 / fRateS);
float fRateN = (1.75 * fFactor); float fDN = (fDwp1 / fRateN);
float fRateF = (2.25 * fFactor); float fDF = (fDwp1 / fRateF);
float fRateVF = (2.75 * fFactor); float fDVF = (fDwp1 / fRateVF);
int nRate = GetMovementRate (oNpc);
int nLocation = GetLocalInt (oNpc, "atloc");
	{switch (nLocation)
		{
		case 1:
		break;
		default:
		  {switch (nRate)
		      {
		      default:
              break;
              case 2:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDVS)+0.2), ActionJumpToObject(oWp1,1));
              SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 3:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDS)+0.2), ActionJumpToObject(oWp1,1));
              SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 4:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDN)+0.2), ActionJumpToObject(oWp1,1));
              SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              case 5:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDF)+0.2), ActionJumpToObject(oWp1,1));
              SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;  
              case 6:    
        	  ActionMoveToObject (oWp1,0,0.0);
	          DelayCommand (((fDVF)+0.2), ActionJumpToObject(oWp1,1));
              SetLocalInt (oNpc, "ud",0);
		      SetLocalInt (oNpc,"atloc",1);
		      break;
              }
           }                                         		      
		break;
		}
	}	
}

		  
//This function grabs wp definition and spawn definition
//then destroys wp and recreates wp at spawn int
//REQUIRES: valid NPC, valid WP, valid Spawn WP
//LocalString on NPC named "wptag"
//spawn tag naming convention "SPAWN_"NPC TAG HERE"_01" etc...
void SpawnDestroyCreate (object oNpc, object oWp1, float fDwp1)
{
if (fDwp1 <= 1.0)
    {       
    int nVar = GetLocalInt (oNpc,"wptag");
    string sNpc = GetTag (OBJECT_SELF);
    string sNpc2 = GetStringRight (sNpc,3);
    string sSptag = IntToString (nVar);
    string sShift = GetLocalString (oNpc, "sShift");
    string sWayset = GetGlobalString (sShift);
    object oSpawn = GetObjectByTag ("SPAWN_"+(sWayset)+"_"+(sNpc)+"_0"+(IntToString (nVar)));
    location lSpawn = GetLocation(oSpawn);
    DestroyObject (oWp1,0.0); 
    CreateObject (OBJECT_TYPE_WAYPOINT,(sWayset),lSpawn,0,(sWayset)+(sNpc2));
    }
}

//This function is a duplicate of SpawnDestroyCreate without the
//distance check requirement
void WrapperDestroyCreate (object oNpc, object oWp1)
{      
    int nVar = GetLocalInt (oNpc,"wptag");
    string sNpc = GetTag (OBJECT_SELF);
    string sNpc2 = GetStringRight (sNpc,3);
    string sSptag = IntToString (nVar);
    string sShift = GetLocalString (oNpc, "sShift");
    string sWayset = GetGlobalString (sShift);
    object oSpawn = GetObjectByTag ("SPAWN_"+(sWayset)+"_"+(sNpc)+"_0"+(IntToString (nVar)));
    location lSpawn = GetLocation(oSpawn);
    DestroyObject (oWp1,0.0); 
    object oWp2 = CreateObject (OBJECT_TYPE_WAYPOINT,(sWayset),lSpawn,0,(sWayset)+(sNpc2));
	DelayJump (oNpc, oWp2);
}

//This function checks various local integers and executes
//other commands based on the location, time, reset status, and 
//sleep status of NPC's who call it
void VariableSwitcher (object oNpc, object oWp1, int nReset)
{
object oMod = GetModule();
object oPC = GetFirstPC();
int nHour = GetTimeHour();
int nWakel = GetLocalInt (oNpc, "wakel");
int nAct1l = GetLocalInt (oNpc, "act1l");
int nDinnerl = GetLocalInt (oNpc, "dinnerl");
int nAct2l = GetLocalInt (oNpc, "act2l");
int nSleepl = GetLocalInt (oNpc, "sleepl");
int nMidnightl = GetLocalInt (oNpc, "midnightl");
int nUd = GetLocalInt (oNpc, "ud");
int nAwake = GetLocalInt (oNpc, "awake");
int nLocation = GetLocalInt (oNpc, "atloc");
int nUpdate = GetLocalInt (oMod, "updated");
int nWwp = GetLocalInt (oNpc,"wpcontrol");
int nTraining = GetLocalInt (oNpc, "training");
int nTrain1st = GetLocalInt (oNpc, "train1st");
int nUsespawn = GetLocalInt (oNpc, "spawn");
int nActivity1 = GetLocalInt (oNpc, "updateactone");
int nActivity2 = GetLocalInt (oNpc, "updateacttwo");
int nActorig = GetLocalInt (oNpc, "originalact");
string sActorig = GetLocalString (oNpc, "originalstring");
string sDay = ("sDay");
string sSwing = ("sSwing");
string sNight = ("sNight");

	{switch (nUpdate)
		{
		case 0:	
		if ((nHour == 7) || (nHour == 11) 
		|| (nHour == 15) || (nHour == 19)
		|| (nHour == 23) || (nHour == 3)) 
		GlobalSet(oMod);
		SetLocalInt (oMod, "updated", 1);
		break;
		case 1: 
		break;
		}
	}
	{switch (nHour)
		{
		case 1: case 5: case 9:
		case 13: case 17: case 21:
		SetLocalInt (oNpc, "reset", 0);
		break;
		case 0: case 4: case 8:
		case 12: case 16: case 20:		
		KickStart ();
		break;
		default: 
		break;
		}
	}		
	{switch (nReset)
		{
		case 0:
			{switch (nHour)
				{
				case 0:	case 2:
				case 4:	case 6:
				case 8:	case 10:
				case 12: case 14:
				case 16: case 18:
				case 20: case 22:
				break;
				case 1: case 5: case 9:
				case 13: case 17: case 21:
				break;				
				default:
				SetLocalInt (oNpc, "reset",1);
				NpcReset(oNpc);
				if ((GetArea (oNpc) == GetArea (oPC)) || (GetArea (oWp1) == GetArea (oPC)))
					{SetAILevel (oNpc , AI_LEVEL_NORMAL);}
				break;
				}				
			}
		case 1:
		break;
		}
	}		

	{switch (nAwake)
		{
		case 0:
		if ((nHour == 7) || (nHour == 15) || (nHour == 23))
		SetLocalInt(oNpc,"sleepcontrol",0);
		NpcWakeUp (oNpc); SetLocalInt (oNpc,"awake",1);
		break;
		case 1:
		break;
		}
	}
	{switch (nUsespawn)
		{
		case 1:
			{switch (nHour)
				{
				default:
				break;
				case 1: case 5: case 9: case 13: case 17: case 21:
					{switch (nActivity1)
						{
						default:
						break;
						case 1:
						SetLocalInt (oNpc, sActorig, nActorig);
						SetLocalInt (oNpc, "updateactone", 0);
						break;
						}
					}	
				break;
				case 2: case 6: case 10: case 14: case 18: case 22:
					{switch (nActivity2)
						{
						default:
						break;
						case 1:
						SetLocalInt (oNpc, sActorig, nActorig);
						SetLocalInt (oNpc, "updateacttwo", 0);
						break;
						}
					}	
				break;
				}
			}
		default:
		break;
		}		
	}															
SetLocalInt (oNpc,"ud2",1);		
}

//This function sets global integers and strings based on the
//time of day
void GlobalSet (object oMod)
{
int nHour = GetTimeHour();
switch (nHour)
  {
  case 3:
  case 4:
  case 5:
  case 6:
  SetGlobalInt ("midnight", 1);
  SetGlobalInt ("wake", 0);
  SetGlobalInt ("act1", 0);
  SetGlobalInt ("act2", 0);
  SetGlobalInt ("dinner", 0);
  SetGlobalInt ("sleep", 0);
  SetGlobalInt ("midnights", 0);
  SetGlobalInt ("wakes", 0);
  SetGlobalInt ("act1s", 1);
  SetGlobalInt ("act2s", 0);
  SetGlobalInt ("dinners", 0);
  SetGlobalInt ("sleeps", 0);
  SetGlobalInt ("midnightn", 0);
  SetGlobalInt ("waken", 0);
  SetGlobalInt ("act1n", 0);
  SetGlobalInt ("act2n", 0);
  SetGlobalInt ("dinnern", 1);
  SetGlobalInt ("sleepn", 0);
  SetGlobalString ("sDayprevious", "SLEEPWP");
  SetGlobalString ("sDay", "MIDNIGHTWP");
  SetGlobalString ("sDaynext", "WAKEWP");
  SetGlobalString ("sSwingprevious", "WAKEWP");
  SetGlobalString ("sSwing", "ACT1WP");
  SetGlobalString ("sSwingnext", "ACT2WP");
  SetGlobalString ("sNightprevious", "ACT2WP");
  SetGlobalString ("sNight", "EATWP");
  SetGlobalString ("sNightnext", "SLEEPWP");
  break;
  case 7:
  case 8:
  case 9:
  case 10:
  SetGlobalInt ("midnight", 0);
  SetGlobalInt ("wake", 1);
  SetGlobalInt ("act1", 0);
  SetGlobalInt ("act2", 0);
  SetGlobalInt ("dinner", 0);
  SetGlobalInt ("sleep", 0);
  SetGlobalInt ("midnights", 0);
  SetGlobalInt ("wakes", 0);
  SetGlobalInt ("act1s", 0);
  SetGlobalInt ("act2s", 1);
  SetGlobalInt ("dinners", 0);
  SetGlobalInt ("sleeps", 0);
  SetGlobalInt ("midnightn", 0);
  SetGlobalInt ("waken", 0);
  SetGlobalInt ("act1n", 0);
  SetGlobalInt ("act2n", 0);
  SetGlobalInt ("dinnern", 0);
  SetGlobalInt ("sleepn", 1);
  SetGlobalString ("sDayprevious", "MIDNIGHTWP");
  SetGlobalString ("sDay", "WAKEWP");
  SetGlobalString ("sDaynext", "ACT1WP");
  SetGlobalString ("sSwingprevious", "ACT1WP");
  SetGlobalString ("sSwing", "ACT2WP");
  SetGlobalString ("sSwingnext", "EATWP");
  SetGlobalString ("sNightprevious", "EATWP");
  SetGlobalString ("sNight", "SLEEPWP");
  SetGlobalString ("sNightnext", "MIDNIGHTWP");
  break; 
  case 11:
  case 12:
  case 13:
  case 14: 
  SetGlobalInt ("midnight", 0);
  SetGlobalInt ("wake", 0);
  SetGlobalInt ("act1", 1);
  SetGlobalInt ("act2", 0);
  SetGlobalInt ("dinner", 0);
  SetGlobalInt ("sleep", 0);
  SetGlobalInt ("midnights", 0);
  SetGlobalInt ("wakes", 0);
  SetGlobalInt ("act1s", 0);
  SetGlobalInt ("act2s", 0);
  SetGlobalInt ("dinners", 1);
  SetGlobalInt ("sleeps", 0);
  SetGlobalInt ("midnightn", 1);
  SetGlobalInt ("waken", 0);
  SetGlobalInt ("act1n", 0);
  SetGlobalInt ("act2n", 0);
  SetGlobalInt ("dinnern", 0);
  SetGlobalInt ("sleepn", 0);
  SetGlobalString ("sDayprevious", "WAKEWP");
  SetGlobalString ("sDay", "ACT1WP");
  SetGlobalString ("sDaynext", "ACT2WP");
  SetGlobalString ("sSwingprevious", "ACT2WP");
  SetGlobalString ("sSwing", "EATWP");
  SetGlobalString ("sSwingnext", "SLEEPWP");
  SetGlobalString ("sNightprevious", "SLEEPWP");
  SetGlobalString ("sNight", "MIDNIGHTWP");
  SetGlobalString ("sNightnext", "WAKEWP");
  break;
  case 15:
  case 16:
  case 17:
  case 18:
  SetGlobalInt ("midnight", 0);
  SetGlobalInt ("wake", 0);
  SetGlobalInt ("act1", 0);
  SetGlobalInt ("act2", 1);
  SetGlobalInt ("dinner", 0);
  SetGlobalInt ("sleep", 0);
  SetGlobalInt ("midnights", 0);
  SetGlobalInt ("wakes", 0);
  SetGlobalInt ("act1s", 0);
  SetGlobalInt ("act2s", 0);
  SetGlobalInt ("dinners", 0);
  SetGlobalInt ("sleeps", 1);
  SetGlobalInt ("midnightn", 0);
  SetGlobalInt ("waken", 1);
  SetGlobalInt ("act1n", 0);
  SetGlobalInt ("act2n", 0);
  SetGlobalInt ("dinnern", 0);
  SetGlobalInt ("sleepn", 0);
  SetGlobalString ("sDayprevious", "ACT1WP");
  SetGlobalString ("sDay", "ACT2WP");
  SetGlobalString ("sDaynext", "EATWP");
  SetGlobalString ("sSwingprevious", "EATWP");
  SetGlobalString ("sSwing", "SLEEPWP");
  SetGlobalString ("sSwingnext", "MIDNIGHTWP");
  SetGlobalString ("sNightprevious", "MIDNIGHTWP");
  SetGlobalString ("sNight", "WAKEWP");
  SetGlobalString ("sNightnext", "ACT1WP");
  break; 
  case 19:
  case 20:
  case 21:
  case 22: 
  SetGlobalInt ("midnight", 0);
  SetGlobalInt ("wake", 0);
  SetGlobalInt ("act1", 0);
  SetGlobalInt ("act2", 0);
  SetGlobalInt ("dinner", 1);
  SetGlobalInt ("sleep", 0);
  SetGlobalInt ("midnights", 1);
  SetGlobalInt ("wakes", 0);
  SetGlobalInt ("act1s", 0);
  SetGlobalInt ("act2s", 0);
  SetGlobalInt ("dinners", 0);
  SetGlobalInt ("sleeps", 0);
  SetGlobalInt ("midnightn", 0);
  SetGlobalInt ("waken", 0);
  SetGlobalInt ("act1n", 1);
  SetGlobalInt ("act2n", 0);
  SetGlobalInt ("dinnern", 0);
  SetGlobalInt ("sleepn", 0);
  SetGlobalString ("sDayprevious", "ACT2WP");
  SetGlobalString ("sDay", "EATWP");
  SetGlobalString ("sDaynext", "SLEEPWP");
  SetGlobalString ("sSwingprevious", "SLEEPWP");
  SetGlobalString ("sSwing", "MIDNIGHTWP");
  SetGlobalString ("sSwingnext", "WAKEWP");
  SetGlobalString ("sNightprevious", "WAKEWP");
  SetGlobalString ("sNight", "ACT1WP");
  SetGlobalString ("sNightnext", "ACT2WP");
  break;
  
  case 23:
  case 0:
  case 1:
  case 2:
  SetGlobalInt ("midnight", 0);
  SetGlobalInt ("wake", 0);
  SetGlobalInt ("act1", 0);
  SetGlobalInt ("act2", 0);
  SetGlobalInt ("dinner", 0);
  SetGlobalInt ("sleep", 1);
  SetGlobalInt ("midnights", 0);
  SetGlobalInt ("wakes", 1);
  SetGlobalInt ("act1s", 0);
  SetGlobalInt ("act2s", 0);
  SetGlobalInt ("dinners", 0);
  SetGlobalInt ("sleeps", 0);
  SetGlobalInt ("midnightn", 0);
  SetGlobalInt ("waken", 0);
  SetGlobalInt ("act1n", 0);
  SetGlobalInt ("act2n", 1);
  SetGlobalInt ("dinnern", 0);
  SetGlobalInt ("sleepn", 0);
  SetGlobalString ("sDayprevious", "EATWP");
  SetGlobalString ("sDay", "SLEEPWP");
  SetGlobalString ("sDaynext", "MIDNIGHTWP");
  SetGlobalString ("sSwingprevious", "MIDNIGHTWP");
  SetGlobalString ("sSwing", "WAKEWP");
  SetGlobalString ("sSwingnext", "ACT1WP");
  SetGlobalString ("sNightprevious", "ACT1WP");
  SetGlobalString ("sNight", "ACT2WP");
  SetGlobalString ("sNightnext", "EATWP");
  break;
  }

}

//This function resets stored variables at the change of activity
//and runs the VariableSwitcher(); function
void NpcReset(object oNpc)
{
ClearAllActions();		
SetLocalInt (oNpc, "ud", 0);
SetLocalInt (oNpc, "ud2", 0);
SetLocalInt (oNpc, "awake", 0);
SetLocalInt (oNpc,"wpcontrol",0);
SetLocalInt (oNpc, "updated", 0);
SetLocalInt (oNpc, "training",0);
SetLocalInt (oNpc, "train1st",0);
SetLocalInt (oNpc, "original",0);
SetLocalInt (oNpc, "atloc", 0);
SetLocalInt (oNpc, "clearflags", 0);
SetLocalInt (oNpc, "wptag", 1);
SetLocalInt (oNpc, "actioncounter", 0);
SetLocalInt (oNpc, "hiderseeker" , 1);
SetLocalInt (oNpc, "X2_L_SPAWN_USE_AMBIENT", 0);
SetLocalInt (oNpc, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE", 0);
SetLocalInt (oNpc, "NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE", 0);
//
//
int nWriteprotect =	GetLocalInt (oNpc, "writeprotect");
location lWpstore = GetLocalLocation (oNpc, "wplocation");
float fWpstore = GetLocalFloat (oNpc, "wpfacing");
string sWptype = GetLocalString (oNpc, "wptype");
string sWayset = GetLocalString (oNpc, "template");
int nActorig = GetLocalInt (oNpc, "originalact");
string sActorig = GetLocalString (oNpc, "originalstring");
object oWpdup = GetObjectByTag (sWptype);
    {switch (nWriteprotect)
        {
        default:
        break;
        case 1: 
        DestroyObject (oWpdup);
        SetLocalInt (oNpc, sActorig, nActorig);
		SetLocalInt (oNpc, "wptag", 1);
        object oWpreplace = CreateObject (OBJECT_TYPE_WAYPOINT, sWayset, lWpstore,0, sWptype);
        AssignCommand (oWpreplace, SetFacing (fWpstore));
        DeleteLocalInt (oNpc, "writeprotect");
        DeleteLocalLocation (oNpc, "wplocation");
        DeleteLocalFloat (oNpc, "wpfacing");
        DeleteLocalString (oNpc, "wptype");
        DeleteLocalString (oNpc, "template");
        DeleteLocalInt (oNpc, "originalact");
        DeleteLocalString (oNpc, "originalstring");
		DeleteLocalInt (oNpc, "updateactone");
		DeleteLocalInt (oNpc, "updateacttwo");
		DeleteLocalInt (oNpc, "updateactthree");
		DeleteLocalInt (oNpc, "resetspawn1");
		DeleteLocalInt (oNpc, "resetspawn2");	
        DeleteLocalInt (oNpc, "spawnact1behavior");	
        DeleteLocalInt (oNpc, "spawnact2behavior");
        DeleteLocalInt (oNpc, "equipcounter");
        DeleteLocalInt (oNpc, "actioncounter");
		DeleteLocalInt (oNpc, "prone");
		DeleteLocalInt (oNpc, "hiderseeker");
        }
    }
//
int nReset = GetLocalInt (oNpc, "reset");
object oWp1 = GetCurrentWp (oNpc);
VariableSwitcher (oNpc, oWp1, nReset);
}

//This function compares time and shift values to return the correct
//activity integer REQUIRES: activity assignments in NPC variables
//when placed in toolset(wakel,act1l,dinnerl,act2l,sleepl,midnightl)
//REQUIRES: local string "sShift" set to either sDay, sSwing, or sNight
int GetTimeActivity (object oNpc)
{
int nHour = GetTimeHour();
int nWakel = GetLocalInt (oNpc, "wakel");
int nAct1l = GetLocalInt (oNpc, "act1l");
int nDinnerl = GetLocalInt (oNpc, "dinnerl");
int nAct2l = GetLocalInt (oNpc, "act2l");
int nSleepl = GetLocalInt (oNpc, "sleepl");
int nMidnightl = GetLocalInt (oNpc, "midnightl");
string sDay = ("sDay");
string sSwing = ("sSwing");
string sNight = ("sNight");

	if (((GetGlobalInt ("wake") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("wakes") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("waken") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
    {return (nWakel);}
	if (((GetGlobalInt ("act1") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("act1s") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("act1n") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
	{return (nAct1l);}
	if (((GetGlobalInt ("act2") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("act2s") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("act2n") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
	{return (nAct2l);}
	if (((GetGlobalInt ("dinner") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("dinners") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("dinnern") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
	{return (nDinnerl);}
	if (((GetGlobalInt ("sleep") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("sleeps") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("sleepn") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
	{return (nSleepl);}
	if (((GetGlobalInt ("midnight") == 1) && (GetLocalString (oNpc,"sShift") == (sDay)))
	|| ((GetGlobalInt ("midnights") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing)))
	|| ((GetGlobalInt ("midnightn") == 1) && (GetLocalString (oNpc,"sShift") == (sNight))))
	{return (nMidnightl);}
    else
    return (0);
}

//This function compares time and shift values to return the correct
//activity string REQUIRES: activity assignments in NPC variables
//when placed in toolset(wakel,act1l,dinnerl,act2l,sleepl,midnightl)
string GetTimeString (object oNpc)
{
int nHour = GetTimeHour();
string sWakel = ("wakel");
string sAct1l = ("act1l");
string sDinnerl = ("dinnerl");
string sAct2l = ("act2l");
string sSleepl = ("sleepl");
string sMidnightl = ("midnightl");
string sDay = ("sDay");
string sSwing = ("sSwing");
string sNight = ("sNight");

	if ((GetGlobalInt ("wake") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("wakes") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("waken") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
    {return (sWakel);}
	if ((GetGlobalInt ("act1") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("act1s") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("act1n") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
	{return (sAct1l);}
	if ((GetGlobalInt ("act2") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("act2s") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("act2n") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
	{return (sAct2l);}
	if ((GetGlobalInt ("dinner") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("dinners") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("dinnern") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
	{return (sDinnerl);}
	if ((GetGlobalInt ("sleep") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("sleeps") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("sleepn") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
	{return (sSleepl);}
	if ((GetGlobalInt ("midnight") == 1) && (GetLocalString (oNpc,"sShift") == (sDay))
	|| (GetGlobalInt ("midnights") == 1) && (GetLocalString (oNpc,"sShift") == (sSwing))
	|| (GetGlobalInt ("midnightn") == 1) && (GetLocalString (oNpc,"sShift") == (sNight)))
	{return (sMidnightl);}
    else
	return ("");
}

// use this to get the item string either stored on the NPC
// or return the default for the appropriate activity
string GetItemString (object oNpc, int nAct)
{
string sWepright = GetLocalString (oNpc, "wepright");
string sWepleft = GetLocalString (oNpc, "wepleft");    
    {switch (nAct)
        {
	    case 0: return ""; break;
	    case 1: return ""; break;
	    case 2: return ""; break;
	    case 3: return ""; break;
	    case 4: return ""; break;
	    case 5: return ""; break;
	    case 6: return ""; break;
	    case 7: return ""; break;
	    case 8: return ""; break;
	    case 9: return ""; break;
	    case 10: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_spoon"; break;
	    case 11: return ""; break;
	    case 12: return ""; break;
	    case 13: if (sWepleft != "") {return sWepleft;}
                 else
                 return "npc_drum"; break;
	    case 14: if (sWepleft != "") {return sWepleft;}
                 else
                 return "npc_flute"; break;
	    case 15: case 30: 
                 if (sWepright != "") {return sWepright;}
                 else
                 return "npc_hammer"; break;
	    case 16: if (sWepleft != "") {return sWepleft;}
                 else
                 return "npc_lute"; break;
	    case 17: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_handaxe"; break;
	    case 18: return ""; break;
	    case 19: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_longsword"; break;	
	    case 20: return ""; break;
        case 21: return ""; break;
        case 22: return ""; break;
        case 23: return ""; break;
        case 24: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_longsword"; break;
        case 25: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_longsword"; break;
        case 26: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_longsword"; break;
        case 27: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_longsword"; break;
        case 28: return ""; break;	
        case 29: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_spoon"; break;
        case 36: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_dagger"; break;
        case 37: if (sWepright != "") {return sWepright;}
                 else
                 return "npc_dagger"; break;
        case 40: if (sWepleft != "") {return sWepright;}
                 else
                 return "nw_it_torch001"; break;				 		 				 				 
        default: return ""; break;
        }
    return "";
    }
}


//Use this to get either the variable armor string off of the NPC
// or the default (variable must be template resref of object to create)
string GetArmorString (object oNpc, int nAct)
{
string sArmor = GetLocalString (oNpc, "armor");
    {switch (nAct)
        {
	    case 19: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_scale"; break;	
        case 24: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_scale"; break;
        case 25: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_scale"; break;
        case 26: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_scale"; break;
        case 27: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_scale"; break;
		case 36: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_leather"; break;
		case 37: if (sArmor != "") {return sArmor;}
                 else
                 return "npc_leather"; break;				 
        default: return ""; break;
        }
    return "";
    }
}

//Clears NPC plot, hidden, and aggressive faction flags
void ClearFlags (object oNpc)
{
int nClear = GetLocalInt (oNpc, "clearflags");
int nFaction = GetLocalInt (oNpc, "faction");
	{switch (nClear)
		{
		default:		
		ChangeToStandardFaction (oNpc, nFaction);
		DelayCommand (0.3,SetPlotFlag (oNpc,0));
		SetScriptHidden (oNpc,0,0);
		RemoveEffect (oNpc,EffectNWN2SpecialEffectFile("fx_invisibility"));
		SetLocalInt (oNpc, "clearflags", 1);
		break;
		case 1:
		break;
		}
	}	
}
//This function grabs the wptag variable off of the NPC and
//increments by 1 and then stores the new wptag
void IncrementWwp (object oNpc)
{
object oWpref = GetCurrentWwp (oNpc);
if (GetArea (oWpref) != GetArea (oNpc)){return;}
int nWptag = GetLocalInt (oNpc, "wptag");
string sWptag = IntToString (nWptag);
SetLocalInt (oNpc,"atloc",0);				
int nVar = StringToInt (sWptag);
nVar++;
SetLocalInt (oNpc ,"wptag", nVar);
object oWp1= GetCurrentWwp (oNpc);
if (oWp1 == OBJECT_INVALID){SetLocalInt (oNpc, "wptag", 1);}			
}

//Use this function to store the original wp paramaters
//and NPC paramaters for later restoration in the NpcReset(); function
void StoreOriginalWp (object oNpc)
{
int nWriteprotect = GetLocalInt (oNpc, "writeprotect");
if (nWriteprotect != 1)
	{
	object oWpstore = GetCurrentWp (oNpc);
	location lWpstore = GetLocation (oWpstore);
	float fWpstore = GetFacing (oWpstore);
	string sNpc = GetTag (OBJECT_SELF);
	string sNpc2 = GetStringRight (sNpc,3);
	string sShift = GetLocalString (oNpc, "sShift");
	string sWayset = GetGlobalString (sShift);
	string sWptype = ((sWayset)+(sNpc2));
	int nActorig = GetTimeActivity (oNpc);
	string sActorig = GetTimeString (oNpc);
	SetLocalString (oNpc, "template", sWayset);
	SetLocalLocation (oNpc, "wplocation", lWpstore);
	SetLocalFloat (oNpc, "wpfacing", fWpstore);
	SetLocalString (oNpc, "wptype", sWptype);
	SetLocalInt (oNpc, "originalact", nActorig);
	SetLocalString (oNpc, "originalstring", sActorig);
	SetLocalInt (oNpc, "writeprotect", 1);
	}
}	

//Call before armed activities (post, wwp, etc...)
void NpcArm (object oNpc)
{
object oCheck = GetItemInSlot (1, oNpc);
object oCheck2 = GetItemInSlot (4, oNpc);
object oCheck3 = GetItemInSlot (5, oNpc);
if (((oCheck != OBJECT_INVALID) && (oCheck2 != OBJECT_INVALID))
|| ((oCheck != OBJECT_INVALID) && (oCheck3 != OBJECT_INVALID))) {return;}
int nAct = GetTimeActivity (oNpc);
string sItem = GetItemString (oNpc, nAct);
string sArmor = GetArmorString (oNpc, nAct);
if ((oCheck2 == OBJECT_INVALID) && (oCheck3 == OBJECT_INVALID))
	{SetLocalInt (oNpc, "armed", 0);}
if (oCheck == OBJECT_INVALID) {SetLocalInt (oNpc, "armed", 0);}
int nArmed = GetLocalInt (oNpc,"armed");
	{switch (nArmed)
		{
		case 0:
		ClearFlags (oNpc);
		EquipNewItem(oNpc, sItem, 4, TRUE);
		EquipNewItem(oNpc, sArmor, 1, TRUE);
		DelayCommand (0.4, EquipNewItem(oNpc, sItem, 4, FALSE));
		DelayCommand (0.8, EquipNewItem(oNpc, sArmor, 1, FALSE));

		SetLocalInt (oNpc, "armed", 1);
		break;
		case 1:
		break;
		}

	}	
}
//Call before disarmed activities (sleep etc...)
void NpcDisarm (object oNpc)
{
int nFactioncontrol = GetLocalInt (oNpc, "faction");
ChangeToStandardFaction (oNpc, nFactioncontrol);
object oArmor = GetItemInSlot(1 ,oNpc);
object oWp1 = GetCurrentWp (oNpc);
int nCheck = GetIsInCombat (oNpc);
if (oArmor != OBJECT_INVALID){SetLocalInt (oNpc, "armed", 1);}
int nArmed = GetLocalInt (oNpc,"armed");
if (nCheck == TRUE) {SetLocalInt (oNpc,"training",1);}
int nTraining = GetLocalInt (oNpc, "training");
object oItem1 = GetFirstItemInInventory (oNpc);
object oItemn = GetNextItemInInventory (oNpc);
	{switch (nTraining)
		{
		default:
		break;
		case 1:
		ClearAllActions(TRUE);			
		SuspendAI (oNpc, FALSE,5.0);
		SetLocalInt (oNpc,"training",0);
		break;
		}
	}
	{switch (nArmed)
		{
		case 0:
		break;
		case 1:
		ClearAllActions (TRUE);
		ClearFlags (oNpc);
		DelayCommand (0.2,DestroyItemInSlot(oNpc, 1));
		DelayCommand (0.4,DestroyItemInSlot(oNpc, 4));
		DelayCommand (0.6,DestroyItemInSlot(oNpc, 5));
		DelayCommand (0.8,DestroyItemInSlot(oNpc, 1));
		DelayCommand (1.0,DestroyItemInSlot(oNpc, 4));
		DelayCommand (1.2,DestroyItemInSlot(oNpc, 5));
		DelayCommand (1.4, DestroyObject (oItem1));
		DelayCommand (1.6, DestroyObject (oItemn));	
		ClearInventory (oNpc);
		SetLocalInt (oNpc, "armed", 0);
		object oStill = GetFirstItemInInventory (oNpc);
		string sStill = GetTag (oStill);
		object oItemc = GetFirstItemInInventory(oNpc);
    	while(GetIsObjectValid(oItemc) == TRUE)
    	{
        DestroyObject(oItemc);
        oItemc = GetNextItemInInventory(oNpc);
    	}	
		break;
		}
	}
}

//Call before activities that need right hand item with no armor
void NpcEquipItemRight(object oNpc)
{
object oArmor = GetItemInSlot (1, oNpc);
object oCheck = GetItemInSlot (4, oNpc);
int nAct = GetTimeActivity (oNpc);
string sItem = GetItemString (oNpc, nAct);
if (oArmor != OBJECT_INVALID) {NpcDisarm (oNpc);}
if (oCheck != OBJECT_INVALID) {return;}
if (oCheck == OBJECT_INVALID) {SetLocalInt (oNpc, "armed", 0);}
int nArmed = GetLocalInt (oNpc,"armed");
int nEquip = GetLocalInt (oNpc, "equipcounter");
	{switch (nArmed)
		{
        case 0:		  		  
            {switch (nEquip)
                {
                default:    		    		
                ClearFlags (oNpc);
                EquipNewItem(oNpc, sItem, 4);
                DelayCommand (0.4, EquipNewItem(oNpc, sItem, 4, FALSE));
                SetLocalInt (oNpc, "equipcounter",1);
                SetLocalInt (oNpc, "armed", 1);
                break;
                case 1:    		    		
                ClearFlags (oNpc);
                EquipNewItem(oNpc, sItem, 4);
                DelayCommand (0.4, EquipNewItem(oNpc, sItem, 4, FALSE));
                SetLocalInt (oNpc, "equipcounter",2);
                SetLocalInt (oNpc, "armed", 1);
                break;  
                case 2:    		    		
                ClearFlags (oNpc);
                CreateItemOnObject(sItem, oNpc, 1);
                ActionEquipMostDamagingMelee();
                SetLocalInt (oNpc, "equipcounter",3);
                SetLocalInt (oNpc, "armed", 1);
                break;
                case 3:
                break;
                }
            }                              
		break;
		default:
		break;
		}
	}	
}

//call before activities that need left hand item with no armor
void NpcEquipItemLeft(object oNpc)
{
int nAct = GetTimeActivity (oNpc);
string sItem = GetItemString (oNpc, nAct);
object oCheck = GetItemInSlot (5, oNpc);
if (oCheck == OBJECT_INVALID) {SetLocalInt (oNpc, "armed", 0);}
int nArmed = GetLocalInt (oNpc,"armed");
	{switch (nArmed)
		{
		case 0:
		ClearFlags (oNpc);
        DestroyItemInSlot(oNpc, 4);
        EquipNewItem(oNpc, sItem, 5, 1);
		SetLocalInt (oNpc, "armed", 1);
		break;
		default:
		break;
		}
	}	
}


//function for getting the NPC's out of bed
void NpcWakeUp (object oNpc)
{
string sCheckd = "sDay";
string sChecks = "sSwing";
string sCheckn = "sNight";
string sNpc = GetTag (OBJECT_SELF);
string sNpc2 = GetStringRight (sNpc,3);
string sShift = GetLocalString (oNpc, "sShift");
string sP = ("previous");
string sWayset2 = GetGlobalString ((sShift)+(sP));
string sWayset = GetGlobalString (sShift);
object oWp1 = GetObjectByTag ((sWayset)+(sNpc2));
object oWp2 = GetObjectByTag ((sWayset2)+(sNpc2));
float fDwp1 = GetDistanceToObject (oWp1);
int nHour = GetTimeHour();
object oMod = GetModule();
int nUpdate = GetLocalInt (oMod, "updated");
int nSleep = GetLocalInt (oNpc, "sleepcontrol");

	if (((nHour == 7) && (nSleep == 0) && (sShift == sCheckd))
	|| ((nHour == 15) && (nSleep == 0) && (sShift == sCheckn))
	|| ((nHour == 23) && (nSleep == 0))&& (sShift == sChecks))
	{
	if ((fDwp1 >= 0.5) && (nUpdate == 1)) 
		{
		ActionPlayCustomAnimation (oNpc, "situp", 0,1.0);
		DelayCommand (1.0,ActionJumpToObject (oWp2,1));
		DelayCommand (1.4, ActionPlayCustomAnimation (oNpc ,"idle" ,1 ,1.0));
		SetLocalInt (oNpc, "ud", 0);
		}
	}
} 

//sets faction to aggro against other training NPC's
void NpcAggroTraining (object oNpc, object oFactioncontrol)
{
ChangeFaction (oNpc, oFactioncontrol);
object oEnemy = GetNearestObject(OBJECT_TYPE_CREATURE, oNpc,1);	
object oEnemy2 = GetNearestObjectByTag ("npc_target" , oNpc);		
int nEnemycheck = GetIsEnemy(oEnemy,oNpc);
if (nEnemycheck == TRUE)
{ActionAttack (oEnemy,0);}
else
{ActionAttack (oEnemy2,0);}
SetLocalInt (oNpc, "training", 1);
}

//Action wrapper for PlayCustomAnimation to allow delay and assign
void ActionPlayCustomAnimation(object oNpc, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
    PlayCustomAnimation(oNpc, sAnimationName, nLooping, fSpeed);	
}
//clear out excess inventory at disarm
void ClearInventory (object oNpc)
{
    object oItem = GetFirstItemInInventory(oNpc);
    while(GetIsObjectValid(oItem) == TRUE)
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oNpc);
    }
object oItem2 = GetFirstItemInInventory (oNpc);
DelayCommand (0.2,DestroyObject(oItem2));
}

//this will transport stuck NPC's to the location they should be at
void KickStart()
{
ClearAllActions ();
object oNpc = OBJECT_SELF;
int nActivity = GetTimeActivity (oNpc);
int nOriginal = GetLocalInt (oNpc, "originalact");
	if ((nActivity == 29) || (nActivity == 30) || (nActivity == 38) || (nActivity >= 80)
	|| (nActivity == 26) || (nActivity == 27) || (nActivity == 40) || (nActivity == 41) 
	|| (nActivity == 42) || (nOriginal == 40) || (nOriginal >= 90))
		{return;}
object oWp1 = GetCurrentWp (oNpc);
float fDwp1 = GetDistanceToObject (oWp1);
if ((oWp1 != OBJECT_INVALID) && (fDwp1 >= 2.5))
	{ 
	ActionJumpToObject (oWp1);
	}
}

//wrapper for IsCreatureInView adds range argument
int IsCreatureInViewInRange (object oViewObj, float fRange)
{
float fCheck = GetDistanceToObject (oViewObj);
int nView = IsCreatureInView (oViewObj,75.0);
	{switch (nView)
		{
		case TRUE:
		if (fRange >= (fCheck)+0.1){return TRUE;}
		else {return FALSE;}
		break;
		case FALSE:
		return FALSE;
		break;
		}
	}
return FALSE;	
}		

//checks NPC mark strings and activity integers for targets.
object AcquireTarget (object oNpc)
{
//check if we have already found a target if so return
string sCheck = GetLocalString (oNpc, "targetstring");
int nCheck = GetLocalInt (oNpc, "targetacquired");
if (nCheck ==1) {return (GetObjectByTag(sCheck));}
object oMark = CheckHitList (oNpc);
string sMark = GetTag (oMark);
	if (oMark != OBJECT_INVALID)  
		{
		SetLocalString (oNpc, "targetstring", sMark); 
		SetLocalInt (oNpc, "targetacquired", 1);
//		SendMessageToPC (GetFirstPC(),(sMark));
		return oMark;
		}
object oArea = GetArea(oNpc);
int nTarget = GetLocalInt (oNpc, "target");
object oTarget = GetNextObjectInArea(oArea);
int nAcquired = GetTimeActivity (oTarget);
	if (nTarget == 0){return OBJECT_INVALID;}
	while(nAcquired != nTarget)
	    {
	    oTarget = GetNextObjectInArea(oArea);
		nAcquired = GetTimeActivity (oTarget);
		if (oTarget == OBJECT_INVALID) {return OBJECT_INVALID;}
	    }	
SetLocalInt (oNpc, "targetacquired", 1);
string sTarget = GetTag (oTarget);
SetLocalString (oNpc, "targetstring", (sTarget));
return oTarget;	
}


//Check to see if a target is facing the caller of 
//this command
//float fdegrees 1/2 float range 75.0 = 150 degree facing arc
//object oTarget = target to check if is facing caller
int IsFacingMe(float fDegrees, object oTarget)
{
    int iRet;
    // return direction in degrees.
    float fDirectionOfFacing = GetFacing(oTarget);

    float fDirectionOfObject = GetAngleBetweenObjects(oTarget,OBJECT_SELF);

    // float fDelta = GetNormalizedDirection(fDirectionOfFacing - fDirectionOfObject);

    iRet = IsDirectionWithinTolerance(fDirectionOfObject, fDirectionOfFacing, fDegrees);
    return (iRet);
}	

//Checks for witnesses and returns TRUE if the coast is clear
//returns FALSE if witnesses are within sight range
int CheckForWitnesses (object oNpc, object oTarget, float fWitnessRange)
{
    object oWitness1 = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget);
    object oWitness2 = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, 2);	
	int nSleeping1 = GetTimeActivity (oWitness1);
	int nSleeping2 = GetTimeActivity (oWitness2);	
    float fWitness1 = GetDistanceBetween (oTarget, oWitness1);
    float fWitness2 = GetDistanceBetween (oTarget, oWitness2);
	if (nSleeping1 == 0) {(fWitness1 = (fWitnessRange)+0.1);}
	if (nSleeping2 == 0) {(fWitness2 = (fWitnessRange)+0.1);}	
	if ((nSleeping1 == 4) || (nSleeping1 == 5)) {(fWitness1 = (fWitnessRange)+0.1);}
	if ((nSleeping2 == 4) || (nSleeping2 == 5)) {(fWitness2 = (fWitnessRange)+0.1);}
	if ((oWitness1 == oNpc) || (oWitness1 == oTarget)) {(fWitness1 = (fWitnessRange)+0.1);}
	if ((oWitness2 == oNpc) || (oWitness2 == oTarget)) {(fWitness2 = (fWitnessRange)+0.1);}	
	string sW1 = GetTag (oWitness1);
	string sW2 = GetTag (oWitness2);		
    if ((fWitness1 >= fWitnessRange) && (fWitness2 >= fWitnessRange)) {return TRUE;}
    else 
    return FALSE;
} 


//cycle through the assassin's hitlist 
//for valid targets
object CheckHitList (object oNpc)
{
int nList = GetLocalInt(oNpc,"hitcount");
int nHitCount;
for (nHitCount =1; nHitCount <=(nList); nHitCount++)
	{
	string sMark = GetLocalString (oNpc, "mark"+IntToString(nHitCount));
	if (sMark != "")
		{
		object oMark = GetObjectByTag (sMark);
		SetLocalString (oNpc, "mark"+IntToString(nHitCount), "");
		return oMark;
		}	
	}
return OBJECT_INVALID;	
}

//use distance divided by movement rate and rate factor to return
//a float int seconds to delay
float GetDelay (object oNpc, object oTarget)
{	

float fDwp1 = GetDistanceToObject (oTarget);
float fFactor = GetMovementRateFactor(oNpc);
float fRateVS = (0.75 * fFactor); float fDVS = (fDwp1 / fRateVS);
float fRateS = (1.25 * fFactor); float fDS = (fDwp1 / fRateS);
float fRateN = (1.75 * fFactor); float fDN = (fDwp1 / fRateN);
float fRateF = (2.25 * fFactor); float fDF = (fDwp1 / fRateF);
float fRateVF = (2.75 * fFactor); float fDVF = (fDwp1 / fRateVF);
location lBackstab = GetBehindLocation (oTarget, 1.0);
int nRate = GetMovementRate (oNpc);
		  {switch (nRate)
		      {
		      default: break; case 2: return fDVS; break;
              case 3: return fDS; break; case 4: return fDN; break;
              case 5: return fDF; break; case 6: return fDVF; break;
              }
           } 
return fDN;		                                           		      		
}

//use to return location of MIDNIGHTWP instead of target
//if the target is sleeping
location CheckActivity (object oTarget)
{
int nActivity = GetTimeActivity (oTarget);
location lTarget = GetLocation (oTarget);
location lSafe;
string sNpc = GetTag (oTarget);
string sNpc2 = GetStringRight (sNpc,3);
object oBed = GetObjectByTag ("MIDNIGHTWP"+(sNpc2));
	{switch (nActivity)
		{
		case 4: case 5: case 31: case 32:
		return GetLocation (oBed);
		break;
		default:
		return GetBehindLocation (oTarget,1.0);
		break;
		}
	}
return GetBehindLocation (oTarget,1.0);	
}

//check area for wp and npc and perform transition if not equal
//general transitioin tag in current area = TRANS_areatag
//general transition tag in next area = TRANS_areatag
//specific transition tag in current area = TRANS_npctag_areatag
//specific transition tag in next area = TRANS_npctag_areatag
void AreaTransition (object oNpc)
{
ClearAllActions ();
object oWp1;
int nActivity = GetTimeActivity (oNpc);
	{switch (nActivity)
		{
		case 26: case 27:
		oWp1 = GetCurrentWwp (oNpc);
		break;
		default:
		oWp1 = GetCurrentWp (oNpc);
		break;
		}
	}	
object oPC = GetFirstPC();
object oAreaNPC = GetArea (oNpc);
object oAreaPC = GetArea (oPC);
object oAreaWP = GetArea (oWp1);
string sAreaNPC = GetTag (oAreaNPC);
string sAreaWP = GetTag (oAreaWP);
string sNpc = GetTag (oNpc);


//apply tag conventions
object oTrans1Gen = GetObjectByTag ("TRANS_"+(sAreaNPC));
object oTrans2Gen = GetObjectByTag ("TRANS_"+(sAreaWP));
object oTrans1Area = GetObjectByTag("TRANS_"+(sAreaWP)+"_"+(sAreaNPC));
object oTrans2Area = GetObjectByTag("TRANS_"+(sAreaNPC)+"_"+(sAreaWP));
object oTrans1Specific = GetObjectByTag ("TRANS_"+(sNpc)+"_"+(sAreaNPC));
object oTrans2Specific = GetObjectByTag ("TRANS_"+(sNpc)+"_"+(sAreaWP));

//compare and exit if wp and npc in same area
if (oAreaWP == oAreaNPC) {return;}
if ((oAreaWP == OBJECT_INVALID) && (oAreaNPC == oAreaPC)) {return;}
else if (oAreaWP != oAreaNPC)
		{
		SetLocalInt (oNpc, "transactive", 1);
		if (oTrans1Specific != OBJECT_INVALID)
			{
			ActionMoveToObject (oTrans1Specific);
			if (oAreaPC != oAreaWP)
				{
				ActionJumpToObject (oWp1);
				}
			else
				{
				if (oTrans2Specific != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Specific);
					}				
				else if (oTrans2Area != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Area);
					}
				else
					{	
					ActionJumpToObject (oTrans2Gen);
					}
				}	
			}
		else if (oTrans1Area != OBJECT_INVALID)
			{
			ActionMoveToObject (oTrans1Area);
			if (oAreaPC != oAreaWP)
				{
				ActionJumpToObject (oWp1);
				}
			else
				{
				if (oTrans2Specific != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Specific);
					}				
				else if (oTrans2Area != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Area);
					}
				else
					{	
					ActionJumpToObject (oTrans2Gen);
					}
				}
			}			
		else
			{
			ActionMoveToObject (oTrans1Gen);
			if (oAreaPC != oAreaWP)
				{
				ActionJumpToObject (oWp1);
				}
			else
				{
				if (oTrans2Specific != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Specific);
					}				
				else if (oTrans2Area != OBJECT_INVALID)
					{
					ActionJumpToObject (oTrans2Area);
					}
				else
					{	
					ActionJumpToObject (oTrans2Gen);
					}
				}
			}			
		}			
}
// action wrapper for SetLocalInt
void ActionSetLocalInt (object oNpc, string sVarName, int nValue)
{
SetLocalInt (oNpc, sVarName, nValue);
}

//interrupts normal heartbeat script execuation
//for cross area travel
void HeartbeatCheck (object oNpc)
{
int nCheck = GetTimeActivity (oNpc);
object oPC = GetFirstPC();
object oNpc = OBJECT_SELF;
object oWp1;
int nWwp;
	{switch (nCheck)
		{		
		case 26:
		nWwp = CheckWwpArea (oNpc);
		oWp1 = GetCurrentWwp (oNpc);
		if (GetArea (oNpc) != GetArea (oWp1)) {SetLocalInt (oNpc, "ud", 1);}
		if (nWwp == FALSE) {SetLocalInt (oNpc, "ud", 1);}
		if (nWwp == TRUE) {SetLocalInt (oNpc, "ud", 0);}
		break;
		case 27: case 40: case 41:
		SetLocalInt (oNpc, "ud", 0);
		break;
		default:
		oWp1 = GetCurrentWp (oNpc);
		if (GetArea (oNpc) != GetArea (oWp1)) {SetLocalInt (oNpc, "ud", 1);}
		if (GetArea (oNpc) != GetArea (oPC)) {SetLocalInt (oNpc, "ud", 1);}
		if ((GetArea (oNpc) == GetArea (oWp1)) && (GetArea (oNpc) == GetArea (oPC))) {SetLocalInt (oNpc, "ud", 0);}
		break;
		}
	}
}

//Experimental - Not currently used
object GetLeader (object oNpc)
{
int nLeaderFound = GetLocalInt (oNpc, "leaderfound");
if (nLeaderFound == 1) 
	{
	string sLeader = GetLocalString (oNpc, "leaderstring");
	object oTest = GetObjectByTag (sLeader);
	return oTest;
	}
object oArea = GetArea(oNpc);
object oTest = GetFirstObjectInArea (oArea);
string sResCheck = GetTag (oNpc);
string sResRef;
int nLeader;
while (oTest != OBJECT_INVALID)
		{
		sResRef = GetTag (oTest);
		nLeader = GetLocalInt (oTest, "lead");
		if ((sResRef == sResCheck) && (nLeader == 1))
			{
			string sLeader = GetTag (oTest);
			SetLocalString (oNpc, "leaderstring", sLeader);
			SetLocalInt (oNpc, "leaderfound", 1);
			return oTest;
			}
		oTest = GetNextObjectInArea (oArea);	
		}

return OBJECT_INVALID;
}

//checks through a NPC wp set for wwp's in same area as PC
int CheckWwpArea (object oNpc)	
{
object oPC = GetFirstPC();
string sNpc = GetTag (oNpc);
string sNpc2 = GetStringRight (sNpc,3);
int nWptag = GetLocalInt (oNpc,"wptag");
string sWptag = IntToString (nWptag);
object oWp1 = GetObjectByTag ("WP_"+(sNpc)+"_0"+IntToString(nWptag));
	while (oWp1 != OBJECT_INVALID)
		{
		oWp1 = GetObjectByTag ("WP_"+(sNpc)+"_0"+IntToString(nWptag));
		if (GetArea(oWp1) == GetArea (oPC)){return TRUE;}
		nWptag++;
		}
	return FALSE;	
}

//this function returns an object which meets the criteria
//object tag = string tag passed paramater
//object state is currently off //NPC will turn state to on
object GetInteractiveNight (object oNpc, string sTag)
{
object oArea = GetArea (oNpc);
object oInteractive = GetFirstObjectInArea (oArea);
string sCheck;
int nCheck;
	while (oInteractive != OBJECT_INVALID)
		{
		sCheck = GetTag (oInteractive);
		nCheck = GetLocalInt (oInteractive, "LightState");
		if ((sCheck == sTag) && (nCheck != 1))
			{return oInteractive;}
		oInteractive = GetNextObjectInArea (oArea);
		}
return OBJECT_INVALID;			
}

//this function returns an object which meets the criteria
//object tag = string tag passed paramater
//object state is currently on //NPC will turn state to off
object GetInteractiveDay (object oNpc, string sTag)
{
object oArea = GetArea (oNpc);
object oInteractive = GetFirstObjectInArea (oArea);
string sCheck;
int nCheck;
	while (oInteractive != OBJECT_INVALID)
		{
		sCheck = GetTag (oInteractive);
		nCheck = GetLocalInt (oInteractive, "LightState");
		if ((sCheck == sTag) && (nCheck != 0))
			{return oInteractive;}
		oInteractive = GetNextObjectInArea (oArea);
		}
return OBJECT_INVALID;			
}

//this function randomly generates conversation which
//is stored on the bar maid to be used throughout the
//order and fulfillment process
void  TakeOrder(object oNpc)
{
object oBartender = GetObjectByTag (GetLocalString (oNpc, "bartender"));
string sBartender = GetName (oBartender);
int nMultiple;
string sOrder1;
string sOrder2;
//Set these conversation strings for the bar maid to speak to the customer
//when asking if they want to order anything
    {switch (Random (6))//Bar Maid to customer first question
        {
        case 1: SetLocalString (oNpc, "query", "What can I get for you?"); break; 
        case 2: SetLocalString (oNpc, "query", "What'll you have?"); break;
        case 3: SetLocalString (oNpc, "query", "Do you need anything?"); break; 
        case 4: SetLocalString (oNpc, "query", "Another round?"); break; 
        case 5: SetLocalString (oNpc, "query", "Will you have the usual?"); break; 
        default: SetLocalString (oNpc, "query", "We have Thaylian red, black beer, golden mead, fruit wine, and Moorish whiskey"); break;
        } 
    }
//This is the random drink list part 1
//change this to whatever you want your custom drink list to contain
    {switch (Random (5))//Roll order part 1
        {
        case 1: sOrder1 = "Thaylian red"; SetLocalString (oNpc, "order1", sOrder1);break;  
        case 2: sOrder1 = "black beer"; SetLocalString (oNpc, "order1", sOrder1);break; 
        case 3: sOrder1 = "golden mead"; SetLocalString (oNpc, "order1", sOrder1);break; 
        case 4: sOrder1 = "fruit wine"; SetLocalString (oNpc, "order1", sOrder1);break;  
        default: sOrder1 = "Moorish whiskey"; SetLocalString (oNpc, "order1", sOrder1);break; 
        }
    }
//This is the random drink list part 2
//change this to whatever you want your custom drink list to contain
    {switch (Random(5))//Roll order part 2
        {
        case 4: sOrder2 = "Thaylian red"; SetLocalString (oNpc, "order2", sOrder2);break;  
        case 3: sOrder2 = "black beer"; SetLocalString (oNpc, "order2", sOrder2);break; 
        case 2: sOrder2 = "golden mead"; SetLocalString (oNpc, "order2", sOrder2);break; 
        case 1: sOrder2 = "fruit wine"; SetLocalString (oNpc, "order2", sOrder2);break;  
        default: sOrder2 = "Moorish whiskey"; SetLocalString (oNpc, "order2", sOrder2);break; 
        }  
    }
//customer order response concatenated with drink list order
    {switch (Random (6))//customer order to barmaid
        {
        case 1: 
        SetLocalInt (oNpc, "multiple", 1);
        if (sOrder1 == sOrder2)
            {SetLocalString (oNpc, "response1", " I'll have 2 "+sOrder1+"s");}
            else {SetLocalString (oNpc, "response1", "I'll have "+sOrder1+" and bring my friend some "+sOrder2);}
        break;    
        case 2: 		
        SetLocalInt (oNpc, "multiple", 1);
        if (sOrder1 == sOrder2)
            {SetLocalString (oNpc, "response1", " How about a couple of tankards of "+sOrder1);}
            else {SetLocalString (oNpc, "response1", "One "+sOrder1+" and one "+sOrder2);}
        break; 
        case 3: 		
        SetLocalInt (oNpc, "multiple", 1);
        if (sOrder1 == sOrder2)
            {SetLocalString (oNpc, "response1", " 2 orders of "+sOrder1);}
            else {SetLocalString (oNpc, "response1", "Ill have "+sOrder1+" and "+sOrder2+" for my partner");}
        break; 
        case 4:
        SetLocalInt (oNpc, "multiple", 0);
        SetLocalString (oNpc, "response1", "I'll take the "+sOrder1);
        break;
        case 5:
        SetLocalInt (oNpc, "multiple", 0);
        SetLocalString (oNpc, "response1", "I'd like "+sOrder1);
        break; 
        default:
        SetLocalInt (oNpc, "multiple", 0);
        SetLocalString (oNpc, "response1", "Bring me the "+sOrder1);
        break;               
        }
    }
//bar maid confirming order with customer
nMultiple = GetLocalInt (oNpc, "multiple");
    {switch (nMultiple) //Bar maid to customer on way to get order from bartender
        {
        default: //single order
            {switch (Random (3))
                {
                case 1:
                SetLocalString (oNpc, "response2", "One "+sOrder1+" coming right up");
                break;
                case 2:
                SetLocalString (oNpc, "response2", "I'll be right back with your "+sOrder1);
                break;
                default:
                SetLocalString (oNpc, "response2", sOrder1+" it is, give me just one minute to get it");
                break;
                }
            }
		break;	
        case 1: //multiple order
            {switch (Random (3))
                {
                case 1:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response2", "Two "+sOrder1+"s coming right up");}
                else {SetLocalString (oNpc, "response2", "One "+sOrder1+" and one "+sOrder2+" coming right up");} 
                break;    
                case 2:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response2", "It'll be just a minute for those "+sOrder1+"s");}
                    else {SetLocalString (oNpc, "response2", sOrder1+" and "+sOrder2+", I'll be right back");} 
                break;
                default:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response2", "Let me go get those "+sOrder1+"s for you");}
                    else {SetLocalString (oNpc, "response2", "I'll be just a minute");} 
                break;                                          
                }
            }
		break;	
        }
    }
//bar maid issuing order to bartender to be filled
    {switch (nMultiple)//Bar maid to Bartender
        {
        default: //single order
            {switch (Random (3))
                {
                case 1:
                SetLocalString (oNpc, "response3", "One "+sOrder1+" "+sBartender);
                break;
                case 2:
                SetLocalString (oNpc, "response3", sOrder1+" please");
                break;
                default:
                SetLocalString (oNpc, "response3", sOrder1+", and shake a leg");
                break;
                }
            }
		break;	
        case 1: //multiple order
            {switch (Random (3))
                {
                case 1:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response3", "Two "+sOrder1+"s "+sBartender);}
                    else {SetLocalString (oNpc, "response3", "One "+sOrder1+" and one "+sOrder2);} 
                break;    
                case 2:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response3", sBartender+", get me two "+sOrder1+"s");}
                    else {SetLocalString (oNpc, "response3", sOrder1+" and "+sOrder2);} 
                break;
                default:
                if (sOrder1 == sOrder2) 
                    {SetLocalString (oNpc, "response3", "Some thirsty people tonight, two "+sOrder1+"s");}
                    else {SetLocalString (oNpc, "response3", "One "+sOrder1+" and one "+sOrder2+" for the big spenders over there");} 
                break;                                          
                }
            }
		break;	
        }
    }
//bartender confirming order to be filled
	{switch (Random (3))//bartender to bar maid
		{
		case 1:
		SetLocalString (oNpc, "response4", "Got it!");
		break;
		case 2:
		SetLocalString (oNpc, "response4", "I'm on it");
		break;
		default:
		SetLocalString (oNpc, "response4", "Coming right up");
		}
	}
//bar maid delivering drinks to customer and assessing drink charges
	{switch (nMultiple)// bar maid to customer delivering drinks
		{
		case 1:
		if (sOrder1 == sOrder2) 
        	{SetLocalString (oNpc, "response5", "Two "+sOrder1+"s, that will be 8 coppers");}
			else
			{SetLocalString (oNpc, "response5", "One "+sOrder1+" and one "+sOrder2+" enjoy!  That will be 8 coppers");}
		break;
		default:
		SetLocalString (oNpc, "response5", "One "+sOrder1+", that will run 4 coppers today.");
		break;
		}
	}
//customer to bar maid after receiving drinks
	{switch (Random(4))//customer to bar maid
		{
		case 1:
		SetLocalString (oNpc, "response6", "Ahhh... that hits the spot thank you");
		break;
		case 2: 
		SetLocalString (oNpc, "response6", "Here you go, and a little extra for your speed");
		break;
		case 3:
		SetLocalString (oNpc, "response6", "MMM... this is good");	
		break;
		default:
		SetLocalString (oNpc, "response6", "If you see my cup starting to get empty, come on back OK?");
		break;
		}
	}
//bartender to bar maid after filling drink order from bar maid
	{switch (nMultiple)//bartender to bar maid after getting drinks
		{
		case 1:
		if (sOrder1 == sOrder2) 
        	{SetLocalString (oNpc, "response7", "Two "+sOrder1+"s");}
			else
			{SetLocalString (oNpc, "response7", "One "+sOrder1+" and one "+sOrder2);}
		break;
		default:
		SetLocalString (oNpc, "response7", "One "+sOrder1);
		break;
		}
	}
//random chatter from bar maid to bartender at rest
	{switch (Random (4))//Bar maid to bartender at rest
		{
		case 1: SetLocalString (oNpc, "response8", "That guy in the corner is about to get sick, he has had quite a bit of "+sOrder1);break;
		case 2: SetLocalString (oNpc, "response8", "The tips have been all right today");break;
		case 3: SetLocalString (oNpc, "response8", "OH, he's turning green. That "+sOrder1+" will get you every time.");break;	
		default: SetLocalString (oNpc, "response8", "This is a thirsty crowd");break;
		}
	}
//random chatter from bartender to bar maid at rest
	{switch (Random (4))//Bartender to bar maid at rest
		{
		case 1: SetLocalString (oNpc, "response9", "We are running a bit low on the "+sOrder2);break;
		case 2: SetLocalString (oNpc, "response9", "See if you can push the "+sOrder2);break;
		case 3: SetLocalString (oNpc, "response9", "Does this "+sOrder2+" smell all right to you?  It looks a little cloudy.");break;
		default: SetLocalString (oNpc, "response9", "If I have to listen to one more sob story from some guy liquored up on "+sOrder2+"...");break;
		}
	}			
}

//this function counts the current number of creatures in the area where the bar maid is operating
int GetCreatureCount(object oNpc)
{
object oNpc = OBJECT_SELF;
int nCount;
int nResult;
object oCount;
int nPatrons = GetLocalInt (oNpc,"patrons");
if (nPatrons != 0){return nPatrons;}
	else 
	{
	oCount = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNpc, nCount);
	while (oCount != OBJECT_INVALID)
		{
		nCount++;
		oCount = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oNpc, nCount);
		nResult = nCount;
		}
	SetLocalInt (oNpc, "patrons", nResult);
	return nResult;	
	}
}

//this function targets a customer that is not on the exclusion list
//it will try to target four times before returning an invalid object
object GetCustomer(object oNpc, int nPatrons)
{
object oExclude1 = GetObjectByTag (GetLocalString (oNpc, "exclude1"));
object oExclude2 = GetObjectByTag (GetLocalString (oNpc, "exclude2"));
object oExclude3 = GetObjectByTag (GetLocalString (oNpc, "exclude3"));
object oExclude4 = GetObjectByTag (GetLocalString (oNpc, "exclude4"));
object oExclude5 = GetObjectByTag (GetLocalString (oNpc, "exclude5"));
object oExclude6 = GetObjectByTag (GetLocalString (oNpc, "exclude6"));
object oExclude7 = GetObjectByTag (GetLocalString (oNpc, "exclude7"));
object oExclude8 = GetObjectByTag (GetLocalString (oNpc, "exclude8"));
object oExclude9 = GetObjectByTag (GetLocalString (oNpc, "exclude9"));
object oExclude10 = GetObjectByTag (GetLocalString (oNpc, "exclude10"));
int nRandom = Random(nPatrons);
object oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
    if (oCustomer !=  OBJECT_SELF && oCustomer != oExclude1 && oCustomer != oExclude2 && oCustomer != oExclude3 && oCustomer != oExclude4 && oCustomer != oExclude5
	&& oCustomer != oExclude6 && oCustomer != oExclude7 && oCustomer != oExclude8 && oCustomer != oExclude9 && oCustomer != oExclude10)
		{if (GetIsObjectValid (oCustomer) == TRUE)
			{return oCustomer;}}
nRandom = Random(nPatrons);	
    if (oCustomer !=  OBJECT_SELF && oCustomer != oExclude1 && oCustomer != oExclude2 && oCustomer != oExclude3 && oCustomer != oExclude4 && oCustomer != oExclude5
	&& oCustomer != oExclude6 && oCustomer != oExclude7 && oCustomer != oExclude8 && oCustomer != oExclude9 && oCustomer != oExclude10)
		{if (GetIsObjectValid (oCustomer) == TRUE)
			{return oCustomer;}}	
nRandom = Random(nPatrons);	
oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
    if (oCustomer !=  OBJECT_SELF && oCustomer != oExclude1 && oCustomer != oExclude2 && oCustomer != oExclude3 && oCustomer != oExclude4 && oCustomer != oExclude5
	&& oCustomer != oExclude6 && oCustomer != oExclude7 && oCustomer != oExclude8 && oCustomer != oExclude9 && oCustomer != oExclude10)
		{if (GetIsObjectValid (oCustomer) == TRUE)
			{return oCustomer;}}	
nRandom = Random(nPatrons);	
oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
    if (oCustomer !=  OBJECT_SELF && oCustomer != oExclude1 && oCustomer != oExclude2 && oCustomer != oExclude3 && oCustomer != oExclude4 && oCustomer != oExclude5
	&& oCustomer != oExclude6 && oCustomer != oExclude7 && oCustomer != oExclude8 && oCustomer != oExclude9 && oCustomer != oExclude10)
		{if (GetIsObjectValid (oCustomer) == TRUE)
			{return oCustomer;}}
SetLocalInt (oNpc, "barmaid", 7);							
return OBJECT_INVALID;
}

//this function checks the customer area verses the bar maid
//area and resets the bar maid if the customer is not in the area
void AreaCheck (object oCustomer, object oNpc)
{
if (GetArea (oCustomer) != GetArea (oNpc))
	{
	DeleteLocalInt (oNpc, "barmaid");
	DeleteLocalObject (oNpc, "customer");
	SetLocalInt (oNpc,"patrons", 0);
	}
}
//void main(){}