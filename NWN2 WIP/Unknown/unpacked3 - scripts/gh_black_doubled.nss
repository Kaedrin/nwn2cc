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

    //Player doubled down.. proceed to check winner.
    SetLocalInt(OBJECT_SELF, "CHECK_WINNER", TRUE);
    //Takes Players extra bet.
    TakeGoldFromCreature(GetLocalInt(OBJECT_SELF, "MINIMUM_BET"), GetPCSpeaker(), FALSE);
    //Double bet on Double down, this should be reset correctly after each bet.
    SetLocalInt(OBJECT_SELF, "MINIMUM_BET", (GetLocalInt(OBJECT_SELF, "MINIMUM_BET") * 2));
}
