//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////                  ALL-IN-ONE SEAMLESS AREA TRANSITIONER  (for Neverwinter Nights)                 //////
//////  Date:  July 19, 2002  -  Version 1.1                                                            //////
//////  Created by:  Jaga Te'lesin      (jaga-nwn@earthlink.net)                                        //////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////                                        Copyright Notice                                          //////
//////  You may use this script for personal use however you like.  But if you redistribute you *must*  //////
//////  leave all code untouched and with all comments intact.                                          //////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////                                   For detailed instructions:                                     //////
//////  Please see the readme file that comes with the standard .zip distribution of this script.       //////
//////  It contains detailed installation and configuration instructions. A current version of this     //////
//////  script and the accompanying demo module can be found at:                                        //////
//////                      http://home.earthlink.net/~johncboat/AreaTrans.zip                          //////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

void   TransportEffect     ( object oTarget , float fDuration );
string GetNumberPadding    ( int nNumber );
int    GetIsValidTransArea ( string sAreaTag );

void main()
{ /// Begin User-Defined Variables ///
    float fMaxAreaDim = 320.0f;      // 10.0 per tile in one dimension.  (Areas under 3x3 not recommended)
                                    // Example: 16x16 areas would use 160.0f, 8x8 areas would use 80.0f, etc.
                                    //      *** NOTE:  Linked areas *should* be square only! ***
    float fLandingOffset = 8.0f;    // Distance out from edge in destination Area that PC will land (8 to 10 recommended)
    float fDiagTransSize = 8.0f;    // Distance out from any corner to sense diagonal movement (8 to 15 recommended)
    float fTransitionDelay = 2.5f;  // Delay before zoning, used to prevent cheating by PC's (2.0 to 4.0 recommended)
    int nDEBUG = FALSE;             // Turns on feedback while zoning.  Use for problem solving only, normal state is FALSE.
  /// End User-Defined Variables   ///

    object oPC = GetEnteringObject();
    if ((oPC != OBJECT_INVALID) && (GetLocalInt(oPC,"m_nZoning") != TRUE))
    {
        if (GetLocalInt(GetLocalObject(oPC, "SpawnedBy"),"DontZone") == 1)  return;
        vector vPCVector = GetPosition(oPC);                        // PC's current Vector
        float fPCFacing = GetFacingFromLocation(GetLocation(oPC));  // Direction PC is facing
        float fNorthDist = fMaxAreaDim - vPCVector.y + 80.0f;       // Distance from North edge
        float fSouthDist = vPCVector.y - 80.0f;                     // Distance from South edge
        float fEastDist = fMaxAreaDim - vPCVector.x + 80.0f;        // Distance from East edge
        float fWestDist = vPCVector.x - 80.0f;                      // Distance from West edge
        float fLeast = fMaxAreaDim;                                 // Initialize smallest found dist from any edge
        object oArea;                                               // Destination area
        location lLoc;                                              // Placeholder location for general use
        int nNumber;                                                // Placeholder number for general use
        int nSuccess = FALSE;                                       // Good zone located flag
        int nDir2;                                                  // Fallback direction for diagonal movement
        effect eZoneEffect3 = EffectVisualEffect(VFX_IMP_ACID_L);   // ZoneIn effect for end-of-transition
        int nDir;                                                   // Direction: N=1,S=2,E=3,W=4,NW=5,NE=6,SW=7,SE=8

		if (nDEBUG) 
			if (GetIsPC(oPC))  
				SendMessageToPC(oPC,"PC X = " + FloatToString(vPCVector.x) + " PC Y = " + FloatToString(vPCVector.y) );
		
        // Loop through distances to find direction PC is moving, and set nDir to that direction
        nDir = 1;      // PC at NORTH edge
        fLeast = fNorthDist;
        if (fSouthDist <= fLeast)
        {
            nDir = 2;  // PC at SOUTH edge
            fLeast = fSouthDist;
        }
        if (fEastDist <= fLeast)
        {
            nDir = 3;  // PC at EAST edge
            fLeast = fEastDist;
        }
        if (fWestDist <= fLeast)
        {
            nDir = 4;  // PC at WEST edge
            fLeast = fWestDist;
        }
        if ((fSouthDist > (fMaxAreaDim-fDiagTransSize)) && (fWestDist < fDiagTransSize))
            nDir = 5;  // PC in NORTHWEST trigger area
         else if ((fSouthDist > (fMaxAreaDim-fDiagTransSize)) && (fWestDist > (fMaxAreaDim-fDiagTransSize)))
                  nDir = 6;  // PC in NORTHEAST trigger area
              else if ((fSouthDist < fDiagTransSize) && (fWestDist < fDiagTransSize))
                       nDir = 7;  // PC in SOUTHWEST trigger area
                   else if ((fSouthDist < fDiagTransSize) && (fWestDist > (fMaxAreaDim-fDiagTransSize)))
                            nDir = 8;  // PC in SOUTHEAST trigger area

        string sDestAreaX, sDestAreaY;
        int nCurAreaX, nCurAreaY;
        string sCurAreaTag  = GetStringLowerCase(GetTag(GetArea(oPC)));         // X,Y,Z Tag of Current Area
        string sXYTag       = GetStringLeft(sCurAreaTag,6);                     // Separate out X/Y from Z coordinate
        string sCurAreaX    = GetStringLeft(sXYTag,3);                          // X-coordinate of current area (from Tag)
        string sCurAreaY    = GetStringRight(sXYTag,3);                         // Y-coordinate of current area (from Tag)
        string sCurAreaZ    = GetStringRight(sCurAreaTag,3);                    // Z-coordinate of current area (from Tag)

        if (GetStringLeft(sCurAreaX,1) == "p")
        {
            nCurAreaX = StringToInt(GetStringRight(sCurAreaX,2));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area X coordinate is " + GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX)) + ".");
        }
        else
            if (GetStringLeft(sCurAreaX,1) == "n")
            {
                nCurAreaX = (StringToInt(GetStringRight(sCurAreaX,2)) * (-1));
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area X coordinate is " + GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX)) + ".");
            }

        if (GetStringLeft(sCurAreaY,1) == "p")
        {
            nCurAreaY = StringToInt(GetStringRight(sCurAreaY,2));
            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area Y coordinate is " + GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY)) + ".");
        }
        else
            if (GetStringLeft(sCurAreaY,1) == "n")
            {
                nCurAreaY = (StringToInt(GetStringRight(sCurAreaY,2)) * (-1));
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Current Area Y coordinate is " + GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY)) + ".");
            }

        switch (nDir)           // Calculate new Area Tag based on the direction they are moving, and move them
        {
            case 1:             // Moving NORTH
            {
                --nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                oArea = GetObjectByTag(sCurAreaX + sDestAreaY + sCurAreaZ);
                lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fLandingOffset),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving North:" + "\nDestination Area X TAG is " + sCurAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea))
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving North...",oPC);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 2:  // Moving SOUTH
            {
                ++nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                oArea = GetObjectByTag(sCurAreaX + sDestAreaY + sCurAreaZ);
                lLoc = Location(oArea,Vector(vPCVector.x, 80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving South:" + "\nDestination Area X TAG is " + sCurAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea))
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving South...",oPC);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 3:  // Moving EAST
            {
                ++nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                oArea = GetObjectByTag(sDestAreaX + sCurAreaY + sCurAreaZ);
                lLoc = Location(oArea,Vector(80.0f + fLandingOffset,vPCVector.y),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving East:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sCurAreaY + ".");
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea))
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving East...",oPC);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 4:  // Moving WEST
            {
                --nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                oArea = GetObjectByTag(sDestAreaX + sCurAreaY + sCurAreaZ);
                lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,vPCVector.y),fPCFacing);
                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Moving West:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sCurAreaY + ".");
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea))
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving West...",oPC);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 5:  // Moving NORTHWEST
            {
                --nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                --nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))  // If target Area is validated..
                {
                    oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                    lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,80.0f + fLandingOffset),fPCFacing);
                    if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area validated, moving NorthWest:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving NorthWest...",oPC);
                }
                else
                {
                    if (fNorthDist <= fWestDist)
                        nDir2 = 1;      // Set fallback direction indicator to North
                    else nDir2 = 4;     // Set fallback direction indicator to West
                    if (nDir2 == 1)  // Try to move them North since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying North..");
                        ++nCurAreaX;
                        sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(vPCVector.x, 80.0f + fLandingOffset),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving North...",oPC);
                        }
                        if (nSuccess == FALSE)   // Try to move them West since North Failed..
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North Area NOT validated, trying West...");
                            --nCurAreaX;
                            ++nCurAreaY;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,vPCVector.y),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving West...",oPC);
                            }
                        }
                    }
                    if (nDir2 == 4)  // Try to move them West since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying West.");
                        ++nCurAreaY;
                        sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,vPCVector.y),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving West...",oPC);
                        }
                        if (nSuccess == FALSE)
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West Area NOT validated, trying North.");
                            --nCurAreaY;
                            ++nCurAreaX;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fLandingOffset),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving North...",oPC);
                            }
                        }
                    }
                }
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea)) // Re-verify target area validity
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 6:  // Moving NORTHEAST
            {
                ++nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                --nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))  // If target Area is validated..
                {
                    oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                    lLoc = Location(oArea,Vector(80.0f + fLandingOffset, 80.0f + fLandingOffset),fPCFacing);
                    if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area validated, Moving NorthEast:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving NorthEast...",oPC);
                }
                else
                {
                    if (fNorthDist <= fEastDist)
                        nDir2 = 1;      // Set fallback direction indicator to North
                    else nDir2 = 3;     // Set fallback direction indicator to East
                    if (nDir2 == 1)  // Try to move them North since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying North...");
                        --nCurAreaX;
                        sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fLandingOffset),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving North...",oPC);
                        }
                        if (nSuccess == FALSE)   // Try to move them East since North Failed..
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North Area NOT validated, trying East...");
                            ++nCurAreaX;
                            ++nCurAreaY;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(80.0f + fLandingOffset,vPCVector.y),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving East...",oPC);
                            }
                        }
                    }
                    if (nDir2 == 3)  // Try to move them East since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying East.");
                        ++nCurAreaY;
                        sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(80.0f + fLandingOffset,vPCVector.y),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving East...",oPC);
                        }
                        if (nSuccess == FALSE)
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East Area NOT validated, trying North.");
                            --nCurAreaX;
                            --nCurAreaY;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fLandingOffset),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"North is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving North...",oPC);
                            }
                        }
                    }
                }
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea)) // Re-verify target area validity
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 7:  // Moving SOUTHWEST
            {
                --nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                ++nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))  // If target Area is validated..
                {
                    oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                    lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                    if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area validated, Moving SouthWest:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving SouthWest...",oPC);
                }
                else
                {
                    if (fSouthDist <= fWestDist)
                        nDir2 = 2;      // Set fallback direction indicator to South
                    else nDir2 = 4;     // Set fallback direction indicator to West
                    if (nDir2 == 2)  // Try to move them South since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying South...");
                        ++nCurAreaX;
                        sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving South...",oPC);
                        }
                        if (nSuccess == FALSE)   // Try to move them West since South failed..
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South Area NOT validated, trying West...");
                            --nCurAreaX;
                            --nCurAreaY;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,vPCVector.y),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving West...",oPC);
                            }
                        }
                    }
                    if (nDir2 == 4)  // Try to move them West since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying West...");
                        --nCurAreaY;
                        sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(80.0f + fMaxAreaDim - fLandingOffset,vPCVector.y),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving West...",oPC);
                        }
                        if (nSuccess == FALSE)   // Try to move them South since West failed..
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"West Area NOT validated, trying South...");
                            ++nCurAreaY;
                            ++nCurAreaX;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving South...",oPC);
                            }
                        }
                    }
                }
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea)) // Re-verify target area validity
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
            case 8:  // Moving SOUTHEAST
            {
                ++nCurAreaX;
                sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                ++nCurAreaY;
                sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))  // If target Area is validated..
                {
                    oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                    lLoc = Location(oArea,Vector(80.0f + fLandingOffset,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                    if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area validated, Moving SouthEast:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                    if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving SouthEast...",oPC);
                }
                else
                {
                    if (fSouthDist <= fEastDist)
                        nDir2 = 2;      // Set fallback direction indicator to South
                    else nDir2 = 3;     // Set fallback direction indicator to East
                    if (nDir2 == 2)  // Try to move them South since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying South...");
                        --nCurAreaX;
                        sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving South...",oPC);
                        }
                        if (nSuccess == FALSE)   // Try to move them East since South Failed..
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South Area NOT validated, trying East...");
                            ++nCurAreaX;
                            --nCurAreaY;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(80.0f + fLandingOffset,vPCVector.y),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving East...",oPC);
                            }
                        }
                    }
                    if (nDir2 == 3)  // Try to move them East since it was closer edge..
                    {
                        if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"Destination Area NOT validated, trying East...");
                        --nCurAreaY;
                        sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                        if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                        {
                            oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                            lLoc = Location(oArea,Vector(80.0f + fLandingOffset,vPCVector.y),fPCFacing);
                            nSuccess = TRUE;
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                            if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving East...",oPC);
                        }
                        if (nSuccess == FALSE)
                        {
                            if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"East Area NOT validated, trying South...");
                            ++nCurAreaY;
                            --nCurAreaX;
                            sDestAreaX = GetNumberPadding(nCurAreaX) + IntToString(abs(nCurAreaX));
                            sDestAreaY = GetNumberPadding(nCurAreaY) + IntToString(abs(nCurAreaY));
                            if (GetIsValidTransArea(sDestAreaX + sDestAreaY + sCurAreaZ))
                            {
                                oArea = GetObjectByTag(sDestAreaX + sDestAreaY + sCurAreaZ);
                                lLoc = Location(oArea,Vector(vPCVector.x,80.0f + fMaxAreaDim - fLandingOffset),fPCFacing);
                                if (nDEBUG) if (GetIsPC(oPC))  SendMessageToPC(oPC,"South is valid and will be used:" + "\nDestination Area X TAG is " + sDestAreaX + "." + "\nDestination Area Y TAG is " + sDestAreaY + ".");
                                if (GetIsPC(oPC))  FloatingTextStringOnCreature("Moving South...",oPC);
                            }
                        }
                    }
                }
                if ((oArea != OBJECT_INVALID) && (GetAreaFromLocation(lLoc) == oArea)) // Re-verify target area validity
                {
                    SetLocalInt(oPC,"m_nZoning",TRUE);
                    TransportEffect(oPC,fTransitionDelay);
                    DelayCommand(fTransitionDelay,AssignCommand(oPC,JumpToLocation(lLoc)));
                    DelayCommand(fTransitionDelay,SetLocalInt(oPC,"m_nZoning",FALSE));
                    DelayCommand(fTransitionDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eZoneEffect3,lLoc));
                }
                break;
            }
        }
        if ((oArea == OBJECT_INVALID) && (nDEBUG))
            if (GetIsPC(oPC))  SendMessageToPC(oPC,"Movement to an invalid area attempted.  Area was not found with specified TAG.");
    }
    else
        SendMessageToAllDMs("Object was either invalid, already zoning, or had it's Don't Zone flag set.");
}

void TransportEffect (object oTarget, float fDuration)
{
    effect eZoneEffect1 = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eZoneEffect2 = EffectVisualEffect(VFX_IMP_ACID_L);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eZoneEffect1,oTarget,(fDuration*2.0f));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eZoneEffect2,oTarget);
}

string GetNumberPadding ( int nNumber )
{
    if ((nNumber < 10) && (nNumber > -1))  return "p0";
     else if ((nNumber > 9) && (nNumber < 100))  return "p";
      else if ((nNumber > -10) && (nNumber < 0))  return "n0";
       else if ((nNumber > -100) && (nNumber < -9))  return "n";
        else  return "";
}

int GetIsValidTransArea (string sAreaTag )
{
    object oArea = GetObjectByTag(sAreaTag);
    if (oArea != OBJECT_INVALID)  return TRUE;
     else  return FALSE;
}