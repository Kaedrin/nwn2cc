#include "gh_black_include"

void main() {
    SetLocalInt(OBJECT_SELF, "PlayerScore", GetScore("PLAYER"));
    SetLocalInt(OBJECT_SELF, "DealerScore", GetScore("DEALER"));

    //When this reaches 2, the deck itself will be reset(shuffled) when it is Initialized().
    SetLocalInt(OBJECT_SELF, "RESHUFFLE", GetLocalInt(OBJECT_SELF, "RESHUFFLE") + 1);

    //Check for BLACKJACKs. Both Players with BLACKJACK is a draw. Otherwise
    //the lone Player with a BLACKJACK automatically wins.
    if(GetLocalInt(OBJECT_SELF, "DealerScore") == 21 && GetLocalInt(OBJECT_SELF, "DEALER_CARD_3") == 0) {
        if(GetLocalInt(OBJECT_SELF, "PlayerScore") == 21 && GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") == 0) {
            SpeakString("DRAW: Double Blackjack! Tough game, shall we play again?");
            GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET")); //Give his bet back.
        }
        else if(GetLocalInt(OBJECT_SELF, "PlayerScore") != 21 || GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") != 0) {
            SpeakString("LOSS: Dealer Blackjack! Mr. Griswald needs some practice. Shall we play again?");
        }
    }
    else if(GetLocalInt(OBJECT_SELF, "PlayerScore") == 21 && GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") == 0) {
        SpeakString("WIN: Player Blackjack! Impressive game, shall we play again?");
        GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET") + (GetLocalInt(OBJECT_SELF, "MINIMUM_BET") / 2));
    }
    else {
        //Noone had Blackjack, so check if Dealer can draw, and then find winners.
        //Dealer hits if 16 or less, automatically.
        //Go through hand, and add another card to the appropriate
        //slot.
        while(GetLocalInt(OBJECT_SELF, "DealerScore") <= 16) {
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
        //Noone had a Blackjack, so go through and find out who won.
        if(GetLocalInt(OBJECT_SELF, "DealerScore") >= 22 && GetLocalInt(OBJECT_SELF, "PlayerScore") <= 21) { //Dealer over
            SpeakString("House busts! Your a real card shark! Here's your winnings, paying 3 for 2.");
            GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET") + (GetLocalInt(OBJECT_SELF, "MINIMUM_BET") / 2));
        }
        else if(GetLocalInt(OBJECT_SELF, "PlayerScore") >= 22 && GetLocalInt(OBJECT_SELF, "DealerScore") <= 21) { //Player over
            SpeakString("Player busted! So sorry Mr. Griswald. House wins. Try again!");
        }
        else if(GetLocalInt(OBJECT_SELF, "PlayerScore") >= 22 && GetLocalInt(OBJECT_SELF, "DealerScore") >= 22) { //Both over
            SpeakString("Draw! Tough game, shall we play again?");
            GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET")); //Give his bet back.
        }
        else if(GetLocalInt(OBJECT_SELF, "PlayerScore") > GetLocalInt(OBJECT_SELF, "DealerScore")) { //Player beats Dealer
            SpeakString("Nice playing! You beat the house! Here's your winnings, paying 3 for 2.");
            GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET") + (GetLocalInt(OBJECT_SELF, "MINIMUM_BET") / 2));
        }
        else if(GetLocalInt(OBJECT_SELF, "DealerScore") > GetLocalInt(OBJECT_SELF, "PlayerScore")) { //Both over
            SpeakString("Aww, the house wins Mr. Griswald. Try again, that was a close one!");
        }
        else if(GetLocalInt(OBJECT_SELF, "DealerScore") == GetLocalInt(OBJECT_SELF, "PlayerScore")) { //Equal, tie.
            SpeakString("Draw! A tough match, shall we try again?");
            GiveGoldToCreature(GetPCSpeaker(), GetLocalInt(OBJECT_SELF, "MINIMUM_BET")); //Give his bet back.
        }
        else {
            SpeakString("Gee.. Someone SHOULD have won or tied or SOMETHING! I'm not a very good dealer.");
        }
    }
    //Show Final score.
    ShowHandAndScores(TRUE);

    //Reset minimum bet.
    SetLocalInt(OBJECT_SELF, "MINIMUM_BET", 10);

    //After a game is over, check to make sure player has enough money to continue.
    if(GetGold(GetPCSpeaker()) < GetLocalInt(OBJECT_SELF, "MINIMUM_BET")) {
        SpeakString("Sorry, you've run out of money to bet!");
        DelayCommand(1.0, AssignCommand(GetPCSpeaker(), SpeakString("What can I do with " + IntToString(GetGold(GetPCSpeaker())) + " gold.")));
        DelayCommand(3.0, SpeakString("I don't know. Buy a bullet and RENT a gun!!!"));
    }
}
