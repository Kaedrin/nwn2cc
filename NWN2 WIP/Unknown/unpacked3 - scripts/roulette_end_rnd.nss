//Modified by Stephen Spann (sspann@worldnet.att.net)
//to include the 00 slot, Five-Number bets, Corner Bets, and Split Bets.
//now uses SetListeningPattern() cues instead of a conversation.

///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////

void EndRouletteRound(object PC, int random)
{
object oPC = PC;
int nMoney = 0;
int ixBet = GetLocalInt(oPC,"iBet");
int ixWinnings = GetLocalInt(oPC,"iWinnings");
int ixFive = GetLocalInt(oPC,"iFive");
int ixRed = GetLocalInt(oPC,"iRed");
int ixBlack = GetLocalInt(oPC,"iBlack");
int ixHigh = GetLocalInt(oPC,"iHigh");
int ixLow = GetLocalInt(oPC,"iLow");
int ixEven = GetLocalInt(oPC,"iEven");
int ixOdd = GetLocalInt(oPC,"iOdd");
int ixDoz1 = GetLocalInt(oPC,"iDoz1");
int ixDoz2 = GetLocalInt(oPC,"iDoz2");
int ixDoz3 = GetLocalInt(oPC,"iDoz3");
int ixCol1 = GetLocalInt(oPC,"iCol1");
int ixCol2 = GetLocalInt(oPC,"iCol2");
int ixCol3 = GetLocalInt(oPC,"iCol3");
int ix0su = GetLocalInt(oPC,"i0su");
int ix00su = GetLocalInt(oPC,"i0su");
int ix1su = GetLocalInt(oPC,"i1su");
int ix2su = GetLocalInt(oPC,"i2su");
int ix3su = GetLocalInt(oPC,"i3su");
int ix4su = GetLocalInt(oPC,"i4su");
int ix5su = GetLocalInt(oPC,"i5su");
int ix6su = GetLocalInt(oPC,"i6su");
int ix7su = GetLocalInt(oPC,"i7su");
int ix8su = GetLocalInt(oPC,"i8su");
int ix9su = GetLocalInt(oPC,"i9su");
int ix10su = GetLocalInt(oPC,"i10su");
int ix11su = GetLocalInt(oPC,"i11su");
int ix12su = GetLocalInt(oPC,"i12su");
int ix13su = GetLocalInt(oPC,"i13su");
int ix14su = GetLocalInt(oPC,"i14su");
int ix15su = GetLocalInt(oPC,"i15su");
int ix16su = GetLocalInt(oPC,"i16su");
int ix17su = GetLocalInt(oPC,"i17su");
int ix18su = GetLocalInt(oPC,"i18su");
int ix19su = GetLocalInt(oPC,"i19su");
int ix20su = GetLocalInt(oPC,"i20su");
int ix21su = GetLocalInt(oPC,"i21su");
int ix22su = GetLocalInt(oPC,"i22su");
int ix23su = GetLocalInt(oPC,"i23su");
int ix24su = GetLocalInt(oPC,"i24su");
int ix25su = GetLocalInt(oPC,"i25su");
int ix26su = GetLocalInt(oPC,"i26su");
int ix27su = GetLocalInt(oPC,"i27su");
int ix28su = GetLocalInt(oPC,"i28su");
int ix29su = GetLocalInt(oPC,"i29su");
int ix30su = GetLocalInt(oPC,"i30su");
int ix31su = GetLocalInt(oPC,"i31su");
int ix32su = GetLocalInt(oPC,"i32su");
int ix33su = GetLocalInt(oPC,"i33su");
int ix34su = GetLocalInt(oPC,"i34su");
int ix35su = GetLocalInt(oPC,"i35su");
int ix36su = GetLocalInt(oPC,"i36su");
int ixLine1 = GetLocalInt(oPC,"iLine1");
int ixLine2 = GetLocalInt(oPC,"iLine2");
int ixLine3 = GetLocalInt(oPC,"iLine3");
int ixLine4 = GetLocalInt(oPC,"iLine4");
int ixLine5 = GetLocalInt(oPC,"iLine5");
int ixLine6 = GetLocalInt(oPC,"iLine6");
int ixLine7 = GetLocalInt(oPC,"iLine7");
int ixLine8 = GetLocalInt(oPC,"iLine8");
int ixLine9 = GetLocalInt(oPC,"iLine9");
int ixLine10 = GetLocalInt(oPC,"iLine10");
int ixLine11 = GetLocalInt(oPC,"iLine11");
int ixStreet1 = GetLocalInt(oPC,"iStreet1");
int ixStreet2 = GetLocalInt(oPC,"iStreet2");
int ixStreet3 = GetLocalInt(oPC,"iStreet3");
int ixStreet4 = GetLocalInt(oPC,"iStreet4");
int ixStreet5 = GetLocalInt(oPC,"iStreet5");
int ixStreet6 = GetLocalInt(oPC,"iStreet6");
int ixStreet7 = GetLocalInt(oPC,"iStreet7");
int ixStreet8 = GetLocalInt(oPC,"iStreet8");
int ixStreet9 = GetLocalInt(oPC,"iStreet9");
int ixStreet10 = GetLocalInt(oPC,"iStreet10");
int ixStreet11 = GetLocalInt(oPC,"iStreet11");
int ixStreet12 = GetLocalInt(oPC,"iStreet12");
int ixCorner1 = GetLocalInt(oPC,"iCorner1");
int ixCorner2 = GetLocalInt(oPC,"iCorner2");
int ixCorner3 = GetLocalInt(oPC,"iCorner3");
int ixCorner4 = GetLocalInt(oPC,"iCorner4");
int ixCorner5 = GetLocalInt(oPC,"iCorner5");
int ixCorner6 = GetLocalInt(oPC,"iCorner6");
int ixCorner7 = GetLocalInt(oPC,"iCorner7");
int ixCorner8 = GetLocalInt(oPC,"iCorner8");
int ixCorner9 = GetLocalInt(oPC,"iCorner9");
int ixCorner10 = GetLocalInt(oPC,"iCorner10");
int ixCorner11 = GetLocalInt(oPC,"iCorner11");
int ixCorner12 = GetLocalInt(oPC,"iCorner12");
int ixCorner13 = GetLocalInt(oPC,"iCorner13");
int ixCorner14 = GetLocalInt(oPC,"iCorner14");
int ixCorner15 = GetLocalInt(oPC,"iCorner15");
int ixCorner16 = GetLocalInt(oPC,"iCorner16");
int ixCorner17 = GetLocalInt(oPC,"iCorner17");
int ixCorner18 = GetLocalInt(oPC,"iCorner18");
int ixCorner19 = GetLocalInt(oPC,"iCorner19");
int ixCorner20 = GetLocalInt(oPC,"iCorner20");
int ixCorner21 = GetLocalInt(oPC,"iCorner21");
int ixCorner22 = GetLocalInt(oPC,"iCorner22");
int ixSplit1 = GetLocalInt(oPC,"iSplit1");
int ixSplit2 = GetLocalInt(oPC,"iSplit2");
int ixSplit3 = GetLocalInt(oPC,"iSplit3");
int ixSplit4 = GetLocalInt(oPC,"iSplit4");
int ixSplit5 = GetLocalInt(oPC,"iSplit5");
int ixSplit6 = GetLocalInt(oPC,"iSplit6");
int ixSplit7 = GetLocalInt(oPC,"iSplit7");
int ixSplit8 = GetLocalInt(oPC,"iSplit8");
int ixSplit9 = GetLocalInt(oPC,"iSplit9");
int ixSplit10 = GetLocalInt(oPC,"iSplit10");
int ixSplit11 = GetLocalInt(oPC,"iSplit11");
int ixSplit12 = GetLocalInt(oPC,"iSplit12");
int ixSplit13 = GetLocalInt(oPC,"iSplit13");
int ixSplit14 = GetLocalInt(oPC,"iSplit14");
int ixSplit15 = GetLocalInt(oPC,"iSplit15");
int ixSplit16 = GetLocalInt(oPC,"iSplit16");
int ixSplit17 = GetLocalInt(oPC,"iSplit17");
int ixSplit18 = GetLocalInt(oPC,"iSplit18");
int ixSplit19 = GetLocalInt(oPC,"iSplit19");
int ixSplit20 = GetLocalInt(oPC,"iSplit20");
int ixSplit21 = GetLocalInt(oPC,"iSplit21");
int ixSplit22 = GetLocalInt(oPC,"iSplit22");
int ixSplit23 = GetLocalInt(oPC,"iSplit23");
int ixSplit24 = GetLocalInt(oPC,"iSplit24");
int ixSplit25 = GetLocalInt(oPC,"iSplit25");
int ixSplit26 = GetLocalInt(oPC,"iSplit26");
int ixSplit27 = GetLocalInt(oPC,"iSplit27");
int ixSplit28 = GetLocalInt(oPC,"iSplit28");
int ixSplit29 = GetLocalInt(oPC,"iSplit29");
int ixSplit30 = GetLocalInt(oPC,"iSplit30");
int ixSplit31 = GetLocalInt(oPC,"iSplit31");
int ixSplit32 = GetLocalInt(oPC,"iSplit32");
int ixSplit33 = GetLocalInt(oPC,"iSplit33");
int ixSplit34 = GetLocalInt(oPC,"iSplit34");
int ixSplit35 = GetLocalInt(oPC,"iSplit35");
int ixSplit36 = GetLocalInt(oPC,"iSplit36");
int ixSplit37 = GetLocalInt(oPC,"iSplit37");
int ixSplit38 = GetLocalInt(oPC,"iSplit38");
int ixSplit39 = GetLocalInt(oPC,"iSplit39");
int ixSplit40 = GetLocalInt(oPC,"iSplit40");
int ixSplit41 = GetLocalInt(oPC,"iSplit41");
int ixSplit42 = GetLocalInt(oPC,"iSplit42");
int ixSplit43 = GetLocalInt(oPC,"iSplit43");
int ixSplit44 = GetLocalInt(oPC,"iSplit44");
int ixSplit45 = GetLocalInt(oPC,"iSplit45");
int ixSplit46 = GetLocalInt(oPC,"iSplit46");
int ixSplit47 = GetLocalInt(oPC,"iSplit47");
int ixSplit48 = GetLocalInt(oPC,"iSplit48");
int ixSplit49 = GetLocalInt(oPC,"iSplit49");
int ixSplit50 = GetLocalInt(oPC,"iSplit50");
int ixSplit51 = GetLocalInt(oPC,"iSplit51");
int ixSplit52 = GetLocalInt(oPC,"iSplit52");
int ixSplit53 = GetLocalInt(oPC,"iSplit53");
int ixSplit54 = GetLocalInt(oPC,"iSplit54");
int ixSplit55 = GetLocalInt(oPC,"iSplit55");
int ixSplit56 = GetLocalInt(oPC,"iSplit56");
int ixSplit57 = GetLocalInt(oPC,"iSplit57");
int ixSplit58 = GetLocalInt(oPC,"iSplit58");
int ixSplit59 = GetLocalInt(oPC,"iSplit59");
int ixSplit60 = GetLocalInt(oPC,"iSplit60");
int ixSplit61 = GetLocalInt(oPC,"iSplit61");
int ixSplit62 = GetLocalInt(oPC,"iSplit62");

string sxFive = GetLocalString(OBJECT_SELF,"sFive");
sxFive = "";
SetLocalString(OBJECT_SELF,"sFive","sxFive");

string sxSUHit = GetLocalString(OBJECT_SELF,"sSUHit");
sxSUHit = "";
SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");

string sxRB = GetLocalString(OBJECT_SELF,"sRB");
sxRB = "";
SetLocalString(OBJECT_SELF,"sRB","sxRB");

string sxHL = GetLocalString(OBJECT_SELF,"sHL");
sxHL = "";
SetLocalString(OBJECT_SELF,"sHL","sxHL");

string sxEO = GetLocalString(OBJECT_SELF,"sEO");
sxEO = "";
SetLocalString(OBJECT_SELF,"sEO","sxEO");

string sxDoz = GetLocalString(OBJECT_SELF,"sDoz");
sxDoz = "";
SetLocalString(OBJECT_SELF,"sDoz","sxDoz");

string sxCol = GetLocalString(OBJECT_SELF,"sCol");
sxCol = "";
SetLocalString(OBJECT_SELF,"sCol","sxCol");

string sxLine = GetLocalString(OBJECT_SELF,"sLine");
sxLine = "";
SetLocalString(OBJECT_SELF,"sLine","sxLine");

string sxLine2 = GetLocalString(OBJECT_SELF,"sLine2");
sxLine2 = "";
SetLocalString(OBJECT_SELF,"sLine2","sxLine2");

string sxStreet = GetLocalString(OBJECT_SELF,"sStreet");
sxStreet = "";
SetLocalString(OBJECT_SELF,"sStreet","sxStreet");

string sxCorner = GetLocalString(OBJECT_SELF,"sCorner");
sxCorner = "";
SetLocalString(OBJECT_SELF,"sCorner","sxCorner");

string sxCorner2 = GetLocalString(OBJECT_SELF,"sCorner2");
sxCorner2 = "";
SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");

string sxCorner3 = GetLocalString(OBJECT_SELF,"sCorner3");
sxCorner3 = "";
SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");

string sxCorner4 = GetLocalString(OBJECT_SELF,"sCorner4");
sxCorner4 = "";
SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");

string sxSplit1 = GetLocalString(OBJECT_SELF,"sSplit1");
sxSplit1 = "";
SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");

string sxSplit2 = GetLocalString(OBJECT_SELF,"sSplit2");
sxSplit2 = "";
SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");

string sxSplit3 = GetLocalString(OBJECT_SELF,"sSplit3");
sxSplit3 = "";
SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");

string sxSplit4 = GetLocalString(OBJECT_SELF,"sSplit4");
sxSplit4 = "";
SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");

string sxSplit5 = GetLocalString(OBJECT_SELF,"sSplit5");
sxSplit5 = "";
SetLocalString(OBJECT_SELF,"sSplit4","sxSplit5");


int ixSpot1 = GetLocalInt(OBJECT_SELF,"iSpot1");
string sxSpot1Color = GetLocalString(OBJECT_SELF,"sSpot1Color");


ixSpot1 = random;
SetLocalInt(OBJECT_SELF,"iSpot1", ixSpot1);

switch(ixSpot1)
    {
    case 0:
    nMoney = nMoney + (ix0su*36) + (ixFive*7) + (ixSplit1*18) + (ixSplit2*18) + (ixSplit3*18);
    sxSpot1Color = "Green";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ix0su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix0su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixFive >= 1)
        {
        sxFive = "" + GetName(oPC) + "'s Five-Number bet of "+IntToString(ixFive)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sFive","sxFive");
        }
    if (ixSplit1 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit2 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit3 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 1:
    nMoney = nMoney + (ix1su*36) + (ixFive*7) + (ixRed*2) + (ixLow*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz1*3) + (ixLine1*6) + (ixCorner1*9) + (ixStreet1*12) + (ixSplit2*18) + (ixSplit6*18) + (ixSplit7*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix1su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix1su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixStreet1 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixFive >= 1)
        {
        sxFive = "" + GetName(oPC) + "'s Five-Number bet of "+IntToString(ixFive)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sFive","sxFive");
        }
    if (ixCorner1 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixSplit2 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit6 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit7 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 2:
    nMoney = nMoney + (ix2su*36) + (ixFive*7) + (ixBlack*2) + (ixLow*2) + (ixEven*2) + (ixCol2*3) + (ixDoz1*3) + (ixLine1*6) + (ixCorner1*9) + (ixCorner2*9) + (ixStreet1*12) + (ixSplit3*18) + (ixSplit4*18) + (ixSplit6*18) + (ixSplit8*18) + (ixSplit9*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix2su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix2su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixStreet1 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixFive >= 1)
        {
        sxFive = "" + GetName(oPC) + "'s Five-Number bet of "+IntToString(ixFive)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sFive","sxFive");
        }
    if (ixCorner1 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner2 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit3 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit4 >= 1)
        {
        sxSplit5 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit5","sxSplit5");
        }
    if (ixSplit6 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit8 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit9 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 3:
    nMoney = nMoney + (ix3su*36) + (ixFive*7) + (ixRed*2) + (ixLow*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz1*3) + (ixLine1*6) + (ixCorner2*9) + (ixStreet1*12) + (ixSplit5*18) + (ixSplit8*18) + (ixSplit10*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    GiveGoldToCreature(oPC,ixRed*2);
    if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(oPC,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix3su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix3su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixStreet1 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixFive >= 1)
        {
        sxFive = "" + GetName(oPC) + "'s Five-Number bet of "+IntToString(ixFive)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sFive","sxFive");
        }
    if (ixCorner2 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixSplit5 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit8 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit10 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 4:
    nMoney = nMoney + (ix4su*36) + (ixBlack*2) + (ixLow*2) + (ixEven*2) + (ixCol1*3) + (ixDoz1*3) + (ixLine1*6) + (ixLine2*6) + (ixCorner1*9) + (ixCorner3*9) + (ixStreet2*12) + (ixSplit7*18) + (ixSplit11*18) + (ixSplit12*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix4su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix4su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine2 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet2 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner3 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit7 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit11 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit12 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 5:
    nMoney = nMoney + (ix5su*36) + (ixRed*2) + (ixLow*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz1*3) + (ixLine1*6) + (ixLine2*6) + (ixCorner1*9) + (ixCorner2*9) + (ixCorner3*9) + (ixCorner4*9)+ (ixStreet2*12) + (ixSplit9*18) + (ixSplit11*18) + (ixSplit13*18) + (ixSplit14*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix5su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix5su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine2 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet2 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner2 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner3 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner4 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit9 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit11 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit13 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit14 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 6:
    nMoney = nMoney + (ix6su*36) + (ixBlack*2) + (ixLow*2) + (ixEven*2) + (ixCol3*3) + (ixDoz1*3) + (ixLine1*6)+ (ixLine2*6) + (ixCorner2*9) + (ixCorner4*9)+ (ixStreet2*12) + (ixSplit9*18) + (ixSplit10*18) + (ixSplit13*18) + (ixSplit15*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix6su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix6su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine2 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet2 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner2 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner4 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit10 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit13 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit15 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 7:
    nMoney = nMoney + (ix7su*36) + (ixRed*2) + (ixLow*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz1*3) + (ixLine2*6)+ (ixLine3*6) + (ixCorner3*9) + (ixCorner5*9)+ (ixStreet3*12) + (ixSplit12*18) + (ixSplit16*18) + (ixSplit17*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix7su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix7su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine2 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine3 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet3 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner3 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner5 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit12 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit16 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit17 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 8:
    nMoney = nMoney + (ix8su*36) + (ixBlack*2) + (ixLow*2) + (ixEven*2) + (ixCol2*3) + (ixDoz1*3) + (ixLine2*6)+ (ixLine3*6) + (ixCorner3*9) + (ixCorner4*9) + (ixCorner5*9) + (ixCorner6*9)+ (ixStreet3*12) + (ixSplit14*18) + (ixSplit16*18) + (ixSplit18*18) + (ixSplit19*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix8su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix8su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine2 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine3 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet3 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner3 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner4 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner5 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner6 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit14 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit16 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit18 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit19 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 9:
    nMoney = nMoney + (ix9su*36) + (ixRed*2) + (ixLow*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz1*3) + (ixLine2*6)+ (ixLine3*6) + (ixCorner4*9) + (ixCorner6*9)+ (ixStreet3*12) + (ixSplit15*18) + (ixSplit18*18) + (ixSplit20*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix9su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix9su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine2 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine3 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet3 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner4 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner6 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit15 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit18 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit20 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 10:
    nMoney = nMoney + (ix10su*36) + (ixBlack*2) + (ixLow*2) + (ixEven*2) + (ixCol1*3) + (ixDoz1*3) + (ixLine3*6)+ (ixLine4*6) + (ixCorner5*9) + (ixCorner7*9)+ (ixStreet4*12) + (ixSplit17*18) + (ixSplit21*18) + (ixSplit22*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
    if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix10su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix10su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine3 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine4 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
    if (ixStreet4 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner5 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner7 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit17 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit21 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit21)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit22 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 11:
    nMoney = nMoney + (ix11su*36) + (ixBlack*2) + (ixLow*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz1*3) + (ixLine3*6)+ (ixLine4*6) + (ixCorner5*9) + (ixCorner6*9) + (ixCorner7*9) + (ixCorner8*9)+ (ixStreet4*12) + (ixSplit19*18) + (ixSplit21*18) + (ixSplit23*18) + (ixSplit24*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
    if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix11su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix11su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine3 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine4 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet4 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner5 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner6 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner7 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner8 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit19 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit21 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit21)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit23 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit23)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit24 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit24)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 12:
    nMoney = nMoney + (ix12su*36) + (ixRed*2) + (ixLow*2) + (ixEven*2) + (ixCol3*3) + (ixDoz1*3) + (ixLine3*6)+ (ixLine4*6) + (ixCorner6*9) + (ixCorner8*9) + (ixStreet4*12) + (ixSplit20*18) + (ixSplit23*18) + (ixSplit25*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz1 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix12su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix12su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine3 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine4 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet4 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner6 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner8 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit20 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit23 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit23)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit25 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit25)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 13:
    nMoney = nMoney + (ix13su*36) + (ixBlack*2) + (ixLow*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz2*3) + (ixLine4*6)+ (ixLine5*6) + (ixCorner7*9) + (ixCorner9*9) + (ixStreet5*12) + (ixSplit22*18) + (ixSplit26*18) + (ixSplit27*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix13su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix13su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine4 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine5 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet5 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner7 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner9 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit22 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit26 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit26)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit27 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit27)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 14:
    nMoney = nMoney + (ix14su*36) + (ixRed*2) + (ixLow*2) + (ixEven*2) + (ixCol2*3) + (ixDoz2*3) + (ixLine4*6)+ (ixLine5*6) + (ixCorner7*9) + (ixCorner8*9) + (ixCorner9*9) + (ixCorner10*9)+ (ixStreet5*12) + (ixSplit24*18) + (ixSplit26*18) + (ixSplit28*18) + (ixSplit29*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix14su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix14su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine4 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine5 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet5 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner7 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner8 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner9 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner10 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit24 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit24)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit26 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit26)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit28 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit28)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit29 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit29)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 15:
    nMoney = nMoney + (ix15su*36) + (ixBlack*2) + (ixLow*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz2*3) + (ixLine4*6)+ (ixLine5*6) + (ixCorner8*9) + (ixCorner10*9) + (ixStreet5*12) + (ixSplit25*18) + (ixSplit28*18) + (ixSplit30*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix15su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix15su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine4 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine5 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet5 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner8 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner10 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit25 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit25)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit28 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit28)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit30 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit30)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 16:
    nMoney = nMoney + (ix16su*36) + (ixRed*2) + (ixLow*2) + (ixEven*2) + (ixCol1*3) + (ixDoz2*3) + (ixLine5*6)+ (ixLine6*6) + (ixCorner9*9) + (ixCorner11*9) + (ixStreet6*12) + (ixSplit27*18) + (ixSplit31*18) + (ixSplit32*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                    if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix16su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix16su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine5 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine6 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet6 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner9 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner11 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit27 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit27)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit31 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit31)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit32 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit32)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 17:
    nMoney = nMoney + (ix17su*36) + (ixBlack*2) + (ixLow*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz2*3) + (ixLine5*6)+ (ixLine6*6) + (ixCorner9*9) + (ixCorner10*9) + (ixCorner11*9) + (ixCorner12*9)+ (ixStreet6*12) + (ixSplit29*18) + (ixSplit31*18) + (ixSplit33*18) + (ixSplit34*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
                   if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix17su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix17su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine5 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine6 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet6 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner9 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner10 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner11 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner12 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit29 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit29)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit31 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit31)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit33 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit33)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit34 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit34)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 18:
    nMoney = nMoney + (ix18su*36) + (ixRed*2) + (ixLow*2) + (ixEven*2) + (ixCol3*3) + (ixDoz2*3) + (ixLine5*6)+ (ixLine6*6) + (ixCorner10*9) + (ixCorner12*9) + (ixStreet6*12) + (ixSplit30*18) + (ixSplit33*18) + (ixSplit35*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixLow >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s Low bet of "+IntToString(ixLow)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix18su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix18su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine5 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine6 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet6 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner10 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner12 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit30 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit30)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit33 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit33)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit35 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit35)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 19:
    nMoney = nMoney + (ix19su*36) + (ixRed*2) + (ixHigh*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz2*3) + (ixLine6*6)+ (ixLine7*6) + (ixCorner11*9) + (ixCorner13*9) + (ixStreet7*12) + (ixSplit32*18) + (ixSplit36*18) + (ixSplit37*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix19su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix19su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine6 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine7 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet7 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner11 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner13 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit32 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit32)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit36 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit36)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit37 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit37)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 20:
    nMoney = nMoney + (ix20su*36) + (ixBlack*2) + (ixHigh*2) + (ixEven*2) + (ixCol2*3) + (ixDoz2*3) + (ixLine6*6)+ (ixLine7*6) + (ixCorner11*9) + (ixCorner12*9) + (ixCorner13*9) + (ixCorner14*9)+ (ixStreet7*12) + (ixSplit34*18) + (ixSplit36*18) + (ixSplit38*18) + (ixSplit39*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix20su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix20su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine6 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine7 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet7 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 11)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner1 >= 12)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner1 >= 13)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner1 >= 14)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit34 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit34)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit36 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit36)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit38 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit38)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit39 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit39)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 21:
    nMoney = nMoney + (ix21su*36) + (ixRed*2) + (ixHigh*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz2*3) + (ixLine6*6)+ (ixLine7*6) + (ixCorner12*9) + (ixCorner14*9)+ (ixStreet7*12) + (ixSplit35*18) + (ixSplit38*18) + (ixSplit40*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix21su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix21su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine6 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine6)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine7 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet7 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner12 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner14 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit35 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit35)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit38 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit38)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit40 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit40)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 22:
    nMoney = nMoney + (ix22su*36) + (ixBlack*2) + (ixHigh*2) + (ixEven*2) + (ixCol1*3) + (ixDoz2*3) + (ixLine7*6)+ (ixLine8*6) + (ixCorner13*9) + (ixCorner15*9) + (ixStreet8*12) + (ixSplit37*18) + (ixSplit41*18) + (ixSplit42*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix22su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix22su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine7 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine8 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet8 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 13)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner1 >= 15)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit37 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit37)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit41 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit41)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit42 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit42)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 23:
    nMoney = nMoney + (ix23su*36) + (ixRed*2) + (ixHigh*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz2*3) + (ixLine7*6)+ (ixLine8*6) + (ixCorner13*9) + (ixCorner14*9) + (ixCorner15*9) + (ixCorner16*9)+ (ixStreet8*12) + (ixSplit39*18) + (ixSplit41*18) + (ixSplit43*18) + (ixSplit44*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix23su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix23su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine7 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine8 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet8 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 13)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner13)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner1 >= 14)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner1 >= 15)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner1 >= 16)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit39 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit39)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit41 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit41)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit43 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit43)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit44 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit44)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 24:
    nMoney = nMoney + (ix24su*36) + (ixBlack*2) + (ixHigh*2) + (ixEven*2) + (ixCol3*3) + (ixDoz2*3) + (ixLine7*6)+ (ixLine8*6) + (ixCorner14*9) + (ixCorner16*9) + (ixStreet8*12) + (ixSplit40*18) + (ixSplit43*18) + (ixSplit45*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz2 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix24su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix24su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine7 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine8 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet8 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner14 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner16 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit40 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit40)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit43 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit43)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit45 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit45)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 25:
    nMoney = nMoney + (ix25su*36) + (ixRed*2) + (ixHigh*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz3*3) + (ixLine8*6)+ (ixLine9*6) + (ixCorner15*9) + (ixCorner17*9) + (ixStreet9*12) + (ixSplit42*18) + (ixSplit46*18) + (ixSplit47*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
               if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix25su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix25su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine8 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine9 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet9 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner15 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner17 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit42 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit42)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit46 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit46)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit47 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit47)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 26:
    nMoney = nMoney + (ix26su*36) + (ixBlack*2) + (ixHigh*2) + (ixEven*2) + (ixCol2*3) + (ixDoz3*3) + (ixLine8*6)+ (ixLine9*6) + (ixCorner15*9) + (ixCorner16*9) + (ixCorner17*9) + (ixCorner18*9)+ (ixStreet9*12) + (ixSplit44*18) + (ixSplit46*18) + (ixSplit48*18) + (ixSplit49*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix26su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix26su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine8 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine9 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet9 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner1 >= 15)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner15)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner1 >= 16)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner1 >= 17)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner1 >= 18)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit44 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit44)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit46 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit46)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit48 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit48)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit49 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit49)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 27:
    nMoney = nMoney + (ix27su*36) + (ixRed*2) + (ixHigh*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz3*3) + (ixLine8*6)+ (ixLine9*6) + (ixCorner16*9) + (ixCorner18*9) + (ixStreet9*12) + (ixSplit45*18) + (ixSplit48*18) + (ixSplit50*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix27su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix27su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine8 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine8)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine9 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet9 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner16 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner18 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit45 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit45)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit48 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit48)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit50 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit50)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 28:
    nMoney = nMoney + (ix28su*36) + (ixBlack*2) + (ixHigh*2) + (ixEven*2) + (ixCol1*3) + (ixDoz3*3) + (ixLine9*6)+ (ixLine10*6) + (ixCorner17*9) + (ixCorner19*9) + (ixStreet10*12) + (ixSplit47*18) + (ixSplit51*18) + (ixSplit52*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix28su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix28su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine9 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine10 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet10 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner17 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner19 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit47 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit47)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit51 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit51)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit52 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit52)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 29:
    nMoney = nMoney + (ix29su*36) + (ixBlack*2) + (ixHigh*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz3*3) + (ixLine9*6)+ (ixLine10*6) + (ixCorner17*9) + (ixCorner18*9) + (ixCorner19*9) + (ixCorner20*9)+ (ixStreet10*12) + (ixSplit49*18) + (ixSplit51*18) + (ixSplit53*18) + (ixSplit54*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix29su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix29su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine9 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine10 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet10 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner17 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner17)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner18 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner19 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner20 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit49 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit49)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit51 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit51)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit53 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit53)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit54 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit54)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 30:
    nMoney = nMoney + (ix30su*36) + (ixRed*2) + (ixHigh*2) + (ixEven*2) + (ixCol3*3) + (ixDoz3*3) + (ixLine9*6)+ (ixLine10*6) + (ixCorner18*9) + (ixCorner20*9) + (ixStreet10*12) + (ixSplit50*18) + (ixSplit53*18) + (ixSplit55*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix30su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix30su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine9 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine9)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine10 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet10 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner18 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner20 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit50 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit50)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit53 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit53)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit55 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit55)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 31:
    nMoney = nMoney + (ix31su*36) + (ixBlack*2) + (ixHigh*2) + (ixOdd*2) + (ixCol1*3) + (ixDoz3*3) + (ixLine10*6)+ (ixLine11*6) + (ixCorner19*9) + (ixCorner21*9) + (ixStreet11*12) + (ixSplit52*18) + (ixSplit56*18) + (ixSplit57*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix31su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix31su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine10 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine11 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet11 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner19 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner21 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner21)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit52 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit52)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit56 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit56)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit57 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit57)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 32:
    nMoney = nMoney + (ix32su*36) + (ixRed*2) + (ixHigh*2) + (ixEven*2) + (ixCol2*3) + (ixDoz3*3) + (ixLine10*6)+ (ixLine11*6) + (ixCorner19*9) + (ixCorner20*9) + (ixCorner21*9) + (ixCorner22*9)+ (ixStreet11*12) + (ixSplit54*18) + (ixSplit56*18) + (ixSplit58*18) + (ixSplit59*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix32su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix32su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine10 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine11 >= 1)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet11 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner19 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner20 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixCorner21 >= 1)
        {
        sxCorner3 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner21)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner3","sxCorner3");
        }
    if (ixCorner22 >= 1)
        {
        sxCorner4 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner4","sxCorner4");
        }
    if (ixSplit54 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit14)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit56 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit16)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit58 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit18)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit59 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit19)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;

    case 33:
    nMoney = nMoney + (ix33su*36) + (ixBlack*2) + (ixHigh*2) + (ixOdd*2) + (ixCol3*3) + (ixDoz3*3) + (ixLine10*6)+ (ixLine11*6) + (ixCorner20*9) + (ixCorner22*9)+ (ixStreet11*12) + (ixSplit55*18) + (ixSplit58*18) + (ixSplit60*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix33su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix33su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine1 >= 10)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine10)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
    if (ixLine1 >= 11)
        {
        sxLine2 = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine2","sxLine2");
        }
            if (ixStreet11 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner20 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner22 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit55 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit55)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit58 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit58)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit60 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit60)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    break;

    case 34:
    nMoney = nMoney + (ix34su*36) + (ixRed*2) + (ixHigh*2) + (ixEven*2) + (ixCol1*3) + (ixDoz3*3) + (ixLine11*6)+ (ixCorner21*9) + (ixStreet12*12) + (ixSplit57*18) + (ixSplit61*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol1 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix34su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix34su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine11 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
            if (ixStreet12 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner20 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner20)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixSplit57 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit7)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit61 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    break;

    case 35:
    nMoney = nMoney + (ix35su*36) + (ixBlack*2) + (ixHigh*2) + (ixOdd*2) + (ixCol2*3) + (ixDoz3*3) + (ixLine11*6)+ (ixCorner21*9) + (ixCorner22*9) + (ixStreet12*12) + (ixSplit59*18) + (ixSplit61*18) + (ixSplit62*18);
    sxSpot1Color = "Black";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
                if (ixBlack >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixBlack)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                    if (ixOdd >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Odd bet of "+IntToString(ixOdd)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
            if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol2 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol2)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix35su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix35su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine11 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
             if (ixStreet12 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner21 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner21)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixCorner22 >= 1)
        {
        sxCorner2 = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner2","sxCorner2");
        }
    if (ixSplit59 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit59)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    if (ixSplit61 >= 1)
        {
        sxSplit3 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit61)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit3","sxSplit3");
        }
    if (ixSplit62 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit62)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    break;

    case 36:
    nMoney = nMoney + (ix36su*36) + (ixRed*2) + (ixHigh*2) + (ixEven*2) + (ixCol3*3) + (ixDoz3*3) + (ixLine11*6)+ (ixCorner22*9) + (ixStreet12*12) + (ixSplit60*18) + (ixSplit62*18);
    sxSpot1Color = "Red";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
            if (ixRed >= 1)
        {
        sxRB = "" + GetName(oPC) + "'s "+(sxSpot1Color)+" bet of "+IntToString(ixRed)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sRB","sxRB");
        }
                    if (ixHigh >= 1)
        {
        sxHL = "" + GetName(oPC) + "'s High bet of "+IntToString(ixHigh)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sHL","sxHL");
        }
                        if (ixEven >= 1)
        {
        sxEO = "" + GetName(oPC) + "'s Even bet of "+IntToString(ixEven)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sEO","sxEO");
        }
           if (ixDoz3 >= 1)
        {
        sxDoz = "" + GetName(oPC) + "'s Dozen bet of "+IntToString(ixDoz3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sDoz","sxDoz");
        }
                if (ixCol3 >= 1)
        {
        sxCol = "" + GetName(oPC) + "'s Column bet of "+IntToString(ixCol3)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCol","sxCol");
        }
    if (ix36su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix36su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixLine11 >= 1)
        {
        sxLine = "" + GetName(oPC) + "'s Line bet of "+IntToString(ixLine11)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sLine","sxLine");
        }
            if (ixStreet12 >= 1)
        {
        sxStreet = "" + GetName(oPC) + "'s Street bet of "+IntToString(ixStreet12)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sStreet","sxStreet");
        }
    if (ixCorner22 >= 1)
        {
        sxCorner = "" + GetName(oPC) + "'s Corner bet of "+IntToString(ixCorner22)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sCorner","sxCorner");
        }
    if (ixSplit60 >= 1)
        {
        sxSplit1 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit60)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit1","sxSplit1");
        }
    if (ixSplit62 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit62)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    break;

    case 37:
    nMoney = nMoney + (ixFive*7) + (ix00su*36) + (ixSplit1*18) + (ixSplit4*18) + (ixSplit5*18);
    sxSpot1Color = "Green";
    SetLocalString(OBJECT_SELF,"sSpot1Color","sxSpot1Color");
    if (ix00su >= 1)
        {
        sxSUHit = "" + GetName(oPC) + "'s Straight Up bet of "+IntToString(ix00su)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSUHit","sxSUHit");
        }
    if (ixFive >= 1)
        {
        sxFive = "" + GetName(oPC) + "'s Five-Number bet of "+IntToString(ixFive)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sFive","sxFive");
        }
    if (ixSplit1 >= 1)
        {
        sxSplit2 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit1)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit2","sxSplit2");
        }
    if (ixSplit4 >= 1)
        {
        sxSplit5 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit4)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit5","sxSplit5");
        }
    if (ixSplit5 >= 1)
        {
        sxSplit4 = "" + GetName(oPC) + "'s Split bet of "+IntToString(ixSplit5)+" has hit! ";
        SetLocalString(OBJECT_SELF,"sSplit4","sxSplit4");
        }
    break;
    }
//remove old bets
SetLocalInt(oPC,"iBet",0);
SetLocalInt(oPC,"iFive",0);
SetLocalInt(oPC,"iRed",0);
SetLocalInt(oPC,"iBlack",0);
SetLocalInt(oPC,"iHigh",0);
SetLocalInt(oPC,"iLow",0);
SetLocalInt(oPC,"iEven",0);
SetLocalInt(oPC,"iOdd",0);
SetLocalInt(oPC,"iDoz1",0);
SetLocalInt(oPC,"iDoz2",0);
SetLocalInt(oPC,"iDoz3",0);
SetLocalInt(oPC,"iCol1",0);
SetLocalInt(oPC,"iCol2",0);
SetLocalInt(oPC,"iCol3",0);
SetLocalInt(oPC,"i0su",0);
SetLocalInt(oPC,"i00su",0);
SetLocalInt(oPC,"i1su",0);
SetLocalInt(oPC,"i2su",0);
SetLocalInt(oPC,"i3su",0);
SetLocalInt(oPC,"i4su",0);
SetLocalInt(oPC,"i5su",0);
SetLocalInt(oPC,"i6su",0);
SetLocalInt(oPC,"i7su",0);
SetLocalInt(oPC,"i8su",0);
SetLocalInt(oPC,"i9su",0);
SetLocalInt(oPC,"i10su",0);
SetLocalInt(oPC,"i11su",0);
SetLocalInt(oPC,"i12su",0);
SetLocalInt(oPC,"i13su",0);
SetLocalInt(oPC,"i14su",0);
SetLocalInt(oPC,"i15su",0);
SetLocalInt(oPC,"i16su",0);
SetLocalInt(oPC,"i17su",0);
SetLocalInt(oPC,"i18su",0);
SetLocalInt(oPC,"i19su",0);
SetLocalInt(oPC,"i20su",0);
SetLocalInt(oPC,"i21su",0);
SetLocalInt(oPC,"i22su",0);
SetLocalInt(oPC,"i23su",0);
SetLocalInt(oPC,"i24su",0);
SetLocalInt(oPC,"i25su",0);
SetLocalInt(oPC,"i26su",0);
SetLocalInt(oPC,"i27su",0);
SetLocalInt(oPC,"i28su",0);
SetLocalInt(oPC,"i29su",0);
SetLocalInt(oPC,"i30su",0);
SetLocalInt(oPC,"i31su",0);
SetLocalInt(oPC,"i32su",0);
SetLocalInt(oPC,"i33su",0);
SetLocalInt(oPC,"i34su",0);
SetLocalInt(oPC,"i35su",0);
SetLocalInt(oPC,"i36su",0);
SetLocalInt(oPC,"iLine1",0);
SetLocalInt(oPC,"iLine2",0);
SetLocalInt(oPC,"iLine3",0);
SetLocalInt(oPC,"iLine4",0);
SetLocalInt(oPC,"iLine5",0);
SetLocalInt(oPC,"iLine6",0);
SetLocalInt(oPC,"iLine7",0);
SetLocalInt(oPC,"iLine8",0);
SetLocalInt(oPC,"iLine9",0);
SetLocalInt(oPC,"iLine10",0);
SetLocalInt(oPC,"iLine11",0);
SetLocalInt(oPC,"iStreet1",0);
SetLocalInt(oPC,"iStreet2",0);
SetLocalInt(oPC,"iStreet3",0);
SetLocalInt(oPC,"iStreet4",0);
SetLocalInt(oPC,"iStreet5",0);
SetLocalInt(oPC,"iStreet6",0);
SetLocalInt(oPC,"iStreet7",0);
SetLocalInt(oPC,"iStreet8",0);
SetLocalInt(oPC,"iStreet9",0);
SetLocalInt(oPC,"iStreet10",0);
SetLocalInt(oPC,"iStreet11",0);
SetLocalInt(oPC,"iStreet12",0);
SetLocalInt(oPC,"iCorner1",0);
SetLocalInt(oPC,"iCorner2",0);
SetLocalInt(oPC,"iCorner3",0);
SetLocalInt(oPC,"iCorner4",0);
SetLocalInt(oPC,"iCorner5",0);
SetLocalInt(oPC,"iCorner6",0);
SetLocalInt(oPC,"iCorner7",0);
SetLocalInt(oPC,"iCorner8",0);
SetLocalInt(oPC,"iCorner9",0);
SetLocalInt(oPC,"iCorner10",0);
SetLocalInt(oPC,"iCorner11",0);
SetLocalInt(oPC,"iCorner12",0);
SetLocalInt(oPC,"iCorner13",0);
SetLocalInt(oPC,"iCorner14",0);
SetLocalInt(oPC,"iCorner15",0);
SetLocalInt(oPC,"iCorner16",0);
SetLocalInt(oPC,"iCorner17",0);
SetLocalInt(oPC,"iCorner18",0);
SetLocalInt(oPC,"iCorner19",0);
SetLocalInt(oPC,"iCorner20",0);
SetLocalInt(oPC,"iCorner21",0);
SetLocalInt(oPC,"iCorner22",0);
SetLocalInt(oPC,"iSplit1",0);
SetLocalInt(oPC,"iSplit2",0);
SetLocalInt(oPC,"iSplit3",0);
SetLocalInt(oPC,"iSplit4",0);
SetLocalInt(oPC,"iSplit5",0);
SetLocalInt(oPC,"iSplit6",0);
SetLocalInt(oPC,"iSplit7",0);
SetLocalInt(oPC,"iSplit8",0);
SetLocalInt(oPC,"iSplit9",0);
SetLocalInt(oPC,"iSplit10",0);
SetLocalInt(oPC,"iSplit11",0);
SetLocalInt(oPC,"iSplit12",0);
SetLocalInt(oPC,"iSplit13",0);
SetLocalInt(oPC,"iSplit14",0);
SetLocalInt(oPC,"iSplit15",0);
SetLocalInt(oPC,"iSplit16",0);
SetLocalInt(oPC,"iSplit17",0);
SetLocalInt(oPC,"iSplit18",0);
SetLocalInt(oPC,"iSplit19",0);
SetLocalInt(oPC,"iSplit20",0);
SetLocalInt(oPC,"iSplit21",0);
SetLocalInt(oPC,"iSplit22",0);
SetLocalInt(oPC,"iSplit23",0);
SetLocalInt(oPC,"iSplit24",0);
SetLocalInt(oPC,"iSplit25",0);
SetLocalInt(oPC,"iSplit26",0);
SetLocalInt(oPC,"iSplit27",0);
SetLocalInt(oPC,"iSplit28",0);
SetLocalInt(oPC,"iSplit29",0);
SetLocalInt(oPC,"iSplit30",0);
SetLocalInt(oPC,"iSplit31",0);
SetLocalInt(oPC,"iSplit32",0);
SetLocalInt(oPC,"iSplit33",0);
SetLocalInt(oPC,"iSplit34",0);
SetLocalInt(oPC,"iSplit35",0);
SetLocalInt(oPC,"iSplit36",0);
SetLocalInt(oPC,"iSplit37",0);
SetLocalInt(oPC,"iSplit38",0);
SetLocalInt(oPC,"iSplit39",0);
SetLocalInt(oPC,"iSplit40",0);
SetLocalInt(oPC,"iSplit41",0);
SetLocalInt(oPC,"iSplit42",0);
SetLocalInt(oPC,"iSplit43",0);
SetLocalInt(oPC,"iSplit44",0);
SetLocalInt(oPC,"iSplit45",0);
SetLocalInt(oPC,"iSplit46",0);
SetLocalInt(oPC,"iSplit47",0);
SetLocalInt(oPC,"iSplit48",0);
SetLocalInt(oPC,"iSplit49",0);
SetLocalInt(oPC,"iSplit50",0);
SetLocalInt(oPC,"iSplit51",0);
SetLocalInt(oPC,"iSplit52",0);
SetLocalInt(oPC,"iSplit53",0);
SetLocalInt(oPC,"iSplit54",0);
SetLocalInt(oPC,"iSplit55",0);
SetLocalInt(oPC,"iSplit56",0);
SetLocalInt(oPC,"iSplit57",0);
SetLocalInt(oPC,"iSplit58",0);
SetLocalInt(oPC,"iSplit59",0);
SetLocalInt(oPC,"iSplit60",0);
SetLocalInt(oPC,"iSplit61",0);
SetLocalInt(oPC,"iSplit62",0);
if (oPC == GetObjectByTag("roulettedealer"))
    {
    if (ixSpot1==37)
        {
        AssignCommand(GetObjectByTag("roulettedealer"),SpeakString("The winning spot is Green 00."));
        }
    else
        {
        AssignCommand(GetObjectByTag("roulettedealer"),SpeakString("The winning spot is "+sxSpot1Color+" "+IntToString(ixSpot1)+"."));
        }
    }
else
    {
    string sResult = ""+sxRB+""+sxHL+""+sxEO+""+sxDoz+""+sxCol+""+sxLine+""+sxLine2+""+sxFive+""+sxCorner+""+sxCorner2+""+sxCorner3+""+sxCorner4+""+sxStreet+""+sxSUHit+""+sxSplit1+""+sxSplit2+""+sxSplit3+""+sxSplit4+""+sxSplit5+"";
    GiveGoldToCreature(oPC,nMoney);
    string sMoney = ""+IntToString(nMoney)+"";
    if (sResult != "")
        {
        AssignCommand(GetObjectByTag("roulettedealer"),ActionDoCommand(SpeakString(""+sResult+""+GetName(oPC)+" wins "+sMoney+" gold!")));
        }
    }
DeleteLocalInt(OBJECT_SELF,"nMoney");
}
