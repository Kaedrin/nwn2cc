/*
Filename:           hcr2_bleedsystem_c
System:             bleed system (user configuration script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 10th, 2006
Summary:

This script is consumed by hcr2_bleedsystem_i as an include directive.

Contains user definable toggles and settings for the bleed system.
Should contains include directives for additional files needed by the user,
and any _t scripts (text string definition scripts).

-----------------
Revision: v1.01
Added support for ceasing hostile NPC actions when dying.

Revision v1.03 
Added H2_FORCED_BLEED configuration setting.

Revision v1.04
Added H2_STAY_DOWN_FIX configuration setting.

Revision v1.05
Added H2_HP_ON_DEATH configuration setting.
*/

//You may swap the below #include "hc2_bleedsystem_t" text directives for an equivalant language specific
//one. (All variable names must match however for it to compile properly.)
#include "hcr2_bleedsystem_t"

//All below functions and constants may be overriden by the user, but do not alter the function signature
//or the name of the constant.
//Begin constant declarations.

//Amount of time in seconds between when the player character bleeds while dying.
//Note this is seconds in real time, not game time.
//Recommend value: 6 seconds (1 heartbeat/round)
const float H2_BLEED_DELAY = 6.0;

//Amount of time in seconds between when a stable player character nexts checks to see if they begin to recover.
//Note this is seconds in real time, not game time.
//Recommended Equation: [Minutes per game hour] * 60 seconds, = HoursToSeconds(1)
float H2_STABLE_DELAY = HoursToSeconds(1);

//Percent chance a player character will self stabilize and stop bleedng when dying.
//Range of values is 0 - 100
//Recommended value: 10 (as per 3.5 rules giving 10% chance)
const int H2_SELF_STABILIZE_CHANCE = 20;

//Percent chance a player character will regain conciousness and begin recovery after self-stabilizing.
//Range of values is 0 - 100
//Recommended value: 10 (as per 3.5 rules giving 10% chance)
const int H2_SELF_RECOVERY_CHANCE = 20;

//Amount of hitpoints lost when a player character bleeds.
//Recomended value: 1
const int H2_BLEED_BLOOD_LOSS = 1;

//Heal check DC to provide first aid to a dying charcater to stablize them.
//Default value is 15.
const int H2_FIRST_AID_DC = 15;

//Heal check DC to provide long term care to an injured character.
//Default value is 15.
const int H2_LONG_TERM_CARE_DC = 15;

//The tag of the Healer's Kit item which gives a +2 circumstance bonus to use.
//Modeled after the the PHB 3.5 Healer's Kit item.
const string H2_HEALERS_KIT = "hcr2_healerskit";

//User defined event number sent to the last NPC damager to let them know
//their target is now dying. Use this event to customize NPC behavior 
//for what they will do when their target is bleeding. 
//(suggested options: leave them alone, loot them, target next pc party 
//member, finish them off, etc.)
//Pick any integer value that is not being used for another event number.
const int H2_TARGET_IS_DOWN_EVENT_NUMBER = 2147483501;

//Leave H2_CEASE_NPC_ATTACKS_ON_DYING  to true if you want the NPC who last 
//damaged the PC and made them begin bleeding to stop attacking the PC.
//This occur prior to the event singal above. 
//Note that via custom NPC behavior as described above, you can make an
//NPC continue attacking again.
const int H2_CEASE_NPC_ATTACKS_ON_DYING = TRUE;

//Set H2_FORCED_BLEED to true to force a PC to always fully bleed out.
//Any damage a PC with positive HP takes that goes beyond 0, 
//even if it's beyond -10 (skipping the dying event), will be 
//stopped at 0 hitpoints. For this to work properly the
//bleed system's OnDeath hook-in script must run before the fugue
//system or any similar system's death hook-in script which might revive
//and port the PC. Instant death spells will be affected also,
//so to make them function as intended, you will have to use a spellhook
//event hook-in script and call 
//SetLocalInt(GetSpellAttemptedSpellTarget(), "H2_BLEED_OUT", TRUE);
const int H2_FORCED_BLEED = FALSE;

//Set H2_HP_ON_DEATH to a negative number value.
//If a PC or Companion reaches this value during the dying state they 
//will become dead. 
//If the PartMembersDying campaign flag is set to TRUE, then this value,
//OR the negative of 1/2 the max HP of the PC/Companion, 
//whichever of those values is the highest, will be the point at which 
//the PC/companion becomes dead.
//If PartyMembersDying campaign flag is set to FALSE, then this value
//or -10, whichever is the highest, will be the point at which the PC becomes dead.
//Companions will not use the bleedsystem unless the PartyMembersDying flag
//is set to TRUE.
//The default value is -10.
const int H2_HP_ON_DEATH = -10;

//Set H2_STAY_DOWN_FIX to TRUE if you want to use the 'fix' for the animation
//bug that causes a PC to stand up while bleeding. 
//Warning: using this may induce significant lag.
const int H2_STAY_DOWN_FIX = FALSE;
//End constant declarations.