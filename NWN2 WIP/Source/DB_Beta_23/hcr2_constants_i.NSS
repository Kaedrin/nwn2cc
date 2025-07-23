/*
Filename:           hcr2_constants_i
System:             core (include script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 core constants definitions. (internal use only, NOT user configurable)
This file holds the commonanly used constants
used throughout the core HCR2 for NWN2 system.

This script is accessible from hcr2_locals_i, hcr2_debug_i, hcr2_timers_i, hcr2_core_i.

-----------------
Revision: v1.01
Added constants H2_PREVIOUS_MINUTE, H2_BOOT_MESSAGE & H2_CONTAINER

Revision v1.02
Added constants H2_SAVELOC_TIMER

Revision v1.03
Added some more constsnts for spelltracking

Revision v1.04
Removed H2_PREVIOUS_MINUTE

Revision v1.05
Added H2_EVENT_ON_CHAT, H2_FEATUSES_DATA_POINT, H2_ADDED_ONHITPROPERTY, 
H2_EVENT_ON_PLAYER_STRUCK, H2_PLAYERSTRUCK_SCIRPT, H2_EVENT_ON_PRE_LEVELUP,
H2_EVENT_ON_CANCEL_LEVELUP, H2_EVENT_ON_POST_LEVELUP, H2_EVENT_ON_HOTBAR_CLICK
*/
#include "hcr2_core_c"

const string H2_CORE_DATA_POINT = "HCR2_COREDATAPOINT";
const string H2_FEATUSES_DATA_POINT = "H2_FEATUSES_DATA_POINT";
const string H2_NOACCESS = "HCR2_NOACCESS";
const string H2_RETIRE_PC_MENU_CONV = "hcr2_retirepcconv";
const string H2_PLAYER_MENU_CONV = "hcr2_playermenuconv";

const string H2_EVENT_ON_ACQUIRE_ITEM = "OnAcquireItem";
const string H2_EVENT_ON_ACTIVATE_ITEM = "OnActivateItem";
const string H2_EVENT_ON_CLIENT_ENTER = "OnClientEnter";
const string H2_EVENT_ON_CLIENT_LEAVE = "OnClientLeave";
const string H2_EVENT_ON_CUTSCENE_ABORT = "OnCutSceneAbort";
const string H2_EVENT_ON_HEARTBEAT = "OnHeartBeat";
const string H2_EVENT_ON_MODULE_LOAD = "OnModuleLoad";
//Module start event hooking not accessable because it doesn't fire
//or can't access anything in the not yet loaded module...
//const string H2_EVENT_ON_MODULE_START = "OnModuleStart";
const string H2_EVENT_ON_PC_LOADED = "OnPCLoaded";
const string H2_EVENT_ON_PLAYER_DEATH = "OnPlayerDeath";
const string H2_EVENT_ON_PLAYER_DYING = "OnPlayerDying";
const string H2_EVENT_ON_PLAYER_EQUIP_ITEM = "OnPlayerEquipItem";
const string H2_EVENT_ON_PLAYER_LEVEL_UP = "OnPlayerLevelUp";
const string H2_EVENT_ON_PLAYER_RESPAWN = "OnPlayerReSpawn";
const string H2_EVENT_ON_PLAYER_REST_STARTED = "OnPlayerRestStarted";
const string H2_EVENT_ON_PLAYER_REST_CANCELLED = "OnPlayerRestCancelled";
const string H2_EVENT_ON_PLAYER_REST_FINISHED = "OnPlayerRestFinished";
const string H2_EVENT_ON_PLAYER_UNEQUIP_ITEM = "OnPlayerUnEquipItem";
const string H2_EVENT_ON_SPELLHOOK = "OnSpellHook";
const string H2_EVENT_ON_UNACQUIRE_ITEM = "OnUnAcquireItem";
const string H2_EVENT_ON_USER_DEFINED = "OnUserDefined";
const string H2_EVENT_ON_CHAT = "OnChat";
const string H2_EVENT_ON_PLAYER_STRUCK = "OnPlayerStruck";
const string H2_EVENT_ON_PRE_LEVEL_UP = "OnPreLevelUp";
const string H2_EVENT_ON_CANCEL_LEVEL_UP = "OnCancelLevelUp";
const string H2_EVENT_ON_POST_LEVEL_UP = "OnPostLevelUp";
const string H2_EVENT_ON_HOTBAR_CLICK = "OnHotbarClick";

const string H2_SPELLHOOK_EVENT_SCRIPT = "hcr2_spellhook_e";
const string H2_RESPAWN_EVENT_SCRIPT = "hcr2_playerrespawn_e";
const string H2_PLAYERSTRUCK_SCRIPT = "hcr2_playerstruck_e";
const string H2_ADDED_ONHITPROPERTY = "H3_ADDED_ONHITPROPERTY";

const string H2_LAST_RESPAWN_BUTTON_PRESSER = "H2_LAST_RESPAWN_	BUTTON_PRESSER";

const string H2_AREAEVENT_ON_CLIENT_ENTER = "OnAreaClientEnter";
const string H2_AREAEVENT_ON_ENTER = "OnAreaEnter";
const string H2_AREAEVENT_ON_EXIT = "OnAreaExit";
const string H2_AREAEVENT_ON_HEARTBEAT = "OnAreaHeartBeat";
const string H2_AREAEVENT_ON_USER_DEFINED = "OnAreaUserDefined";

const string H2_PLAYERS_IN_AREA = "H2_PLAYERS_IN_AREA";

const string H2_CREATUREEVENT_ON_BLOCKED = "OnCreatureBlocked";
const string H2_CREATUREEVENT_ON_CONVERSATION = "OnCreatureConversation";
const string H2_CREATUREEVENT_ON_DAMAGED = "OnCreatureDamaged";
const string H2_CREATUREEVENT_ON_DEATH = "OnCreatureDeath";
const string H2_CREATUREEVENT_ON_ENDCOMBATROUND = "OnCreatureEndCombatRound";
const string H2_CREATUREEVENT_ON_HEARTBEAT = "OnCreatureHeartBeat";
const string H2_CREATUREEVENT_ON_INVENTORYDISTURBED = "OnCreatureInventoryDisturbed";
const string H2_CREATUREEVENT_ON_PERCEPTION = "OnCreaturePerception";
const string H2_CREATUREEVENT_ON_PHYSICALLYATTACKED= "OnCreaturePhysicallyAttacked";
const string H2_CREATUREEVENT_ON_RESTED = "OnCreatureRested";
const string H2_CREATUREEVENT_ON_SPAWN = "OnCreatureSpawn";
const string H2_CREATUREEVENT_ON_SPELLCASTAT = "OnCreatureSpellCastAt";
const string H2_CREATUREEVENT_ON_USER_DEFINED = "OnCreatureUserDefined";

const string H2_PLACEABLEEVENT_ON_CLOSED = "OnPlaceableClosed";
const string H2_PLACEABLEEVENT_ON_CONVERSATION = "OnPlaceableConversation";
const string H2_PLACEABLEEVENT_ON_DAMAGED = "OnPlaceableDamaged";
const string H2_PLACEABLEEVENT_ON_DEATH = "OnPlaceableDeath";
const string H2_PLACEABLEEVENT_ON_DISARM = "OnPlaceableDisarm";
const string H2_PLACEABLEEVENT_ON_HEARTBEAT = "OnPlaceableHeartBeat";
const string H2_PLACEABLEEVENT_ON_INVENTORYDISTURBED = "OnPlaceableInventoryDisturbed";
const string H2_PLACEABLEEVENT_ON_LEFTCLICK = "OnPlaceableLeftClick";
const string H2_PLACEABLEEVENT_ON_LOCK = "OnPlaceableLock";
const string H2_PLACEABLEEVENT_ON_MELEEATTACKED= "OnPlaceableMeleeAttacked";
const string H2_PLACEABLEEVENT_ON_OPEN = "OnPlaceableOpen";
const string H2_PLACEABLEEVENT_ON_SPELLCASTAT = "OnPlaceableSpellCastAt";
const string H2_PLACEABLEEVENT_ON_TRAPTRIGGERED = "OnPlaceableTrapTriggered";
const string H2_PLACEABLEEVENT_ON_UNLOCK = "OnPlaceableUnlock";
const string H2_PLACEABLEEVENT_ON_USED = "OnPlaceableUsed";
const string H2_PLACEABLEEVENT_ON_USER_DEFINED = "OnPlaceableUserDefined";

const string H2_DOOREVENT_ON_CLICK = "OnDoorClick";
const string H2_DOOREVENT_ON_CLOSED = "OnDoorClosed";
const string H2_DOOREVENT_ON_CONVERSATION = "OnDoorConversation";
const string H2_DOOREVENT_ON_DAMAGED = "OnDoorDamaged";
const string H2_DOOREVENT_ON_DEATH = "OnDoorDeath";
const string H2_DOOREVENT_ON_DISARM = "OnDoorDisarm";
const string H2_DOOREVENT_ON_FAILTOOPEN = "OnDoorFailToOpen";
const string H2_DOOREVENT_ON_HEARTBEAT = "OnDoorHeartBeat";
const string H2_DOOREVENT_ON_LOCK = "OnDoorLock";
const string H2_DOOREVENT_ON_MELEEATTACKED= "OnDoorMeleeAttacked";
const string H2_DOOREVENT_ON_OPEN = "OnDoorOpen";
const string H2_DOOREVENT_ON_SPELLCASTAT = "OnDoorSpellCastAt";
const string H2_DOOREVENT_ON_TRAPTRIGGERED = "OnDoorTrapTriggered";
const string H2_DOOREVENT_ON_UNLOCK = "OnDoorUnlock";
const string H2_DOOREVENT_ON_USED = "OnDoorUsed";
const string H2_DOOREVENT_ON_USER_DEFINED = "OnDoorUserDefined";

const string H2_PLAYER_HP = "H2_PLAYER_HP";
const string H2_SPELL_TRACK = "H2_SPELL_TRACK";
const string H2_SPELL_TRACK_SP = "H2_SPELL_TRACK_SP";
const string H2_SPELLS_AVAILABLE = "H2_SPELLS_AVAILABLE";

const string H2_FEAT_TRACK = "H2_FEAT_TRACK";
const string H2_PC_PLAYER_NAME = "H2_PC_PLAYER_NAME";
const string H2_PC_CD_KEY = "H2_PCCDKEY";
const string H2_PLAYER_COUNT = "H2_PLAYER_COUNT";

const string H2_BANNED_PREFIX = "BANNED_";
const string H2_LOGIN_BOOT = "H2_LOGIN_BOOT";
const string H2_BOOT_MESSAGE = "H2_BOOT_MESSAGE";
const string H2_MODULE_LOCKED = "H2_MODULE_LOCKED";

const int H2_PLAYER_STATE_ALIVE = 0;
const int H2_PLAYER_STATE_DYING = 1;
const int H2_PLAYER_STATE_DEAD = 2;
const int H2_PLAYER_STATE_STABLE = 3;
const int H2_PLAYER_STATE_RECOVERING = 4;
const int H2_PLAYER_STATE_RETIRED = 5;

const string H2_CONVERSATION_RESREF = "ConversationResRef";
const string H2_PLAYER_DATA_MENU_ITEM_TEXT = "H2_PLAYER_DATA_MENU_ITEM_TEXT";
const string H2_PLAYER_DATA_MENU_INDEX = "H2_PLAYER_DATA_MENU_INDEX";

const string H2_LOGIN_DEATH = "H2_LOGINDEATH";
const string H2_LOCATION_LAST_DIED = "H2_LOCATION_LAST_DIED";
const string H2_PLAYER_DATA_ITEM_TARGET_OBJECT = "H2_PLAYER_DATA_ITEM_TARGET_OBJECT";
const string H2_PLAYER_DATA_ITEM_TARGET_LOCATION = "H2_PLAYER_DATA_ITEM_TARGET_LOCATION";

const string H2_EXPORT_CHAR_TIMER_SCRIPT = "hcr2_exportchars"; 
const string H2_INITIAL_LOGIN = "H2_INITIALLOGIN";
const string H2_SAVE_LOCATION = "hcr2_savelocation"; 
const string H2_MOVING_ITEMS = "H2_MOVINGITEMS";
const string H2_CONTAINER = "H2_CONTAINER";

const string H2_ALLOW_REST = "H2_ALLOW_REST";
const string H2_ALLOW_SPELL_RECOVERY = "H2_ALLOW_SPELL_RECOVERY";
const string H2_ALLOW_FEAT_RECOVERY = "H2_ALLOW_FEAT_RECOVERY";
const string H2_POST_REST_HEAL_AMT = "H2_POST_REST_HEAL_AMT";
const string H2_SKIP_REST_MESSAGEBOX = "H2_SKIP_REST_MESSAGEBOX";
const string H2_SKIP_CANCEL_REST = "H2_SKIP_CANCEL_REST";
const string H2_REST_MESSAGE_CALLBACK_SCRIPT = "gui_hcr2_makepcrest";
const string H2_REST_MESSAGE_CANCEL_SCRIPT = "gui_hcr2_restcancel";
const string H2_OK_TO_REST = "H2_OK_TO_REST";

const string H2_NEXT_TIMER_ID = "H2_NEXT_TIMER_ID";
const string H2_TIMER_SCRIPT = "H2_TIMER_SCRIPT";
const string H2_TIMER_OBJECT = "H2_TIMER_OBJECT";
const string H2_TIMER_INTERVAL = "H2_TIMER_INTERVAL";
const string H2_TIMER_OBJECT_IS_PC = "H2_TIMER_OBJECT_IS_PC";
const string H2_TIMER_IS_RUNNING = "H2_TIMER_IS_RUNNING";
const string H2_SAVELOC_TIMER = "H2_SAVELOC_TIMER";

const string H2_SERVER_START_YEAR = "H2_SERVER_START_YEAR";
const string H2_SERVER_START_MONTH = "H2_SERVER_START_MONTH";
const string H2_SERVER_START_DAY = "H2_SERVER_START_DAY";
const string H2_SERVER_START_HOUR = "H2_SERVER_START_HOUR";
const string H2_SERVER_START_MINUTE = "H2_SERVER_START_MINUTE";