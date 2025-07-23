// vn_inc_constants - Generic constants. Not system constants. 

// What are the real infinity values ???
const int INFINITY = 2147480000; // aprox 2^31-1
const float fINFINITY = 2147480000.0;

// maximum number of items in _any_ stack. NB: doesn't work for gold
const int MAX_STACKABLE = 100;

// events
const int PLC_EVENT_CLICK = 1;
const int PLC_EVENT_CLOSED = 2;
const int PLC_EVENT_CONVERSATION = 3;
const int PLC_EVENT_DAMAGED = 4;
const int PLC_EVENT_DEATH = 5;
const int PLC_EVENT_DISARM = 6;
const int PLC_EVENT_FAIL_OPEN = 7;
const int PLC_EVENT_HEARTBEAT = 8;
const int PLC_EVENT_INVENTORY_DISTURBED = 9;
const int PLC_EVENT_LOCK = 10;
const int PLC_EVENT_MELEE_ATTACKED = 11;
const int PLC_EVENT_OPEN = 12;
const int PLC_EVENT_SPELL_CAST_AT = 13;
const int PLC_EVENT_TRAP_TRIGGERED = 14;
const int PLC_EVENT_UNLOCK = 15;


//const int PLC_EVENT_ON_USED = 16; 
//for some reason using this event crashes the program - perhaps due to addition of
// click and the open, unlock etc events

// possessed by dead characters, (including those walking beyond the veil)
const string DEATH_MARK = "vn_death_mark"; 

// container to create tempory items into, usually to test some property from a given ResRef.
const string CHECK_CHEST = "vn_checkchest";

// variable names for storing locations on the player token for use with the memory & death recall potion
const string MEMORY_RECALL = "Memory_Recall";
const string DEATH_RECALL = "Death_Recall";