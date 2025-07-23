////////////////////////////////////////////////////////////////////////////////
// dmfi_inc_emotes - DM Friendly Initiative - Code to run all 'emotes'
// Original Scripter:  Demetrious      Design: DMFI Design Team
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           11/11/6
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

#include "dmfi_inc_inc_com"
#include "dmfi_inc_const"

// FILE: dmfi_inc_emotes
// Runs code for DMFI Emotes.  It will return a pass regardless right now.
int DMFI_RunEmotes(object oTool, object oSpeaker, string sOriginal)
{
    int nAnim=-1; 
	string sSkill;
	int nChat = -1;
    object oHand;

    string sHeard = GetStringLowerCase(sOriginal);
    
	     if (FindSubString(sHeard, EMT_ABL_STRENGTH) != -1)       { sSkill = EMT_ABL_STRENGTH;}
    else if (FindSubString(sHeard, EMT_ABL_DEXTERITY) != -1)      { sSkill = EMT_ABL_DEXTERITY;}
    else if (FindSubString(sHeard, EMT_ABL_CONSTITUTION) != -1)   { sSkill = EMT_ABL_CONSTITUTION;}
    else if (FindSubString(sHeard, EMT_ABL_INTELLIGENCE) != -1)   { sSkill = EMT_ABL_INTELLIGENCE;}
    else if (FindSubString(sHeard, EMT_ABL_WISDOM) != -1)         { sSkill = EMT_ABL_WISDOM;}
    else if (FindSubString(sHeard, EMT_ABL_CHARISMA) != -1)       { sSkill = EMT_ABL_CHARISMA;}

    else if (FindSubString(sHeard, EMT_SAVE_FORTITUDE) != -1)     { sSkill = EMT_SAVE_FORTITUDE;}
    else if (FindSubString(sHeard, EMT_SAVE_REFLEX) != -1)        { sSkill = EMT_SAVE_REFLEX;}
    else if (FindSubString(sHeard, EMT_SAVE_WILL) != -1)          { sSkill = EMT_SAVE_WILL;}

    else if (FindSubString(sHeard, EMT_SKL_APPRAISE) != -1)       { sSkill = EMT_SKL_APPRAISE ;}
    else if (FindSubString(sHeard, EMT_SKL_BLUFF) != -1)          { sSkill = EMT_SKL_BLUFF;}
    else if (FindSubString(sHeard, EMT_SKL_CONCENTRATION) != -1)  { sSkill = EMT_SKL_CONCENTRATION;}
    else if (FindSubString(sHeard, EMT_SKL_CRAFT_ARMOR) != -1)    { sSkill = EMT_SKL_CRAFT_ARMOR ;}
    else if (FindSubString(sHeard, EMT_SKL_CRAFT_TRAP) != -1)     { sSkill = EMT_SKL_CRAFT_TRAP;}
    else if (FindSubString(sHeard, EMT_SKL_CRAFT_WEAPON) != -1)   { sSkill = EMT_SKL_CRAFT_WEAPON;}
    else if (FindSubString(sHeard, EMT_SKL_DISABLE_TRAP) != -1)   { sSkill = EMT_SKL_DISABLE_TRAP;}
    else if (FindSubString(sHeard, EMT_SKL_DISCIPLINE) != -1)     { sSkill = EMT_SKL_DISCIPLINE;}
    else if (FindSubString(sHeard, EMT_SKL_HEAL) != -1)           { sSkill = EMT_SKL_HEAL;}
    else if (FindSubString(sHeard, EMT_SKL_HIDE) != -1)           { sSkill = EMT_SKL_HIDE;}
    else if (FindSubString(sHeard, EMT_SKL_INTIMIDATE) != -1)     { sSkill = EMT_SKL_INTIMIDATE;}
    else if (FindSubString(sHeard, EMT_SKL_LISTEN) != -1)         { sSkill = EMT_SKL_LISTEN;}
    else if (FindSubString(sHeard, EMT_SKL_LORE) != -1)           { sSkill = EMT_SKL_LORE;}
    else if (FindSubString(sHeard, EMT_SKL_MOVE_SILENTLY) != -1)  { sSkill = EMT_SKL_MOVE_SILENTLY;}
    else if (FindSubString(sHeard, EMT_SKL_OPEN_LOCK) != -1)      { sSkill = EMT_SKL_OPEN_LOCK;}
    else if (FindSubString(sHeard, EMT_SKL_PARRY) != -1)          { sSkill = EMT_SKL_PARRY;}
    else if (FindSubString(sHeard, EMT_SKL_PERFORM) != -1)        { sSkill = EMT_SKL_PERFORM;}
    else if (FindSubString(sHeard, EMT_SKL_SEARCH) != -1)         { sSkill = EMT_SKL_SEARCH;}
    else if (FindSubString(sHeard, EMT_SKL_SET_TRAP) != -1)       { sSkill = EMT_SKL_SET_TRAP;}
    else if (FindSubString(sHeard, EMT_SKL_SPELLCRAFT) != -1)     { sSkill = EMT_SKL_SPELLCRAFT;}
    else if (FindSubString(sHeard, EMT_SKL_SPOT) != -1)           { sSkill = EMT_SKL_SPOT;}
    else if (FindSubString(sHeard, EMT_SKL_TAUNT) != -1)          { sSkill = EMT_SKL_TAUNT;}
    else if (FindSubString(sHeard, EMT_SKL_TUMBLE) != -1)         { sSkill = EMT_SKL_TUMBLE;}
    else if (FindSubString(sHeard, EMT_SKL_USE_MAGIC_DEVICE) != -1) { sSkill = EMT_SKL_USE_MAGIC_DEVICE;}
	
	else if (FindSubString(sHeard, EMT_SKL_DIPLOMACY) != -1)      { sSkill = EMT_SKL_DIPLOMACY;}
	else if (FindSubString(sHeard, EMT_SKL_SURVIVAL) != -1)       { sSkill = EMT_SKL_SURVIVAL;}
	else if (FindSubString(sHeard, EMT_SKL_SLEIGHT_OF_HAND) != -1){ sSkill = EMT_SKL_SLEIGHT_OF_HAND;}
	else if (FindSubString(sHeard, EMT_SKL_CRAFT_ALCHEMY) != -1)  { sSkill = EMT_SKL_CRAFT_ALCHEMY;}
	
    if (sSkill!="")  DMFI_RollCheck(oSpeaker, sSkill, DMFI_GetIsDM(oSpeaker), oSpeaker, oTool);

	//*Animation Emotes*  
	else if (FindSubString(sHeard, EMT_BOX)!=-1)
    {
        if ((FindSubString(sHeard, EMT_CARRY)!=-1) || (FindSubString(sHeard, EMT_MOVE)!=-1) ||(FindSubString(sHeard, EMT_LOAD)!=-1))
            nAnim = ANIMATION_LOOPING_BOXCARRY;
        else if ((FindSubString(sHeard, EMT_HURRY)!=-1) || (FindSubString(sHeard, EMT_HURRI)!=-1))
            nAnim = ANIMATION_LOOPING_BOXHURRIED;
        else
            nAnim = ANIMATION_LOOPING_BOXIDLE;
    }	
	else if (FindSubString(sHeard, EMT_GUITAR)!=-1)
    {
        if ((FindSubString(sHeard, EMT_PLAY)!=-1) || (FindSubString(sHeard, EMT_SING)!=-1) || (FindSubString(sHeard, EMT_SONG)!=-1))
            nAnim = ANIMATION_LOOPING_GUITARPLAY;
        else if ((FindSubString(sHeard, EMT_FIDGET)!=-1) || (FindSubString(sHeard, EMT_MESS)!=-1) || (FindSubString(sHeard, EMT_TINKER)!=-1))
            nAnim = ANIMATION_FIREFORGET_GUITARIDLEFIDGET;
        else
            nAnim = ANIMATION_LOOPING_GUITARIDLE;
    }
    else if (FindSubString(sHeard, EMT_FLUTE)!=-1)
    {
        if ((FindSubString(sHeard, EMT_PLAY)!=-1) || (FindSubString(sHeard, EMT_SING)!=-1) || (FindSubString(sHeard, EMT_SONG)!=-1))
            nAnim = ANIMATION_LOOPING_FLUTEPLAY;
        else if ((FindSubString(sHeard, EMT_FIDGET)!=-1) || (FindSubString(sHeard, EMT_MESS)!=-1) || (FindSubString(sHeard, EMT_TINKER)!=-1))
            nAnim = ANIMATION_FIREFORGET_FLUTEIDLEFIDGET;
        else
            nAnim = ANIMATION_LOOPING_FLUTEIDLE;
    }
    else if (FindSubString(sHeard, EMT_DRUM)!=-1)
    {
        if ((FindSubString(sHeard, EMT_PLAY)!=-1) || (FindSubString(sHeard, EMT_SING)!=-1) || (FindSubString(sHeard, EMT_SONG)!=-1))
            nAnim = ANIMATION_LOOPING_DRUMPLAY;
        else if ((FindSubString(sHeard, EMT_FIDGET)!=-1) || (FindSubString(sHeard, EMT_MESS)!=-1) || (FindSubString(sHeard, EMT_TINKER)!=-1))
            nAnim = ANIMATION_FIREFORGET_DRUMIDLEFIDGET;
        else
            nAnim = ANIMATION_LOOPING_DRUMIDLE;
    }
	else if (FindSubString(sHeard, EMT_KNEEL)!=-1)
    {
        if ((FindSubString(sHeard, EMT_FIDGET)!=-1) ||(FindSubString(sHeard, EMT_MESS)!=-1)||(FindSubString(sHeard, EMT_TINKER)!=-1))
            nAnim = ANIMATION_FIREFORGET_KNEELFIDGET;
        else if ((FindSubString(sHeard, EMT_TALK)!=-1)|| (FindSubString(sHeard, EMT_SPEAK)!=-1)|| (FindSubString(sHeard, EMT_TELLS)!=-1))
            nAnim = ANIMATION_FIREFORGET_KNEELTALK;
        else if ((FindSubString(sHeard, EMT_INJURE)!=-1)|| (FindSubString(sHeard, EMT_HURT)!=-1))
            nAnim = ANIMATION_FIREFORGET_KNEELDAMAGE;
        else if ((FindSubString(sHeard, EMT_DIE)!=-1)|| (FindSubString(sHeard, EMT_DEATH)!=-1))
            nAnim = ANIMATION_FIREFORGET_KNEELDEATH;
        else
            nAnim = ANIMATION_LOOPING_KNEELIDLE;
    }
	else if (FindSubString(sHeard, EMT_LOOK)!=-1)
    {
        if (FindSubString(sHeard, EMT_UP)!=-1)
            nAnim = ANIMATION_LOOPING_LOOKUP;
        else if (FindSubString(sHeard, EMT_DOWN)!=-1)
            nAnim = ANIMATION_LOOPING_LOOKDOWN;
        else if (FindSubString(sHeard, EMT_LEFT)!=-1)
            nAnim = ANIMATION_LOOPING_LOOKLEFT;
        else if (FindSubString(sHeard, EMT_RIGHT)!=-1)
            nAnim = ANIMATION_LOOPING_LOOKRIGHT;
		else if (FindSubString(sHeard, EMT_FAR)!=-1)
			nAnim = ANIMATION_LOOPING_LOOK_FAR;	
    }
	else if (FindSubString(sHeard, EMT_LAY)!=-1)
    {
        if ((FindSubString(sHeard, EMT_DOWN)!=-1) || (FindSubString(sHeard, EMT_BACK)!=-1))
            nAnim = ANIMATION_FIREFORGET_LAYDOWN;
    }
	else if (FindSubString(sHeard, EMT_FALL)!= -1)
	{
		if (FindSubString(sHeard, EMT_BACK)!= -1)
        	nAnim = ANIMATION_LOOPING_DEAD_BACK;
		else if (FindSubString(sHeard, EMT_FORWARD)!=-1)
			nAnim =	ANIMATION_LOOPING_DEAD_FRONT;
	}		
			
	else if (FindSubString(sHeard, EMT_BOW) != -1 || FindSubString(sHeard, EMT_CURTSEY) != -1)
        nAnim = ANIMATION_FIREFORGET_BOW;
    else if (FindSubString(sHeard, EMT_DRINK) != -1 || FindSubString(sHeard, EMT_SIP) != -1)
        nAnim = ANIMATION_FIREFORGET_DRINK;
    else if (FindSubString(sHeard, EMT_YAWN)!= -1 ||  FindSubString(sHeard, EMT_STRETCH) != -1 || FindSubString(sHeard, EMT_BORED) != -1 || FindSubString(sHeard, EMT_LETS_GO) !=-1)
    {
	    nAnim = ANIMATION_FIREFORGET_PAUSE_BORED;
    	nChat = VOICE_CHAT_BORED;
	}	
	else if (FindSubString(sHeard, EMT_SCRATCH)!= -1)
        nAnim = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
    else if (FindSubString(sHeard, EMT_READ)!= -1 || FindSubString(sHeard, EMT_BOOK)!=-1 || FindSubString(sHeard, EMT_PAPER)!=-1)
        nAnim = ANIMATION_FIREFORGET_READ;
    else if (FindSubString(sHeard, EMT_SALUTE)!= -1)
        nAnim = ANIMATION_FIREFORGET_SALUTE;
    else if (FindSubString(sHeard, EMT_STEAL)!= -1 || FindSubString(sHeard, EMT_SWIPE) != -1)
        nAnim = ANIMATION_FIREFORGET_STEAL;
    else if (FindSubString(sHeard, EMT_MOCK) != -1)
    {
	    nAnim = ANIMATION_FIREFORGET_TAUNT;
    	nChat = VOICE_CHAT_TAUNT;
	}	
	else if ((FindSubString(sHeard, EMT_CHEER)!= -1) || (FindSubString(sHeard, EMT_HOORAY)!= -1) || (FindSubString(sHeard, EMT_CELEBRATE)!= -1))
    {
	    nAnim = ANIMATION_FIREFORGET_VICTORY1;
    	nChat = VOICE_CHAT_CHEER;
	}	
	else if (FindSubString(sHeard, EMT_FLOP)!= -1)
        nAnim = ANIMATION_LOOPING_DEAD_FRONT;
    else if (FindSubString(sHeard, EMT_BEND)!= -1 || FindSubString(sHeard, EMT_STOOP)!= -1)
        nAnim = ANIMATION_LOOPING_GET_LOW;
    else if (FindSubString(sHeard, EMT_FIDDLE)!= -1)
        nAnim = ANIMATION_LOOPING_GET_MID;
    else if (FindSubString(sHeard, EMT_NOD)!= -1 || FindSubString(sHeard, EMT_AGREE)!= -1)
        nAnim = ANIMATION_LOOPING_LISTEN;
    else if (FindSubString(sHeard, EMT_PEER)!= -1 || FindSubString(sHeard, EMT_SCAN)!= -1)
        nAnim = ANIMATION_LOOPING_LOOK_FAR;
    else if (FindSubString(sHeard, EMT_PRAY)!= -1 || FindSubString(sHeard, EMT_MEDITATE)!= -1)
        nAnim = ANIMATION_LOOPING_MEDITATE;
    else if (FindSubString(sHeard, EMT_DRUNK)!= -1 || FindSubString(sHeard, EMT_WOOZY)!= -1 || FindSubString(sHeard, EMT_SWAY)!= -1)
        nAnim = ANIMATION_LOOPING_PAUSE_DRUNK;
    else if (FindSubString(sHeard, EMT_TIRED)!= -1 || FindSubString(sHeard, EMT_FATIGUE)!= -1 || FindSubString(sHeard, EMT_EXHAUSTED)!= -1 || FindSubString(sHeard, EMT_REST)!=-1)
    {
	    nAnim = ANIMATION_LOOPING_PAUSE_TIRED;
    	nChat = VOICE_CHAT_REST;
	}	
	else if (FindSubString(sHeard, EMT_DEMAND)!= -1 || FindSubString(sHeard, EMT_THREATEN)!= -1)
    {
	    nAnim = ANIMATION_LOOPING_TALK_FORCEFUL;
    	nChat = VOICE_CHAT_THREATEN;
	}
	else if (FindSubString(sHeard, EMT_LAUGH)!= -1 || FindSubString(sHeard, EMT_HAHA)!= -1 || FindSubString(sHeard, EMT_LOL)!= -1)
    {
	    nAnim = ANIMATION_LOOPING_TALK_LAUGHING;
    	nChat = VOICE_CHAT_LAUGH;
	}	
	else if (FindSubString(sHeard, EMT_BEG)!= -1 || FindSubString(sHeard, EMT_PLEAD)!= -1)
        nAnim = ANIMATION_LOOPING_TALK_PLEADING;
    else if (FindSubString(sHeard, EMT_WORSHIP)!= -1)
        nAnim = ANIMATION_LOOPING_MEDITATE;
    else if (FindSubString(sHeard, EMT_TALK)!= -1 || FindSubString(sHeard, EMT_CHATS)!= -1 || FindSubString(sHeard, EMT_SPEAK)!=-1 || FindSubString(sHeard, EMT_STORY)!=-1)
        nAnim = ANIMATION_LOOPING_TALK_NORMAL;
    else if (FindSubString(sHeard, EMT_DUCK)!= -1)
        nAnim = ANIMATION_FIREFORGET_DODGE_DUCK;
    else if (FindSubString(sHeard, EMT_DODGE)!= -1)
        nAnim = ANIMATION_FIREFORGET_DODGE_SIDE;
    else if (FindSubString(sHeard, EMT_CANTRIP)!= -1)
        nAnim = ANIMATION_LOOPING_CONJURE1;
    else if (FindSubString(sHeard, EMT_CAST)!= -1)
        nAnim = ANIMATION_LOOPING_CONJURE2;
    else if (FindSubString(sHeard, EMT_COLLAPSE)!=-1  || FindSubString(sHeard, EMT_TRIPS)!=-1)
        nAnim = ANIMATION_LOOPING_DEAD_FRONT;
    else if (FindSubString(sHeard, EMT_SPASM)!= -1)
        nAnim = ANIMATION_LOOPING_SPASM;
    else if (FindSubString(sHeard, EMT_STAND)!=-1)
        nAnim = ANIMATION_FIREFORGET_STANDUP;
    else if (FindSubString(sHeard, EMT_GREET)!= -1 || FindSubString(sHeard, EMT_WAVE) != -1 || FindSubString(sHeard, EMT_HELLO)!= -1 || FindSubString(sHeard, EMT_HI) != -1)
    {
		nAnim = ANIMATION_FIREFORGET_GREETING;
    	nChat = VOICE_CHAT_HELLO;
	}	
	else if (FindSubString(sHeard, EMT_PRONE)!=-1)
        nAnim = ANIMATION_LOOPING_PRONE;
    else if (FindSubString(sHeard, EMT_DANCE)!=-1)
        nAnim = ANIMATION_LOOPING_DANCE01;
    else if (FindSubString(sHeard, EMT_BOOGIE)!=-1)
        nAnim = ANIMATION_LOOPING_DANCE02;
    else if (FindSubString(sHeard, EMT_FROLIC)!=-1)
        nAnim = ANIMATION_LOOPING_DANCE03;
    else if (FindSubString(sHeard, EMT_COOK)!=-1)
        nAnim = ANIMATION_LOOPING_COOK01;
    else if (FindSubString(sHeard, EMT_MEAL)!=-1)
        nAnim = ANIMATION_LOOPING_COOK02;
    else if (FindSubString(sHeard, EMT_CRAFT)!=-1)
        nAnim = ANIMATION_LOOPING_CRAFT01;
    else if (FindSubString(sHeard, EMT_FORGE)!=-1)
        nAnim = ANIMATION_LOOPING_FORGE01;
    else if (FindSubString(sHeard, EMT_SHOVEL)!=-1)
        nAnim = ANIMATION_LOOPING_SHOVELING;
    else if (FindSubString(sHeard, EMT_INJURE)!= -1 || FindSubString(sHeard, EMT_LIMP) != -1 || FindSubString(sHeard, EMT_HURT)!= -1)
        nAnim = ANIMATION_LOOPING_INJURED;
    else if (FindSubString(sHeard, EMT_COLLAPSE)!=-1)
        nAnim = ANIMATION_FIREFORGET_COLLAPSE;
    else if (FindSubString(sHeard, EMT_ACTIVATE)!=-1)
        nAnim = ANIMATION_FIREFORGET_ACTIVATE;
    else if (FindSubString(sHeard, EMT_USE)!=-1)
        nAnim = ANIMATION_FIREFORGET_USEITEM;
    else if (FindSubString(sHeard, EMT_BARD)!=-1)
        nAnim = ANIMATION_FIREFORGET_BARDSONG;
    else if (FindSubString(sHeard, EMT_WILDSHAPE)!=-1)
        nAnim = ANIMATION_FIREFORGET_WILDSHAPE;
    else if (FindSubString(sHeard, EMT_SEARCH)!=-1)
        nAnim = ANIMATION_FIREFORGET_SEARCH;
    else if (FindSubString(sHeard, EMT_INTIMIDATE)!=-1)
        nAnim = ANIMATION_FIREFORGET_INTIMIDATE;
    else if ((FindSubString(sHeard, EMT_CHUCKLE)!=-1) || (FindSubString(sHeard, EMT_GIGGLE)!= -1))
        nAnim = ANIMATION_FIREFORGET_CHUCKLE;
			
		if (FindSubString(sHeard, EMT_ATTACK)!=-1)	nChat = VOICE_CHAT_ATTACK;
		else if (FindSubString(sHeard, EMT_BATTLECRY)!=-1)	
		{
			int n = d3();
			if (n==1)
				nChat = VOICE_CHAT_BATTLECRY1;
			else if (n==2)
				nChat = VOICE_CHAT_BATTLECRY2;
			else 
				nChat = VOICE_CHAT_BATTLECRY3;
		}
		else if (FindSubString(sHeard, EMT_PAIN)!=-1)	
		{
			int n = d3();
			if (n==1)
				nChat = VOICE_CHAT_PAIN1;
			else if (n==2)
				nChat = VOICE_CHAT_PAIN2;
			else 
				nChat = VOICE_CHAT_PAIN3;
		}
		else if ((FindSubString(sHeard, EMT_HEAL)!=-1) && (FindSubString(sHeard, EMT_ME)!=-1))	nChat = VOICE_CHAT_HEALME;
		else if (FindSubString(sHeard, EMT_HELP)!=-1)	nChat = VOICE_CHAT_HELP;						
		else if (FindSubString(sHeard, EMT_ENEMIES)!=-1)	nChat = VOICE_CHAT_ENEMIES;
		else if (FindSubString(sHeard, EMT_FLEE)!=-1)	nChat = VOICE_CHAT_FLEE;
		else if (FindSubString(sHeard, EMT_GUARDME)!=-1)	nChat = VOICE_CHAT_GUARDME;	
		else if (FindSubString(sHeard, EMT_HOLD)!=-1)	nChat = VOICE_CHAT_HOLD;		
		else if ((FindSubString(sHeard, EMT_NEAR)!=-1) && (FindSubString(sHeard, EMT_DEATH)!=-1))	nChat = VOICE_CHAT_NEARDEATH;	
		else if (FindSubString(sHeard, EMT_POISONED)!=-1)	nChat = VOICE_CHAT_POISONED;	
		else if (FindSubString(sHeard, EMT_SPELL_FAIL)!=-1)	nChat = VOICE_CHAT_SPELLFAILED;
		else if (FindSubString(sHeard, EMT_WEAPON_SUCKS)!=-1)	nChat = VOICE_CHAT_WEAPONSUCKS;
		else if (FindSubString(sHeard, EMT_FOLLOW_ME)!=-1)	nChat = VOICE_CHAT_FOLLOWME;
		else if ((FindSubString(sHeard, EMT_LOOK)!=-1) && (FindSubString(sHeard, EMT_HERE)!=-1))	nChat = VOICE_CHAT_LOOKHERE;			
		else if (FindSubString(sHeard, EMT_GROUP)!=-1)	nChat = VOICE_CHAT_GROUP;
		else if (FindSubString(sHeard, EMT_MOVE_OVER)!=-1)	nChat = VOICE_CHAT_MOVEOVER;						
		else if (FindSubString(sHeard, EMT_CANDO)!=-1)	nChat = VOICE_CHAT_CANDO;
		else if (FindSubString(sHeard, EMT_CANTDO)!=-1)	nChat = VOICE_CHAT_CANTDO;
		else if (FindSubString(sHeard, EMT_TASKCOMPLETE)!=-1)	nChat = VOICE_CHAT_TASKCOMPLETE;	
		else if (FindSubString(sHeard, EMT_ENCUMBERED)!=-1)	nChat = VOICE_CHAT_ENCUMBERED;		
		else if (FindSubString(sHeard, EMT_SELECTED)!=-1)	nChat = VOICE_CHAT_SELECTED;	
		else if (FindSubString(sHeard, EMT_NO)!=-1)	nChat = VOICE_CHAT_NO;	
		else if (FindSubString(sHeard, EMT_STOP)!=-1)	nChat = VOICE_CHAT_STOP;
		else if (FindSubString(sHeard, EMT_GOODBYE)!=-1)	nChat = VOICE_CHAT_GOODBYE;
		else if (FindSubString(sHeard, EMT_THANKS)!=-1)	nChat = VOICE_CHAT_THANKS;
		else if (FindSubString(sHeard, EMT_CUSS)!=-1)	nChat = VOICE_CHAT_CUSS;	
		else if (FindSubString(sHeard, EMT_TALKTOME)!=-1)	nChat = VOICE_CHAT_TALKTOME;
		else if (FindSubString(sHeard, EMT_GOODIDEA)!=-1)	nChat = VOICE_CHAT_GOODIDEA;
		else if (FindSubString(sHeard, EMT_BADIDEA)!=-1)	nChat = VOICE_CHAT_BADIDEA;	
		else if (FindSubString(sHeard, EMT_PICK_LOCK)!=-1)	nChat = VOICE_CHAT_PICKLOCK;	
		else if (FindSubString(sHeard, EMT_CHECK_AREA)!=-1)	nChat = VOICE_CHAT_SEARCH;
		else if (FindSubString(sHeard, EMT_YES)!=-1)	nChat = VOICE_CHAT_YES;	
		else if (FindSubString(sHeard, EMT_PICK_LOCK)!=-1)	nChat = VOICE_CHAT_PICKLOCK;	
		else if (FindSubString(sHeard, EMT_COVER)!=-1)	nChat = VOICE_CHAT_HIDE;	

    if (nAnim!=-1)
        AssignCommand(oSpeaker, ClearAllActions());

    if (nAnim >99)
        AssignCommand(oSpeaker, ActionPlayAnimation(nAnim, 0.1));
    else
        AssignCommand(oSpeaker, ActionPlayAnimation(nAnim, 0.1, 300.));
		
	if (nChat!=-1)
		DelayCommand(0.2, AssignCommand(oSpeaker, PlayVoiceChat(nChat)));

    return DMFI_STATE_SUCCESS;
}