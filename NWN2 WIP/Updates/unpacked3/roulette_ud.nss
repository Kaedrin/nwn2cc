//Roulette modified by Stephen Spann  (sspann@worldnet.att.net)
//originally from Charles Adam's 'Casino Bertix' module
//now includes the 00 slot, Five-Number bets, Corner Bets, and Split Bets.
//and uses SetListeningPattern() cues instead of a conversation.


void main() {
    int nUser = GetUserDefinedEventNumber();

    if(nUser == 1004) { //OnConversation.
        int nMatch = GetListenPatternNumber();
        string sUser = IntToString(nMatch);
        int nStringLength = GetStringLength(sUser);
        string sBetType = GetStringRight(sUser, 3);
        string sBetAmount = GetStringLeft(sUser, (nStringLength - 3));
        int nBet = (StringToInt(sBetAmount));
        nMatch = StringToInt("10" + sBetType);
        object oPC = GetLastSpeaker();

            switch(nMatch) {
                case 10001:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold Five-Number bet.");
                        int ixFive = GetLocalInt(oPC,"iFive");
                        ixFive += nBet;
                        SetLocalInt(oPC,"iFive", ixFive);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10002:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Reds.");
                        int ixRed = GetLocalInt(oPC,"iRed");
                        ixRed += nBet;
                        SetLocalInt(oPC,"iRed", ixRed);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10003:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Blacks.");
                        int ixBlack = GetLocalInt(oPC,"iBlack");
                        ixBlack += nBet;
                        SetLocalInt(oPC,"iBlack", ixBlack);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10004:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Odds.");
                        int ixOdd = GetLocalInt(oPC,"iOdd");
                        ixOdd += nBet;
                        SetLocalInt(oPC,"iOdd", ixOdd);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10005:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Evens.");
                        int ixEven = GetLocalInt(oPC,"iEven");
                        ixEven += nBet;
                        SetLocalInt(oPC,"iEven", ixEven);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10006:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Highs.");
                        int ixHigh = GetLocalInt(oPC,"iHigh");
                        ixHigh += nBet;
                        SetLocalInt(oPC,"iHigh", ixHigh);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10007:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a " + IntToString(nBet) + " gold bet on Lows.");
                        int ixLow = GetLocalInt(oPC,"iLow");
                        ixLow += nBet;
                        SetLocalInt(oPC,"iLow", ixLow);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10008:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Column bet of " + IntToString(nBet) + " gold.");
                        int ixCol1 = GetLocalInt(oPC,"iCol1");
                        ixCol1 += nBet;
                        SetLocalInt(oPC,"iCol1", ixCol1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10009:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Column bet of " + IntToString(nBet) + " gold.");
                        int ixCol2 = GetLocalInt(oPC,"iCol2");
                        ixCol2 += nBet;
                        SetLocalInt(oPC,"iCol2", ixCol2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10010:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Column bet of " + IntToString(nBet) + " gold.");
                        int ixCol3 = GetLocalInt(oPC,"iCol3");
                        ixCol3 += nBet;
                        SetLocalInt(oPC,"iCol3", ixCol3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10011:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Dozen bet of " + IntToString(nBet) + " gold.");
                        int ixDoz1 = GetLocalInt(oPC,"iDoz1");
                        ixDoz1 += nBet;
                        SetLocalInt(oPC,"iDoz1", ixDoz1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10012:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Dozen bet of " + IntToString(nBet) + " gold.");
                        int ixDoz2 = GetLocalInt(oPC,"iDoz2");
                        ixDoz2 += nBet;
                        SetLocalInt(oPC,"iDoz2", ixDoz2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10013:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Dozen bet of " + IntToString(nBet) + " gold.");
                        int ixDoz3 = GetLocalInt(oPC,"iDoz3");
                        ixDoz3 += nBet;
                        SetLocalInt(oPC,"iDoz3", ixDoz3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10014:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine1 = GetLocalInt(oPC,"iLine1");
                        ixLine1 += nBet;
                        SetLocalInt(oPC,"iLine1", ixLine1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10015:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine2 = GetLocalInt(oPC,"iLine2");
                        ixLine2 += nBet;
                        SetLocalInt(oPC,"iLine2", ixLine2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10016:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine3 = GetLocalInt(oPC,"iLine3");
                        ixLine3 += nBet;
                        SetLocalInt(oPC,"iLine3", ixLine3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10017:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine4 = GetLocalInt(oPC,"iLine4");
                        ixLine4 += nBet;
                        SetLocalInt(oPC,"iLine4", ixLine4);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10018:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine5 = GetLocalInt(oPC,"iLine5");
                        ixLine5 += nBet;
                        SetLocalInt(oPC,"iLine5", ixLine5);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10019:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine6 = GetLocalInt(oPC,"iLine6");
                        ixLine6 += nBet;
                        SetLocalInt(oPC,"iLine6", ixLine6);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10020:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine7 = GetLocalInt(oPC,"iLine7");
                        ixLine7 += nBet;
                        SetLocalInt(oPC,"iLine7", ixLine7);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10021:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine8 = GetLocalInt(oPC,"iLine8");
                        ixLine8 += nBet;
                        SetLocalInt(oPC,"iLine8", ixLine8);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10022:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine9 = GetLocalInt(oPC,"iLine9");
                        ixLine9 += nBet;
                        SetLocalInt(oPC,"iLine9", ixLine9);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10023:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine10 = GetLocalInt(oPC,"iLine10");
                        ixLine10 += nBet;
                        SetLocalInt(oPC,"iLine10", ixLine10);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10024:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Line bet of " + IntToString(nBet) + " gold.");
                        int ixLine11 = GetLocalInt(oPC,"iLine11");
                        ixLine11 += nBet;
                        SetLocalInt(oPC,"iLine11", ixLine11);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10025:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet1 = GetLocalInt(oPC,"iStreet1");
                        ixStreet1 += nBet;
                        SetLocalInt(oPC,"iStreet1", ixStreet1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10026:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet2 = GetLocalInt(oPC,"iStreet2");
                        ixStreet2 += nBet;
                        SetLocalInt(oPC,"iStreet2", ixStreet2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10027:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet3 = GetLocalInt(oPC,"iStreet3");
                        ixStreet3 += nBet;
                        SetLocalInt(oPC,"iStreet3", ixStreet3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10028:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet4 = GetLocalInt(oPC,"iStreet4");
                        ixStreet4 += nBet;
                        SetLocalInt(oPC,"iStreet4", ixStreet4);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10029:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet5 = GetLocalInt(oPC,"iStreet5");
                        ixStreet5 += nBet;
                        SetLocalInt(oPC,"iStreet5", ixStreet5);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10030:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet6 = GetLocalInt(oPC,"iStreet6");
                        ixStreet6 += nBet;
                        SetLocalInt(oPC,"iStreet6", ixStreet6);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10031:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet7 = GetLocalInt(oPC,"iStreet7");
                        ixStreet7 += nBet;
                        SetLocalInt(oPC,"iStreet7", ixStreet7);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10032:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet8 = GetLocalInt(oPC,"iStreet8");
                        ixStreet8 += nBet;
                        SetLocalInt(oPC,"iStreet8", ixStreet8);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10033:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet9 = GetLocalInt(oPC,"iStreet9");
                        ixStreet9 += nBet;
                        SetLocalInt(oPC,"iStreet9", ixStreet9);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10034:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet10 = GetLocalInt(oPC,"iStreet10");
                        ixStreet10 += nBet;
                        SetLocalInt(oPC,"iStreet10", ixStreet10);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10035:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet11 = GetLocalInt(oPC,"iStreet11");
                        ixStreet11 += nBet;
                        SetLocalInt(oPC,"iStreet11", ixStreet11);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10036:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Street bet of " + IntToString(nBet) + " gold.");
                        int ixStreet12 = GetLocalInt(oPC,"iStreet12");
                        ixStreet12 += nBet;
                        SetLocalInt(oPC,"iStreet12", ixStreet12);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10037:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner1 = GetLocalInt(oPC,"iCorner1");
                        ixCorner1 += nBet;
                        SetLocalInt(oPC,"iCorner1", ixCorner1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10038:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner2 = GetLocalInt(oPC,"iCorner2");
                        ixCorner2 += nBet;
                        SetLocalInt(oPC,"iCorner2", ixCorner2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10039:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner3 = GetLocalInt(oPC,"iCorner3");
                        ixCorner3 += nBet;
                        SetLocalInt(oPC,"iCorner3", ixCorner3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10040:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner4 = GetLocalInt(oPC,"iCorner4");
                        ixCorner4 += nBet;
                        SetLocalInt(oPC,"iCorner4", ixCorner4);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10041:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner5 = GetLocalInt(oPC,"iCorner5");
                        ixCorner5 += nBet;
                        SetLocalInt(oPC,"iCorner5", ixCorner5);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10042:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner6 = GetLocalInt(oPC,"iCorner6");
                        ixCorner6 += nBet;
                        SetLocalInt(oPC,"iCorner6", ixCorner6);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10043:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner7 = GetLocalInt(oPC,"iCorner7");
                        ixCorner7 += nBet;
                        SetLocalInt(oPC,"iCorner7", ixCorner7);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10044:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner8 = GetLocalInt(oPC,"iCorner8");
                        ixCorner8 += nBet;
                        SetLocalInt(oPC,"iCorner8", ixCorner8);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10045:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner9 = GetLocalInt(oPC,"iCorner9");
                        ixCorner9 += nBet;
                        SetLocalInt(oPC,"iCorner9", ixCorner9);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10046:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner10 = GetLocalInt(oPC,"iCorner10");
                        ixCorner10 += nBet;
                        SetLocalInt(oPC,"iCorner10", ixCorner10);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10047:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner11 = GetLocalInt(oPC,"iCorner11");
                        ixCorner11 += nBet;
                        SetLocalInt(oPC,"iCorner11", ixCorner11);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10048:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner12 = GetLocalInt(oPC,"iCorner12");
                        ixCorner12 += nBet;
                        SetLocalInt(oPC,"iCorner12", ixCorner12);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10049:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner13 = GetLocalInt(oPC,"iCorner13");
                        ixCorner13 += nBet;
                        SetLocalInt(oPC,"iCorner13", ixCorner13);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10050:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner14 = GetLocalInt(oPC,"iCorner14");
                        ixCorner14 += nBet;
                        SetLocalInt(oPC,"iCorner14", ixCorner14);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10051:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner15 = GetLocalInt(oPC,"iCorner15");
                        ixCorner15 += nBet;
                        SetLocalInt(oPC,"iCorner15", ixCorner15);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10052:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner16 = GetLocalInt(oPC,"iCorner16");
                        ixCorner16 += nBet;
                        SetLocalInt(oPC,"iCorner16", ixCorner16);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10053:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner17 = GetLocalInt(oPC,"iCorner17");
                        ixCorner17 += nBet;
                        SetLocalInt(oPC,"iCorner17", ixCorner17);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10054:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner18 = GetLocalInt(oPC,"iCorner18");
                        ixCorner18 += nBet;
                        SetLocalInt(oPC,"iCorner18", ixCorner18);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10055:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner19 = GetLocalInt(oPC,"iCorner19");
                        ixCorner19 += nBet;
                        SetLocalInt(oPC,"iCorner19", ixCorner19);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10056:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner20 = GetLocalInt(oPC,"iCorner20");
                        ixCorner20 += nBet;
                        SetLocalInt(oPC,"iCorner20", ixCorner20);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10057:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner21 = GetLocalInt(oPC,"iCorner21");
                        ixCorner21 += nBet;
                        SetLocalInt(oPC,"iCorner21", ixCorner21);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10058:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Corner bet of " + IntToString(nBet) + " gold.");
                        int ixCorner22 = GetLocalInt(oPC,"iCorner22");
                        ixCorner22 += nBet;
                        SetLocalInt(oPC,"iCorner22", ixCorner22);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10059:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix0su = GetLocalInt(oPC,"i0su");
                        ix0su += nBet;
                        SetLocalInt(oPC,"i0su", ix0su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10060:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix00su = GetLocalInt(oPC,"i00su");
                        ix00su += nBet;
                        SetLocalInt(oPC,"i00su", ix00su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10061:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix1su = GetLocalInt(oPC,"i1su");
                        ix1su += nBet;
                        SetLocalInt(oPC,"i1su", ix1su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10062:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix2su = GetLocalInt(oPC,"i2su");
                        ix2su += nBet;
                        SetLocalInt(oPC,"i2su", ix2su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10063:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix3su = GetLocalInt(oPC,"i3su");
                        ix3su += nBet;
                        SetLocalInt(oPC,"i3su", ix3su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10064:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix4su = GetLocalInt(oPC,"i4su");
                        ix4su += nBet;
                        SetLocalInt(oPC,"i4su", ix4su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10065:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix5su = GetLocalInt(oPC,"i5su");
                        ix5su += nBet;
                        SetLocalInt(oPC,"i5su", ix5su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10066:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix6su = GetLocalInt(oPC,"i6su");
                        ix6su += nBet;
                        SetLocalInt(oPC,"i6su", ix6su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10067:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix7su = GetLocalInt(oPC,"i7su");
                        ix7su += nBet;
                        SetLocalInt(oPC,"i7su", ix7su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10068:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix8su = GetLocalInt(oPC,"i8su");
                        ix8su += nBet;
                        SetLocalInt(oPC,"i8su", ix8su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10069:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix9su = GetLocalInt(oPC,"i9su");
                        ix9su += nBet;
                        SetLocalInt(oPC,"i9su", ix9su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10070:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix10su = GetLocalInt(oPC,"i10su");
                        ix10su += nBet;
                        SetLocalInt(oPC,"i10su", ix10su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10071:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix11su = GetLocalInt(oPC,"i11su");
                        ix11su += nBet;
                        SetLocalInt(oPC,"i11su", ix11su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10072:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix12su = GetLocalInt(oPC,"i12su");
                        ix12su += nBet;
                        SetLocalInt(oPC,"i12su", ix12su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10073:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix13su = GetLocalInt(oPC,"i13su");
                        ix13su += nBet;
                        SetLocalInt(oPC,"i13su", ix13su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10074:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix14su = GetLocalInt(oPC,"i14su");
                        ix14su += nBet;
                        SetLocalInt(oPC,"i14su", ix14su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10075:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix15su = GetLocalInt(oPC,"i15su");
                        ix15su += nBet;
                        SetLocalInt(oPC,"i15su", ix15su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10076:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix16su = GetLocalInt(oPC,"i16su");
                        ix16su += nBet;
                        SetLocalInt(oPC,"i16su", ix16su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10077:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix17su = GetLocalInt(oPC,"i17su");
                        ix17su += nBet;
                        SetLocalInt(oPC,"i17su", ix17su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10078:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix18su = GetLocalInt(oPC,"i18su");
                        ix18su += nBet;
                        SetLocalInt(oPC,"i18su", ix18su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10079:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix19su = GetLocalInt(oPC,"i19su");
                        ix19su += nBet;
                        SetLocalInt(oPC,"i19su", ix19su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10080:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix20su = GetLocalInt(oPC,"i20su");
                        ix20su += nBet;
                        SetLocalInt(oPC,"i20su", ix20su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10081:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix21su = GetLocalInt(oPC,"i21su");
                        ix21su += nBet;
                        SetLocalInt(oPC,"i21su", ix21su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10082:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix22su = GetLocalInt(oPC,"i22su");
                        ix22su += nBet;
                        SetLocalInt(oPC,"i22su", ix22su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10083:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix23su = GetLocalInt(oPC,"i23su");
                        ix23su += nBet;
                        SetLocalInt(oPC,"i23su", ix23su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10084:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix24su = GetLocalInt(oPC,"i24su");
                        ix24su += nBet;
                        SetLocalInt(oPC,"i24su", ix24su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10085:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix25su = GetLocalInt(oPC,"i25su");
                        ix25su += nBet;
                        SetLocalInt(oPC,"i25su", ix25su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10086:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix26su = GetLocalInt(oPC,"i26su");
                        ix26su += nBet;
                        SetLocalInt(oPC,"i26su", ix26su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10087:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix27su = GetLocalInt(oPC,"i27su");
                        ix27su += nBet;
                        SetLocalInt(oPC,"i27su", ix27su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10088:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix28su = GetLocalInt(oPC,"i28su");
                        ix28su += nBet;
                        SetLocalInt(oPC,"i28su", ix28su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10089:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix29su = GetLocalInt(oPC,"i29su");
                        ix29su += nBet;
                        SetLocalInt(oPC,"i29su", ix29su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10090:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix30su = GetLocalInt(oPC,"i30su");
                        ix30su += nBet;
                        SetLocalInt(oPC,"i30su", ix30su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10091:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix31su = GetLocalInt(oPC,"i31su");
                        ix31su += nBet;
                        SetLocalInt(oPC,"i31su", ix31su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10092:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix32su = GetLocalInt(oPC,"i32su");
                        ix32su += nBet;
                        SetLocalInt(oPC,"i32su", ix32su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10093:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix33su = GetLocalInt(oPC,"i33su");
                        ix33su += nBet;
                        SetLocalInt(oPC,"i33su", ix33su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10094:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix34su = GetLocalInt(oPC,"i34su");
                        ix34su += nBet;
                        SetLocalInt(oPC,"i34su", ix34su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10095:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix35su = GetLocalInt(oPC,"i35su");
                        ix35su += nBet;
                        SetLocalInt(oPC,"i35su", ix35su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10096:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Straight Up bet of " + IntToString(nBet) + " gold.");
                        int ix36su = GetLocalInt(oPC,"i36su");
                        ix36su += nBet;
                        SetLocalInt(oPC,"i36su", ix36su);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10097:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit1 = GetLocalInt(oPC,"iSplit1");
                        ixSplit1 += nBet;
                        SetLocalInt(oPC,"iSplit1", ixSplit1);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10098:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit2 = GetLocalInt(oPC,"iSplit2");
                        ixSplit2 += nBet;
                        SetLocalInt(oPC,"iSplit2", ixSplit2);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10099:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit3 = GetLocalInt(oPC,"iSplit3");
                        ixSplit3 += nBet;
                        SetLocalInt(oPC,"iSplit3", ixSplit3);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10100:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit4 = GetLocalInt(oPC,"iSplit4");
                        ixSplit4 += nBet;
                        SetLocalInt(oPC,"iSplit4", ixSplit4);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10101:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit5 = GetLocalInt(oPC,"iSplit5");
                        ixSplit5 += nBet;
                        SetLocalInt(oPC,"iSplit5", ixSplit5);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10102:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit6 = GetLocalInt(oPC,"iSplit6");
                        ixSplit6 += nBet;
                        SetLocalInt(oPC,"iSplit6", ixSplit6);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10103:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit7 = GetLocalInt(oPC,"iSplit7");
                        ixSplit7 += nBet;
                        SetLocalInt(oPC,"iSplit7", ixSplit7);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10104:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit8 = GetLocalInt(oPC,"iSplit8");
                        ixSplit8 += nBet;
                        SetLocalInt(oPC,"iSplit8", ixSplit8);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10105:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit9 = GetLocalInt(oPC,"iSplit9");
                        ixSplit9 += nBet;
                        SetLocalInt(oPC,"iSplit9", ixSplit9);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10106:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit10 = GetLocalInt(oPC,"iSplit10");
                        ixSplit10 += nBet;
                        SetLocalInt(oPC,"iSplit10", ixSplit10);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10107:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit11 = GetLocalInt(oPC,"iSplit11");
                        ixSplit11 += nBet;
                        SetLocalInt(oPC,"iSplit11", ixSplit11);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10108:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit12 = GetLocalInt(oPC,"iSplit12");
                        ixSplit12 += nBet;
                        SetLocalInt(oPC,"iSplit12", ixSplit12);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10109:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit13 = GetLocalInt(oPC,"iSplit13");
                        ixSplit13 += nBet;
                        SetLocalInt(oPC,"iSplit13", ixSplit13);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10110:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit14 = GetLocalInt(oPC,"iSplit14");
                        ixSplit14 += nBet;
                        SetLocalInt(oPC,"iSplit14", ixSplit14);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10111:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit15 = GetLocalInt(oPC,"iSplit15");
                        ixSplit15 += nBet;
                        SetLocalInt(oPC,"iSplit15", ixSplit15);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10112:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit16 = GetLocalInt(oPC,"iSplit16");
                        ixSplit16 += nBet;
                        SetLocalInt(oPC,"iSplit16", ixSplit16);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10113:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit17 = GetLocalInt(oPC,"iSplit17");
                        ixSplit17 += nBet;
                        SetLocalInt(oPC,"iSplit17", ixSplit17);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10114:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit18 = GetLocalInt(oPC,"iSplit18");
                        ixSplit18 += nBet;
                        SetLocalInt(oPC,"iSplit18", ixSplit18);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10115:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit19 = GetLocalInt(oPC,"iSplit19");
                        ixSplit19 += nBet;
                        SetLocalInt(oPC,"iSplit19", ixSplit19);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10116:
                if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit20 = GetLocalInt(oPC,"iSplit20");
                        ixSplit20 += nBet;
                        SetLocalInt(oPC,"iSplit20", ixSplit20);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10117:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit21 = GetLocalInt(oPC,"iSplit21");
                        ixSplit21 += nBet;
                        SetLocalInt(oPC,"iSplit21", ixSplit21);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10118:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit22 = GetLocalInt(oPC,"iSplit22");
                        ixSplit22 += nBet;
                        SetLocalInt(oPC,"iSplit22", ixSplit22);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10119:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit23 = GetLocalInt(oPC,"iSplit23");
                        ixSplit23 += nBet;
                        SetLocalInt(oPC,"iSplit23", ixSplit23);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10120:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit24 = GetLocalInt(oPC,"iSplit24");
                        ixSplit24 += nBet;
                        SetLocalInt(oPC,"iSplit24", ixSplit24);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10121:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit25 = GetLocalInt(oPC,"iSplit25");
                        ixSplit25 += nBet;
                        SetLocalInt(oPC,"iSplit25", ixSplit25);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10122:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit26 = GetLocalInt(oPC,"iSplit26");
                        ixSplit26 += nBet;
                        SetLocalInt(oPC,"iSplit26", ixSplit26);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10123:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit27 = GetLocalInt(oPC,"iSplit27");
                        ixSplit27 += nBet;
                        SetLocalInt(oPC,"iSplit27", ixSplit27);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10124:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit28 = GetLocalInt(oPC,"iSplit28");
                        ixSplit28 += nBet;
                        SetLocalInt(oPC,"iSplit28", ixSplit28);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10125:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit29 = GetLocalInt(oPC,"iSplit29");
                        ixSplit29 += nBet;
                        SetLocalInt(oPC,"iSplit29", ixSplit29);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10126:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit30 = GetLocalInt(oPC,"iSplit30");
                        ixSplit30 += nBet;
                        SetLocalInt(oPC,"iSplit30", ixSplit30);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10127:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit31 = GetLocalInt(oPC,"iSplit31");
                        ixSplit31 += nBet;
                        SetLocalInt(oPC,"iSplit31", ixSplit31);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10128:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit32 = GetLocalInt(oPC,"iSplit32");
                        ixSplit32 += nBet;
                        SetLocalInt(oPC,"iSplit32", ixSplit32);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10129:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit33 = GetLocalInt(oPC,"iSplit33");
                        ixSplit33 += nBet;
                        SetLocalInt(oPC,"iSplit33", ixSplit33);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10130:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit34 = GetLocalInt(oPC,"iSplit34");
                        ixSplit34 += nBet;
                        SetLocalInt(oPC,"iSplit34", ixSplit34);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10131:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit35 = GetLocalInt(oPC,"iSplit35");
                        ixSplit35 += nBet;
                        SetLocalInt(oPC,"iSplit35", ixSplit35);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10132:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit36 = GetLocalInt(oPC,"iSplit36");
                        ixSplit36 += nBet;
                        SetLocalInt(oPC,"iSplit36", ixSplit36);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10133:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit37 = GetLocalInt(oPC,"iSplit37");
                        ixSplit37 += nBet;
                        SetLocalInt(oPC,"iSplit37", ixSplit37);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10134:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit38 = GetLocalInt(oPC,"iSplit38");
                        ixSplit38 += nBet;
                        SetLocalInt(oPC,"iSplit38", ixSplit38);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10135:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit39 = GetLocalInt(oPC,"iSplit39");
                        ixSplit39 += nBet;
                        SetLocalInt(oPC,"iSplit39", ixSplit39);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10136:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit40 = GetLocalInt(oPC,"iSplit40");
                        ixSplit40 += nBet;
                        SetLocalInt(oPC,"iSplit40", ixSplit40);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10137:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit41 = GetLocalInt(oPC,"iSplit41");
                        ixSplit41 += nBet;
                        SetLocalInt(oPC,"iSplit41", ixSplit41);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10138:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit42 = GetLocalInt(oPC,"iSplit42");
                        ixSplit42 += nBet;
                        SetLocalInt(oPC,"iSplit42", ixSplit42);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10139:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit43 = GetLocalInt(oPC,"iSplit43");
                        ixSplit43 += nBet;
                        SetLocalInt(oPC,"iSplit43", ixSplit43);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10140:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit44 = GetLocalInt(oPC,"iSplit44");
                        ixSplit44 += nBet;
                        SetLocalInt(oPC,"iSplit44", ixSplit44);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10141:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit45 = GetLocalInt(oPC,"iSplit45");
                        ixSplit45 += nBet;
                        SetLocalInt(oPC,"iSplit45", ixSplit45);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10142:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit46 = GetLocalInt(oPC,"iSplit46");
                        ixSplit46 += nBet;
                        SetLocalInt(oPC,"iSplit46", ixSplit46);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10143:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit47 = GetLocalInt(oPC,"iSplit47");
                        ixSplit47 += nBet;
                        SetLocalInt(oPC,"iSplit47", ixSplit47);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10144:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit48 = GetLocalInt(oPC,"iSplit48");
                        ixSplit48 += nBet;
                        SetLocalInt(oPC,"iSplit48", ixSplit48);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10145:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit49 = GetLocalInt(oPC,"iSplit49");
                        ixSplit49 += nBet;
                        SetLocalInt(oPC,"iSplit49", ixSplit49);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10146:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit50 = GetLocalInt(oPC,"iSplit50");
                        ixSplit50 += nBet;
                        SetLocalInt(oPC,"iSplit50", ixSplit50);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10147:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit51 = GetLocalInt(oPC,"iSplit51");
                        ixSplit51 += nBet;
                        SetLocalInt(oPC,"iSplit51", ixSplit51);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10148:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit52 = GetLocalInt(oPC,"iSplit52");
                        ixSplit52 += nBet;
                        SetLocalInt(oPC,"iSplit52", ixSplit52);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10149:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit53 = GetLocalInt(oPC,"iSplit53");
                        ixSplit53 += nBet;
                        SetLocalInt(oPC,"iSplit53", ixSplit53);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10150:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit54 = GetLocalInt(oPC,"iSplit54");
                        ixSplit54 += nBet;
                        SetLocalInt(oPC,"iSplit54", ixSplit54);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10151:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit55 = GetLocalInt(oPC,"iSplit55");
                        ixSplit55 += nBet;
                        SetLocalInt(oPC,"iSplit55", ixSplit55);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10152:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit56 = GetLocalInt(oPC,"iSplit56");
                        ixSplit56 += nBet;
                        SetLocalInt(oPC,"iSplit56", ixSplit56);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10153:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit57 = GetLocalInt(oPC,"iSplit57");
                        ixSplit57 += nBet;
                        SetLocalInt(oPC,"iSplit57", ixSplit57);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10154:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit58 = GetLocalInt(oPC,"iSplit58");
                        ixSplit58 += nBet;
                        SetLocalInt(oPC,"iSplit58", ixSplit58);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10155:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit59 = GetLocalInt(oPC,"iSplit59");
                        ixSplit59 += nBet;
                        SetLocalInt(oPC,"iSplit59", ixSplit59);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10156:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit60 = GetLocalInt(oPC,"iSplit60");
                        ixSplit60 += nBet;
                        SetLocalInt(oPC,"iSplit60", ixSplit60);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10157:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit61 = GetLocalInt(oPC,"iSplit61");
                        ixSplit61 += nBet;
                        SetLocalInt(oPC,"iSplit61", ixSplit61);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;
                case 10158:
                    if (GetGold(oPC) >= nBet)
                        {
                        TakeGoldFromCreature(nBet, oPC, TRUE);
                        SpeakString (GetName(oPC)+" has placed a Split bet of " + IntToString(nBet) + " gold.");
                        int ixSplit62 = GetLocalInt(oPC,"iSplit62");
                        ixSplit62 += nBet;
                        SetLocalInt(oPC,"iSplit62", ixSplit62);
                        SetLocalInt(oPC,"iBet",1);
                        }
                    else SpeakString (GetName(oPC)+", you don't have that much gold.");
                    break;

            }

        }
    }