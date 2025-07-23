#include "gh_black_include"

void main() {
    //Player chose to deal another card. Max of 6 cards possible.
    //Go through hand, and add another card to the appropriate
    //slot.
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") == 0) {
        SetLocalInt(OBJECT_SELF, "PLAYER_CARD_3", Deal());
    }
    else if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_4") == 0) {
        SetLocalInt(OBJECT_SELF, "PLAYER_CARD_4", Deal());
    }
    else if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_5") == 0) {
        SetLocalInt(OBJECT_SELF, "PLAYER_CARD_5", Deal());
    }
    else if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_6") == 0) {
        SetLocalInt(OBJECT_SELF, "PLAYER_CARD_6", Deal());
    }

    SetLocalInt(OBJECT_SELF, "PlayerScore", GetScore("PLAYER"));
    SetLocalInt(OBJECT_SELF, "DealerScore", GetScore("DEALER"));

    //Dealer hits if 16 or less, automatically.
    //Go through hand, and add another card to the appropriate
    //slot.
    if(GetLocalInt(OBJECT_SELF, "DealerScore") <= 16) {
        if(GetLocalInt(OBJECT_SELF, "DEALER_CARD_3") == 0) {
            SetLocalInt(OBJECT_SELF, "DEALER_CARD_3", Deal());
        }
        else if(GetLocalInt(OBJECT_SELF, "DEALER_CARD_4") == 0) {
            SetLocalInt(OBJECT_SELF, "DEALER_CARD_4", Deal());
        }
        else if(GetLocalInt(OBJECT_SELF, "DEALER_CARD_5") == 0) {
            SetLocalInt(OBJECT_SELF, "DEALER_CARD_5", Deal());
        }
        else if(GetLocalInt(OBJECT_SELF, "DEALER_CARD_6") == 0) {
            SetLocalInt(OBJECT_SELF, "DEALER_CARD_6", Deal());
        }
        SetLocalInt(OBJECT_SELF, "DealerScore", GetScore("DEALER"));
    }

    //If Player or Dealer busts... check for winner.
    if(GetLocalInt(OBJECT_SELF, "PlayerScore") >= 22 || GetLocalInt(OBJECT_SELF, "DealerScore") >= 22) {
        SetLocalInt(OBJECT_SELF, "CHECK_WINNER", TRUE);
    }
    //Or if Dealer has 17 or more, and Player has more than the Dealer... check for winner.
    else if(GetLocalInt(OBJECT_SELF, "DealerScore") >= 17 && GetLocalInt(OBJECT_SELF, "PlayerScore") > GetLocalInt(OBJECT_SELF, "DealerScore")) {
        SetLocalInt(OBJECT_SELF, "CHECK_WINNER", TRUE);
    }
    else if(GetLocalInt(OBJECT_SELF, "PlayerScore") == 21) {
        SetLocalInt(OBJECT_SELF, "CHECK_WINNER", TRUE);
    }
    else {
        //Show scores.
        ShowHandAndScores(TRUE);
    }
}
