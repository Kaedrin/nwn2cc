/////////////////////////////////////////
//maid_inc
#include "maid_text"
void GetInnArea(object oPC)
{
string sArea = GetTag(GetArea(oPC));
string sBarmaid = "";


//specific per inn

if (sArea == "rlg_osi_1") 
{
 
sBarmaid = "rlg_oldskull_barmaid";
}
} 