/*
Filename:           hcr2_pccorse_c
System:             pc corpse (user configuration script)
Author:             Edward Beck (0100010)
Date Created:       Dec. 2nd, 2006
Summary:

This script is consumed by hcr2_pccorpse_i as an include directive.

Contains user definable toggles and settings for the pccorpse subsystem.
Should contains include directives for additional files needed by the user,
and any _t scripts (text string definition scripts).

-----------------
Revision: 

*/

//You may swap the below #include "hcr2_pccorpse_t" text directives for an equivalant language specific
//one. (All variable names must match however for it to compile properly.)
#include "hcr2_pccorpse_t"


//All below functions and constants may be overriden by the user, but do not alter the function signature
//or the name of the constant.
//Begin function and constant declarations.

//Set this value ot the name of the database or table you want to be used for
//storing external data associated with the pc corpse subsystem.
const string H2_PCCORPSE_INFO = "HCR2_PCCORPSE_INFO";

//User defined event number sent to an NPC when a corpse token is activated on them.
//Pick any integer value that is not being used for another event number.
const int H2_PCCORPSE_ITEM_ACTIVATED_EVENT_NUMBER = 2147483500;

//Can be TRUE or FALSE.
//Set this to FALSE if you do not want to allow PC's to ressurect a corpse token at all.
//Default value is TRUE.
const int H2_ALLOW_CORPSE_RESS_BY_PLAYERS = TRUE;

//Can be TRUE or FALSE.
//Set this to TRUE if you want the raised PC to endure the PHB XP loss upon being raised or ressurected.
const int H2_APPLY_XP_LOSS_FOR_RESS = FALSE;

//Can be TRUE or FALSE.
//Set this to TRUE if you want the caster to lose gold according to the amount the PHB says is required
//for the cast spell.
const int H2_REQUIRE_GOLD_FOR_RESS = FALSE;

//The cost in gold for the raise dead spell. (must be a positive value)
//This only applies if H2_REQUIRE_GOLD_COST_FOR_RESS = TRUE
const int H2_GOLD_COST_FOR_RAISE_DEAD = 5000;

//The cost in gold for the ressurection spell. (must be a positive value)
//This only applies if H2_REQUIRE_GOLD_COST_FOR_RESS = TRUE
const int H2_GOLD_COST_FOR_RESSERECTION = 10000;

//Can be TRUE of FALSE
//Set this to TRUE if you want the PC to drop their items when dying or dead into a dropped items container.
const int H2_DROP_PLAYER_ITEMS = FALSE;

//End function and constant declarations.