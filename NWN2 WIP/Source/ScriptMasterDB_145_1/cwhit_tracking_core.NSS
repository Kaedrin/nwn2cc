//::///////////////////////////////////////////////
//:: cwhit_tracking
//:: Purpose: Provide a real Tracking mechanism
//:: Created By: Chris Whitaker for Dalelands Beyond PW
//:: Created On: March 8, 2011
//:://////////////////////////////////////////////
// The script reduces all areas to 10 x 10 x 10 cubes and in each of
// those cubes it will store up to 10 TrackingMsgs and TrackingDCs.
// Note: Testing has indicated that the NWN scripting engine does a
// poor job of storing a large number of local variables.  For example
// if an area was 100x100x10 units it would have 10x10x1 tiles in it.
// If I created 100 parallel arrays to store TrackingMsgs and named them
// "Tile 0,0,0", "Tile 1,0,0", "Tile 2,0,0"... "Tile 9,9,0" well that
// would seem to work fine... BUT when I wish to lookup the array called
// "Tile <x>,<y>,<z>" NWN Scripting does a linear search of every array
// until it finds the right one.  It does not resolve via a hashmap or
// any other efficient manner.  [authors note: shame on OEI, you should
// be ashamed].  To work around this I must in each area have one enormous
// array where the index is (z*SizeX*SizeY + y*SizeX + x) * 10 + msgIndex
// in this way it simulates a hashtable where the key is fn(x,y,z,msgIndex)
// and so the data can be retreived without a linear search.


#include "nw_o0_itemmaker"


const float TRACKING_UPDATE_TIME		= 6.0;

// Using a smaller tile size will reduce the memory footprint and 
// the frequency a PC actually enters a new tile... but it will also 
// cause issues with allowing [non-swift] trackers to move at a run
// and other issues with resolution of tracks... 
// ie it a bad idea! Stick with 10!!
const int TILE_SIZE = 10;

// this is the number of trails each tile stores... 
const int LIST_SIZE = 10;

// preconditions:
// the oPC leaves tracks ie (GetHasFeat(FEAT_TRACKLESS_STEP, oPC) == FALSE || GetIsAreaNatural(oArea) == FALSE) is true
// object oLastArea, int nLastTile, int nLastIndex represents the last track they left
// object oNewArea, string sNewTile, int nNewIndex represents where to store the next track
void makeTrackToNewArea(object oPC, int bUsedDoor,
                        object oLastArea, int nLastTile, int nLastIndex, 
                        object oNewArea, int nNewTile, int nNewIndex) {
						
//	SendMessageToPC(oPC, "start exec of makeTrackToNewArea");
//	SendMessageToPC(oPC, "makeTrackToNewArea : nLastTile=" +IntToString(nLastTile));
//	SendMessageToPC(oPC, "makeTrackToNewArea : nLastIndex=" +IntToString(nLastIndex));
    if (nLastIndex != -1 && GetIsObjectValid(oLastArea)) {
	    // we have a valid prior trail... update it
		int nLastTileAndIndex = nLastTile * 10 + nLastIndex;
//	SendMessageToPC(oPC, "makeTrackToNewArea : nLastTileAndIndex=" +IntToString(nLastTileAndIndex));
	string sLastMsg = GetLocalArrayString(oLastArea, "TrackingMsg", nLastTileAndIndex);
//	SendMessageToPC(oPC, "makeTrackToNewArea : sLastMsg=" +sLastMsg);
		if (sLastMsg != "") { // this is a sanity check really... consider removing... 
		    // since if nLastIndex != -1 -> sLastMsg != ""
			if (bUsedDoor) 	sLastMsg += " and head through the door.";
			else {
				// this is an actual transit to a new area
				sLastMsg += " and head towards " + GetName(oNewArea) +".";
				// update the swifttracking exit data for the last area
				int nEntryExitIndex = GetLocalInt(oPC, "AreaEntryExitIdx");
				SetLocalArrayString(oLastArea, "ExitToArea", nEntryExitIndex, 
				                    " to " + GetName(oNewArea) +".");
				// pick the next entryExit index for this area
				nEntryExitIndex = GetLocalInt(oNewArea, "AreaEntryExitIdx") + 1;
				SetLocalInt(oNewArea, "AreaEntryExitIdx", nEntryExitIndex);
				SetLocalInt(oPC, "AreaEntryExitIdx", nEntryExitIndex);
				// update the swifttracking entry data for the new area
				SetLocalArrayString(oNewArea, "EntryFromArea", nEntryExitIndex,  
				                    "  From " + GetName(oLastArea));
			}
	SetLocalArrayString(oLastArea, "TrackingMsg", nLastTileAndIndex, sLastMsg);
		} // else there was no track there so nothing to update
	}
	
	// now record a new trail with the direction we came from
	int nTrackingDC = GetLocalInt(oNewArea, "TrackDC");
	if (nTrackingDC == 0) {
		nTrackingDC = 10;
		if (GetIsAreaNatural(oNewArea) == FALSE) nTrackingDC += 5;
		if (GetIsAreaInterior(oNewArea) == FALSE) nTrackingDC += 5;
	}
	
	string sNextMsg = ")"; // leading bracket for the index number
	int nPCWeight = GetWeight(oPC);
	nTrackingDC += 10 - nPCWeight/100;
	if (nPCWeight < 500) sNextMsg += "Very Shallow ";
	else if (nPCWeight < 1000) sNextMsg += "Shallow ";
	else if (nPCWeight < 1500) {}// no special depth
	else if (nPCWeight < 2000) sNextMsg += "Deep ";
	else sNextMsg += "Very Deep ";
	
	switch (GetRacialType(oPC)) {
		case RACIAL_TYPE_DWARF : sNextMsg += "Dwarf tracks enter "; break;
		case RACIAL_TYPE_ELF : sNextMsg += "Elf tracks enter "; break;
		case RACIAL_TYPE_GNOME : sNextMsg += "Gnome tracks enter "; break;
		case RACIAL_TYPE_HALFLING : sNextMsg += "Halfling tracks enter "; break;
		case RACIAL_TYPE_HALFORC : sNextMsg += "Orcish tracks enter "; break;
		case RACIAL_TYPE_GRAYORC : sNextMsg += "Orcish tracks enter "; break;
		default : sNextMsg += "Humanoid tracks enter "; break;
	}
	
	// now determine where we came from
	if (bUsedDoor) sNextMsg += "through the door";
	else if (nLastIndex != -1 && GetIsObjectValid(oLastArea)) sNextMsg += "from " + GetName(oLastArea);
	else sNextMsg += "apparently from nowhere";
	int nNewTileAndIndex = nNewTile * 10 + nNewIndex;
	SetLocalArrayInt(oNewArea, "TrackingDC", nNewTileAndIndex, nTrackingDC);
	// todo: consider merging Race and Direction into one field... trail
	SetLocalArrayString(oNewArea, "TrackingMsg", nNewTileAndIndex, sNextMsg);
	SetLocalArrayInt(oNewArea, "TrackingEntryExitIdx", nNewTileAndIndex, GetLocalInt(oPC, "AreaEntryExitIdx"));
	SetLocalArrayInt(oNewArea, "TileIndex", nNewTile, nNewIndex);
}
	 
// preconditions:
// the oPC leaves tracks ie (GetHasFeat(FEAT_TRACKLESS_STEP, oPC) == FALSE || GetIsAreaNatural(oArea) == FALSE) is true
void makeTracksWithinArea(object oPC, object oArea,
						  int fromX, int fromY, int fromZ, int nLastIndex, 
						  int toX, int toY, int toZ, int nSpeedSQD) {
						  
//	SendMessageToPC(oPC, "start exec of makeTracksWithinArea");
  // I would like to have done tail recursion to keep it clean and simple... but it seems
  // the scripting system cannot handle all that much stack space  :(
  
  int nAreaTilesInXAxis = GetAreaSize(AREA_WIDTH, oArea);
  int nAreaTilesInYAxis = GetAreaSize(AREA_HEIGHT, oArea);
  while (TRUE) {
	int nChangeX = (toX - fromX);
	int nChangeY = (toY - fromY);
	int nChangeZ = (toZ - fromZ);
	
	if (nChangeX == 0 && nChangeY == 0 && nChangeZ == 0) return; // nothing to do
	
	int n2ChangeX = 2*nChangeX; // precalc these to reduce floating point math below
	int n2ChangeY = 2*nChangeY; // precalc these to reduce floating point math below
	int n2ChangeZ = 2*nChangeZ; // precalc these to reduce floating point math below
	
	int nDirectionOfX = 0; if (nChangeX > 0) {nDirectionOfX = 1;} else if (nChangeX < 0) nDirectionOfX = -1;
	int nDirectionOfY = 0; if (nChangeY > 0) {nDirectionOfY = 1;} else if (nChangeY < 0) nDirectionOfY = -1;
	int nDirectionOfZ = 0; if (nChangeZ > 0) {nDirectionOfZ = 1;} else if (nChangeZ < 0) nDirectionOfZ = -1;
	
	//update the last trail we left with the direction we went.
	int nLastTile = fromZ*nAreaTilesInXAxis*nAreaTilesInYAxis + fromY*nAreaTilesInXAxis + fromX;
	int nLastTileAndIndex = nLastTile * 10 + nLastIndex;
//	string sLastTile = IntToString(fromX) +"," + IntToString(fromY) +"," + IntToString(fromZ);
//	SendMessageToPC(oPC, "Your Last Trail was in " +sLastTile+ " and the trail index there was " + IntToString(nLastIndex) );

    int nextX = fromX; int nextY = fromY; int nextZ  = fromZ; // this is the next tile to mark with a trail
	string sLastMsg = GetLocalArrayString(oArea, "TrackingMsg", nLastTileAndIndex);
	if (nSpeedSQD < 3) sLastMsg += " and walk";
	else if (nSpeedSQD < 9) sLastMsg += " and run";
	else sLastMsg += " and sprint";

	// move along the axis in which the destination is most distant.
	if (abs(nChangeX) >= abs(nChangeY) && abs(nChangeX) >= abs(nChangeZ)) {
	   // we now know abs(nChangeX) is the largest AND non-zero
	   // move in the X direction... maybe the others too?
	   nextX = fromX + nDirectionOfX;
	   if (abs(n2ChangeY) >= abs(nChangeX)) nextY = fromY + nDirectionOfY;
	   if (abs(n2ChangeZ) >= abs(nChangeX)) {
	      nextZ = fromZ + nDirectionOfZ;
		  if (nDirectionOfZ == 1) sLastMsg += " up and";
		  else sLastMsg += " down and"; // (nDirectionOfZ == -1)
	   }
	} else if (abs(nChangeY) >= abs(nChangeX) && abs(nChangeY) >= abs(nChangeZ)) {
	   // we now know abs(nChangeY) is the largest AND non-zero
	   // move in the Y direction... maybe the others too?
	   nextY = fromY + nDirectionOfY;
	   if (abs(n2ChangeX) >= abs(nChangeY)) nextX = fromX + nDirectionOfX;
	   if (abs(n2ChangeZ) >= abs(nChangeY)) {
	      nextZ = fromZ + nDirectionOfZ;
		  if (nDirectionOfZ == 1) sLastMsg += " up and";
		  else sLastMsg += " down and"; // (nDirectionOfZ == -1)
	   }
	} else if (abs(nChangeZ) >= abs(nChangeX) && abs(nChangeZ) >= abs(nChangeY)) {
	   // we now know abs(nChangeZ) is the largest AND non-zero
	   // move in the Z direction... hopefully the others too!!!!
	   // in truth I dunno how we would get here... really really steep hills?
	      nextZ = fromZ + nDirectionOfZ;
	   if (nDirectionOfZ == 1) sLastMsg += " up";
	   else sLastMsg += " down"; // (nDirectionOfZ == -1)
	   if (abs(n2ChangeX) >= abs(nChangeZ)) {nextX = fromX + nDirectionOfX; sLastMsg += " and";}
	   if (abs(n2ChangeY) >= abs(nChangeZ)) {nextY = fromY + nDirectionOfY; sLastMsg += " and";}
	}
	 
	int nNextTile = nextZ*nAreaTilesInXAxis*nAreaTilesInYAxis + nextY*nAreaTilesInXAxis + nextX;
    int nNextIndex = GetLocalArrayInt(oArea, "TileIndex", nNextTile) + 1;
	// reset to 0 when we hit LIST_SIZE... we store only LIST_SIZE trails in slots 0..(LIST_SIZE-1)
	if (nNextIndex == LIST_SIZE) nNextIndex = 0;
	int nNextTileAndIndex = nNextTile * 10 + nNextIndex;
	 
//  string sNextTile = IntToString(nextX) +"," + IntToString(nextY) +"," + IntToString(nextZ);
//	SendMessageToPC(oPC, "Your Next Trail will be in " +sNextTile+ " at trail index " + IntToString(nNextIndex) );
	 
	int nTrackingDC = GetLocalInt(oArea, "TrackDC");
	if (nTrackingDC == 0) {
		nTrackingDC = 10;
		if (GetIsAreaNatural(oArea) == FALSE) nTrackingDC += 5;
		if (GetIsAreaInterior(oArea) == FALSE) nTrackingDC += 5;
	}
	
	nTrackingDC += nSpeedSQD - 4;
	 
	string sNextMsg = ")"; // leading bracket for the index number
	int nPCWeight = GetWeight(oPC);
	nTrackingDC += 10 - nPCWeight/100;
	if (nPCWeight < 500) sNextMsg += "Very Shallow ";
	else if (nPCWeight < 1000) sNextMsg += "Shallow ";
	else if (nPCWeight < 1500) {}// no special depth
	else if (nPCWeight < 2000) sNextMsg += "Deep ";
	else sNextMsg += "Very Deep ";
	
	switch (GetRacialType(oPC)) {
		case RACIAL_TYPE_DWARF : sNextMsg += "Dwarf tracks enter from "; break;
		case RACIAL_TYPE_ELF : sNextMsg += "Elf tracks enter from "; break;
		case RACIAL_TYPE_GNOME : sNextMsg += "Gnome tracks enter from "; break;
		case RACIAL_TYPE_HALFLING : sNextMsg += "Halfling tracks enter from "; break;
		case RACIAL_TYPE_HALFORC : sNextMsg += "Orcish tracks enter from "; break;
		case RACIAL_TYPE_GRAYORC : sNextMsg += "Orcish tracks enter from "; break;
		default : sNextMsg += "Humanoid tracks enter from "; break;
	}
	SetLocalArrayInt(oArea, "TrackingDC", nNextTileAndIndex, nTrackingDC);
	 
	// now determine where we came from and update both the last and next tiles
	if (nextX < fromX) {
	  if (nextY < fromY) {
	     sLastMsg += " South West.";
	     sNextMsg += " the North East";
	  } else if (nextY > fromY) {
	     sLastMsg += " North West.";
	     sNextMsg += "the South East";
	  } else {
	     sLastMsg += " West.";
	     sNextMsg += " the East";
	  }
	}  
	else if (nextX > fromX) {
	  if (nextY < fromY) {
	     sLastMsg += " South East.";
	     sNextMsg += " the North West";
	  } else if (nextY > fromY) {
	     sLastMsg += " North East.";
	     sNextMsg += " the South West";
	  } else {
	     sLastMsg += " East.";
	     sNextMsg += " the West";
	  }
	}
	else { // nextX == fromX
	  if (nextY < fromY) {
	     sLastMsg += " South.";
	     sNextMsg += " the North";
	  } else if (nextY > fromY) {
	     sLastMsg += " North.";
	     sNextMsg += " the South";
	  } else {
	     sLastMsg += "."; // ok this means they headed straight up or down... huh? Can happen
	     sNextMsg += " below";
	  }
	}
	
//	SendMessageToPC(oPC, "Setting lastTile " + IntToString(nLastTileAndIndex) + ":" + sLastMsg );
	SetLocalArrayString(oArea, "TrackingMsg", nLastTileAndIndex, sLastMsg);
//	SendMessageToPC(oPC, "Setting nextTile " + IntToString(nNextTileAndIndex) + ":" + sNextMsg );
	SetLocalArrayString(oArea, "TrackingMsg", nNextTileAndIndex, sNextMsg);
	SetLocalArrayInt(oArea, "TrackingEntryExitIdx", nNextTileAndIndex, GetLocalInt(oPC, "AreaEntryExitIdx"));
	SetLocalArrayInt(oArea, "TileIndex", nNextTile, nNextIndex);
	
	// dont really need this but why not
	SetLocalInt(oPC, "LAST_TILE_X", nextX);
	SetLocalInt(oPC, "LAST_TILE_Y", nextY);
	SetLocalInt(oPC, "LAST_TILE_Z", nextZ);
	SetLocalInt(oPC, "LAST_TRAIL_INDEX", nNextIndex);	
	
	// now make the recursive call to finish the trail
	//makeTracksWithinArea(oPC, oArea, nextX, nextY, nextZ, nNextIndex, toX, toY, toZ, nSpeedSQD);
    fromX = nextX;	
    fromY = nextY;	
    fromZ = nextZ;	
    nLastIndex = nNextIndex;
  }	
}

// oPC is the PC leaving tracks
// bShowTracks if FALSE means do not display tracks the oPC could see
// bIsAJump if TRUE means the oPC has moved via a jump... and did not actually move the distance
void doTracking(object oPC, int bShowTracks = TRUE, int bIsAJump = FALSE) {
//		SendMessageToPC(oPC, "doTracking - enter " + GetName(oPC) );
//		if (bShowTracks) SendMessageToPC(oPC, "doTracking - bShowTracks is TRUE");
//		else SendMessageToPC(oPC, "doTracking - bShowTracks is FALSE");
//		if (bIsAJump) SendMessageToPC(oPC, "doTracking - bIsAJump is TRUE");
//		else SendMessageToPC(oPC, "doTracking - bIsAJump is FALSE");
        if (GetIsDM(oPC))  return; // do not track DMs
		object oArea = GetArea(oPC);
		
		// Make sure we are not in limbo or transit
		if (GetIsObjectValid(oArea)) 
		{ 
//		SendMessageToPC(oPC, "doTracking - valid area " + GetName(oArea));
		   if ((FindSubString( GetName( oArea ), "OOC" ) != -1) ||
		       (FindSubString( GetName( oArea ), "Fugue" ) != -1) ) {
			   // do not track or leave tracks in an OOC room or the Fugue
			   // mark last trail as -1 so we know they have no current trail
			   SetLocalInt(oPC, "LAST_TRAIL_INDEX", -1);
//		       SendMessageToPC(oPC, "doTracking - in no tracking area");
			   return;
		   } 		   
		   string sCurrentAreaTag = GetTag(oArea);	
		   string sLastAreaTag = GetLocalString(oPC, "LAST_AREA_TAG");
		   int bNewArea = (sCurrentAreaTag != sLastAreaTag);	      
		   location oLocation = GetLocation(oPC);
		   vector vPosition = GetPositionFromLocation(oLocation);
		   int x = FloatToInt(vPosition.x / TILE_SIZE);
		   int y = FloatToInt(vPosition.y / TILE_SIZE);
		   int z = FloatToInt(vPosition.z / TILE_SIZE);
//		SendMessageToPC(oPC, "Your position is " +IntToString(x)+ "," +IntToString(y)+ "," +IntToString(z)); 
		   int nLastTileX = GetLocalInt(oPC, "LAST_TILE_X");
		   int nLastTileY = GetLocalInt(oPC, "LAST_TILE_Y");
		   int nLastTileZ = GetLocalInt(oPC, "LAST_TILE_Z");
		   int nLastIndex = GetLocalInt(oPC, "LAST_TRAIL_INDEX");
		   int bNewTile = (x != nLastTileX || y != nLastTileY || z != nLastTileZ ); 
		   if (bNewArea || bNewTile) 
		   {
		      // clearly we have moved... how far?
			  // yes I am ignoring changes in z... so sue me!  
			  // have you ever noticed that PC speed is also only limited in 2D... 
			  // you dont slow down running up and down hills.
			  int nChangeX = nLastTileX - x;
			  int nChangeY = nLastTileY - y;
			  // I am using speed squared to cut down on floating point math
			  int nSpeedSQD = nChangeX*nChangeX + nChangeY*nChangeY;
			  
		      // dump all the trails we can see here
			  int nAreaTilesInXAxis = GetAreaSize(AREA_WIDTH, oArea);
			  int nAreaTilesInYAxis = GetAreaSize(AREA_HEIGHT, oArea);
//			  SendMessageToPC(oPC, "The area size is WIDTH="+IntToString(nAreaTilesInXAxis)+",HEIGHT="+IntToString(nAreaTilesInYAxis));
			  int nCurrentTile = z*nAreaTilesInXAxis*nAreaTilesInYAxis + y*nAreaTilesInXAxis + x;
		      int nCurrentIndex = GetLocalArrayInt(oArea, "TileIndex", nCurrentTile);
//			  SendMessageToPC(oPC, "This tile is " +IntToString(nCurrentTile)+ " and the trail index here is " + IntToString(nCurrentIndex) );
		      
			  // in order to track you must be a swift tracker or a slow moving tracker
			  // note we have to assume that the tracker walked through a door since we cant tell based on distances moved
			  // with a nSpeedSQD < 3 the PC can move one tile in X or Y or both... but not 2 tiles
		      if (bShowTracks && 
			      (GetHasFeat(FEAT_SWIFT_TRACKER, oPC) || 
				  (GetHasFeat(FEAT_TRACK, oPC) && (nSpeedSQD < 3 || bIsAJump || bNewArea)))) {
				  // start at the most recent Trail
				  int nPlayerSurvivalSkill = GetSkillRank(SKILL_SURVIVAL , oPC);
				  
				  int nDCMods = 0;
				  if (GetIsNight() && GetIsAreaInterior(oArea) == FALSE) nDCMods += 3;
			      int nRainPower = GetWeather(oArea, WEATHER_TYPE_RAIN);
				  if (nRainPower != WEATHER_POWER_INVALID) nDCMods += nRainPower;
			      int nSnowPower = GetWeather(oArea, WEATHER_TYPE_SNOW);
				  if (nSnowPower != WEATHER_POWER_INVALID) nDCMods += nSnowPower * 3;
				  
			      int nIndex = nCurrentIndex;
			      int nCounter = 0;  // we are going to do this at most 10 times
			      while (nCounter < LIST_SIZE) {
				     // how hard is this?
					 int nCurrentTileAndIndex = nCurrentTile * 10 + nIndex;
					 int nDC = GetLocalArrayInt(oArea, "TrackingDC", nCurrentTileAndIndex) + nCounter * 3 + nDCMods;
					 nCounter++; // increment here... so that its set right for the message to PC
			         // Is their skill high enough?
					 if (nPlayerSurvivalSkill >= nDC) {
				         string sMsg = GetLocalArrayString(oArea, "TrackingMsg", nCurrentTileAndIndex);
						 if (sMsg == "") break; // first time the result is "" implies the rest are ""
						 if (GetHasFeat(FEAT_SWIFT_TRACKER, oPC)) {
						    int nEntryExitIdx = GetLocalArrayInt(oArea, "TrackingEntryExitIdx", nCurrentTileAndIndex);
							string sSwiftMsgFrom = GetLocalArrayString(oArea, "EntryFromArea", nEntryExitIdx);
							string sSwiftMsgTo = GetLocalArrayString(oArea, "ExitToArea", nEntryExitIdx);
							sMsg = sMsg + sSwiftMsgFrom + sSwiftMsgTo;
						 } 
					     SendMessageToPC(oPC, IntToString(nCounter) + sMsg);	
					 }
					 nIndex--;
					 if (nIndex == -1) nIndex = LIST_SIZE-1; // the list is circular
			      }		      
			  }
		  
			  // now leave trails of my own... maybe
			  if (GetHasSpellEffect(SPELL_ETHEREALNESS, oPC) || GetHasSpellEffect(724, oPC) || // Eth'Jaunt
			      (GetHasFeat(FEAT_TRACKLESS_STEP, oPC) && GetIsAreaNatural(oArea))) {
				  // nothing to see here
//				  SendMessageToPC(oPC, "doTracking - PC does not leave tracks");
                  SetLocalInt(oPC, "LAST_TRAIL_INDEX", -1);
			  } else {
			      nCurrentIndex++; if (nCurrentIndex == LIST_SIZE) nCurrentIndex = 0;
//			      string sLastTile = IntToString(nLastTileX) +"," + IntToString(nLastTileY) +"," + IntToString(nLastTileZ);
//				  SendMessageToPC(oPC, "Your Last Trail was " +sLastTile+ " and the trail index there was " + IntToString(nLastIndex) );
			      if (bNewArea || bIsAJump || nLastIndex == -1) {
				    int bUsedDoor = (bNewArea == FALSE);
//		            if (bUsedDoor) SendMessageToPC(oPC, "doTracking - bUsedDoor is TRUE");
//		            else SendMessageToPC(oPC, "doTracking - bUsedDoor is FALSE");
					object oLastArea = GetObjectByTag(sLastAreaTag);	
				    int nLastAreaTilesInXAxis = GetAreaSize(AREA_WIDTH, oLastArea);
			        int nLastAreaTilesInYAxis = GetAreaSize(AREA_HEIGHT, oLastArea);			
	                int nLastTile = nLastTileZ*nLastAreaTilesInXAxis*nLastAreaTilesInYAxis + nLastTileY*nLastAreaTilesInXAxis + nLastTileX;
			        makeTrackToNewArea(oPC, bUsedDoor, oLastArea, nLastTile, nLastIndex, oArea, nCurrentTile, nCurrentIndex);		            
			      }
			      else {
				     makeTracksWithinArea(oPC, oArea, nLastTileX, nLastTileY, nLastTileZ, nLastIndex, x, y, z, nSpeedSQD);
			      }	  
			      SetLocalInt(oPC, "LAST_TRAIL_INDEX", nCurrentIndex);
		     }
			 
		     // finally record our location on the PC
		     SetLocalString(oPC, "LAST_AREA_TAG", sCurrentAreaTag); // maybe a no-op but harmless to do anyway
					SetLocalInt(oPC, "LAST_TILE_X", x);
					SetLocalInt(oPC, "LAST_TILE_Y", y);
					SetLocalInt(oPC, "LAST_TILE_Z", z);
		} 
//		else SendMessageToPC(oPC, "doTracking - PC has not moved");
	} 
//	else SendMessageToPC(oPC, "doTracking - invalid area");
}

//void main(){}