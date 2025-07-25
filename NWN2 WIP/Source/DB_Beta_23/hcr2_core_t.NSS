/*
Filename:           hcr2_core_t
System:             core (text include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 String constants
This file holds the various strings associated with the core HCR2 system

To make an alternate language version of this script, save this script with a different name,
and translate all of the below text. Then in hcr2_core_c, replace [#include "hcr2_core_t"]
with [#include "your new language text script name"].

-----------------
Revision: v1.01
Dropped name too long text message due to removal of
PC max name length check.

Recision v1.02
Added some more logging text messages.

Revision v1.05
Added some more logging text messages.
*/

const string H2_TEXT_USING_PERSISTENCE = "Using Persistence System: ";
const string H2_TEXT_SEND_TO_SAVED_LOC = "Sending you to your last saved location.";
const string H2_TEXT_RETIRED_PC_BOOT = "This character has been retired from play. Please log in with a different one after being booted.";
const string H2_TEXT_TOO_MANY_CHARS_BOOT = "This is not one of your registered characters. Please log in with a registered character after being booted.";
const string H2_TEXT_CHAR_REGISTERED = "This character is now registered.";
const string H2_TEXT_TOTAL_REGISTERED_CHARS = "Total number of registered characters: ";
const string H2_TEXT_MAX_REGISTERED_CHARS = " Maximum registered characters: ";
const string H2_TEXT_CURRENT_GAME_DATE_TIME = "Current Game Date and Time: ";
const string H2_TEXT_YOU_HAVE_DIED = "You have died.";
const string H2_TEXT_RECOVER_WITH_REST_IN = "You can recover spells and health by resting in: ";
const string H2_TEXT_HOURS = " hours.";
const string H2_TEXT_SETTINGS_NOT_READ = "The module builder has not read and customized the rule settings for this module.";
const string H2_TEXT_YOU_ARE_BANNED = "You have been banned from the server.";
const string H2_TEXT_SERVER_IS_FULL = "The server is full, remaining space is resevered for DM logins. Try again later.";
const string H2_TEXT_MODULE_LOCKED = "The module is currently locked from player login. Try again later.";
const string H2_TEXT_PLAYER_NOT_ONLINE = "The player is not online.";
const string H2_TEXT_REST_NOT_ALLOWED_HERE = "You may not rest here.";

const string H2_TEXT_TARGET_ITEM_MUST_BE_IN_INVENTORY = "Target item must be in your inventory to do that.";
const string H2_TEXT_NOT_ENOUGH_GOLD = "You do not have enough gold for that.";
const string H2_TEXT_CANNOT_USE_ON_SELF = "You cannot use that on yourself.";
const string H2_TEXT_OFFLINE_PLAYER = "Offline player";
const string H2_TEXT_CANNOT_PLACE_THERE = "You cannot place that there.";
const string H2_TEXT_CANNOT_USE_ON_TARGET = "You cannot use that on that target.";
const string H2_TEXT_TOO_FAR_AWAY  = "You are too far away to do that.";

//Skill check message construction:
//GetName(oSkillUser) + " " + H2_TEXT_SKILL_* + H2_TEXT_SKILL_CHECK + rollresult + " + " + modifier + " = " + total
//"JimBob Heal skill check. Roll: 10 + 4 = 14"
const string H2_TEXT_SKILL_CHECK = " skill check. Roll: "; 

const string H2_TEXT_SKILL_APPRAISE = "Appraise";
const string H2_TEXT_SKILL_BLUFF = "Bluff";
const string H2_TEXT_SKILL_CONCENTRATION = "Concentration";
const string H2_TEXT_SKILL_CRAFT_ALCHEMY = "Craft Alchemy";
const string H2_TEXT_SKILL_CRAFT_ARMOR = "Craft Armor";
const string H2_TEXT_SKILL_CRAFT_TRAP = "Craft Trap";
const string H2_TEXT_SKILL_CRAFT_WEAPON = "Craft Weapon";
const string H2_TEXT_SKILL_DIPLOMACY = "Diplomacy";
const string H2_TEXT_SKILL_DISABLE_TRAP = "Disable Trap";
const string H2_TEXT_SKILL_DISCIPLINE = "Discipline";
const string H2_TEXT_SKILL_HEAL = "Heal";
const string H2_TEXT_SKILL_HIDE = "Hide";
const string H2_TEXT_SKILL_INTIMIDATE = "Intimidate";
const string H2_TEXT_SKILL_LISTEN = "Listen";
const string H2_TEXT_SKILL_LORE = "Lore";
const string H2_TEXT_SKILL_MOVE_SILENTLY = "Move Silently";
const string H2_TEXT_SKILL_OPEN_LOCK = "Open Lock";
const string H2_TEXT_SKILL_PARRY = "Parry";
const string H2_TEXT_SKILL_PERFORM = "Perform";
//const string H2_TEXT_SKILL_RIDE = "Ride";
const string H2_TEXT_SKILL_SEARCH = "Search";
const string H2_TEXT_SKILL_SET_TRAP = "Set Trap";
const string H2_TEXT_SKILL_SLEIGHT_OF_HAND = "Sleight of Hand";
const string H2_TEXT_SKILL_SPELLCRAFT = "Spellcraft";
const string H2_TEXT_SKILL_SPOT = "Spot";
const string H2_TEXT_SKILL_SURVIVAL = "Survival";
const string H2_TEXT_SKILL_TAUNT = "Taunt";
const string H2_TEXT_SKILL_TUMBLE = "Tumble";
const string H2_TEXT_SKILL_USE_MAGIC_DEVICE = "Use Magic Device";

//Player Data Item conversation node texts:
//-H2_TEXT_PLAYER_DATA_ITEM_CONV_ROOT_NODE
//      -(custom action nodes) (pc options)
//      -H2_TEXT_RETIRE_PC_MENU_OPTION
//      -H2_TEXT_PLAYER_DATA_MENU_NOTHING
const string H2_TEXT_PLAYER_DATA_ITEM_CONV_ROOT_NODE = "What action would you like to perform?";
const string H2_TEXT_RETIRE_PC_MENU_OPTION = "Retire this character.";
const string H2_TEXT_PLAYER_DATA_MENU_NOTHING = "Nothing.";

//Retire PC conversation node texts:
//-H2_TEXT_RETIRE_PC_CONV_ROOT_NODE
//      -H2_TEXT_RETIRE_PC_CONV_NEVERMIND [END DIALOGUE]   (pc option)
//      -H2_TEXT_RETIRE_PC_CONV_RETIRE_OPTION              (pc option)
//          -H2_TEXT_RETIRE_PC_CONV_CONFIRM_MESSAGE
//              -H2_TEXT_RETIRE_PC_CONV_NEVERMIND [END DIALOGUE]     (pc option)
//              -H2_TEXT_RETIRE_PC_CONV_RETIRE_OPTION [End DIALOGUE] (pc option)
const string H2_TEXT_RETIRE_PC_CONV_ROOT_NODE = "Selecting to retire your character will cause this character to become unregistered, thus freeing a registration slot for a new character, but it also means you cannot play this character any longer.";
const string H2_TEXT_RETIRE_PC_CONV_NEVERMIND = "Nevermind, I don't want to do this.";
const string H2_TEXT_RETIRE_PC_CONV_RETIRE_OPTION = "Yes, retire my character.";
const string H2_TEXT_RETIRE_PC_CONV_CONFIRM_MESSAGE = "This character will be retired forever, and will not be playable again. You will then be booted and upon login you will need to make a new character. Are you sure you want to do this?";

//PC Rest MessageBox texts:
const string H2_TEXT_REST_MESSAGE = "Do you wish to rest?";
const string H2_TEXT_RESTBUTTON = "Rest";

const string H2_TEXT_LOG_BOOTED = /*GetPCPlayerName() + */  " BOOTED: ";  // + boot message
const string H2_TEXT_LOG_PLAYER_MENU = "Player Menu: "; // + menu text  + H2_TEXT_LOG_PLAYER_MENU_EXCEEDED
const string H2_TEXT_LOG_PLAYER_MENU_EXCEEDED = " exceeded maximum allowed.";
const string H2_TEXT_LOG_PLAYER_LEVELUP = /*GetName(oPC) + "_" + GetPCPlayerName() + */ " has gained a level. New Level: "; // + IntToString(GetHitDice(oPC));

//GetName(oPC) + "_" + GetPCPlayerName(oPC) + H2_TEXT_LOG_PLAYER_HAS_DIED +
//GetName(GetLastHostileActor(oPC)) + H2_TEXT_LOG_PLAYER_HAS_DIED2 + GetName(GetGetArea(oPC))
const string H2_TEXT_LOG_PLAYER_HAS_DIED = " was killed by ";
const string H2_TEXT_LOG_PLAYER_HAS_DIED2 = " in area ";

const string H2_TEXT_LOG_MODULE_HOOKIN_SCRIPTS_DETECTED = "Module Hook-In Scripts detected:";