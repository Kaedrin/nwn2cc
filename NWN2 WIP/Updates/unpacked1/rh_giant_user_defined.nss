//::///////////////////////////////////////////////
/*	
	rh_giant_user_defined

Risen Hero Giant Boulder Throwing User Defined Events
Placed on giants user defined script 
needs rh_giant_spawn on On Spawn script

Checks for hostile creature and throws boulder 
Must be between 10' to 150' (3m to 45.7m)  from giant

Written by Shaughn

Thanks to: 
-Dirtywick and his house of scripting on BouncyRock Entertainment
http://forum.bouncyrock.com/viewforum.php?f=22
-Dorateen for play testing.


*/
//:://////////////////////////////////////////////

#include "ginc_combat"
#include "ginc_ai"
#include "rh_giant_boulder_throw"

void main()
{
    // enter desired behaviour here
	
	
	int nEvent = GetUserDefinedEventNumber();
	int iTimes = GetLocalInt(OBJECT_SELF,"boulder_times");
	int iRock  = GetLocalInt(OBJECT_SELF,"boulder_attack");
	//Used to check if boulder throw used in current combat round. 
	//1 boulder attack per round, Reset at end of combat round
	
	switch( nEvent )
	{
		case EVENT_PERCEIVE:
		{
			//Do I need a spot and listen check if PC is hidden?
			
			object oPrec	=	GetLastPerceived();
			location lPrec	=	GetLocation(oPrec);
			float fDist		=	GetDistanceBetween(OBJECT_SELF,oPrec);
			
			if (GetLastPerceptionSeen() || GetLastPerceptionHeard())
			{
			if (GetIsEnemy(oPrec) && iRock != 1)
			{
				if(fDist >= 3.0 && iTimes < 3)
				{
					ClearAllActions(TRUE);
					//SuspendAI(OBJECT_SELF,FALSE,0.0);
					AIIgnoreCombat(OBJECT_SELF);
					SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
					BoulderThrow(lPrec);
					SetLocalInt(OBJECT_SELF,"boulder_attack",1);
					break;
				}
				else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			}
			}
			else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			break;
			
		}
		
		case EVENT_ATTACKED:
		{
		
			object oAtt		=	GetLastAttacker();
			location lAtt	=	GetLocation(oAtt);
			float fDist		=	GetDistanceBetween(OBJECT_SELF,oAtt);
			
			if (GetIsEnemy(oAtt)  && iRock != 1)
			{
				if(fDist >= 3.0 && iTimes < 3)
				{
					ClearAllActions(TRUE);
					//SuspendAI(OBJECT_SELF,FALSE,0.0);
					AIIgnoreCombat(OBJECT_SELF);
					SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
					BoulderThrow(lAtt);
					SetLocalInt(OBJECT_SELF,"boulder_attack",1);
					break;
				}
				else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			}
			else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			break;	
		}
		
		case EVENT_DAMAGED:
		{
			object oDam		=	GetLastDamager();
			location lDam	=	GetLocation(oDam);
			float fDist		=	GetDistanceBetween(OBJECT_SELF,oDam);
			
			if (GetIsEnemy(oDam) && iRock != 1)
			{
				if(fDist >= 3.0 && iTimes < 3)
				{
					ClearAllActions(TRUE);
					//SuspendAI(OBJECT_SELF,FALSE,0.0);
					AIIgnoreCombat(OBJECT_SELF);
					SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
					BoulderThrow(lDam);
					SetLocalInt(OBJECT_SELF,"boulder_attack",1);
					break;
				}
				else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			}
			else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			break;
		}
		
		case EVENT_END_COMBAT_ROUND:
		{
			object oLast	=	GetAttackTarget(OBJECT_SELF);
			SetLocalInt(OBJECT_SELF,"boulder_attack",0);//resets boulder attack for 1 per round
			if (GetIsObjectValid(oLast))
			{
			   	location lLast	=	GetLocation(oLast);
				float fDist		=	GetDistanceBetween(OBJECT_SELF,oLast);
			
				if (GetIsEnemy(oLast))
				{
					if(fDist >= 3.0 && iTimes < 3)
					{
						ClearAllActions(TRUE);
						//SuspendAI(OBJECT_SELF,FALSE,0.0);
						AIIgnoreCombat(OBJECT_SELF);
						SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
						BoulderThrow(lLast);
						SetLocalInt(OBJECT_SELF,"boulder_attack",1);
						break;
					}
					else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
				
				}	
			}
			else
			{
				int nNth = 1;
				oLast = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, OBJECT_SELF, nNth);
				while (GetIsObjectValid(oLast))
				{
					location lLast	=	GetLocation(oLast);
					float fDist		=	GetDistanceBetween(OBJECT_SELF,oLast);
					if (GetIsEnemy(oLast) && fDist <=45.7)
					{
						if(fDist >= 3.0 && iTimes < 3 )
						{
							ClearAllActions(TRUE);
							//SuspendAI(OBJECT_SELF,FALSE,0.0);
							AIIgnoreCombat(OBJECT_SELF);
							SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
							BoulderThrow(lLast);
							SetLocalInt(OBJECT_SELF,"boulder_attack",1);
							break;
						}
					nNth++;
					oLast = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, OBJECT_SELF, nNth);
					}
				}
				if(GetLocalInt(OBJECT_SELF,"boulder_attack") == 0)
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);	
				}
			}
		
			break;
		}
		case EVENT_SPELL_CAST_AT:
		{
			object oCast	=	GetLastSpellCaster();
			location lCast	=	GetLocation(oCast);
			float fDist		=	GetDistanceBetween(OBJECT_SELF,oCast);
			
			if (GetIsEnemy(oCast)  && iRock != 1)
			{
				if(fDist >= 3.0 && iTimes < 3)
				{
					ClearAllActions(TRUE);
					//SuspendAI(OBJECT_SELF,FALSE,0.0);
					AIIgnoreCombat(OBJECT_SELF);
					SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
					BoulderThrow(lCast);
					SetLocalInt(OBJECT_SELF,"boulder_attack",1);
					break;
				}
				else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			}
			else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			break;
		}
		
		case EVENT_HEARTBEAT:
		{
			if(GetIsInCombat(OBJECT_SELF) && iRock != 1 && iTimes < 3)
			{
				int    nNth		=	1;
				int nDone		=	0;
				object oTarget	=	 GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, OBJECT_SELF, nNth);
				float fDist;
				location lTarget;
				
				while (GetIsObjectValid(oTarget) || nDone != 1)
				{
					if (GetIsReactionTypeHostile(oTarget,OBJECT_SELF))
					{
					nDone =1;
					}
					nNth++;
					oTarget	=	GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, OBJECT_SELF, nNth);
					fDist	=	GetDistanceBetween(oTarget,OBJECT_SELF);
				}
			
				if(nDone == 1 && fDist >= 3.0 && fDist <=45.7)
				{
					lTarget	=	GetLocation(oTarget);	
					ClearAllActions(TRUE);
					//SuspendAI(OBJECT_SELF,FALSE,0.0);
					AIIgnoreCombat(OBJECT_SELF);
					SetLocalInt(OBJECT_SELF,"boulder_times",iTimes+1);
					BoulderThrow(lTarget);
					SetLocalInt(OBJECT_SELF,"boulder_attack",1);
					break;
				} 
				else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
			}
			else
				{
					//ResumeAI(OBJECT_SELF);
					AIResetType(OBJECT_SELF);
				}
				
		break;
		}
	}
}
				
	
	