/*
    Simple blackjack game. Dealer(NPC) vs. Player.
    Dealer stands on all 17s.
    Doubleing down is implemented.
    Winnings are 3 to 2. Minimum bet is a variable, default to 10 gold.
    No Surrenders, no Splits, although feel free to add that functionality,
    it should be relatively easy to fit SOME of those in.
*/


/* INITIALIZE DECK
Resets deck so all cards are 'undrawn'.
The 'Y' and 'N' at the end of the value indicates whether its been drawn or
not. 'N' = drawn, 'Y' = undrawn or available to be drawn :)
Also resets the players and dealers hands so they have no cards.
and turns off the "check for winner" trigger.
Also in the value of the cards, I included the suit, although whether
a card is a Heart, Diamond, Club or Spade does not matter in BlackJack.
Its only there in case I wanted to use this same deck for another game
type later on.
*/
void InitializeDeck() { //Resets deck and hands so none are 'drawn'.

    //Only reshuffle deck on 3rd game played.
    if(GetLocalInt(OBJECT_SELF, "RESHUFFLE") >= 3 || GetLocalInt(OBJECT_SELF, "RESHUFFLE") == 0) {
        SetLocalString(OBJECT_SELF, "1", "01HY");
        SetLocalString(OBJECT_SELF, "2", "01DY");
        SetLocalString(OBJECT_SELF, "3", "01CY");
        SetLocalString(OBJECT_SELF, "4", "01SY");
        SetLocalString(OBJECT_SELF, "5", "02HY");
        SetLocalString(OBJECT_SELF, "6", "02DY");
        SetLocalString(OBJECT_SELF, "7", "02CY");
        SetLocalString(OBJECT_SELF, "8", "02SY");
        SetLocalString(OBJECT_SELF, "9", "03HY");
        SetLocalString(OBJECT_SELF, "10", "03DY");
        SetLocalString(OBJECT_SELF, "11", "03CY");
        SetLocalString(OBJECT_SELF, "12", "03SY");
        SetLocalString(OBJECT_SELF, "13", "04HY");
        SetLocalString(OBJECT_SELF, "14", "04DY");
        SetLocalString(OBJECT_SELF, "15", "04CY");
        SetLocalString(OBJECT_SELF, "16", "04SY");
        SetLocalString(OBJECT_SELF, "17", "05HY");
        SetLocalString(OBJECT_SELF, "18", "05DY");
        SetLocalString(OBJECT_SELF, "19", "05CY");
        SetLocalString(OBJECT_SELF, "20", "05SY");
        SetLocalString(OBJECT_SELF, "21", "06HY");
        SetLocalString(OBJECT_SELF, "22", "06DY");
        SetLocalString(OBJECT_SELF, "23", "06CY");
        SetLocalString(OBJECT_SELF, "24", "06SY");
        SetLocalString(OBJECT_SELF, "25", "07HY");
        SetLocalString(OBJECT_SELF, "26", "07DY");
        SetLocalString(OBJECT_SELF, "27", "07CY");
        SetLocalString(OBJECT_SELF, "28", "07SY");
        SetLocalString(OBJECT_SELF, "29", "08HY");
        SetLocalString(OBJECT_SELF, "30", "08DY");
        SetLocalString(OBJECT_SELF, "31", "08CY");
        SetLocalString(OBJECT_SELF, "32", "08SY");
        SetLocalString(OBJECT_SELF, "33", "09HY");
        SetLocalString(OBJECT_SELF, "34", "09DY");
        SetLocalString(OBJECT_SELF, "35", "09CY");
        SetLocalString(OBJECT_SELF, "36", "09SY");
        SetLocalString(OBJECT_SELF, "37", "10HY");
        SetLocalString(OBJECT_SELF, "38", "10DY");
        SetLocalString(OBJECT_SELF, "39", "10CY");
        SetLocalString(OBJECT_SELF, "40", "10SY");
        SetLocalString(OBJECT_SELF, "41", "11HY");
        SetLocalString(OBJECT_SELF, "42", "11DY");
        SetLocalString(OBJECT_SELF, "43", "11CY");
        SetLocalString(OBJECT_SELF, "44", "11SY");
        SetLocalString(OBJECT_SELF, "45", "12HY");
        SetLocalString(OBJECT_SELF, "46", "12DY");
        SetLocalString(OBJECT_SELF, "47", "12CY");
        SetLocalString(OBJECT_SELF, "48", "12SY");
        SetLocalString(OBJECT_SELF, "49", "13HY");
        SetLocalString(OBJECT_SELF, "50", "13DY");
        SetLocalString(OBJECT_SELF, "51", "13CY");
        SetLocalString(OBJECT_SELF, "52", "13SY");
        SpeakString("Deck reshuffled.");
        //Reset shuffle.
        SetLocalInt(OBJECT_SELF, "RESHUFFLE", 0);
    }

    //Resetting Dealer and Player hands to 'empty'.
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_1", 0);
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_2", 0);
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_3", 0);
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_4", 0);
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_5", 0);
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_6", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_1", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_2", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_3", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_4", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_5", 0);
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_6", 0);

    //Reset check for winner.
    SetLocalInt(OBJECT_SELF, "CHECK_WINNER", FALSE);
}


/* DEAL ONE CARD!
Just picks one random card from the deck, if the card is designated with a
'N' at the end of its value, a different card is picked until one is available.*/
int Deal() { //Draws random card. Suit and color do not matter in BlackJack.
    int iCard = Random(52) + 1;
    //Iterate through deck till we get a card that is 'available'.
    while(GetStringRight(GetLocalString(OBJECT_SELF, IntToString(iCard)), 1) == "N") {
        iCard = Random(52) + 1;
    }
    //Set that card to NO, so we don't draw it again.
    SetLocalString(OBJECT_SELF, IntToString(iCard), GetStringLeft(GetLocalString(OBJECT_SELF, IntToString(iCard)), 3) + "N");
    return iCard;
}


/* GET FACE VALUE!
Get the face value of the card. Jack's, Queen's, King's = 10. Ace's = 1 or 11.
All the other cards are face value.*/
int FaceValue(int iCard) {
    if(iCard >= 41) {
        return 10;
    }
    else if(iCard >= 1 && iCard <= 4) {
        return 11;
    }
    else {
        return StringToInt(GetStringLeft(GetLocalString(OBJECT_SELF, IntToString(iCard)), 2));
    }
}


/* GET CARD NAME
Just get the proper name of the card. Jack's, Queen's, King's and Ace's.*/
string CardName(int iCard) {
    if(iCard >= 1 && iCard <= 4) {
        return "Ace";
    }
    else if(iCard >= 5 && iCard <= 40) {
        return GetStringLeft(GetLocalString(OBJECT_SELF, IntToString(iCard)), 2);
    }
    else if(iCard >= 41 && iCard <= 44) {
        return "Jack";
    }
    else if(iCard >= 45 && iCard <= 48) {
        return "Queen";
    }
    else if(iCard >= 49 && iCard <= 52) {
        return "King";
    }
    else {
        return "Empty";
    }
}


/* GET HAND SCORE
Get the score of the hand. Called with "PLAYER" or "DEALER" based on which
hand you want to check the score on. If score is greater than 22, it will
search for an Ace and change its value to a 1 from an 11.*/
int GetScore(string WHO) {
    int iScore;
    iScore = FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_1")) + FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_2")) + FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_3")) + FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_4")) + FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_5")) + FaceValue(GetLocalInt(OBJECT_SELF, WHO + "_CARD_6"));

    if(iScore >= 22) { //If score is greater than 21, check for an Ace and minus 10 from score.
        int iCount = 0;
        for(iCount = 1; iCount <= 6; iCount++) {
            int iCard = GetLocalInt(OBJECT_SELF, WHO + "_CARD_" + IntToString(iCount));
            if(iScore >= 22) {
                if(iCard >= 1 && iCard <= 4) {
                    iScore = iScore - 10;
                }
            }
        }
    }
    return iScore;
}


/* SHOW PLAYER AND DEALER HANDS AND SCORES
Show the scores of the player and dealer, as well as showing the hands to
the PC. Hides the first dealer card from the player.*/
void ShowHandAndScores(int DealerNotHidden) {
    SetLocalInt(OBJECT_SELF, "PlayerScore", GetScore("PLAYER"));
    SetLocalInt(OBJECT_SELF, "DealerScore", GetScore("DEALER"));
    SendMessageToPC(GetPCSpeaker(), "Player score: " + IntToString(GetLocalInt(OBJECT_SELF, "PlayerScore")) + " Bet: " + IntToString(GetLocalInt(OBJECT_SELF, "MINIMUM_BET")));
    if(DealerNotHidden == TRUE) { //Hide Dealers first card.
        SendMessageToPC(GetPCSpeaker(), "Dealer score: " + IntToString(GetLocalInt(OBJECT_SELF, "DealerScore")));
    }
    string PlayerHand = "Player hand: " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_1")) + ", " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_2"));
    string DealerHand;
    if(DealerNotHidden == TRUE) { //hide Dealers first card.
        DealerHand = "Dealer hand: " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_1")) + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_2"));
    }
    else {
        DealerHand = "Dealer hand: " + "HIDDEN" + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_2"));
    }
    //Iterate through the hands of the players and only show the nth number card in each hand if
    //one of the players has a card in that spot.
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") != 0 || GetLocalInt(OBJECT_SELF, "DEALER_CARD_3") != 0) {
        PlayerHand = PlayerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3"));
        DealerHand = DealerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_3"));
    }
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_4") != 0 || GetLocalInt(OBJECT_SELF, "DEALER_CARD_4") != 0) {
        PlayerHand = PlayerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_4"));
        DealerHand = DealerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_4"));
    }
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_5") != 0 || GetLocalInt(OBJECT_SELF, "DEALER_CARD_5") != 0) {
        PlayerHand = PlayerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_5"));
        DealerHand = DealerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_5"));
    }
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_6") != 0 || GetLocalInt(OBJECT_SELF, "DEALER_CARD_6") != 0) {
        PlayerHand = PlayerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_6"));
        DealerHand = DealerHand + ", " + CardName(GetLocalInt(OBJECT_SELF, "DEALER_CARD_6"));
    }
    //Spit it out!
    SendMessageToPC(GetPCSpeaker(), PlayerHand);
    SendMessageToPC(GetPCSpeaker(), DealerHand);
}


