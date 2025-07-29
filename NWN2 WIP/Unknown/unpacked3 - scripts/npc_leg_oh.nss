//////////////////////////
//NPC Control 1.4
//HB script
//Uncle FB 05/09
//Use HB script npc_default1 instead
//if you want to use ambient behavior
//////////////////////////
#include "npc_activinc"
#include "npc_include"

void main()
{
object oPC = GetFirstPC();
object oNpc = OBJECT_SELF;
object oMod = GetModule();
GlobalSet (oMod);
AreaTransition(oNpc);
HeartbeatCheck (oNpc);
int nUd = GetLocalInt(oNpc, "ud");
if (nUd == 1) {return;}
if (IsInConversation(oNpc) == TRUE){return;}
int nSpeak = (0);
int nReset = GetLocalInt (oNpc, "reset");
object oWp1 = GetCurrentWp (oNpc);
VariableSwitcher (oNpc, oWp1, nReset);
int nSwitch = GetTimeActivity (oNpc);
	{switch (nSwitch)
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
	case 40: NpcLightKeeper (oNpc, oWp1, nSpeak); break;
	case 41: NpcBarmaid (oNpc, oWp1); break;
	case 42: NpcBartender (oNpc, oWp1); break;
	case 200: break;//reserved for ambient animations
	case 91: LocateWrapper (oNpc,oWp1,0,0,0,0,1,28,22,0,1,1); break;
	case 92: LocateWrapper (oNpc,oWp1,0,0,1,28,1,28,22,1,0,1); break;
	case 93: LocateWrapper (oNpc,oWp1,1,28,1,28,1,12,22,0,1,1); break;
	case 94: LocateWrapper (oNpc,oWp1,1,28,1,28,1,28,23,0,0,1); break;
	case 95: LocateWrapper (oNpc,oWp1,1,7,1,7,1,7,20,0,0,1); break;
	case 96: LocateWrapper (oNpc,oWp1,1,7,1,7,1,7,10,0,0,1); break;	
	case 97: LocateWrapper (oNpc,oWp1,1,33,1,33,1,0,33,1,1,0); break;
	case 98: LocateWrapper (oNpc,oWp1,0,0,0,0,1,11,10,0,1,0); break;
	default: NpcDisarm (oNpc); NpcMeditate (oNpc, oWp1, nSpeak); break;
	}
}
}	