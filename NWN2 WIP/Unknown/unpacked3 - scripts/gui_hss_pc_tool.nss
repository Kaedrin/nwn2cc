// script_name: gui_hss_pc_tool
/*


Description:

Script called from PC Tools GUI element.  This one script handles all of the
functionality for PC Tools (man, I love parameter passing :D).
	
	
Events:

####--Init: (1.0)

Display (1)
OnAdd  (2) 
OnRemove (3)
OnCreate (4)
OnCreate Custom Button Floater -- Horiz. (5)
OnCreate Custom Button Floater -- Vert. (6)
OnCreate Text Macro -- Vert. (7)
OnAdd Custom Button Floater -- Horiz. (8)
OnAdd Custom Button Floater -- Vert. (9)
OnAdd Text Macro -- Vert. (10)

####--Quick Button: (2.0)
	
Save (1)
Time  (2)
safe Loc (3)
Campfire (4)
Tent (5)
AFK	(6)
	
####--DieRolls:  (3.0)

Number header -- clear (100)
Number Button (1-10)

Type Header -- clear  (101)
Type Button (2,4,6,8,10,12,20,100)  (8)

Saves Header -- clear (102)
Type Button (1-3)fort, reflex, will

Ability Check header -- clear (103)
Type Button (1-6)str, dex, con, int, wis, cha 

Skill Check header -- Clear (104)
Type Button (1-28)

Appraise        -- 1
Bluff           -- 2
Concentration   -- 3
Craft Alchemy   -- 4
Craft Armour    -- 5
Craft Trap      -- 6
Craft Weapon    -- 7
Diplomacy       -- 8
Disable Device  -- 9
Heal            -- 10
Hide            -- 11
Intimidate      -- 12
Listen          -- 13
Lore            -- 14
Move Silently   -- 15
Open Lock       -- 16
Parry           -- 17
Perform         -- 18
Ride            -- 19
Search          -- 20
Set Trap        -- 21
Sleight of Hand -- 22
Spellcraft      -- 23
Spot            -- 24
Survival        -- 25
Taunt           -- 26
Tumble          -- 27
Use Magic Device-- 28


Public   (998)

Private  (999)

Roll  (1000)

####--Emotes: (4.0)

Emote Header -- Clear (100)


Emote Type Buttons (1-?)

Emote cease (101)
One-shot (102)
Looping (103)

Emote Roll (1000)

####--VFX's (5.0)
sStringparam1

####--Miscellaneous (6.0)

Custom Buttons (1-100)

Object Interaction Remove (101)

####--Config (7.0)

Float custom buttons:

Yes (1)

No (2)

Yes Vertical (3)

Display Macro Tab:

Yes (4)

No (5)

Load min. yes (6)

Load min. no (7)

Apply settings at startup (50)

####--Text Macros (8.0)

Speak Macro (1)

Macro Page Back (10)

Macro page Forward (11)

Apply Macro Label (100)

Apply Macro Text (101)

Exit Macro Setup (103)

Macro Volume (110)

####--Timer (9.0)


####--Message Box Callbacks (10.0)

AutoFollow:

Yes (1)

No (2)


		
*/
// Name_Date: Heed, March 31, 2007

// Updated:    Heed, Oct 3, 2008
//-- bug fix for looping animations being broken in 1.12
//-- empty strings are now being passed as "0" by the engine -- unsure if intended or not.

#include "x0_i0_position"
#include "hcr2_core_i"


/*                                Constants                              */

const int HSS_PC_TOOLS_DIE_STANDARD = 100;
const int HSS_PC_TOOLS_DIE_SAVE = 200;
const int HSS_PC_TOOLS_DIE_ABILITY = 300;
const int HSS_PC_TOOLS_DIE_SKILL = 400;
const int HSS_PC_TOOLS_EMOTE = 500;

const string SCREEN_HSS_PC_TOOLS = "SCREEN_HSS_PC_TOOLS";
const string HSS_PC_TOOLS_XML = "hss_pc_tools.xml";
const string SCREEN_HSS_PC_TOOLS_CB = "SCREEN_HSS_PC_TOOLS_CB";
const string HSS_PC_TOOLS_CB_XML = "hss_pc_tools_cb.xml";
const string SCREEN_HSS_PC_TOOLS_CB_V = "SCREEN_HSS_PC_TOOLS_CB_V";
const string HSS_PC_TOOLS_CB_V_XML = "hss_pc_tools_cb_v.xml";
const string SCREEN_HSS_PC_TOOLS_TM_V = "SCREEN_HSS_PC_TOOLS_TM_V";
const string HSS_PC_TOOLS_TM_V_XML = "hss_pc_tools_tm_v.xml";
const string SCREEN_HSS_PC_TOOLS_MSG_BOX = "SCREEN_HSS_PC_TOOLS_MSG_BOX";
const string HSS_PC_TOOLS_MSG_BOX_XML = "hss_pc_tools_msgbox.xml";

const int HSS_PC_TOOLS_INT = 1;
const int HSS_PC_TOOLS_STRING = 2;
const int HSS_PC_TOOLS_FLOAT = 3;
const int HSS_PC_TOOLS_LOC = 4;
const int HSS_PC_TOOLS_VEC = 5;
const int HSS_PC_TOOLS_OBJ = 6;

/*                             Configuration                              */

//Enter the string tag of the required items here if you want to require
//the PC to be in possession of a particular item before he/she can create
//the object (tent or campfire).
//If empty string (""), then that object can always be created.
const string HSS_PCTOOLS_CAMPFIRE_ITEM = "";
const string HSS_PCTOOLS_TENT_ITEM = "";

//Enter the limit to the number of PC Tools items that can be created by
//the same PC at any one instance. i.e. entering 2 would mean the PC could
//have 2 items created and could not create a third if the other 2 still
//exist at that time (have not been destroyed).
//entering -1 means no limit at all.
const int HSS_PCTOOLS_CAMPFIRE_ITEM_LIMIT = 1;
const int HSS_PCTOOLS_TENT_ITEM_LIMIT = 1;

//Set this to 1 if you want to exclude areas marked as above ground,
//interior and unnatural from object creation permission. Otherwise 0.
//i.e. a PC will not be able to create a campfire or tent if the area he/she
//is in is flagged as above ground, interior and unnatural.
//NOTE! These are the default settings when an area is created using a
//tileset.  Areas such as caves and mines need to have these peoperties
//set manually to the correct values or they will be excluded from object
//creation (probably not what you want). Only set this to 1 if you have
//been setting your area properties maually to the correct values or
//intend to do so.
const int HSS_PCTOOLS_OBJECT_CREATE_RESTRICT = 0;

//set a value between 1 and 6 to specify the particular AFK visual effect
//that will be applied to the PC when using the "Toggle AFK" button.
//1 = "AFK", 2 = arrow pointing up, 3 = "silhouette" model with sparklies,
//4 = just sparklies, 5 = alpha model with sparklies, 6 = "silhouette" model
//without sparklies. 
const int HSS_PCTOOLS_AFK_VFX = 1;

//Enter the string tag of the required items here if you want to require
//the PC to be in possession of a particular item before he/she can use a
//VFX prop.
//If empty string (""), then that VFX prop can always be used.
const string HSS_PCTOOLS_VFX_DRINKBEER_ITEM = "";
const string HSS_PCTOOLS_VFX_DRUMA_ITEM = "";
const string HSS_PCTOOLS_VFX_DRUMB_ITEM = "";
const string HSS_PCTOOLS_VFX_FLUTEA_ITEM = "";
const string HSS_PCTOOLS_VFX_FLUTEB_ITEM = "";
const string HSS_PCTOOLS_VFX_MANDOLINA_ITEM = "";
const string HSS_PCTOOLS_VFX_MANDOLINB_ITEM = "";
const string HSS_PCTOOLS_VFX_MANDOLINC_ITEM = "";
const string HSS_PCTOOLS_VFX_PAN_ITEM = "";
const string HSS_PCTOOLS_VFX_RAKE_ITEM = "";
const string HSS_PCTOOLS_VFX_SHOVEL_ITEM = "";
const string HSS_PCTOOLS_VFX_SMITHYHAMMER_ITEM = "";
const string HSS_PCTOOLS_VFX_SPOON_ITEM = "";
const string HSS_PCTOOLS_VFX_WINE_ITEM = "";

//Enter the text that will be displayed for the corresponding custom buttons.
const string HSS_PCTOOLS_CUSTOM1_TEXT = "KEMOanims";
const string HSS_PCTOOLS_CUSTOM2_TEXT = "Custom 2";
const string HSS_PCTOOLS_CUSTOM3_TEXT = "Custom 3";
const string HSS_PCTOOLS_CUSTOM4_TEXT = "Custom 4";
const string HSS_PCTOOLS_CUSTOM5_TEXT = "Custom 5";
const string HSS_PCTOOLS_CUSTOM6_TEXT = "Custom 6";
const string HSS_PCTOOLS_CUSTOM7_TEXT = "Custom 7";
const string HSS_PCTOOLS_CUSTOM8_TEXT = "Custom 8";
const string HSS_PCTOOLS_CUSTOM9_TEXT = "Custom 9";
const string HSS_PCTOOLS_CUSTOM10_TEXT = "Custom 10";
const string HSS_PCTOOLS_CUSTOM11_TEXT = "Custom 11";
const string HSS_PCTOOLS_CUSTOM12_TEXT = "Custom 12";
const string HSS_PCTOOLS_CUSTOM13_TEXT = "Custom 13";
const string HSS_PCTOOLS_CUSTOM14_TEXT = "Custom 14";
const string HSS_PCTOOLS_CUSTOM15_TEXT = "Custom 15";
const string HSS_PCTOOLS_CUSTOM16_TEXT = "Custom 16";
const string HSS_PCTOOLS_CUSTOM17_TEXT = "Custom 17";
const string HSS_PCTOOLS_CUSTOM18_TEXT = "Custom 18";
const string HSS_PCTOOLS_CUSTOM19_TEXT = "Target 1";
const string HSS_PCTOOLS_CUSTOM20_TEXT = "Target 2";
const string HSS_PCTOOLS_CUSTOM21_TEXT = "Target 3";
const string HSS_PCTOOLS_CUSTOM22_TEXT = "Target 4";
const string HSS_PCTOOLS_CUSTOM23_TEXT = "Target 5";
const string HSS_PCTOOLS_CUSTOM24_TEXT = "Target 6";
const string HSS_PCTOOLS_CUSTOM25_TEXT = "Target 7";
const string HSS_PCTOOLS_CUSTOM26_TEXT = "Target 8";
const string HSS_PCTOOLS_CUSTOM27_TEXT = "Target 9";
const string HSS_PCTOOLS_CUSTOM28_TEXT = "Target 10";
const string HSS_PCTOOLS_CUSTOM29_TEXT = "Target 11";
const string HSS_PCTOOLS_CUSTOM30_TEXT = "Target 12";
const string HSS_PCTOOLS_CUSTOM31_TEXT = "Target 13";
const string HSS_PCTOOLS_CUSTOM32_TEXT = "Target 14";
const string HSS_PCTOOLS_CUSTOM33_TEXT = "Target 15";
const string HSS_PCTOOLS_CUSTOM34_TEXT = "Target 16";
const string HSS_PCTOOLS_CUSTOM35_TEXT = "Target 17";
const string HSS_PCTOOLS_CUSTOM36_TEXT = "Target 18";


//Enable/disable DMFI plugin capability for PC's. 1 = on, 0 = off.
//DMFI must already be installed for this to function.  This just enables
//the launching of DMFI from the PC Tools plugin tab -- anything that
//happens after the plugin button is pressed is DMFI functionality and not
//PC Tools functionality.  All configuration for DMFI is handled through
//your DMFI install and not through PC Tools.
const int HSS_PCTOOLS_DMFI_PLUGIN_PC = 0;

//Colour strings for feedback messages.
const string HSS_PCTOOLS_COLOUR1 = "<color=#C1AB89>";
const string HSS_PCTOOLS_COLOUR2 = "<color=#EFD4AC>";
const string HSS_PCTOOLS_COLOUR_END = "</c>";

//Default automatic decay time (in seconds) for objects (tent or campfire)
//created via PC Tools.
const float HSS_OBJECT_DECAY = 3600.0;

//Save character feedback text.
const string HSS_SAVE_MESSAGE = "Character saved.";

//Save character feedback text when location save is enabled.
const string HSS_SAVE_MESSAGE_W_LOC = "Character and location saved.";

//Safe Location feedback text.
const string HSS_SAFE_LOC_MESSAGE = "Attempting to find safe location.";

//Item/Prop failure text.
const string HSS_NO_ITEM_MESSAGE = "You need to possess a specific item to do this.";

//Item creation limit exceeded message.
const string HSS_ITEM_LIMIT_MESSAGE = "You have too many instances of this item currently placed. Destroy one in order to create another.";

//Object creation area restricted message.
const string HSS_CREATION_RESTRICT_MESSAGE = "You cannot create that object in here.";

//Message sent to the PC when attempting to use the "Safe Location" button
//and that ability has been disabled either by area or per PC.
//You can exclude individual PC's by setting a local int value of 1 on them
//using the following variable name: "HSS_PCTOOLS_NO_MAKESAFE" .
//You can exclude an area by setting the same local on the area itself.
const string HSS_NO_MAKESAFE_MESSAGE = "This option is not available for you at this time.";

//0 = NWN database, 1 = NWNX database, 2 = inventory item persistency.
//NOTE! no vector support if using DB type 2.
//NOTE2!! Choosing 1 (NWNX) means you need to include nwnx_sql in this
//script and uncomment the lines in the functions HSS_PCTools_StorePersistentData()
//and HSS_PCTools_RetrievePersistentData() which make the calls to the
//nwnx_sql persistent data functions. You should really just be using
//the NWNX specific .erf which is already setup to use the NWNX calls.
const int HSS_PCTOOLS_DBTYPE = 0;

//table name used by HSS_PCTools_StorePersistentData() when DB type is
//for a NWNX DB.
const string HSS_NWNX_TABLE = "pwdata";

//table name used by HSS_PCTools_StorePersistentData() when DB type is
//for a NWNX DB and an object is being stored.
const string HSS_NWNX_OBJ_TABLE = "pwobjdata";

//set to 1 to strip colour tags from macros, 0 to allow them.
const int HSS_PCTOOLS_STRIP_MACROS = 1;

//set the variable name here that will be used when a PC's location is
//saved to the DB via a "Save Character" button use.
//Note that to have the PC actually be transported to the saved location
//upon logging in you must have code in the OnEnter or OnPCLoaded module
//event to do so -- PC Tools saves the data, but the data must be used
//by the builder so that it actually does something.
const string HSS_PCTOOLS_LOC_VAR = "HSS_PCTOOLS_PC_LOCATION";

//set this int to 1 to have the character's location saved when the
//"Save Character" button is used. Set to 0 to only have the character
//file saved with no location saved.
const int HSS_PCTOOLS_SAVE_LOC = 1;



/*                            End Configuration                            */


/*                           Function Prototypes                           */

//removes all local variables on oPC associated with PC Tools functionality
//nbroadcast = TRUE will clear the broadcast mode int, FALSE will not
void HSS_PCTools_CleanPCLocals(object oPC, int nBroadcast = TRUE);

//called from the oncreate event -- setup custom buttons, etc.
//nGUI can be 1 for PC Tools Main, 2 for Custom Buttons Horizontal Floater
//or 3 for Custom Buttons Vertical Floater, 4 for Text Macro Pad
void HSS_PCTools_OnGUICreate(object oPC, int nGUI = 1);

//called from the OnAdd event.
void HSS_PCTools_OnGUIAdd(object oPC, int nGUI = 1);

//save the character oPC
void HSS_PCTools_SaveCharacter(object oPC, string sPCID);

//displays the date/time for the PC
void HSS_PCTools_GetTime(object oPC);

//try and move oPC out of a stuck location
void HSS_PCTools_MakeSafeLocation(object oPC);

//create an item. sItem is parsed by the function ("Tent" and "Campfire" supported)
void HSS_PCTools_Create(object oPC, string sItem = "Tent");

//toggle AFK vfx on oPC
void HSS_PCTools_ToggleAFK(object oPC);

//do the die roll and display the result
void HSS_PCToools_RollDie(object oPC);

//set the GUI locals to disable the other die roll types when one has been chosen.
void HSS_PCTools_SetGUIDieRollType(object oPC, int nType = HSS_PC_TOOLS_DIE_STANDARD);

//removes all local variables on oPC associated with PC Tools functionality
void HSS_PCTools_DeleteGUIDieRollType(object oPC);

//Do an emote
void HSS_PCTools_DoEmote(object oPC);

//applies/removes the vfx props
void HSS_PCTools_ApplyVFX(object oPC, string sVFX);

//removes (destroys) a placeable created by PC Tools (tent or campfire)
void HSS_PCTools_Remove(object oPC, int nObject);

//Function handles the execution of code for the 9 custom buttons.
//See the function implementation to add your own code for the behaviour
//of these buttons.  Set their display name via the constants above.
void HSS_PCTools_CustomButton(object oPC, int nButton, float fX = 0.0, float fY = 0.0, float fZ = 0.0, int nString1 = -1, int nObject = -1);
		   
//wrapper function for PlayCustomAnimation() so it is a void function
//can be called via DelayCommand or queued.
void HSS_PCTools_PlayCustomAnim(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0);

//destroys all objects in  oObject's inventory (not slots)
void HSS_DestroyAllInventory(object oObject);

//Converts an integer to a string.  If the integer is 1-9 it will convert it to
//a string with a leading zero. i.e. 7 will be returned "07".  Otherwise, it
//just performs a regular Int to String conversion.
string HSS_IntToLeadingZeroString(int nNumber);

//Returns item possessed by oCreature.  If found, it will cache that object
//as a local on oCreature and any subsequent call by this function will
//use the local to reference the object instead of doing an inventory
//iteration search via GetItemPossessedBy().
object HSS_GetItemPossessedBy_Cached(object oCreature, string sItemTag);

//called from a delaycommand when an object is created.  Will only destroy
//and decrement the count of object instances if the object actually exists.
void HSS_PCTools_DestroyAndDecrement(object oPC, object oObject, string sObject);

//Stores data to a DB depending upon the value of nStorageType. 0 = NWN DB,
//1 = NWNX DB, 2 = inventory item persistency. See constant HSS_PCTOOLS_DBTYPE
//above to switch DB type globally for all of this function's calls.
//oObject is the object the data is set on, sVarName is the variable name for the data,
//sDB is the database name (only used for native DB, NWNX uses hardcoded
//values that are switchable via the constants above).
//nDataType is the kind of data:
//Data Constants
//HSS_PC_TOOLS_INT = 1;
//HSS_PC_TOOLS_STRING = 2;
//HSS_PC_TOOLS_FLOAT = 3;
//HSS_PC_TOOLS_LOC = 4;
//HSS_PC_TOOLS_VEC = 5;
//HSS_PC_TOOLS_OBJ = 6;
//sValue is the actual data to be stored -- ALWAYS passed in as a string.
//the function will store the data to the type specified by nDataType
//nExpiration is used for NWNX calls only and sets an expiration value.
void HSS_PCTools_StorePersistentData(object oObject, string sVarName, string sDB, int nDataType, string sValue, int nExpiration = 0, int nStorageType = HSS_PCTOOLS_DBTYPE);

//retireves the persistent variable -- all return values are STRINGS
//use string conversion functions to turn them into their proper data type.
//see the store function of this type of function for more details.
string HSS_PCTools_RetrievePersistentData(object oObject, string sVarName, string sDB, int nDataType, int nStorageType = HSS_PCTOOLS_DBTYPE);

//converts a string to a vector. string format = "(float, float, float)"
//format is the same as the output from VectorToString().
vector HSS_StringToVector(string sVec);

//converts a string to a location.
//string format = "(AreaTagString) (float, float, float) (float)"
//format is the same as output from LocationToString().
location HSS_StringToLocation(string sLoc);

//returns true if sString has a section of text = "<color="
int HSS_PCTools_IsStringColoured(string sString);

//call on a delaycommand passing in the timer duration as the delay.
//when run, the function will set off an alarm notifying of timer
//expiration and the timer's label.
void HSS_PCTools_StartTimer(object oPC, int nTime, string sLabel, string sAlarm);

//displays a PC Tools message box.
void HSS_PCTools_DisplayMessageBox(object oPC, string sMsg, int nOkCB, int nCancelCB, int bShowCancel = TRUE, string sOk = "Yes", string sCancel = "No");




void main(string sParamString1, int nParamInt, float fParamFloat, string sParamString2, string sParamString3, int nParamInt2, float fParamFloat2, float fParamFloat3, float fParamFloat4)
{
   object oPC = OBJECT_SELF;
   string sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
   int nEventType = FloatToInt(fParamFloat);
   int nEventSub = nParamInt;
   int nString1 = StringToInt(sParamString1);
   string sString;
   

   //workaround code for the fact that the GUI call to execute the server
   //script is fired on the DM when he is possessing an NPC.  In short, all
   //commands get run on the DM object instead of the possessed creature.
   //DM's must select the creature they want to control and do any PC Tools
   //commands before possessing it (i.e. emotes, vfx's will be done on
   //the creature if it's selected and a DM is using PC Tools). For a DM
   //to use the tools on himself he just needs to have himself selected.
   object oTarget = GetPlayerCurrentTarget(oPC);   
   if (GetIsDM(oPC) && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
      {
      oPC = oTarget;
      }
   
  
   switch (nEventType)
       {
	   //init events
	   case 1:
       switch (nEventSub)
	       {
		   //gui popup
		   case 1:
		   DisplayGuiScreen(OBJECT_SELF, SCREEN_HSS_PC_TOOLS, FALSE, HSS_PC_TOOLS_XML);
		   break;
		   //on add -- pc tools
		   case 2:
		   HSS_PCTools_CleanPCLocals(oPC, FALSE);
           HSS_PCTools_OnGUIAdd(oPC);		   
		   break;
		   //on remove
		   case 3:
		   HSS_PCTools_CleanPCLocals(oPC, FALSE);		   
		   break;
		   //on create
		   case 4:
           HSS_PCTools_OnGUICreate(oPC);			   
		   break;
		   //on create -- custom button floater -- horizontal
		   case 5:
           HSS_PCTools_OnGUICreate(oPC, 2);			   
		   break;
		   //on create -- custom button floater -- vertical
		   case 6:
           HSS_PCTools_OnGUICreate(oPC, 3);			   
		   break;
		   //on create -- text macros -- vertical
		   case 7:
           HSS_PCTools_OnGUICreate(oPC, 4);			   
		   break;
		   //on add -- custom button floater -- horizontal
		   case 8:
           HSS_PCTools_OnGUIAdd(oPC, 2);		   
		   break;
		   //on add -- custom button floater -- vertical
		   case 9:
           HSS_PCTools_OnGUIAdd(oPC, 3);		   
		   break;
		   //on add -- text macros -- vertical
		   case 10:
           HSS_PCTools_OnGUIAdd(oPC, 4);		   
		   break;			   			   		   			   		   		   		   		   		   
		   }	   
	   break;
	   
	   //quick button events
	   case 2:
       switch (nEventSub)
	       {
		   //save character
		   case 1:
           HSS_PCTools_SaveCharacter(oPC, sPCID);
		   break;
		   //get time
		   case 2:
           HSS_PCTools_GetTime(oPC);
		   break;
		   //make location safe
		   case 3:
		   HSS_PCTools_MakeSafeLocation(oPC);
		   break;
		   //make campfire
		   case 4:
           HSS_PCTools_Create(oPC, "Campfire");
		   break;
		   //pitch tent
		   case 5:
           HSS_PCTools_Create(oPC, "Tent");
		   break;
		   //toggle AFK
		   case 6:
		   HSS_PCTools_ToggleAFK(oPC);
		   break;		   		   		   
		   }		   
	   break;
	   
	   //die roll events
	   case 3:
       switch (nEventSub)
	       {
		   //die number header 
		   case 100:
		   //die number specific
		   if (nString1 > 0)
		      {
			  SetLocalInt(oPC, "HSS_PCTOOLS_DIE_NUM", nString1);
			  SetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE", HSS_PC_TOOLS_DIE_STANDARD);
			  HSS_PCTools_SetGUIDieRollType(oPC, HSS_PC_TOOLS_DIE_STANDARD);
			  return;
			  }
           DeleteLocalInt(oPC, "HSS_PCTOOLS_DIE_NUM");
           DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
		   HSS_PCTools_DeleteGUIDieRollType(oPC);		   
		   break;
		   
		   //die type header
		   case 101:
		   //die type specific
		   if (nString1 > 0)
		      {
			  SetLocalInt(oPC, "HSS_PCTOOLS_DIE_TYPE", nString1);
			  SetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE", HSS_PC_TOOLS_DIE_STANDARD);
			  HSS_PCTools_SetGUIDieRollType(oPC, HSS_PC_TOOLS_DIE_STANDARD);
			  return;
			  }
           DeleteLocalInt(oPC, "HSS_PCTOOLS_DIE_TYPE");
		   DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
		   HSS_PCTools_DeleteGUIDieRollType(oPC); 
		   break;
		   
		   //save type header
		   case 102:
		   //save type specific
		   if (nString1 > 0)
		      {
			  SetLocalInt(oPC, "HSS_PCTOOLS_SAVE_TYPE", nString1);
			  SetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE", HSS_PC_TOOLS_DIE_SAVE);
			  HSS_PCTools_SetGUIDieRollType(oPC, HSS_PC_TOOLS_DIE_SAVE);
			  return;
			  }
           DeleteLocalInt(oPC, "HSS_PCTOOLS_SAVE_TYPE");
		   DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
		   HSS_PCTools_DeleteGUIDieRollType(oPC); 
		   break;
		   
		   //ability check header
		   case 103:
		   //ability type specific
		   if (nString1 > 0)
		      {
			  SetLocalInt(oPC, "HSS_PCTOOLS_ABILITY_TYPE", nString1);
			  SetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE", HSS_PC_TOOLS_DIE_ABILITY);
			  HSS_PCTools_SetGUIDieRollType(oPC, HSS_PC_TOOLS_DIE_ABILITY);
			  return;
			  }
           DeleteLocalInt(oPC, "HSS_PCTOOLS_ABILITY_TYPE");
		   DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
		   HSS_PCTools_DeleteGUIDieRollType(oPC); 
		   break;
		   //skill check header
		   case 104:
		   if (nString1 > 0)
		      {
			  SetLocalInt(oPC, "HSS_PCTOOLS_SKILL_TYPE", nString1);
			  SetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE", HSS_PC_TOOLS_DIE_SKILL);
			  HSS_PCTools_SetGUIDieRollType(oPC, HSS_PC_TOOLS_DIE_SKILL);
			  return;
			  }
           DeleteLocalInt(oPC, "HSS_PCTOOLS_SKILL_TYPE");
		   DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
		   HSS_PCTools_DeleteGUIDieRollType(oPC); 
		   break;
		   
		   //public button chosen
		   case 998:
           DeleteLocalInt(oPC, "HSS_PCTOOLS_BROADCAST_TYPE");		   
		   break;
		   
		   //private button chosen
		   case 999:
           SetLocalInt(oPC, "HSS_PCTOOLS_BROADCAST_TYPE", 1);
		   break;
		   
		   //roll button chosen
		   case 1000:
           HSS_PCToools_RollDie(oPC);
		   break;		   		   		   
		   }		   	   
	   break;
	   
	   //emote events
	   case 4:
	   //emote type chosen 
	   if (nEventSub < 100 && nEventSub > 0)
	      {
		  SetLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE", sParamString1);
		  SetLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE_2", sParamString2);
		  //using nEventSub as delay for second animation call if
		  //a second animation is given (workaround since the float param
		  //is used for the main event types -- second animation was an
		  //afterthought -- delays must be entered in xml as 10x actual
		  //value [i.e. delay of 2.5 is entered as 25] ).
		  //hehe, I didn't know, when I did this, that parameters are
		  //unlimited -- could have just added another. Doh! Unlikely to change now.
		  if (sParamString2 != "")
		     {
			 //seems empty strings ("") are now passed as "0" -- gah!
		     //this caused the looping option to fail -- bug fix.		 
		     if (sParamString2 != "0")
			    {
				SetLocalFloat(oPC, "HSS_PC_TOOLS_ANIM_DELAY", IntToFloat(nEventSub)/10.0);
				}
			 }		  
		  return;
		  }
	   //do emote or clear emote choice	  
       switch (nEventSub)
	       {   
		   //clear emote
		   case 100:
		   DeleteLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE");
		   break;
		   
		   //cease emote
		   case 101:
		   SetLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE", sParamString1);
           HSS_PCTools_DoEmote(oPC);
     	   break;
		   
		   //one-shot emote
		   case 102:
           DeleteLocalInt(oPC, "HSS_PC_TOOLS_ANIM_LOOP");
		   break;
		   
		   //looping emote
		   case 103:
           SetLocalInt(oPC, "HSS_PC_TOOLS_ANIM_LOOP", 1);
		   break;
		   		   		   		   		   		   		   
		   //do emote
		   case 1000:
		   HSS_PCTools_DoEmote(oPC);
		   break;		   
		   }	   
	   break;
       
	   //vfx request event	   
	   case 5:
       HSS_PCTools_ApplyVFX(oPC, sParamString1);
	   break;
	   
	   //Mic tab events	   
	   case 6:
	   if (nEventSub < 101)
		  {
		  if (sParamString1 == "click")
		     {
			 SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode entered -- click target.");
			 return;
			 }		  
          HSS_PCTools_CustomButton(oPC, nEventSub, fParamFloat2, fParamFloat3, fParamFloat4, nString1, nParamInt2);
		  return;			  
		  }
       switch (nEventSub)
	       {   
		   //object interaction -- remove
		   case 101:
		   
		   if (sParamString1 == "click")
		      {
			  SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode entered -- click target.");
			  return;
			  }
			  		   
           HSS_PCTools_Remove(oPC, nParamInt2);
		   break;
		   //object interaction -- autofollow
		   case 102:
		   
		   if (sParamString1 == "click")
		      {
			  SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode entered -- click target.");
			  return;
			  }
		   
		   if (GetIsDM(oPC))
		      {
			  ActionForceFollowObject(IntToObject(nParamInt2), 2.0);
			  return;
			  }
			  
		   if (!GetIsPC(IntToObject(nParamInt2)))
		      {
			  SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "You can only request to " +
			                 "auto follow other player characters.");
			  return;				 
			  }	  
			  
		   HSS_PCTools_DisplayMessageBox(IntToObject(nParamInt2), HSS_PCTOOLS_COLOUR1 +
		   "Auto follow has been requested by " + HSS_PCTOOLS_COLOUR2 +
		   GetName(oPC) + HSS_PCTOOLS_COLOUR1 + ". Will you grant this request?", 1, 2);
		   SetLocalGUIVariable(IntToObject(nParamInt2), SCREEN_HSS_PC_TOOLS_MSG_BOX, 100, IntToString(ObjectToInt(oPC)));
		   break;		   		   		   			   		   
		   }	    
	   break;
	   
	   //Config tab events	   
	   case 7:
       switch (nEventSub)
	       {   
		   //float -- yes
		   case 1:
           SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ABOUT_CBUT", TRUE);
		   DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_CB, FALSE, HSS_PC_TOOLS_CB_XML);
           CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB_V);
		   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 40, "yes");
		   		   
		   break;
		   
		   //float -- no
		   case 2:
           SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ABOUT_CBUT", FALSE);
		   CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB);
		   CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB_V);
		   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 40, "no");
			  							  		   
		   break;
		   
		   //float vertical -- yes
		   case 3:
           SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ABOUT_CBUT", TRUE);
		   CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB);
		   DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_CB_V, FALSE, HSS_PC_TOOLS_CB_V_XML);
		   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 40, "yesv");
		   		   
		   break;

		   //text macro -- yes		   
		   case 4:
		   DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_TM_V, FALSE, HSS_PC_TOOLS_TM_V_XML);
		   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 41, "yestm");
		   		   
		   break;
		   
		   //text macro -- no		   
		   case 5:
		   CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_TM_V);
		   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 41, "notm");
	   		   
		   break;
		   
		   //load min -- yes		   
		   case 6:
           return;
	   		   
		   break;		   

		   //load min -- no		   
		   case 7:
           return;
	   		   
		   break;		   
		   
		   case 50:
		   HSS_PCTools_StorePersistentData(oPC, "40", "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_STRING, sParamString1);		   
		   HSS_PCTools_StorePersistentData(oPC, "41", "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_STRING, sParamString2);
		   HSS_PCTools_StorePersistentData(oPC, "42", "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_STRING, sParamString3);										  
           SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "PC Tools startup settings saved.");										  		   		   
		   break;		   		   
		   }

	   break;	   

	   //text macros	   		   
	   case 8:
       switch (nEventSub)
	       {   
		   //
		   case 1:
           SpeakString(GetLocalString(oPC, sParamString1),
		              GetLocalInt(oPC, sParamString1 + "_VOLUME"));

		   break;

		   //macro page selection
		   case 10:
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_01", TRUE);
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_02", TRUE);		   
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_03", TRUE);		   
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_04", TRUE);
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_05", TRUE);		   		   
		  

		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_PAGE_PANE_" +
		                     HSS_IntToLeadingZeroString(nString1), FALSE);
													 					  			  
		   break;
		   
		   //apply macro label		   
		   case 100:
		   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_TM_V, sParamString2,
		                   -1, sParamString1);
		   HSS_PCTools_StorePersistentData(oPC, sParamString2 + "_LABEL", "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_STRING, sParamString1);
										  				 
		   break;
		   
		   //apply macro text		   
		   case 101:
	       if (HSS_PCTOOLS_STRIP_MACROS && HSS_PCTools_IsStringColoured(sParamString1))
		      {
			  sParamString1 = "Colour tags have been disallowed.";
			  }		   
           SetLocalString(oPC, sParamString2, sParamString1);
		   HSS_PCTools_StorePersistentData(oPC, sParamString2, "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_STRING, sParamString1);
										  
		   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_TM_V,
		                   "PC_TOOLS_TM_V_INPUT_TEXT", -1, " ");
					   						   								  						 		   
		   break;

		   //exit macro setup
		   case 103:
		   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_TM_V,
		                   "PC_TOOLS_TM_V_INPUT_TEXT", -1, " ");
		   break;
		   		   		   
		   //macro volume		   
		   case 110:
           SetLocalInt(oPC, sParamString2 + "_VOLUME", nString1);
		   HSS_PCTools_StorePersistentData(oPC, sParamString2 + "_VOLUME", "pctools--" + sPCID,
		                                  HSS_PC_TOOLS_INT, IntToString(nString1));
										  				 		   
		   break;		   		   		   
		   }

	   break;
	   
	   //timers	   		   
	   case 9:
	   
	      //start timer (local 80 -- label, local 81 -- duration, local 90 type)
	      switch (StringToInt(sParamString3))
		      {
			  case 1:
			  //SpeakString(IntToString(nParamInt));
			  if (sParamString1 == "" || nParamInt < 1 || nParamInt > 300)
			     {
				 SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "A label and duration both need to be set.");
				 return;
				 }
			  
			  if (GetLocalInt(oPC, "HSS_TIMERS_TOTAL") >= 3)
			     {
				 SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "You may only have a maximum of three concurrent timers active.");
				 return;				 
				 }	 
				 
			  SetLocalInt(oPC, "HSS_TIMERS_TOTAL", GetLocalInt(oPC, "HSS_TIMERS_TOTAL") + 1);
			  
              SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + 
			  "PC Tools Timer Started -- Timer " + HSS_PCTOOLS_COLOUR2 +
			  sParamString1 + "</c>" + " will expire after " + HSS_PCTOOLS_COLOUR2 +
			  IntToString(nParamInt) + "</c> minute(s).");
			   
              DelayCommand(IntToFloat(nParamInt * 60), HSS_PCTools_StartTimer(oPC, nParamInt, sParamString1, sParamString2));
			   
			  break;
			  }
		   
	   break;
	   
	   //Message Box Callbacks	   		   
	   case 10:
	   
	      switch (StringToInt(sParamString1))
		      {
			  //Save message
			  case 0:
			  SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR2 + "PC Tools Message Box Text: " +
			  "</c>" + sParamString1);
			  break;			  
			  //AutoFollow -- Yes
			  case 1:
			  SendMessageToPC(IntToObject(nParamInt), HSS_PCTOOLS_COLOUR1 +
			  "Auto follow request granted by " + HSS_PCTOOLS_COLOUR2 +
			  GetName(oPC) + HSS_PCTOOLS_COLOUR1 + ".");
			  AssignCommand(IntToObject(nParamInt), ActionForceFollowObject(oPC, 2.0));
			  break;
			  //AutoFollow -- No
			  case 2:
			  SendMessageToPC(IntToObject(nParamInt), HSS_PCTOOLS_COLOUR1 +
			  "Auto follow request denied by " + HSS_PCTOOLS_COLOUR2 +
			  GetName(oPC) + HSS_PCTOOLS_COLOUR1 + ".");			  
			  break;			  
			  }
	   
	   break;	   	   	   	   
	   }
   
 
}

void HSS_PCTools_CleanPCLocals(object oPC, int nBroadcast = TRUE)
{
   DeleteLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");   
   DeleteLocalInt(oPC, "HSS_PCTOOLS_DIE_NUM");
   DeleteLocalInt(oPC, "HSS_PCTOOLS_DIE_TYPE");   
   DeleteLocalInt(oPC, "HSS_PCTOOLS_SAVE_TYPE");
   DeleteLocalInt(oPC, "HSS_PCTOOLS_ABILITY_TYPE");
   DeleteLocalInt(oPC, "HSS_PCTOOLS_SKILL_TYPE");
   DeleteLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE"); 
   DeleteLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE_2");      
   DeleteLocalFloat(oPC, "HSS_PC_TOOLS_ANIM_DELAY");
   
   if (nBroadcast)
      {	     
      DeleteLocalInt(oPC, "HSS_PCTOOLS_BROADCAST_TYPE");
      DeleteLocalInt(oPC, "HSS_PC_TOOLS_ANIM_LOOP");	  
      }
}

void HSS_PCTools_OnGUICreate(object oPC, int nGUI = 1)
{
   string sHelp;
   int nCount = 1;
   string sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
     
   switch (nGUI)
       {
	   case 1:
       //big ass string -- help text -- easier to edit if present in script
       //rather than the xml.
       sHelp = HSS_PCTOOLS_COLOUR2+"<b><i>Interface:</i></b>" + HSS_PCTOOLS_COLOUR_END +
       "\n\n" +
	   "You can drag PC Tools by <b>Lclick+hold</b> on "+
       "the PC Tools icon. <b>Rclick</b> on the icon will minimize the entire menu down to "+
       "only the icon. <b>Lclick</b> on the icon will restore the menu." +
	   "\n\n"+
       "The six <b>quick buttons</b> are activated by simply "+
       "clicking on them. '<b>Save Character</b>' will export your character. '<b>Check Time</b>' "+
       "will message you the date/time. '<b>Safe Location</b>' will attempt to "+
       "unstick you if you are trapped in a non-pathable spot. '<b>Build Campfire</b>' "+
       "will create a campfire object that will destroy its inventory when it "+
       "is destroyed (server rules on object creation may apply). '<b>Pitch Tent</b>' "+
       "will create a tent object (server rules on object creation may apply). "+
       "Created objects can be destroyed by navigating to the '<b>Miscellaneous</b>' "+
       "tab, using the '<b>Remove</b>' button and then targeting the object. "+
       "If not removed, then created objects will decay on their own after a period of time. "+
       "'<b>Toggle AFK</b>' will apply a visual effect to your character "+
       "to indicate that you are not present. Using the button when the effect is "+
       "already present will remove the effect."+
       "\n\n"+   
       HSS_PCTOOLS_COLOUR2+"<b><i>Collapsable Subsections:</i></b>"+ HSS_PCTOOLS_COLOUR_END +
	   "\n\n"+
       "The '<b>Die Rolls</b>' section "+
       "is used by selecting the type of roll you want to make and then pressing "+
       "the '<b>Roll!</b>' button.  Only one type of roll can be made at one time: "+
       "Standard, Saves, Ability and Skill.  Standard rolls require a die type "+
       "and number of dice to roll to be chosen.  If no number is selected, then "+
       "a single dice of the type chosen will be rolled.  The other roll types "+
       "just require a choice to be selected and then use of the '<b>Roll!</b>' button. "+
       "You can clear any selection made by clicking on the header button text that "+
       "titles each section.  Furthermore, you can choose to '<b>Roll Publically</b>' "+
       "or '<b>Roll Privately</b>': public rolls are presented as spoken text by "+
       "your character and private rolls are messaged to you."+
       "\n\n"+
       "The '<b>Emotes</b>' section is the most intensive of the subsections. "+
       "Within this section you can invoke animations for your PC as well as "+
       "apply visual effects props.  The '<b>Postures</b>' pane allows you to "+
       "choose postures or stances for your character which will always be looping. "+
       "To cancel a posture cleanly use the corresponding <color=red><i>italic red</i></c> "+
       "emote option from the pane and hit '<b>Emote</b>'. "+
       " In all other cases where no <color=red><i>italic red</i></c> "+
       "option is available the emote is cancelled via the '<b>Cease</b>' button. "+
       "'<b>Posture Modifications</b>' can be invoked if you have a posture already "+
       "in use.  These are usually called as '<b>One-Shot</b>' animations, but "+
       "they can be called as '<b>Looping</b>' animations.  For instance, you can "+
       "be in the kneel down posture and then subsequently call the kneel fidget "+
       "modification.  If called as a looping modification you would keep on "+
       "fidgeting until you call an <color=#2CAE2C><i>italic green</i></c> idle "+
       "modification to return to the base idle posture. Or, you could simply call "+
       "the <color=red><i>Kneel Up</i></c> animation to cancel the posture entirely "+
       "and return to a normal standing posture.  Apart from the '<b>VFX Props</b>' "+
       "section all of the other sections are used by simply selecting your emote, "+
       "choosing '<b>One-Shot</b>' or '<b>Looping</b>' and then hitting the '<b>Emote!</b>' "+
       "button.  If you are running a looping animation use the '<b>Cease!</b>' "+
       "button to cancel the animation when you are ready.  The '<b>VFX Props</b>' "+
       "section allows you to equip visual effects props onto your character "+
       "(server rules on vfx prop application may apply).  To use a prop you need "+
       "only to select it from the list.  If you already have a prop applied it will "+
       "be removed before your new choice is applied.  To remove a prop without "+
       "applying another one click on the header button text that titles the section. "+
       "Clicking on any other header button text will clear the selection of any "+
       "emote type buttons for the emote panes."+
       "\n\n"+
       "The '<b>Miscellaneous</b>' section holds the rest of PC Tools functionality "+
       "access.  Previously mentioned, the '<b>Object Interaction</b>' tab allows "+
       "you to remove any object that has been created using PC Tools via the '<b>Remove</b>' button. " +
	   "Also within this section is the '<b>Auto Follow</b>' button which allows your character "+
	   "to follow another PC automatically. Click the button and then the intended PC. "+
	   "The intended PC will then be asked if they will allow your PC to auto follow. "+
	   "If the answer is no, you will be informed and if the answer is yes you will begin auto following. "+
	   "The '<b>Timers</b>' button will open up the timers pane over top of the '<b>Custom Buttons</b>' "+
	   "section. Here you can set alarm clock style timers which will give off a notification "+
	   "upon expiration. You set the duration in (real) minutes, a label for the timer and "+
	   "the type of alarm. Alarms can be a message, a message with a string posted to your screen "+
	   "or a message with a red screen flash. Timers are limited to a maximum duration of 120 minutes "+
	   "and you can only have 3 timers active at any one time. When you have the timer setup press the "+
	   "'<b>Start</b>' button and it will begin. "+
	   "The '<b>Custom Buttons</b>' "+
       "section allows builders to add in their own customized code to extend PC Tools "+
       "capabilities to meet the builder's needs.  Refer to module or world documentation "+
       "for description of any custom button functionality that may be available. "+
       "The '<b>Plugins</b>' section is to allow easier integration of other 3rd party "+
       "GUI packages and, if enabled, the buttons present will launch their named "+
       "GUI package.  Any functionality offered by another 3rd party package is "+
       "active after the plugin button is pressed and is not PC Tools functionality "+
       "-- see the proper package documentation for questions, etc.  The '<b>Options</b>' "+
       "tab launches the options window which allows end-user configuration. "+
       "The '<b>Help</b>' tab launches this screen and the '<b>About</b>' box contains "+
       "version information, minimum required game version, current game version "+
       "and contact information.";
   
 
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM1_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM1_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM2_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM2_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM3_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM3_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM4_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM4_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM5_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM5_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM6_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM6_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM7_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM7_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM8_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM8_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM9_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM9_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM10_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM10_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM11_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM11_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM12_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM12_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM13_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM13_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM14_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM14_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM15_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM15_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM16_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM16_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM17_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM17_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM18_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM18_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM19_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM19_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM20_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM20_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM21_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM21_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM22_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM22_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM23_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM23_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM24_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM24_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM25_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM25_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM26_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM26_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM27_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM27_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM28_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM28_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM29_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM29_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM30_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM30_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM31_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM31_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM32_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM32_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM33_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM33_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM34_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM34_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM35_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM35_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CUSTOM36_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM36_TEXT);						   					   
  
	   	   
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_HELP_TEXT", -1,
    				   sHelp);
                                         
       if (HSS_PCTOOLS_DMFI_PLUGIN_PC == 1)
          {
          SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 600, "true");
          }
          else
          {
          SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 600, "false");      
          }
		  
       SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 10,
                          "homepage.ntlworld.com/kbyiers/NWN/");
						  
	      
	   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "40", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		
	   if (sHelp != "")
		  {
		  SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 40, sHelp);
		  }
		  else
		  {
	      SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 40, "no");		  
		  }
		  
	   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "41", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		
	   if (sHelp != "")
		  {
		  SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 41, sHelp);
		  }
		  else
		  {
	      SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 41, "notm");		  
		  }
		  
	   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		
	   if (sHelp != "")
		  {
		  SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 42, sHelp);
		  }
		  else
		  {
	      SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, 42, "nomin");		  
		  }
	  	   	   						  
	   break;
	   
	   //Custom Button Floater -- Horizontal
	   case 2:
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM1_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM1_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM2_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM2_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM3_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM3_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM4_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM4_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM5_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM5_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM6_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM6_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM7_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM7_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM8_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM8_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM9_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM9_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM10_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM10_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM11_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM11_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM12_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM12_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM13_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM13_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM14_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM14_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM15_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM15_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM16_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM16_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM17_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM17_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM18_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM18_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM19_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM19_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM20_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM20_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM21_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM21_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM22_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM22_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM23_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM23_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM24_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM24_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM25_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM25_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM26_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM26_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM27_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM27_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM28_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM28_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM29_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM29_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM30_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM30_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM31_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM31_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM32_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM32_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM33_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM33_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM34_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM34_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM35_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM35_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CUSTOM36_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM36_TEXT);					   					   	   
	   break;
	   
	   //Custom Button Floater -- Vertical
	   case 3:
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM1_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM1_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM2_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM2_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM3_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM3_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM4_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM4_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM5_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM5_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM6_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM6_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM7_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM7_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM8_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM8_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM9_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM9_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM10_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM10_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM11_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM11_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM12_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM12_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM13_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM13_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM14_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM14_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM15_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM15_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM16_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM16_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM17_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM17_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM18_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM18_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM19_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM19_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM20_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM20_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM21_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM21_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM22_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM22_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM23_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM23_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM24_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM24_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM25_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM25_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM26_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM26_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM27_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM27_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM28_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM28_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM29_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM29_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM30_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM30_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM31_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM31_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM32_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM32_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM33_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM33_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM34_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM34_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM35_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM35_TEXT);
       SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CUSTOM36_BUTTON", -1,
    				   HSS_PCTOOLS_CUSTOM36_TEXT);		   
	   break;

	   //text macro vertical	   
	   case 4:

	   //load saved macro data	   
	   while (nCount <= 45)
	       {
		   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "PC_TOOLS_MACRO_BUTTON_" +
						       HSS_IntToLeadingZeroString(nCount) + "_LABEL", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
							
		   if (sHelp != "")
		      {
		      SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_MACRO_BUTTON_" + HSS_IntToLeadingZeroString(nCount),
		                      -1, sHelp);			  
			  }
			  
		   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "PC_TOOLS_MACRO_BUTTON_" +
						       HSS_IntToLeadingZeroString(nCount), "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   if (sHelp != "")
		      {
			  SetLocalString(oPC, "PC_TOOLS_MACRO_BUTTON_" + HSS_IntToLeadingZeroString(nCount), sHelp);				  			  
			  }

		   sHelp = HSS_PCTools_RetrievePersistentData(oPC, "PC_TOOLS_MACRO_BUTTON_" +
						       HSS_IntToLeadingZeroString(nCount) + "_VOLUME", "pctools--" + sPCID, HSS_PC_TOOLS_INT);
		   if (sHelp != "")
		      {
			  SetLocalInt(oPC, "PC_TOOLS_MACRO_BUTTON_" + HSS_IntToLeadingZeroString(nCount) + "_VOLUME", StringToInt(sHelp));				  			  
			  }
			  							   			  			  			  					
		   nCount++;
		   }

	   //we're on page 1 -- need a space or single quotes when passing
	   //a pure int -- engine bug	   
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS_TM_V, 55, "'1'");
	   	   
	   break;	   	   
	   }
	  
      
}

void HSS_PCTools_OnGUIAdd(object oPC, int nGUI = 1)
{
   string sString;
   int nCount = 1;
   string sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
     
   switch (nGUI)
       {
	   //PC Tools
	   case 1:	   
	   sString = HSS_PCTools_RetrievePersistentData(oPC, "40", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);	
		   	   
	   if (sString == "yes")
		  {
		  DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_CB, FALSE, HSS_PC_TOOLS_CB_XML);
		  CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB_V);
          SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ABOUT_CBUT", TRUE);		  
			  
	      sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
		  if (sString == "nomin" || sString == "")
		     {
		     SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CB_ROOT_PANE", FALSE);
			 }				  
		  }
		  else
		  if (sString == "yesv")
		  {
		  DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_CB_V, FALSE, HSS_PC_TOOLS_CB_V_XML);
		  CloseGUIScreen(oPC, SCREEN_HSS_PC_TOOLS_CB);
          SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ABOUT_CBUT", TRUE);
		  		  			  
	      sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
		  if (sString == "nomin" || sString == "")
		     {
		     SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CB_V_ROOT_PANE", FALSE);
			 }			  			  			 
		  }

	    sString = HSS_PCTools_RetrievePersistentData(oPC, "41", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
		if (sString == "yestm")
		   {
		   DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_TM_V, FALSE, HSS_PC_TOOLS_TM_V_XML);
			  
	       sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
		   if (sString == "nomin" || sString == "")
		      {
		      SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_ROOT_PANE", FALSE);
			  }				  
		   }
			  
	    sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
		if (sString == "nomin" || sString == "")
		   {
		   SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_ROOT_PANE", FALSE);
		   }			  		  
		  	   	   						  
	   break;
	   
	   //Custom Button Floater -- Horizontal
	   case 2:
	   sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
	   if (sString == "nomin" || sString == "")
		  {
		  SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CB_ROOT_PANE", FALSE);
		  }	   
	   break;
	   
	   //Custom Button Floater -- Vertical
	   case 3:
	   sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
	   if (sString == "nomin" || sString == "")
		  {
		  SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CB_V_ROOT_PANE", FALSE);
		  }		   
	   break;

	   //text macro vertical	   
	   case 4:
	   sString = HSS_PCTools_RetrievePersistentData(oPC, "42", "pctools--" + sPCID, HSS_PC_TOOLS_STRING);
		   			  
	   if (sString == "nomin" || sString == "")
		  {
		  SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_TM_V, "PC_TOOLS_TM_V_ROOT_PANE", FALSE);
		  }	
	   break;	   	   
	   }
}

void HSS_PCTools_SaveCharacter(object oPC, string sPCID)
{
   h2_SavePCLocation(oPC);
   string sMsg = HSS_SAVE_MESSAGE;

   if (HSS_PCTOOLS_SAVE_LOC)
      {
      HSS_PCTools_StorePersistentData(oPC, HSS_PCTOOLS_LOC_VAR, "pctools--" + sPCID,
                          HSS_PC_TOOLS_LOC, LocationToString(GetLocation(oPC)));
	  sMsg = HSS_SAVE_MESSAGE_W_LOC;	  
	  }

   ExportSingleCharacter(oPC);
   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + sMsg);
}

void HSS_PCTools_GetTime(object oPC)
{
	ExecuteScript("gui_alex_checkdate", oPC);
	
/*
   int nHour = GetTimeHour();
   int nMinute = GetTimeMinute();
   int nDay = GetCalendarDay();
   int nMonth = GetCalendarMonth();
   int nYear = GetCalendarYear();
   string sDay;
   string sMonth;
   string sAm;
   string sMsg;
   */

/* GreyHawk Calendar   	  
   switch (nDay)
       {
       case 1:
       case 8:
       case 15:
       case 22:
       sDay = "Starday";
       break;
	   
       case 2:
       case 9:
       case 16:
       case 23:
       sDay = "Sunday";
       break;
	   
       case 3:
       case 10:
       case 17:
       case 24:
       sDay = "Moonday";
       break;
	   
       case 4:
       case 11:
       case 18:
       case 25:
       sDay = "Godsday";
       break;
	   
       case 5:
       case 12:
       case 19:
       case 26:
       sDay = "Waterday";
       break;
	   
       case 6:
       case 13:
       case 20:
       case 27:
       sDay = "Earthday";
       break;
	   
       case 7:
       case 14:
       case 21:
       case 28:
       sDay = "Freeday";
       break;	   	   	   	   	  	   	   
       }
   
   switch (nMonth)
       {
       case 1:
       sMonth = "Fireseek";
       break;
	   
       case 2:
       sMonth = "Readying";
       break;
	   
       case 3:
       sMonth = "Coldeven";
       break;
	   
       case 4:
       sMonth = "Planting";
       break;
	   
       case 5:
       sMonth = "Flocktime";
       break;
	   
       case 6:
       sMonth = "Wealsun";
       break;
	   
       case 7:
       sMonth = "Reaping";
       break;
	   
       case 8:
       sMonth = "Goodmonth";
       break;
	   
       case 9:
       sMonth = "Harvester";
       break;
	   
       case 10:
       sMonth = "Patchwall";
       break;
	   
       case 11:
       sMonth = "Ready'reat";
       break;
	   
       case 12:
       sMonth = "Sunsebb";
       break;	   	   	   	   	   	   	   	   	   	  	   	   
       }
*/	   
/*
   //Gregorian(ish) Calendar   	  
   switch (nDay)
       {
       case 1:
       case 8:
       case 15:
       case 22:
       sDay = "Sunday";
       break;
	   
       case 2:
       case 9:
       case 16:
       case 23:
       sDay = "Monday";
       break;
	   
       case 3:
       case 10:
       case 17:
       case 24:
       sDay = "Tuesday";
       break;
	   
       case 4:
       case 11:
       case 18:
       case 25:
       sDay = "Wednesday";
       break;
	   
       case 5:
       case 12:
       case 19:
       case 26:
       sDay = "Thursday";
       break;
	   
       case 6:
       case 13:
       case 20:
       case 27:
       sDay = "Friday";
       break;
	   
       case 7:
       case 14:
       case 21:
       case 28:
       sDay = "Saturday";
       break;	   	   	   	   	  	   	   
       }
   
   switch (nMonth)
       {
       case 1:
       sMonth = "January";
       break;
	   
       case 2:
       sMonth = "February";
       break;
	   
       case 3:
       sMonth = "March";
       break;
	   
       case 4:
       sMonth = "April";
       break;
	   
       case 5:
       sMonth = "May";
       break;
	   
       case 6:
       sMonth = "June";
       break;
	   
       case 7:
       sMonth = "July";
       break;
	   
       case 8:
       sMonth = "August";
       break;
	   
       case 9:
       sMonth = "September";
       break;
	   
       case 10:
       sMonth = "October";
       break;
	   
       case 11:
       sMonth = "November";
       break;
	   
       case 12:
       sMonth = "December";
       break;	   	   	   	   	   	   	   	   	   	  	   	   
       }
	   
   if (nHour > 12)
      {
      nHour = nHour - 12;
      sAm = "pm";
      }
      else
      {
      sAm = "am";
      }	

   //GetTimeMinute() is whacked -- best we can do is hour level precision.
   //Remove if the function ever gets fixed.   	  
   nMinute = 0; 	  
     
   sMsg = sDay + ", " + sMonth + " " + HSS_IntToLeadingZeroString(nDay) + 
          ", " + IntToString(nYear) + "." + "   " + IntToString(nHour) +
     	  " : " + HSS_IntToLeadingZeroString(nMinute) + " " + sAm;


   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Date/Time is:  " + sMsg);
   */

}

void HSS_PCTools_MakeSafeLocation(object oPC)
{
   if (GetLocalInt(oPC, "HSS_PCTOOLS_NO_MAKESAFE") ||
      GetLocalInt(GetArea(oPC), "HSS_PCTOOLS_NO_MAKESAFE"))
      {
      SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_NO_MAKESAFE_MESSAGE);
      return;      
      }
      
   JumpToLocation(CalcSafeLocation(oPC, GetLocation(oPC), 3.0, FALSE, FALSE));
   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_SAFE_LOC_MESSAGE);
}

void HSS_PCTools_Create(object oPC, string sItem = "Tent")
{
   string sID;
   location lLoc;
   object oCreate;
   object oItem;
   string sAnim;
   object oArea = GetArea(oPC);
   object oMod = GetModule();
   string sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
   int nTentCount = GetLocalInt(oMod, "HSS_PCTOOLS_TENT_ITEM_COUNT_" + sPCID);
   int nFireCount = GetLocalInt(oMod, "HSS_PCTOOLS_CAMPFIRE_ITEM_COUNT_" + sPCID);

   if (HSS_PCTOOLS_OBJECT_CREATE_RESTRICT == 1 && !GetIsDM(oPC) && GetIsPC(oPC))
      {
      if (GetIsAreaAboveGround(oArea) && GetIsAreaInterior(oArea) &&  
         !GetIsAreaNatural(oArea))
         {
         SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 +
         HSS_CREATION_RESTRICT_MESSAGE);
         return;          
         }
      }   

   if (sItem == "Campfire")
      {
      if (nFireCount >= HSS_PCTOOLS_CAMPFIRE_ITEM_LIMIT &&
         HSS_PCTOOLS_CAMPFIRE_ITEM_LIMIT != -1)
         {
         if (!GetIsDM(oPC) && GetIsPC(oPC))
            {
            SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_ITEM_LIMIT_MESSAGE);
            return;
            }         
         }
         
      if (HSS_PCTOOLS_CAMPFIRE_ITEM != "" && !GetIsDM(oPC) && GetIsPC(oPC))
         {
         oItem = HSS_GetItemPossessedBy_Cached(oPC, HSS_PCTOOLS_CAMPFIRE_ITEM);
         
         if (!GetIsObjectValid(oItem))
            {
            SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_NO_ITEM_MESSAGE);
            return;
            }
         }

      sAnim = "disableground";                           
      sID = "HSS_PCTOOLS_CAMPFIRE";   
	  lLoc = CalcSafeLocation(oPC, GetAheadLocation(oPC, DISTANCE_TINY),
                0.1,FALSE, FALSE);
      oCreate = CreateObject(OBJECT_TYPE_PLACEABLE, "hss_campfire_01",
                     lLoc, FALSE, sID);
      SetLocalInt(oMod, "HSS_PCTOOLS_CAMPFIRE_ITEM_COUNT_" + sPCID,
      nFireCount + 1);
      SetLocalString(oCreate, "HSS_PCTOOLS_CREATOR", 
      "HSS_PCTOOLS_CAMPFIRE_ITEM_COUNT_" + sPCID);
      				  
      DelayCommand(HSS_OBJECT_DECAY, HSS_DestroyAllInventory(oCreate));
      DelayCommand(HSS_OBJECT_DECAY + 1.0, HSS_PCTools_DestroyAndDecrement(oMod,
      oCreate, "HSS_PCTOOLS_CAMPFIRE_ITEM_COUNT_" + sPCID));      
	  }
	  else
	  if (sItem == "Tent")
	  {
      if (nTentCount >= HSS_PCTOOLS_TENT_ITEM_LIMIT &&
         HSS_PCTOOLS_TENT_ITEM_LIMIT != -1)
         {
         if (!GetIsDM(oPC) && GetIsPC(oPC))
            {         
            SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_ITEM_LIMIT_MESSAGE);
            return;
            }         
         }      
      if (HSS_PCTOOLS_TENT_ITEM != "" && !GetIsDM(oPC) && GetIsPC(oPC))
         {
         oItem = HSS_GetItemPossessedBy_Cached(oPC, HSS_PCTOOLS_TENT_ITEM);
                 
         if (!GetIsObjectValid(oItem))
            {
            SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_NO_ITEM_MESSAGE);
            return;
            }
         }

      sAnim = "disablefront";                        
      sID = "HSS_PCTOOLS_TENT";      
      lLoc = CalcSafeLocation(oPC, GetAheadLocation(oPC, DISTANCE_SHORT),
                   0.1,FALSE, FALSE);
      oCreate = CreateObject(OBJECT_TYPE_PLACEABLE, "hss_tent_01",
                     lLoc, FALSE, sID);
      SetLocalInt(oMod, "HSS_PCTOOLS_TENT_ITEM_COUNT_" + sPCID,
      nTentCount + 1);
      SetLocalString(oCreate, "HSS_PCTOOLS_CREATOR", 
      "HSS_PCTOOLS_TENT_ITEM_COUNT_" + sPCID);      
      				  
      DelayCommand(HSS_OBJECT_DECAY, HSS_PCTools_DestroyAndDecrement(oMod,
      oCreate, "HSS_PCTOOLS_TENT_ITEM_COUNT_" + sPCID));
      }

   if (sAnim != "")
      {
      ActionDoCommand(HSS_PCTools_PlayCustomAnim(oPC, sAnim, TRUE));
      ActionDoCommand(DelayCommand(4.0, HSS_PCTools_PlayCustomAnim(oPC, "%", FALSE)));         	          
      }    

}

void HSS_PCTools_ToggleAFK(object oPC)
{
   effect eAFK;
   
   switch (HSS_PCTOOLS_AFK_VFX)
       {
	   case 1:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_01"), -999));	   
	   break;
	   
	   case 2:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_02"), -999));	   
	   break;
	   
	   case 3:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_03"), -999));	   
	   break;
	   
	   case 4:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_04"), -999));	   
	   break;	
	   
	   case 5:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_05"), -999));	   
	   break;
	   
	   case 6:
       eAFK = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile("fx_hss_afk_06"), -999));	   
	   break;	   		      	   	   	   
	   }
	   
   
   effect eFirst = GetFirstEffect(oPC);
   
   while (GetIsEffectValid(eFirst))
       {
	   if (GetEffectSpellId(eFirst) == -999)
	      {
		  RemoveEffect(oPC, eFirst);
		  SetLocalInt(oPC, "hv_player_afk", 0);
		  return;
		  }
	   eFirst = GetNextEffect(oPC);	  
	   }
   
   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAFK, oPC);   
   SetLocalInt(oPC, "hv_player_afk", 1);
}

void HSS_PCToools_RollDie(object oPC)
{
   int nRollType = GetLocalInt(oPC, "HSS_PCTOOLS_ROLL_TYPE");
   
   int nDieNum = GetLocalInt(oPC, "HSS_PCTOOLS_DIE_NUM");
   int nDieType = GetLocalInt(oPC, "HSS_PCTOOLS_DIE_TYPE");
   
   int nSaveType = GetLocalInt(oPC, "HSS_PCTOOLS_SAVE_TYPE");
   int nAbilityType = GetLocalInt(oPC, "HSS_PCTOOLS_ABILITY_TYPE");
   int nSkillType = GetLocalInt(oPC, "HSS_PCTOOLS_SKILL_TYPE");
   
   int nBroadcast = GetLocalInt(oPC, "HSS_PCTOOLS_BROADCAST_TYPE");

   int nVal1;
   int nRoll;
   int nRank;
   string sMsg;
   string sSkill;
   float fAnimDelay;
   
   switch (nRollType)
       {
	   //standard die
	   case HSS_PC_TOOLS_DIE_STANDARD:
       if (nDieNum == 0)
          {
          nDieNum = 1;
          }       
	   switch (nDieType)
	       {
		   case 2:
		   nVal1 = d2(nDieNum);
		   break;
		   
		   case 4:
		   nVal1 = d4(nDieNum);
		   break;
		   
		   case 6:
		   nVal1 = d6(nDieNum);
		   break;
		   
		   case 8:
		   nVal1 = d8(nDieNum);
		   break;
		   
		   case 10:
		   nVal1 = d10(nDieNum);
		   break;
		   
		   case 12:
		   nVal1 = d12(nDieNum);
		   break;
		   
		   case 20:
		   nVal1 = d20(nDieNum);
		   break;
		   
		   case 100:
		   nVal1 = d100(nDieNum);
		   break;		   		   		   		   		   		   		   
		   }
	   
	   sMsg = HSS_PCTOOLS_COLOUR1 + "*Rolled " + HSS_PCTOOLS_COLOUR2 + 
	   IntToString(nVal1) + HSS_PCTOOLS_COLOUR1 + " on " + 
	   HSS_PCTOOLS_COLOUR2 + "("+ IntToString(nDieNum) + ")" + 
	   HSS_PCTOOLS_COLOUR1 + " d" + IntToString(nDieType) + "*";
	   
       SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_STANDARD, "TRUE");	   	    
	   break;
	   
	   //saves
	   case HSS_PC_TOOLS_DIE_SAVE:
       switch (nSaveType)
          {
	      case SAVING_THROW_FORT:
		  nRank = GetFortitudeSavingThrow(oPC);
	      nRoll = d20();
		  sSkill = HSS_PCTOOLS_COLOUR2 + "Fortitude" + HSS_PCTOOLS_COLOUR_END;
	      break;
	   
	      case SAVING_THROW_REFLEX:
		  nRank = GetReflexSavingThrow(oPC);
	      nRoll = d20();
		  sSkill = HSS_PCTOOLS_COLOUR2 + "Reflex" + HSS_PCTOOLS_COLOUR_END;
	      break;
	   
	      case SAVING_THROW_WILL:
		  nRank = GetWillSavingThrow(oPC);
	      nRoll = d20();
		  sSkill = HSS_PCTOOLS_COLOUR2 + "Will" + HSS_PCTOOLS_COLOUR_END;
	      break;
		  }
		  
	   sMsg = sSkill + HSS_PCTOOLS_COLOUR2 + " Save: " + HSS_PCTOOLS_COLOUR1 +
	   "Rank: " + HSS_PCTOOLS_COLOUR2 + IntToString(nRank) +
	   HSS_PCTOOLS_COLOUR1 + " + Roll: " + HSS_PCTOOLS_COLOUR2 +
	   IntToString(nRoll) + HSS_PCTOOLS_COLOUR1 + " = " + HSS_PCTOOLS_COLOUR2 + 
	   IntToString(nRank + nRoll) + HSS_PCTOOLS_COLOUR1 + ".";
	   
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SAVE, "TRUE");		  	   
	   break;

	   //ability	   
	   case HSS_PC_TOOLS_DIE_ABILITY:
	   switch (nAbilityType)
	       {
		   //str
		   case 1:
		   nRank = GetAbilityModifier(ABILITY_STRENGTH, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Strength" + HSS_PCTOOLS_COLOUR_END;		   
		   break;
		   
		   //dex
		   case 2:
		   nRank = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Dexterity" + HSS_PCTOOLS_COLOUR_END;		   		   
		   break;
		   
		   //con
		   case 3:
		   nRank = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Constitution" + HSS_PCTOOLS_COLOUR_END;			   
		   break;
		   
		   //int
		   case 4:
		   nRank = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Intelligence" + HSS_PCTOOLS_COLOUR_END;		   
		   break;
		   
		   //wis
		   case 5:
		   nRank = GetAbilityModifier(ABILITY_WISDOM, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Wisdom" + HSS_PCTOOLS_COLOUR_END;		   
		   break;
		   
		   //cha
		   case 6:
		   nRank = GetAbilityModifier(ABILITY_CHARISMA, oPC);
	       nRoll = d20();
		   sSkill = HSS_PCTOOLS_COLOUR2 + "Charisma" + HSS_PCTOOLS_COLOUR_END;		   
		   break;		   		   		   		   		   
		   }

	   sMsg = sSkill + HSS_PCTOOLS_COLOUR2 + " Check: " + HSS_PCTOOLS_COLOUR1 +
	   "Bonus: " + HSS_PCTOOLS_COLOUR2 + IntToString(nRank) +
	   HSS_PCTOOLS_COLOUR1 + " + Roll: " + HSS_PCTOOLS_COLOUR2 +
	   IntToString(nRoll) + HSS_PCTOOLS_COLOUR1 + " = " + HSS_PCTOOLS_COLOUR2 + 
	   IntToString(nRank + nRoll) + HSS_PCTOOLS_COLOUR1 + ".";
	   		   	   
       SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_ABILITY, "TRUE");	   
	   break;
	   
	   //skill
	   case HSS_PC_TOOLS_DIE_SKILL:
       switch (nSkillType)
	       {
		    //appraise
	        case 1:
		    nRank = GetSkillRank(SKILL_APPRAISE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Appraise" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //bluff
	        case 2:
		    nRank = GetSkillRank(SKILL_BLUFF, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Bluff" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //concentration
	        case 3:
		    nRank = GetSkillRank(SKILL_CONCENTRATION, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Concentration" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //craft alchemy
	        case 4:
		    nRank = GetSkillRank(SKILL_CRAFT_ALCHEMY, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Craft Alchemy" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //craft armour
	        case 5:
		    nRank = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Craft Armour" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //craft trap
	        case 6:
		    nRank = GetSkillRank(SKILL_CRAFT_TRAP, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Craft Trap" + HSS_PCTOOLS_COLOUR_END;
	        break;			
	        //craft weapon
	        case 7:
		    nRank = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Craft Weapon" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //diplomacy
	        case 8:
		    nRank = GetSkillRank(SKILL_DIPLOMACY, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Diplomacy" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //disable trap
	        case 9:
		    nRank = GetSkillRank(SKILL_DISABLE_TRAP, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Disable Trap" + HSS_PCTOOLS_COLOUR_END;
	        break;
		    //heal
	        case 10:
		    nRank = GetSkillRank(SKILL_HEAL, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Heal" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //hide
	        case 11:
		    nRank = GetSkillRank(SKILL_HIDE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Hide" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //intimidate
	        case 12:
		    nRank = GetSkillRank(SKILL_INTIMIDATE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Intimidate" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //listen
	        case 13:
		    nRank = GetSkillRank(SKILL_LISTEN, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Listen" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //lore
	        case 14:
		    nRank = GetSkillRank(SKILL_LORE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Lore" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //move silently
	        case 15:
		    nRank = GetSkillRank(SKILL_MOVE_SILENTLY, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Move Silently" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //open lock
	        case 16:
		    nRank = GetSkillRank(SKILL_OPEN_LOCK, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Open Lock" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //parry
	        case 17:
		    nRank = GetSkillRank(SKILL_PARRY, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Parry" + HSS_PCTOOLS_COLOUR_END;
	        break;
		    //perform
	        case 18:
		    nRank = GetSkillRank(SKILL_PERFORM, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Perform" + HSS_PCTOOLS_COLOUR_END;
	        break;
		    //ride
	        case 19:
		    nRank = GetSkillRank(SKILL_RIDE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Ride" + HSS_PCTOOLS_COLOUR_END;
	        break;
			//search	   
	        case 20:
		    nRank = GetSkillRank(SKILL_SEARCH, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Search" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //set trap
	        case 21:
		    nRank = GetSkillRank(SKILL_SET_TRAP, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Set Trap" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //sleight of hand
	        case 22:
		    nRank = GetSkillRank(SKILL_SLEIGHT_OF_HAND, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Sleight of Hand" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //spellcraft
	        case 23:
		    nRank = GetSkillRank(SKILL_SPELLCRAFT, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Spellcraft" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //spot
	        case 24:
		    nRank = GetSkillRank(SKILL_SPOT, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Spot" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //survival
	        case 25:
		    nRank = GetSkillRank(SKILL_SURVIVAL, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Survival" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //taunt
	        case 26:
		    nRank = GetSkillRank(SKILL_TAUNT, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Taunt" + HSS_PCTOOLS_COLOUR_END;
	        break;
		    //tumble
	        case 27:
		    nRank = GetSkillRank(SKILL_TUMBLE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Tumble" + HSS_PCTOOLS_COLOUR_END;
	        break;
	        //UMD
	        case 28:
		    nRank = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPC);
	        nRoll = d20();
		    sSkill = HSS_PCTOOLS_COLOUR2 + "Use Magic Device" + HSS_PCTOOLS_COLOUR_END;
	        break;			  		  	   	   	 		  	   	   	   	   	   	   	   
	      }

	   sMsg = sSkill + HSS_PCTOOLS_COLOUR2 + " Check: " + HSS_PCTOOLS_COLOUR1 +
	   "Rank: " + HSS_PCTOOLS_COLOUR2 + IntToString(nRank) +
	   HSS_PCTOOLS_COLOUR1 + " + Roll: " + HSS_PCTOOLS_COLOUR2 +
	   IntToString(nRoll) + HSS_PCTOOLS_COLOUR1 + " = " + HSS_PCTOOLS_COLOUR2 + 
	   IntToString(nRank + nRoll) + HSS_PCTOOLS_COLOUR1 + ".";
	   		   		   		   		   		   		   
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SKILL, "TRUE");	   
	   break;	   	   	   
	   }

	   if (sMsg == "")
	      {
		  sMsg = HSS_PCTOOLS_COLOUR1 + "Select a die roll type before rolling.";
          nBroadcast = 1;
		  }

	   if (!nDieType && nRollType == HSS_PC_TOOLS_DIE_STANDARD)
		  {
		  sMsg = HSS_PCTOOLS_COLOUR1 + "Standard die rolls require a die type.";
		  nBroadcast = 1;
		  }
			 		  		  
	   if (nRollType == HSS_PC_TOOLS_DIE_STANDARD && !nBroadcast)
	      {
	      HSS_PCTools_PlayCustomAnim(oPC, "gettable", FALSE, 2.0);
          DelayCommand(1.0, PlaySound("it_generictiny"));
		  DelayCommand(1.5, HSS_PCTools_PlayCustomAnim(oPC, "getground", FALSE, 2.0));
		  fAnimDelay = 2.0;
		  }		  
	   
	   if (nBroadcast)
	      {
		  DelayCommand(fAnimDelay, SendMessageToPC(oPC, sMsg));
		  }
		  else
		  {
		  DelayCommand(fAnimDelay, SpeakString(sMsg));
		  }

       HSS_PCTools_CleanPCLocals(oPC, FALSE);		  		  
       DelayCommand(0.2, HSS_PCTools_DeleteGUIDieRollType(oPC));   
}

void HSS_PCTools_SetGUIDieRollType(object oPC, int nType = HSS_PC_TOOLS_DIE_STANDARD)
{
   switch (nType)
       {
	   case HSS_PC_TOOLS_DIE_STANDARD:
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SAVE, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_ABILITY, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SKILL, "TRUE");
	   break;
	   
	   case HSS_PC_TOOLS_DIE_SAVE:
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_STANDARD, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_ABILITY, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SKILL, "TRUE");
	   break;
	   
	   case HSS_PC_TOOLS_DIE_ABILITY:
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_STANDARD, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SAVE, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SKILL, "TRUE");
	   break;
	   
	   case HSS_PC_TOOLS_DIE_SKILL:
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_STANDARD, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SAVE, "TRUE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_ABILITY, "TRUE");
	   break;	   	   	   			   	   
	   }
}

void HSS_PCTools_DeleteGUIDieRollType(object oPC)
{
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_STANDARD, "FALSE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SAVE, "FALSE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_ABILITY, "FALSE");
	   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_DIE_SKILL, "FALSE");
}


void HSS_PCTools_DoEmote(object oPC)
{
   string sEmote = GetLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE");
   string sEmote2 = GetLocalString(oPC, "HSS_PC_TOOLS_ANIM_TYPE_2");   
   int nLoop = GetLocalInt(oPC, "HSS_PC_TOOLS_ANIM_LOOP");
   float fDelay = GetLocalFloat(oPC, "HSS_PC_TOOLS_ANIM_DELAY");


   if (sEmote != "")
      {
	  if (sEmote == "%" || sEmote2 != "")
	     {
		 //seems empty strings ("") are now passed as "0" -- gah!
		 //this caused the looping option to fail -- bug fix.
		 if (sEmote2 != "0")
		    {
			nLoop = 0;
			}
		 }
      HSS_PCTools_PlayCustomAnim(oPC, sEmote, nLoop);

	  if (sEmote2 != "")
	     {
		 //seems empty strings ("") are now passed as "0" -- gah!
		 //this caused the looping option to fail -- bug fix.		 
		 if (sEmote2 != "0")
		    {
		    nLoop = 1;
		    DelayCommand(fDelay, HSS_PCTools_PlayCustomAnim(oPC, sEmote2, nLoop));			
			}
		 }
      }
	  
   HSS_PCTools_CleanPCLocals(oPC, FALSE);
      
   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_EMOTE, "TRUE");   
   DelayCommand(0.2, SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS, HSS_PC_TOOLS_EMOTE, "FALSE"));      
}

void HSS_PCTools_ApplyVFX(object oPC, string sVFX)
{
   string sEffect = "fx_hss_" + sVFX;
   effect eProp = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile(sEffect), -899));
   effect eFirst = GetFirstEffect(oPC);
   object oItem;
   string sItem;

   if (sVFX == "drinkbeer")
      {
      sItem = HSS_PCTOOLS_VFX_DRINKBEER_ITEM;
      }
      else
      if (sVFX == "druma")
      {
      sItem = HSS_PCTOOLS_VFX_DRUMA_ITEM;
      }
      else
      if (sVFX == "drumb")
      {
      sItem = HSS_PCTOOLS_VFX_DRUMB_ITEM;
      }
      else
      if (sVFX == "flutea")
      {
      sItem = HSS_PCTOOLS_VFX_FLUTEA_ITEM;
      }
      else
      if (sVFX == "fluteb")
      {
      sItem = HSS_PCTOOLS_VFX_FLUTEB_ITEM;
      }            
      else
      if (sVFX == "mandolina")
      {
      sItem = HSS_PCTOOLS_VFX_MANDOLINA_ITEM;
      }
      else
      if (sVFX == "mandolinb")
      {
      sItem = HSS_PCTOOLS_VFX_MANDOLINB_ITEM;
      }
      else
      if (sVFX == "mandolinc")
      {
      sItem = HSS_PCTOOLS_VFX_MANDOLINC_ITEM;
      }      
      else
      if (sVFX == "pan")
      {
      sItem = HSS_PCTOOLS_VFX_PAN_ITEM;
      }      
      else
      if (sVFX == "rake")
      {
      sItem = HSS_PCTOOLS_VFX_RAKE_ITEM;
      }             
      else
      if (sVFX == "shovel")
      {
      sItem = HSS_PCTOOLS_VFX_SHOVEL_ITEM;
      } 
      else
      if (sVFX == "smithyhammer")
      {
      sItem = HSS_PCTOOLS_VFX_SMITHYHAMMER_ITEM;
      } 
      else
      if (sVFX == "spoon")
      {
      sItem = HSS_PCTOOLS_VFX_SPOON_ITEM;
      }      
      else
      if (sVFX == "wine")
      {
      sItem = HSS_PCTOOLS_VFX_WINE_ITEM;
      }
       
                              
   if (sItem != "" && GetIsPC(oPC) && !GetIsDM(oPC))
      {
      oItem = HSS_GetItemPossessedBy_Cached(oPC, sItem);
         
      if (!GetIsObjectValid(oItem))
         {
         SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + HSS_NO_ITEM_MESSAGE);
         return;
         }
      }
         
   while (GetIsEffectValid(eFirst))
       {
	   if (GetEffectSpellId(eFirst) == -899)
	      {
		  RemoveEffect(oPC, eFirst);
		  break;
		  }
	   eFirst = GetNextEffect(oPC);	  
	   }   
   
   if (sVFX == "%")
      {
	  return;	     	  
	  }
	     
   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eProp, oPC);
   
}

void HSS_PCTools_Remove(object oPC, int nObject)
{
   object oTarget = IntToObject(nObject);
   string sTag = GetTag(oTarget);
   object oMod = GetModule();
   string sPCID = GetLocalString(oTarget, "HSS_PCTOOLS_CREATOR");
   string sMsg;
   string sAnim;

   
   if (!GetIsObjectValid(oTarget) || sTag != "HSS_PCTOOLS_TENT" &&
      sTag != "HSS_PCTOOLS_CAMPFIRE")
      {
	  SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "No valid target chosen " +
	                 "for this action.");
	  return;				 
	  }

   if (sTag == "HSS_PCTOOLS_TENT")
      {
	  sMsg = HSS_PCTOOLS_COLOUR1 + "*Packs Up Tent*";
	  sAnim = "disablefront";
      DelayCommand(6.0, HSS_PCTools_DestroyAndDecrement(oMod, oTarget, sPCID));
	  }
	  else
	  {
	  sMsg = HSS_PCTOOLS_COLOUR1 + "*Puts Out Fire*";
	  sAnim = "disableground";
      DelayCommand(6.0, HSS_PCTools_DestroyAndDecrement(oMod, oTarget, sPCID));
	  }
	  
   ActionMoveToObject(oTarget, FALSE);
   if (!GetIsDM(oPC))
      {	  
      ActionSpeakString(sMsg);
      }
   ActionDoCommand(HSS_PCTools_PlayCustomAnim(oPC, sAnim, TRUE));
   ActionDoCommand(DelayCommand(4.0, HSS_PCTools_PlayCustomAnim(oPC, "%", FALSE)));   
   ActionDoCommand(HSS_DestroyAllInventory(oTarget));
   	  
}

void HSS_PCTools_CustomButton(object oPC, int nButton, float fX = 0.0, float fY = 0.0, float fZ = 0.0, int nString1 = -1, int nObject = -1)
{
   //variables for Target type butons
   object oTarget = IntToObject(nObject);
   vector vTargetPos = Vector(fX, fY, fZ);
   location lTargetLoc = Location(GetAreaFromLocation(GetLocation(oPC)),
                         vTargetPos, 0.0);

   switch (nButton)
       {
    	   //custom button 1
		   case 1:
          // KEMO Emotes
           //your custom button code goes here
			DisplayGuiScreen(oPC,"KEMO_ANIM",FALSE,"kemo_anim.xml");
			CloseGUIScreen(oPC,"KEMO_ANIM_MIN");
     	   break;
		   
		   //custom button 2
		   case 2:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 3
		   case 3:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");	   
		   break;
		   		   		   		   		   		   		   
		   //custom button 4
		   case 4:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 5
		   case 5:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
     	   break;
		   
		   //custom button 6
		   case 6:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 7
		   case 7:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   		   		   		   		   		   		   
		   //custom button 8
		   case 8:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 9
		   case 9:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;

    	   //custom button 10
		   case 10:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");
     	   break;
		   
		   //custom button 11
		   case 11:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 12
		   case 12:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");	   
		   break;
		   		   		   		   		   		   		   
		   //custom button 13
		   case 13:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 14
		   case 14:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
     	   break;
		   
		   //custom button 15
		   case 15:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 16
		   case 16:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   		   		   		   		   		   		   
		   //custom button 17
		   case 17:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom button 18
		   case 18:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Button number " +
		                  IntToString(nButton) + " has no custom code enabled.");		   
		   break;
		   
		   //custom target mode button 1
		   case 19:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;
		   
		   //custom target mode button 2
		   case 20:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   		   

		   //custom target mode button 3
		   case 21:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 4
		   case 22:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 5
		   case 23:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;	
		   
		   //custom target mode button 6
		   case 24:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   

		   //custom target mode button 7
		   case 25:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 8
		   case 26:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   

		   //custom target mode button 9
		   case 27:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   		   

		   //custom target mode button 10
		   case 28:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;
		   
		   //custom target mode button 11
		   case 29:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   		   

		   //custom target mode button 12
		   case 30:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 13
		   case 31:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 14
		   case 32:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;	
		   
		   //custom target mode button 15
		   case 33:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   

		   //custom target mode button 16
		   case 34:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   
		   
		   //custom target mode button 17
		   case 35:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   

		   //custom target mode button 18
		   case 36:
           //your custom button code goes here
		   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 + "Target mode button number " +
		                  IntToString(nButton - 18) + " has no custom code enabled.");
		   break;			   			   		   		   		   

		   //custom buttons page 1
		   case 96:
		   
		   switch (nString1)
		       {
			   case 1:
			   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_HEADER_BUTTON",
			   -1, "Custom                      Buttons");			   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_01", FALSE);
			   break;
			   
			   case 2:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_01", FALSE);
			   break;
			   
			   case 3:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_01", FALSE);
			   break;	   			   
			   }

		   break;
		   
		   //custom buttons page 2
		   case 97:
		   
		   switch (nString1)
		       {
			   case 1:
			   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_HEADER_BUTTON",
			   -1, "Custom                      Buttons");				   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_02", FALSE);
			   break;

			   case 2:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_02", FALSE);
			   break;
			   
			   case 3:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_02", FALSE);
			   break;			   
			   }
			   			   	
		   break;		   
		   		   		   		   		   
		   //custom buttons page 3
		   case 98:
		   
		   switch (nString1)
		       {
			   case 1:
			   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_HEADER_BUTTON",
			   -1, "Custom Target                       Mode Buttons ");
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_03", FALSE);
			   break;

			   case 2:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_03", FALSE);
			   break;
			   
			   case 3:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_03", FALSE);
			   break;		   
			   }	
			   			   
		   break;
		   
		   //custom buttons page 4
		   case 99:
		   
		   switch (nString1)
		       {
			   case 1:
			   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_HEADER_BUTTON",
			   -1, "Custom Target                       Mode Buttons ");			   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS, "PC_TOOLS_CBUT_04", FALSE);
			   break;
			   
			   case 2:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB_V, "PC_TOOLS_CBUT_04", FALSE);
			   break;
			   
			   case 3:
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_01", TRUE);
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_02", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_03", TRUE);		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_04", TRUE);
		   		   
		       SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_CB, "PC_TOOLS_CBUT_04", FALSE);
			   break;		   
			   }				   
			   
		   break;
		   
	   	   
	   }
}

void HSS_PCTools_PlayCustomAnim(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0)
{
   PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

void HSS_DestroyAllInventory(object oObject)
{
    if (!GetHasInventory(oObject))
	   {
	   return;
	   }
	   
    object oItem = GetFirstItemInInventory(oObject);

    while (GetIsObjectValid(oItem))
        {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oObject);
        }
}

string HSS_IntToLeadingZeroString(int nNumber)
{
string sResult = IntToString(nNumber);

   if (nNumber < 10 && nNumber >= 0)
      {
      sResult = "0"+IntToString(nNumber);
      return sResult;
      }

return sResult;
}

object HSS_GetItemPossessedBy_Cached(object oCreature, string sItemTag)
{
   object oItem = GetLocalObject(oCreature, "HSS_CACHED_ITEM_" + sItemTag);

   //not sure if GetItemPossessor()is more efficient than GetItemPossessedBy()   
   if (GetIsObjectValid(oItem) && GetItemPossessor(oItem) == oCreature)
      {
      return oItem;
      }
      
   oItem = GetItemPossessedBy(oCreature, sItemTag);
   
   if (GetIsObjectValid(oItem))
      {
      SetLocalObject(oCreature, "HSS_CACHED_ITEM_" + sItemTag, oItem);
      return oItem;
      }

   return oItem;            
}

void HSS_PCTools_DestroyAndDecrement(object oPC, object oObject, string sVar)
{

   //might have been destroyed manually, so check for validity first since
   //this can be called via a delay.  Only destroy and decrement if the object
   //exists first.
   if (GetIsObjectValid(oObject))
      {
      DestroyObject(oObject);
      SetLocalInt(oPC, sVar, GetLocalInt(oPC, sVar) - 1);
      }
}

location HSS_StringToLocation(string sLoc)
{
   int nSpace = FindSubString(sLoc, " ");
   string sArea;
   string sVec;
   string sFace;
   location lLoc;//(areatag) (0.0, 0.0, 0.0) (0.0)
   
   sArea = GetSubString(sLoc, 1, nSpace - 2);
   //SpeakString(sArea);
   
   sLoc = GetSubString(sLoc, nSpace + 1, GetStringLength(sLoc) - nSpace);
   nSpace = FindSubString(sLoc, " (");
   sVec = GetSubString(sLoc, 0, nSpace);
   //SpeakString(sVec);
      

   sLoc = GetSubString(sLoc, nSpace + 2, GetStringLength(sLoc) - nSpace);
   nSpace = FindSubString(sLoc, ")");   
   sFace = GetSubString(sLoc, 0, nSpace);   
   //SpeakString(sFace); 
        
   lLoc = Location(GetObjectByTag(sArea), HSS_StringToVector(sVec),
          StringToFloat(sFace));
        
   return lLoc;		
}

vector HSS_StringToVector(string sVec)
{
   int nDelim = FindSubString(sVec, ",");
   string sX;
   string sY;
   string sZ;
   vector vVec;
   
   sX = GetSubString(sVec, 1, nDelim - 1);
   //SpeakString(sX);
   
   sVec = GetSubString(sVec, nDelim + 1, GetStringLength(sVec) - (nDelim +1) );
   nDelim = FindSubString(sVec, ",");
   sY = GetSubString(sVec, 0, nDelim - 1);
   //SpeakString(sY);   

   sVec = GetSubString(sVec, nDelim + 1, GetStringLength(sVec) - (nDelim +1) );
   nDelim = FindSubString(sVec, ")");   
   sZ = GetSubString(sVec, 0, nDelim - 1);    
   //SpeakString(sZ); 
        
   vVec = Vector(StringToFloat(sX), StringToFloat(sY), StringToFloat(sZ));
        
   return vVec;		
}

void HSS_PCTools_StorePersistentData(object oObject, string sVarName, string sDB, int nDataType, string sValue, int nExpiration = 0, int nStorageType = HSS_PCTOOLS_DBTYPE)
{
   switch (nStorageType)
       {
	   //NWNX
	   case 1:
       //uncomment these calls if using NWNX or write your own calls.
	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   //SetPersistentInt(oObject, sVarName, StringToInt(sValue), nExpiration, HSS_NWNX_TABLE);
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   //SetPersistentString(oObject, sVarName, sValue, nExpiration, HSS_NWNX_TABLE);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   //SetPersistentFloat(oObject, sVarName, StringToFloat(sValue), nExpiration, HSS_NWNX_TABLE);		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   //SetPersistentLocation(oObject, sVarName, HSS_StringToLocation(sValue), nExpiration, HSS_NWNX_TABLE);		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   //SetPersistentVector(oObject, sVarName, HSS_StringToVector(sValue), nExpiration, HSS_NWNX_TABLE);		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   //SetPersistentObject(oObject, sVarName, StringToObject(sValue), nExpiration, HSS_NWNX_OBJ_TABLE);		   
		   break;		   		   		   		   		   
		   }
		   	   
	   break;

	   //inventory item persistency
	   case 2:

	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   SetLocalInt(oObject, sVarName, StringToInt(sValue));
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   SetLocalString(oObject, sVarName, sValue);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   SetLocalFloat(oObject, sVarName, StringToFloat(sValue));		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   SetLocalLocation(oObject, sVarName, HSS_StringToLocation(sValue));		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   //SetLocalVector(oObject, sVarName, HSS_StringToVector(sValue));		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   SetLocalObject(oObject, sVarName, StringToObject(sValue));		   
		   break;		   		   		   		   		   
		   }
		   	   
	   break;
	   	   
	   //Native DB	   
	   default:
	   
	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   SetCampaignInt(sDB, sVarName, StringToInt(sValue), oObject);
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   SetCampaignString(sDB, sVarName, sValue, oObject);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   SetCampaignFloat(sDB, sVarName, StringToFloat(sValue), oObject);		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   SetCampaignLocation(sDB, sVarName, HSS_StringToLocation(sValue), oObject);		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   SetCampaignVector(sDB, sVarName, HSS_StringToVector(sValue), oObject);		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   StoreCampaignObject(sDB, sVarName, StringToObject(sValue), oObject);		   
		   break;		   		   		   		   		   
		   }
	   
	   break;
	   
	   }
	  

}

string HSS_PCTools_RetrievePersistentData(object oObject, string sVarName, string sDB, int nDataType, int nStorageType = HSS_PCTOOLS_DBTYPE)
{
   string sResult;
   
   switch (nStorageType)
       {
	   //NWNX
	   case 1:
       //uncomment these calls if using NWNX or write your own calls.
	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   //sResult = IntToString(GetPersistentInt(oObject, sVarName, HSS_NWNX_TABLE));
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   //sResult = GetPersistentString(oObject, sVarName, HSS_NWNX_TABLE);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   //sResult = FloatToString(GetPersistentFloat(oObject, sVarName, HSS_NWNX_TABLE));		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   //sResult = LocationToString(GetPersistentLocation(oObject, sVarName, HSS_NWNX_TABLE));		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   //sResult = VectorToString(GetPersistentVector(oObject, sVarName, HSS_NWNX_TABLE));		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   //sResult = ObjectToString(GetPersistentObject(oObject, sVarName, OBJECT_INVALID, HSS_NWNX_OBJ_TABLE));		   
		   break;		   		   		   		   		   
		   }
		   	   
	   break;

	   //inventory item persistency
	   case 2:

	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   sResult = IntToString(GetLocalInt(oObject, sVarName));
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   sResult = GetLocalString(oObject, sVarName);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   sResult = FloatToString(GetLocalFloat(oObject, sVarName));		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   sResult = LocationToString(GetLocalLocation(oObject, sVarName));		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   //GetLocalVector(oObject, sVarName);		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   sResult = ObjectToString(GetLocalObject(oObject, sVarName));		   
		   break;		   		   		   		   		   
		   }
		   	   
	   break;
	   	   
	   //Native DB	   
	   default:
	   
	   switch (nDataType)
	       {
		   case HSS_PC_TOOLS_INT:
		   sResult = IntToString(GetCampaignInt(sDB, sVarName, oObject));
		   break;
		   
		   case HSS_PC_TOOLS_STRING:
		   sResult = GetCampaignString(sDB, sVarName, oObject);		   
		   break;
		   
		   case HSS_PC_TOOLS_FLOAT:
		   sResult = FloatToString(GetCampaignFloat(sDB, sVarName,  oObject));		   
		   break;
		   
		   case HSS_PC_TOOLS_LOC:
		   sResult = LocationToString(GetCampaignLocation(sDB, sVarName, oObject));		   
		   break;
		   
		   case HSS_PC_TOOLS_VEC:
		   sResult = VectorToString(GetCampaignVector(sDB, sVarName, oObject));		   
		   break;
		   
		   case HSS_PC_TOOLS_OBJ:
		   sResult = ObjectToString(RetrieveCampaignObject(sDB, sVarName, GetLocation(oObject), OBJECT_INVALID, oObject));		   
		   break;		   		   		   		   		   
		   }
	   
	   break;
	   
	   }
	  
   return sResult;
}

int HSS_PCTools_IsStringColoured(string sString)
{
   int nLength = GetStringLength(sString);
   int nCount;
   
   while (nCount < nLength)
       {
	   if (GetSubString(sString, nCount, 7) == "<color=")
	      {
		  return TRUE; 
		  }
	   
	   nCount++;
	   }
   
   return FALSE;   
}

void HSS_PCTools_StartTimer(object oPC, int nTime, string sLabel, string sAlarm)
{
   SetLocalInt(oPC, "HSS_TIMERS_TOTAL", GetLocalInt(oPC, "HSS_TIMERS_TOTAL") - 1);
   
   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR2 + "######--Timer Notification");
			   		   			  
   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR1 +
			   "PC Tools Timer Expired -- Timer " + HSS_PCTOOLS_COLOUR2 +
			   sLabel + "</c>" + " expired after " + HSS_PCTOOLS_COLOUR2 +
			   IntToString(nTime) + "</c> minute(s).");
						   
   SendMessageToPC(oPC, HSS_PCTOOLS_COLOUR2 + "######--Timer Notification");
   
   if (sAlarm == "P")
      {
      DisplayGuiScreen(oPC, "SCREEN_HSS_POPUP_MESSAGE", FALSE, "hss_pc_tools_postmsg.xml");
      SetGUIObjectText(oPC, "SCREEN_HSS_POPUP_MESSAGE", "HSS_POPUP_MESSAGE", -1, "<color=yellow> TIMER EXPIRED!");
      DelayCommand(0.5, SetGUIObjectText(oPC, "SCREEN_HSS_POPUP_MESSAGE", "HSS_POPUP_MESSAGE", -1, "<color=red> TIMER EXPIRED!"));
      DelayCommand(1.0, SetGUIObjectText(oPC, "SCREEN_HSS_POPUP_MESSAGE", "HSS_POPUP_MESSAGE", -1, "<color=yellow> TIMER EXPIRED!"));
      DelayCommand(1.5, SetGUIObjectText(oPC, "SCREEN_HSS_POPUP_MESSAGE", "HSS_POPUP_MESSAGE", -1, "<color=red> TIMER EXPIRED!"));
      DelayCommand(2.0, SetGUIObjectText(oPC, "SCREEN_HSS_POPUP_MESSAGE", "HSS_POPUP_MESSAGE", -1, "<color=yellow> TIMER EXPIRED!"));	  	  	  	  
	  }
      else
      if (sAlarm == "S")
	  {
	  FadeToBlack(oPC, FADE_SPEED_FASTEST, 0.2, 16711680);
	  DelayCommand(1.0, FadeToBlack(oPC, FADE_SPEED_FASTEST, 0.2, 16711680));	  
	  }				   
}

void HSS_PCTools_DisplayMessageBox(object oPC, string sMsg, int nOkCB, int nCancelCB, int bShowCancel = TRUE, string sOk = "Yes", string sCancel = "No")
{
   DisplayGuiScreen(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX,
		           FALSE, HSS_PC_TOOLS_MSG_BOX_XML);
   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, "PC_TOOLS_MSGBOX_TEXT",
                   -1, sMsg);
   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, 1, "'" + IntToString(nOkCB) + "'");
   SetLocalGUIVariable(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, 2, "'" + IntToString(nCancelCB) + "'");
   
   if (!bShowCancel)
      {
	  SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, "PC_TOOLS_MSGBOX_NO_BUTTON", TRUE);
	  }
	  else
	  {
	  SetGUIObjectHidden(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, "PC_TOOLS_MSGBOX_NO_BUTTON", FALSE);	  
	  }
	  
   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, "PC_TOOLS_MSGBOX_YES_BUTTON",
                   -1, sOk);
   SetGUIObjectText(oPC, SCREEN_HSS_PC_TOOLS_MSG_BOX, "PC_TOOLS_MSGBOX_No_BUTTON",
                   -1, sCancel);				   	     				   				   
}