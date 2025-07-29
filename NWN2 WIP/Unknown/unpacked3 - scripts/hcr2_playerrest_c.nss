/*
Filename:           hcr2_playerrest_c
System:             player rest (user configuration include script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 13th, 2006
Summary:
HCR2 player rest variable user-configuration variable settings.
This script is consumed by hcr2_playerrest_i as an include directive.

This contains user definable toggles and settings for the core system.

-----------------
Revision: 

*/

//All below functions and constants may be overriden by the user, but do not alter the function signature
//or the name of the constant.

//Begin user configurable constant declarations.

//Minimum Time in real seconds that must pass since the last time a PC rested and
//recovered spells, feats and health, for them to recover them again when they rest.
//Recommended Equation: [Minutes per game hour] * 60 * 8; (results in 8 game hours)
//The default value is 960, which is 8 game hours using 2 RL minutes per game hour.
//To not require any minimum elapsed time set the value to 0.
const int H2_MINIMUM_SPELL_RECOVERY_REST_TIME = 960;

//Amount of hit points per level that is healed when resting after the minimum time above passed.
//The default value is 1.
//To allow PCs to heal to maximum hitpoints, set the value to -1.
//Note that some rest event hook-in scripts may alter the final amount of HP healed after the rest
//to a value different than what would result from the value you specify below, even if the value is -1.
const int H2_HP_HEALED_PER_REST_PER_LEVEL = -1;

//Set this to true to only allow resting inside designated trigger zones
//or within 4 meters of a campfire.
const int H2_REQUIRE_REST_TRIGGER_OR_CAMPFIRE = TRUE;

//Set this to true to only allow nearby PCs in the party with survival skills to improve the
// options for resting in the wilds
const int H2_SURVIVALISTS_ALLOW_REST = TRUE;
const int H2_DEFAULT_AREA_REST_DC = 30;

//The resref of the campfire placeable to be used for the above condition.
const string H2_CAMPFIRE = "hcr2_campfire";

//The resref of the campfire's light to be used.
const string H2_CAMPFIRE_LIGHT = "hcr2_campfirelight";

//The resref of the placed effect for the campfire's fire. 
const string H2_CAMPFIRE_FIREFX = "n2_fx_torchglow";

//End of user configurable constant declarations.