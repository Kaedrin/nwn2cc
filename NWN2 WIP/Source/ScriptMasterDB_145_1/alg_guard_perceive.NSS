//::///////////////////////////////////////////////
//:: dw_weaponcheck
//:://////////////////////////////////////////////
/*
Guard will warn player with weapon in hand to put it away.
After a few warnings the guard will attack the offending player.
Adapted from a script by David Corrales. This script will not cause the
guards to be bothered by magic staves.
*/
//:://////////////////////////////////////////////
//:: Created By: Dreamwarder
//:: Created On: 3 May 2004
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF);
object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);


//VARIABLES START HERE

//The first warning a guard will give - edit the text between "" as desired.
string WARNING1 = "Please put away your weapon";
string WARNING1a = "We do not allow the display of weapons.";
string WARNING1b = "Sheath and peace knot your weapon.";
string WARNING1c = "Shadowdale does not allow people walking about armed.";


//The second warning - edit as above
string WARNING2 = "I said put away your weapon!";
string WARNING2a = "Are you deaf?";
string WARNING2b = "Put it away before I do it for you!";
string WARNING2c = "I am in no mood for foolishness today, put your weapon away!";


//The third warning
string WARNING3 = "The law still stands here I won't warn you again!";//Move to Player
string WARNING3a = "We don't tolerate this sort of thing!";
string WARNING3b = "Unless you never wish to see the light of day again..put your weapon away!";
string WARNING3c = "Do not tempt me further!";


//The Battlecry
string 	ATTACK_MSG = "Pay for your folly!Rot in jail!";//Attack here
string 	ATTACK_MSG2 = "You insolant fool, it's a cell for you!";
string 	ATTACK_MSG3 = "Then choose jail!";
string 	ATTACK_MSG4 = "So be it, the cell for you!";


//What the guard says when the PC puts their weapon away.
string 	COMPLY_REPLY = "Good you understand the need for laws.";

float	WARN_DISTANCE = 20.0;//Distance in which to spot player
float  	ANGER_DUR = 120.0; //Length of time (sec) that will remain angry at the pc
//END OF VARIABLES

void main()
{
    object oPC;
    object item;
	


	oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF);

	if(oPC != OBJECT_INVALID && (GetDistanceBetween(OBJECT_SELF,oPC) < WARN_DISTANCE) && GetObjectSeen(oPC) && !GetIsEnemy(oPC))
    {

            if (GetItemPossessedBy(oPC, "zhent")!= OBJECT_INVALID)
			{

            }
             //If the pc is holding anyhting other than a Wizard's staff in his right hand then the guard will shout at him to put his weapon away.
            else if(
					((item = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))!=OBJECT_INVALID) 
					 && 
					(GetBaseItemType(item)!=BASE_ITEM_MAGICSTAFF)
					 &&
					(GetBaseItemType(item)!=BASE_ITEM_QUARTERSTAFF)
					 &&
					(GetWeaponType(item)!= WEAPON_TYPE_NONE)
				   )
            {
                if(GetLocalObject(OBJECT_SELF,"LastOffender")==oPC)
                {
                    if(GetLocalInt(OBJECT_SELF,"OffenseCount")==2)
                    {
					   object oTarget;
				  	   location lTarget;
					   oTarget = GetWaypointByTag("WP_hasweapon");
				       lTarget = GetLocation(oTarget);
					   	
					   object oPost;
				  	   location lPost;
					   oPost = GetWaypointByTag("POST_bd_sd_zent1a");
					   lPost = GetLocation(oPost);
					   	
					   int nAttack = d4();
					   switch (nAttack)
					   {
					   case 1: 
					    SpeakString(ATTACK_MSG);
						AssignCommand(oPC, ClearAllActions());
						DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
						DelayCommand(20.0, ActionMoveToLocation(lPost));
						
						//SetIsTemporaryEnemy(oPC,OBJECT_SELF,TRUE,ANGER_DUR);
                       	// ActionAttack(oPC);
						break;
						case 2:
						SpeakString(ATTACK_MSG2);
						AssignCommand(oPC, ClearAllActions());
						DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
						//	SetIsTemporaryEnemy(oPC,OBJECT_SELF,TRUE,ANGER_DUR);
                       	// ActionAttack(oPC);
						break;
						case 3:
						SpeakString(ATTACK_MSG3);
						AssignCommand(oPC, ClearAllActions());
						DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
						//SetIsTemporaryEnemy(oPC,OBJECT_SELF,TRUE,ANGER_DUR);
                       	// ActionAttack(oPC);
						break;
						case 4:
						SpeakString(ATTACK_MSG4);
						AssignCommand(oPC, ClearAllActions());
						DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
						//SetIsTemporaryEnemy(oPC,OBJECT_SELF,TRUE,ANGER_DUR);
                       	// ActionAttack(oPC);
						break;
                        }
						
						 
                    }
                    else if(GetLocalInt(OBJECT_SELF,"OffenseCount")==1)
                    {
                       object oPost;
				  	   location lPost;
					   oPost = GetWaypointByTag("POST_bd_sd_zent1a");
					   lPost = GetLocation(oPost);
					   
					    ActionMoveToObject(oPC,TRUE);
                        DelayCommand(10.0, SetLocalInt(OBJECT_SELF,"OffenseCount",2));
						DelayCommand(40.0, ActionMoveToLocation(lPost));
						int nWarn3 = d4();
					    switch (nWarn3)
						 {
						case 1:
					    SpeakString(WARNING3);
						break;
						case 2:
					    SpeakString(WARNING3a);
						break;
						case 3:
					    SpeakString(WARNING3b);
						break;
						case 4:
					    SpeakString(WARNING3c);
						break;
						}
						
                    }
                    else
                    {
                        DelayCommand(10.0, SetLocalInt(OBJECT_SELF,"OffenseCount",1));
						int nWarn2 = d4();
					    switch (nWarn2)
						{
						case 1:
                        SpeakString(WARNING2);
						break;
						case 2:
                        SpeakString(WARNING2a);
						break;
						case 3:
                        SpeakString(WARNING2b);
						break;
						case 4:
                        SpeakString(WARNING2c);
						break;
						}
                    }
                }
                else
                {
                      	DelayCommand(10.0, SetLocalInt(OBJECT_SELF,"OffenseCount",0));
					  	int nWarn1 = d4();
					    switch (nWarn1)
						{
							case 1:
                        		SpeakString(WARNING1);
								break;
							case 2:
                        		SpeakString(WARNING1a);
								break;
							case 3:
                        		SpeakString(WARNING1b);
								break;
							case 4:
                        		SpeakString(WARNING1c);
								break;
						}
                      
                      SetLocalObject(OBJECT_SELF,"LastOffender",oPC);
                }
             }
             else
             {
                    if( GetLocalObject(OBJECT_SELF,"LastOffender")!= OBJECT_INVALID)
                        
						SpeakString(COMPLY_REPLY);
                        DeleteLocalObject(OBJECT_SELF,"LastOffender");
                        SetLocalInt(OBJECT_SELF,"OffenseCount",0);
						
					 
             }
        }

    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        if(TalentAdvancedBuff(40.0))
        {
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
            return;
        }
    }

    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        int nDay = FALSE;
        if(GetIsDay() || GetIsDawn())
        {
            nDay = TRUE;
        }
        if(GetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT") != nDay)
        {
            if(nDay == TRUE)
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", TRUE);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", FALSE);
            }
            WalkWayPoints();
        }
    }

    if(!GetHasEffect(EFFECT_TYPE_SLEEP))
    {
       
	 
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                {
                    if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) && !IsInConversation(OBJECT_SELF))
                    {
                        if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetIsEncounterCreature() &&
                        !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS) &&
                           !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayImmobileAmbientAnimations();
                        }
                    }
                    else
                    {
                        DetermineSpecialBehavior();
                    }
                }
                else
                {
                    //DetermineCombatRound();
                }
            }
        }
    }
    else
    {
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }

    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
}