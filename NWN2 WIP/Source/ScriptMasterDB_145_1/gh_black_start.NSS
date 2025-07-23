#include "gh_black_include"

void main() {
    //Minimum bet, change this for a more expensive table =)
    SetLocalInt(OBJECT_SELF, "MINIMUM_BET", 10);

    //Take Players bet.
    TakeGoldFromCreature(GetLocalInt(OBJECT_SELF, "MINIMUM_BET"), GetPCSpeaker(), FALSE);

    //Initialize deck
    InitializeDeck();

    //Deal out cards one to Player then to Dealer, etc.
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_1", Deal());
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_1", Deal());
    SetLocalInt(OBJECT_SELF, "PLAYER_CARD_2", Deal());
    SetLocalInt(OBJECT_SELF, "DEALER_CARD_2", Deal());

    //Get the scores of the Player and Dealer hands.
    SetLocalInt(OBJECT_SELF, "PlayerScore", GetScore("PLAYER"));
    SetLocalInt(OBJECT_SELF, "DealerScore", GetScore("DEALER"));

    //If one of the Players has a score of 21 already, they have a BLACKJACK.
    //Announce it and proceed to check for a winner, no need to get player decision
    //as a natural 21 beats a regular 21.
    if(GetLocalInt(OBJECT_SELF, "PlayerScore") == 21 || GetLocalInt(OBJECT_SELF, "DealerScore") == 21) {
        SetLocalInt(OBJECT_SELF, "CHECK_WINNER", TRUE);
    }
    else {
        //Show the scores, but hide the Dealers first card.
        ShowHandAndScores(FALSE);
    }
}
