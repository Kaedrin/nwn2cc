void DoSlots(int nBet);
//void main(){}
void DoSlots(int nBet)
  {
  object oPC = GetPCSpeaker();
    // Slots function begins here
    /* Notes: Each wheel has 64 spots on it. The config and payout are based on machines in Las Vegas, NV.
      Wheel config:
      Item   | W1 Range | W2 Range | W3 Range |
        -------+----------+----------+----------
        Cherry |   1-3    |   1-2    |   1-1    |
        Blank  |   4-5    |   3-5    |   2-4    |
        Plum   |   6-8    |   6-7    |   5-6    |
        Blank  |   9-10   |   8-10   |   7-9    |
        Wmelon |   11-13  |   11-13  |   10-11  |
        Blank  |   14-15  |   14-16  |   12-14  |
        Orange |   16-19  |   17-19  |   15-17  |
        Blank  |   20-21  |   20-22  |   18-20  |
        Lemon  |   22-25  |   23-25  |   21-23  |
        Blank  |   26-30  |   26-30  |   24-31  |
        Bar    |   31-34  |   31-33  |   32-32  |
        Blank  |   35-39  |   34-38  |   33-39  |
        Cherry |   40-41  |   39-40  |   40-40  |
        Blank  |   43-43  |   41-43  |   41-43  |
        Plum   |   45-46  |   44-45  |   44-44  |
        Blank  |   47-48  |   46-48  |   45-47  |
        Wmelon |   49-51  |   49-50  |   48-49  |
        Blank  |   52-53  |   51-53  |   50-52  |
        Orange |   54-56  |   54-55  |   53-55  |
        Blank  |   57-58  |   56-58  |   56-58  |
        Lemon  |   59-62  |   59-61  |   59-61  |
        Blank  |   63-64  |   62-64  |   62-64  |
        -------+----------+----------+----------

        Note that each virtual reel has a total of 64 stops so the total number of possible combinations is 643 = 262,144.

        Payout table:
        Item                     | Payout   |Odds|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Bars             |  5000  | 4*3*1/262,144 =0.000046|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Cherries       |  1000    | 5*4*2/262,144 =0.000153|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Plums              |   200    |6*4*3/262,144 = 0.000275|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Watermelons    |   100    | 6*5*4/262,144 = 0.000458|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Oranges            |    50    |7*5*6/262,144 = 0.000801|
      ---------------+--------+--------------------------------------------------------------+--------+----
        3 Lemons             |    25    |8*6*6/262,144 = 0.001099|
      ---------------+--------+--------------------------------------------------------------+--------+----
        2 Cherries       |    10    | (5*4*62 + 5*60*2 +59*4*2)/262,144 = 0.008820      |
      ---------------+--------+--------------------------------------------------------------+--------+----
        1 Cherry             |       1  |(5*60*62 + 59*4*62 + 59*60*2)/262,144 = 0.153778   |
      ---------------+--------+--------------------------------------------------------------+--------+----

  The average return of the machine is the dot product of the above probabilities and their respective payoffs:

    0.000046*5000 + 0.000153*1000 + 0.000275*200 + 0.000458*100 + 0.000801*50 + 0.001099*25 + 0.008820*10 + 0.153778*2 = 0.94545 .

  Thus for every unit played the machine will return back 94.545%

    */
    int nWheel1, nWheel2, nWheel3;
    int nWheelType1 = 0;
    int nWheelType2 = 0;
    int nWheelType3 = 0;
    int nNumCherries = 0;
    int nPayout;
    string sWheel1, sWheel2, sWheel3;

    nWheel1 = Random(64);
    nWheel2 = Random(64);
    nWheel3 = Random(64);

/* Uncomment if you want to test a particular combination. nWheel1 = 32; nWheel2 = 32; nWheel3 = 32; */

    SendMessageToPC(oPC, "The bet is "+IntToString(nBet)+".");
    if (nBet > 0)
      {
      /* Figure out what each wheel shows */
      switch (nWheel1)
        {
        case 1:
        case 2:
        case 3: sWheel1 = "Cherry";nWheelType1 = 1; nNumCherries++; break;
        case 6:
        case 7:
        case 8: sWheel1 = "Plum";nWheelType1 = 2; break;
        case 11:
        case 12:
        case 13: sWheel1 = "Watermelon";nWheelType1 = 3; break;
        case 16:
        case 17:
        case 18:
        case 19: sWheel1 = "Orange";nWheelType1 = 4; break;
        case 22:
        case 23:
        case 24:
        case 25: sWheel1 = "Lemon";nWheelType1 = 5; break;
        case 31:
        case 32:
        case 33:
        case 34: sWheel1 = "Bar";nWheelType1 = 100; break;
        case 40:
        case 41: sWheel1 = "Cherry";nWheelType1 = 1; nNumCherries++; break;
        case 45:
        case 46: sWheel1 = "Plum";nWheelType1 = 2; break;
        case 49:
        case 50:
        case 51: sWheel1 = "Watermelon";nWheelType1 = 3; break;
        case 54:
        case 55:
        case 56: sWheel1 = "Orange";nWheelType1 = 4; break;
        case 59:
        case 60:
        case 61:
        case 62: sWheel1 = "Lemon";nWheelType1 = 5; break;
        default: sWheel1 = "Blank";nWheelType1 = 0; break;
        }

      switch (nWheel2)
        {
        case 1:
        case 2: sWheel2 = "Cherry";nWheelType2 = 1; nNumCherries++; break;
        case 6:
        case 7: sWheel2 = "Plum";nWheelType2 = 2; break;
        case 11:
        case 12:
        case 13: sWheel2 = "Watermelon";nWheelType2 = 3; break;
        case 17:
        case 18:
        case 19: sWheel2 = "Orange";nWheelType2 = 4; break;
        case 23:
        case 24:
        case 25: sWheel2 = "Lemon";nWheelType2 = 5; break;
        case 31:
        case 32:
        case 33: sWheel2 = "Bar";nWheelType2 = 100; break;
        case 39:
        case 40: sWheel2 = "Cherry";nWheelType2 = 1; nNumCherries++; break;
        case 44:
        case 45: sWheel2 = "Plum";nWheelType2 = 2; break;
        case 49:
        case 50: sWheel2 = "Watermelon";nWheelType2 = 3; break;
        case 54:
        case 55: sWheel2 = "Orange";nWheelType2 = 4; break;
        case 59:
        case 60:
        case 61: sWheel2 = "Lemon";nWheelType2 = 5; break;
        default: sWheel2 = "Blank";nWheelType2 = 1; break;
        }

      switch (nWheel3)
        {
        case 1: sWheel3 = "Cherry";nWheelType3 = 1; nNumCherries++; break;
        case 5:
        case 6: sWheel3 = "Plum";nWheelType3 = 2; break;
        case 10:
        case 11: sWheel3 = "Watermelon";nWheelType3 = 3; break;
        case 15:
        case 16:
        case 17: sWheel3 = "Orange";nWheelType3 = 4; break;
        case 21:
        case 22:
        case 23: sWheel3 = "Lemon";nWheelType3 = 5; break;
        case 32: sWheel3 = "Bar";nWheelType3 = 100; break;
        case 40: sWheel3 = "Cherry";nWheelType3 = 1; nNumCherries++; break;
        case 44: sWheel3 = "Plum";nWheelType3 = 2; break;
        case 48:
        case 49: sWheel3 = "Watermelon";nWheelType3 = 3; break;
        case 53:
        case 54:
        case 55: sWheel3 = "Orange";nWheelType3 = 4; break;
        case 59:
        case 60:
        case 61: sWheel3 = "Lemon";nWheelType3 = 5; break;
        default: sWheel3 = "Blank";nWheelType3 = 0; break;
        }

      /* Display the items on the wheels */
      SendMessageToPC (oPC, sWheel1+" - "+sWheel2+" - "+sWheel3);

      /* Determine if they have won. */
      nPayout = 0;
      if ((nWheelType1 == 100) && (nWheelType2 == 100) && (nWheelType3 == 100))
        {
        /* 3 Bars. */
        nPayout = nBet * 5000;
        }
      if ((nWheelType1 == 1) && (nWheelType2 == 1) && (nWheelType3 == 1))
        {
        /* 3 Cherries. */
        nPayout = nBet * 1000;
        }
      if ((nWheelType1 == 2) && (nWheelType2 == 2) && (nWheelType3 == 2))
        {
        /* 3 Plums. */
        nPayout = nBet * 200;
        }
      if ((nWheelType1 == 3) && (nWheelType2 == 3) && (nWheelType3 == 3))
        {
        /* 3 Watermelons. */
        nPayout = nBet * 100;
        }
      if ((nWheelType1 == 4) && (nWheelType2 == 4) && (nWheelType3 == 4))
        {
        /* 3 Oranges. */
        nPayout = nBet * 50;
        }
      if ((nWheelType1 == 5) && (nWheelType2 == 5) && (nWheelType3 == 5))
        {
        /* 3 Lemons. */
        nPayout = nBet * 25;
        }
      if (nNumCherries == 2)
        {
        /* 2 Cherries. */
        nPayout = nBet * 10;
        }
      if (nNumCherries == 1)
        {
        /* 1 Cherry. */
        nPayout = nBet;
        }

      if (nPayout == 0)
        {
        SendMessageToPC (oPC, "You did not win.\n");
        }
      else
        {
        SendMessageToPC (oPC, "You have won "+IntToString(nPayout)+" .");
        GiveGoldToCreature (oPC, nPayout);
        }
      }
  }

