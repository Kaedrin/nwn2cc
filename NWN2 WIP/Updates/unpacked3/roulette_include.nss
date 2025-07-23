//Roulette modified by Stephen Spann  (sspann@worldnet.att.net)
//originally from Charles Adam's 'Casino Bertix' module
//now includes the 00 slot, Five-Number bets, Corner Bets, and Split Bets.
//and uses SetListenPattern() cues instead of a conversation.

//  Bet amounts - set any bet amounts you don't want to '0'
//  NOTE:  this does not necessarily prevent bets of this amount from being made
//  Bets stack, so if someone really wanted to make a 10,000 gold bet,
//  they could just make a 1000 gold bet 10 times.
int nBet1 = 1;
int nBet5 = 1;
int nBet10 = 1;
int nBet50 = 1;
int nBet100 = 1;
int nBet500 = 1;
int nBet1000 = 1;
int nBet5000 = 1;
int nBet10000 = 1;

//  Spinning duration - set this to how long you would like the wheel to spin
float fSpin = 5.0;

//  Time Between Spins - set this to how many heartbeats you want to go by between spins
//  Default is every 2 minutes (10 heartbeats = 1 minute).
int nBetweenSpins = 20;