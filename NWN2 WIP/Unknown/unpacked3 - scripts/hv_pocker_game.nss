// NPCs Tags
const string PLAYER1 = "algjoe";
const string PLAYER2 = "algjoe2";
const string PLAYER3 = "algjoe3";
const string PLAYER4 = "algjoe4";

// Lines
const string LINE1 = "*Reveals his cards.* Straight flush, gentlemen. Pay up!";
const string LINE2 = "What?! I ain't buying this. Two in a row? You cheated.";
const string LINE3 = "*Throws the card angrily on the table.* I ain't givin' you nothin'.";
const string LINE4 = "Don't be such crybabies. Pay up and play.";

// On Perception for one of the players.
void main()
{
	object oSeen = GetLastPerceived();
	int nRand = Random(20) + 1;
	if ((GetIsPC(oSeen)) && (nRand == 13))  {
		// Check if conversation wasn't initiated in the last 5 minutes
		int nConverse = GetLocalInt(OBJECT_SELF, "hv_poker");
		if (nConverse == 0) {

			// Get poker players NPC objects
			object oPlayer1 = GetObjectByTag(PLAYER1);
			object oPlayer2 = GetObjectByTag(PLAYER2);
			object oPlayer3 = GetObjectByTag(PLAYER3);
			object oPlayer4 = GetObjectByTag(PLAYER4);
	
			// Speak lines in order
			AssignCommand(oPlayer1, DelayCommand(2.0, SpeakString(LINE1)));
			AssignCommand(oPlayer2, DelayCommand(7.0, SpeakString(LINE2)));
			AssignCommand(oPlayer3, DelayCommand(12.0, SpeakString(LINE3)));
			AssignCommand(oPlayer4, DelayCommand(17.0, SpeakString(LINE4)));
		
			SetLocalInt(OBJECT_SELF, "hv_poker", 1);
			// Reset var after 5 minutes.
			DelayCommand(300.0, SetLocalInt(OBJECT_SELF, "hv_poker", 0));
		}
	}
}