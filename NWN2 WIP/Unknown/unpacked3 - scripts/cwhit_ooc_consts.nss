/*
Filename:           db_ooc_consts
System:             core (player chat event script)
Author:             Dalelands Beyond scripting team
Date Created:       Jan 21st, 2010.
Summary:
Integrate some LRES OOC check strings into HCR2 OnChat Event.
*/

/*
 * Case sensitive substring denoting an OOC Area
 */
const string cMvD_02_sOOCAreaName = "OOC";

/*
 * These OOC Substrings are case-sensitive. For case-insensitive matches
 * please use the "Word" constants. See MvD_02_OOCMatchCase and
 * MvD_02_OOCMatchNoCase
 */

/*
 * 1. OOC substring
 */
const string cMvD_02_sOOC1 = "(";

/*
 * 2. OOC substring
 */
const string cMvD_02_sOOC2 = ")";

/*
 * 3. OOC substring
 */
const string cMvD_02_sOOC3 = "/";

/*
 * 4. OOC substring
 */
const string cMvD_02_sOOC4 = "\";

/*
 * 5. OOC substring
 */
const string cMvD_02_sOOC5 = "[";

/*
 * 6. OOC substring
 */
const string cMvD_02_sOOC6 = "]";

/*
 * 7. OOC substring
 */
const string cMvD_02_sOOC7 = ":";

/*
 * 8. OOC substring
 */
const string cMvD_02_sOOC8 = ";";

/*
 * 9. OOC substring
 */
const string cMvD_02_sOOC9 = "<";

/*
 * 10. OOC substring
  */
const string cMvD_02_sOOC10 = ">";

/*
 * 11. OOC substring
 */
const string cMvD_02_sOOC11 = "-_-";

/*
 * 12. OOC substring
 */
const string cMvD_02_sOOC12 = "XD";

/*
 * 12. OOC substring
 */
const string cMvD_02_sOOC13 = "EP";

/*
 * 14. OOC substring
 */
const string cMvD_02_sOOC14 = "XP";

/*
 * 15. OOC substring
 */
const string cMvD_02_sOOC15 = "Oo";

/*
 * 16. OOC substring
 */
const string cMvD_02_sOOC16 = "oO";

/*
 * 17. OOC substring
 */
const string cMvD_02_sOOC17 = "o_O";

/*
 * 18. OOC substring
 */
const string cMvD_02_sOOC18 = "O_o";

/*
 * 19. OOC substring
 */
const string cMvD_02_sOOC19 = "@";

/*
 * These OOC Substrings will be compared to the lowercase string. So the
 * comparision is case insensitive. Therefore the strings must all be
 * lowercase.
 */

/*
 * 1. OOC word
 */
const string cMvD_02_sOOCWord1 = "ooc";

/*
 * 2. OOC word
 */
const string cMvD_02_sOOCWord2 = "lol";

/*
 * 3. OOC word
 */
const string cMvD_02_sOOCWord3 = "lool";

/*
 * 4. OOC word
 */
const string cMvD_02_sOOCWord4 = "loool";

/*
 * 5. OOC word
 */
const string cMvD_02_sOOCWord5 = "looool";

/*
 * 6. OOC word
 */
const string cMvD_02_sOOCWord6 = "*g*";

/*
 * 7. OOC word
 */
const string cMvD_02_sOOCWord7 = "*gg*";

/*
 * 8 OOC word
 */
const string cMvD_02_sOOCWord8 = "*ggg*";

/*
 * 9. OOC word
 */
const string cMvD_02_sOOCWord9 = "cool";

/*
 * 10. OOC word
 */
const string cMvD_02_sOOCWord10 = "afk";

/*
 * 11. OOC word
 */
const string cMvD_02_sOOCWord11 = "*eg*";

/*
 * 12. OOC word
 */
const string cMvD_02_sOOCWord12 = "shit";

/*
 * 13. OOC word
 */
const string cMvD_02_sOOCWord13 = "shyt";

/*
 * 14. OOC word
 */
const string cMvD_02_sOOCWord14 = "fuck";

/*
 * 15. OOC word
 */
const string cMvD_02_sOOCWord15 = "cunt";

/*
 * 16. OOC word
 */
const string cMvD_02_sOOCWord16 = "piss";

/*
 * 17. OOC word
 */
const string cMvD_02_sOOCWord17 = "noob";

/*
 * 18. OOC word
 */
const string cMvD_02_sOOCWord18 = "nwn";