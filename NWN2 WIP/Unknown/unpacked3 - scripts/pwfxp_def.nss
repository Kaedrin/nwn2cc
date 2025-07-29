//::///////////////////////////////////////////////
//:: XP Distribution Script by Knat
//:: pwfxp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//void main(){}
// note: default values are geared towards a LOW xp setting...
//       with easy leveling early (level 1-5) and very hard xp gain later on (lvl 30+)
//       all default values should be epic-level compatible


// this will modify global xp output similar to the module xp-slider
// higher value = more xp
// PC needs to kill a combined CR of (PC-LEVEL * 1000) /  PWFXP_GLOBAL_MODIFIER
// on average to gain a level. use this as a rule of thumb and base to calculate
// the more advanced modifiers
//
// e.g. a level 10 needs to kill 100 CR-10 mobs to level (aprox.) using default 10.0 global modifier
//      he will only need 50 CR-10 mobs if you set it to 20.0
//      setting this to 1000.0 = he only needs one CR-10 mob to level
//
// you can further scale the leveling progress more precisely with the PWFXP_LEVEL_MODIFIERS constant
// just continue to read my comments...
const float PWFXP_GLOBAL_MODIFIER = 4.5;

// displays one-line XP status info after each kill
// useful while you fine tune the system.
// and check the readme.txt in case you want to remove
// the double-xp message from bioware...
const int PWFXP_DEBUG = FALSE;

// NEW & experimental:
// system will use the SetXP function instead of GiveXPToCreature if you set this to TRUE
// this should bypass any "possible" bioware xp modification, like multiclass penalties.
// i did not really test this so far, it's just some rumor i picked up from the
// bioboards. choose whatever you feel better with...
const int PWFXP_USE_SETXP = FALSE;

// NEW:
// pc level gets computed based on the total XP instead of
// using GetLevelBy functions if set to TRUE. this way players ready to levelup
// can't bunker XP to gain better XP bonuses. a level 2 player with
// 3500 total XP (thus, ready to levelup) gets considered
// level 3 by the XP script if you set this switch to TRUE
//
// setting this to FALSE will use the old way of GetLevelByPosition.
// i highly recommend the new way to counter XP (and probably more) exploits...
const int PWFXP_USE_TOTAL_XP_TO_COMPUTE_PCLEVEL = TRUE;

// this is where you apply your subrace ECL modifiers
// add them to the constant in this form "(ECL Modifier)-(Subrace)|...next|...etc"
const string PWFXP_ECL_MODIFIERS = "1-AASIMAR|1-TIEFLING|1-AIR GENASI|1-FIRE GENASI|1-WATER GENASI|1-EARTH GENASI|2-DROW|2-GRAY|2-DUERGAR|3-DEEP|3-SVIRFNEBLIN";

// NEW:
//
// you can add a modifier to change XP output for every single level (including epic levels)
// this also enables you to break the linear nature of NWNs default XP output.
// you can change it to: logarithmic, exponential or any other non-linear
// mathematical function using the PWFXP_LEVEL_MODIFIERS table
//
// you can make the first few levels an easy catch but make the last a pain to reach.... very flexible now
//
// default setting:
//
// level 1 = 1000% xp bonus
// level 2 = 500% xp bonus
// level 3 = 300% xp bonus
// level 4 = 200% xp bonus
// level 5 = 100% xp bonus
//
// level 6 - 10 = no xp change

// level 11 = -15% xp penalty
// level 12 = -15%
// level 13 = -20%
// level 14 = -20%
// level 15 = -25%
// level 16 = -25%
// level 17 = -30%
// level 18 = -30%
// level 19 = -35%
// level 20 = -35%
//
// level 21 = -40% xp penalty
// level 22 = -45%
// level 23 = -50%
// level 24 = -55%
// level 25 = -60%
// level 26 = -65%
// level 27 = -70%
// level 28 = -80%
// level 29 = -90%
//
// level 30 = -91% xp penalty
// level 31 = -91%
// level 32 = -92%
// level 33 = -92%
// level 34 = -93%
// level 35 = -93%
// level 36 = -94%
// level 37 = -94%
// level 38 = -95%
// level 39 = -96%
//
// these settings make it easy first but very tough at later levels.
// the pc would need to kill 100 level 10 creatures to level from 10 to 11, but
// several thousand CR 40 creatures to level from 39 to 40, with the above settings.
// (not counting group bonus or other advanced modifiers)
//
// modifier explanation:
//
// a value of 1 (01.000) means no xp change.
//
// the actual xp bonus/penalty in % = (modifier - 1) * 100
//
// use value < 1.0 to reduce the xp
// e.g. 00.500 = -50%
//      00.010 = -99%
//      00.001 = -99.9%
//
// attention: syntax !!
// always pad with 0. each number must be 6 chars long
// otherwise the parser will fail and your players get 0xp
// i use very simplistic parsing to optimize cpu use...
//
// the first number modifies level 1, the last number level 40
//
//                            LEVEL-----01--|--02--|--03--|--04--|--05--|--06--|--07--|--08--|--09--|--10--|--11--|--12--|--13--|--14--|--15--|--16--|--17--|--18--|--19--|--20--|--21--|--22--|--23--|--24--|--25--|--26--|--27--|--28--|--29--|--30--|--31--|--32--|--33--|--34--|--35--|--36--|--37--|--38--|--39--|--40--|
const string PWFXP_LEVEL_MODIFIERS = "11.000|06.000|04.000|03.000|02.000|01.700|01.450|01.200|01.000|00.930|00.850|00.800|00.750|00.700|00.630|00.560|00.500|00.430|00.390|00.330|00.270|00.230|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001|00.001";

// small bonus for killing blow dealer
const float PWFXP_KILLINGBLOW_MODIFIER = 0.1; // 10%

// PC level gets compared to the average party level.
// APL = Average Party Level
//
//
// attention: the below example was from version 1.1
//            most if not all constants have been changed (scalar for example is 100% now and thus fully linear)
//
//            example uses below values
//            const float PWFXP_APL_REDUCTION = 2.0;
//            const float PWFXP_APL_NOXP = 4.0;
//            const float PWFXP_SCALAR = 0.5
//
// XP gets reduced if PC-level > APL + APL_REDUCTION
//   XP reduction is based on SCALAR, be careful if you change this
//   right now its 0 - 50% (scalar 0.5) for delta 2 (APL_REDUCTION) .. delta 4 (APL_NOXP)
//    delta = abs(APL - PC Level)
//   this means it will switch from 50% reduction to 100% reduction in one leap in case the PC level
//   is greater then APL + APL_NOXP.
//   i did this for a better granularity for the given default values but
//   you can freely change APL_REDUCTION and/or APL_NOXP. XP reduction gets auto-adjusted to the maximum
//   of SCALAR (50% default).
//
// XP gets reduced to zero if PC-level > APL + APL_NOXP
//
// Example (using default values):
// PC A = level 7
// PC B = level 3
// PC C = level 1
//
// average party level (APL) = 3.66
//
// Distance PC A = abs(PClevel - AveragePartyLevel) = abs(7 - 3.66) = 3.34
// PC-A has a final distance of 1.34 (3.34 - APL_REDUCTION)
// XP reduction = (SCALAR / (APL_NOXP - APL_REDUCTION)) * 1.34 = (0.5 / 2) * 1.34 = 33.5% XP reduction
//
// Distance PC B = abs(PClevel - AveragePartyLevel) = abs(3 - 3.66) = 0.66
// PC-A has a final distance of -1.34 (0.66 - APL_REDUCTION)
// no XP reduction
//
// Distance PC C = abs(PClevel - AveragePartyLevel) = abs(1 - 3.66) = 2.66
// PC-A has a final distanceof 0.66 (2.66 - APL_REDUCTION)
// XP reduction = (SCALAR / (APL_NOXP - APL_REDUCTION)) * 0.66 = (0.5 / 2) * 0.66 = 16.5% XP reduction
//
// those PCs with the biggest impact to the average party level receive the biggest XP reduction
// (in the above case PC A)
//
// set _REDUCTION to 40 and _NOXP to 41 if you don't want any APL reduction
//
// changed default to a bit less harsh values
const float PWFXP_APL_REDUCTION = 3.0; // levels
const float PWFXP_APL_NOXP = 5.0;

// NEW:
// these 4 constants works like the APL constants above but it compares
// PC level vs challenge rating of the dead creature
//
// you can distinct two different cases now:
//
// PC level > CR of the creature (CR + PWFXP_CR_LESSTHAN_PCLEVEL_REDUCTION)
// PC level < CR of the creature (CR + PWFXP_CR_GREATERTHAN_PCLEVEL_REDUCTION)
//
// math is the same as the APL example above, just exchange
// AveragePartyLevel with CR of dead creature and use
// PWFXP_CR_*_PCLEVEL_REDUCTION and PWFXP_CR_*_PCLEVEL_NOXP as the constants
//
// set _REDUCTION to CR_MAX and _NOXP to CR_MAX+1 if you don't want any cr reduction
//
// reduction constants for PCs fighting mobs with a CR below their level
const float PWFXP_CR_LESSTHAN_PCLEVEL_REDUCTION = 4.0;
const float PWFXP_CR_LESSTHAN_PCLEVEL_NOXP = 7.0;

// note: default setting only penalize PCs if they try to kill something
//       that should be *impossible* for their level.
//       a 40 level epic PC will be able to kill CR 60 creatures without
//       penalty and a large low-level group of players will be able to
//       kill a much higher CR creature without penalty...(a group of lvl5 players killing
//       a CR 20 creature won't receive any penalty. penalty will start to kick in if they try
//       to kill a creature with a CR > 25
//       you can use this to counter low-level XP exploits. e.g. a level 40 player
//       could mangle a mob down to 1 HP. then a low level comes in and deals the final
//       blow -> classical xp exploit...
//       default settings make sure that nothing can get out of hand, but you can make
//       this harsher if you want (but keep in mind that creatures can have a higher
//       CR than the players maximum level, like CR 60)
//
// set _REDUCTION to CR_MAX and _NOXP to CR_MAX+1 if you don't want any cr reduction
//
// reduction constants for PCs fighting mobs with a CR above their level
const float PWFXP_CR_GREATERTHAN_PCLEVEL_REDUCTION = 5.0;
const float PWFXP_CR_GREATERTHAN_PCLEVEL_NOXP = 9.0;

// described above
const float PWFXP_SCALAR = 1.0;

// maximum CR cap
// this stops creatures with sky-high CRs from giving godly XP
const float PWFXP_CR_MAX = 20.0;

// groups get a small xp bonus
// formular is groupsize-1 * modifier
// with a default value of 0.1 (10%) a party of 4 receives 30% XP bonus
// this should encourage grouping
// set it to 0.0 if you dont like that...
const float PWFXP_GROUPBONUS_MODIFIER = 0.60;

// groub members need to be within this distance to the dead creature
// if they want to get any XP during fights
const float PWFXP_MAXIMUM_DISTANCE_TO_GROUP = 30.0; // meters

// safety mechanism
// minimum XP for a kill
const int PWFXP_MINIMUM_XP = 1;

// safety mechanism
// maximum XP for a kill
const int PWFXP_MAXIMUM_XP = 55;

// UPDATED:
// these constants determine how XP division works
// you can now distinct between animal companion,
// familiars, dominated, summoned and henchman. you can set a different
// xp divisor for each of them. (default: henchman has max reduction impact followed
// by dominated, summoned, familiars, animal companion)
// e.g.: a group with two PCs + 1 FAMILIAR + 1 SUMMONED CREATURE
// gets a total XP divisor of 2.5 (using default values).
// if they kill a 1000XP mob, both PCs only receive 400 XP
const float PWFXP_XP_DIVISOR_PC  = 1.0;
const float PWFXP_XP_DIVISOR_DOMINATED = 0.5;
const float PWFXP_XP_DIVISOR_HENCHMAN = 0.5;
const float PWFXP_XP_DIVISOR_SUMMONED = 0.3;
const float PWFXP_XP_DIVISOR_ANIMALCOMPANION = 0.2;
const float PWFXP_XP_DIVISOR_FAMILIAR = 0.2;
// used in case i can't determine the associate type
const float PWFXP_XP_DIVISOR_UNKNOWN = 0.5;

// don't change these
float PWFXP_APL_MODIFIER = PWFXP_SCALAR / (PWFXP_APL_NOXP - PWFXP_APL_REDUCTION);
float PWFXP_CR_LESSTHAN_PCLEVEL_MODIFIER = PWFXP_SCALAR / (PWFXP_CR_LESSTHAN_PCLEVEL_NOXP - PWFXP_CR_LESSTHAN_PCLEVEL_REDUCTION);
float PWFXP_CR_GREATERTHAN_PCLEVEL_MODIFIER = PWFXP_SCALAR / (PWFXP_CR_GREATERTHAN_PCLEVEL_NOXP - PWFXP_CR_GREATERTHAN_PCLEVEL_REDUCTION);