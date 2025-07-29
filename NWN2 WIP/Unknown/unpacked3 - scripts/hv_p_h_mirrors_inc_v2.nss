#include "x0_i0_position"

// The width of the targets (the mirrors, in meters),
// must be even
const float MIRROR_WIDTH = 2.0;

const string MIRROR_TAG = "hv_p_h_mirror";

const string GOLEM = "hv_p_h_golem";

const string CRYSTAL = "hv_p_h_mirrors_crystal";

const string KEY_CRYSTAL = "hv_p_h_key_crystal";

const int TOTAL_MIRRORS = 4;

// Max hops so lightning rays won't bounce forever
// under certain conditions
const int MAX_HOPS = 10;

// Anti-spam system: set delay so players
// can't spam buttons
const float ANTI_SPAM_DELAY = 5.0;

// Declarations

void TryToFireAtTarget(float fShootingAngle);

// Return the closest object that can be hit.
// if none can be hit, return OBJECT_INVALID.
object GetNearestHitTarget(object oShooter, float fShootingAngle);

// Return TRUE if oShooter hits oTarget, FALSE otherwise
int CheckPossibleTarget(object oShooter, object oTarget, float fShootingAngle);

// Implementation

// Get an additional point on the straight line
// according to its angle
vector GetAdditionalPoint(vector vPointA, float fAngle)
{
	vector vPointB = GetChangedPosition(vPointA, 1.0, fAngle);
	return vPointB;
}

// Get hit angle between target and shot lines
float GetHitAngle(object oA, object oB, float fAngleA)
{
	// Object A - Shooter
	vector vPointA = GetPosition(oA);
	float fA = fAngleA;		
	vector vPointB = GetAdditionalPoint(vPointA, fA);
	float mA = 0.0;
	
	/* 
	SpeakString("Ax1: "+FloatToString(vPointA.x));
	SpeakString("Ax2: "+FloatToString(vPointB.x));
	SpeakString("Ay1: "+FloatToString(vPointA.y));
	SpeakString("Ay2: "+FloatToString(vPointB.y));
	*/
	
	int bFlagA = FALSE;
	int bFlagB = FALSE;
	float fXDifference = vPointA.x - vPointB.x;
	if (fXDifference < 0.0) { fXDifference = fXDifference * (-1); }
	if (fXDifference < 0.001)
		bFlagA = TRUE;
	else
		mA = (vPointB.y - vPointA.y) / (vPointB.x - vPointA.x);
	
	// Object B - target
	location lLeftPoint = GetStepLeftLocation(oB);
	location lRightPoint = GetStepRightLocation(oB);
	vector vPointC = GetPositionFromLocation(lLeftPoint);
	vector vPointD = GetPositionFromLocation(lRightPoint);
	float mB = 0.0;
	
	/*
	SpeakString("Bx1: "+FloatToString(vPointC.x));
	SpeakString("Bx2: "+FloatToString(vPointD.x));
	SpeakString("By1: "+FloatToString(vPointC.y));
	SpeakString("By2: "+FloatToString(vPointD.y));
	*/
	
	fXDifference = vPointD.x - vPointC.x;
	if (fXDifference < 0.0) { fXDifference = fXDifference * (-1); }
	if (fXDifference < 0.001)
		bFlagB = TRUE;
	else
		mB = (vPointD.y - vPointC.y) / (vPointD.x - vPointC.x);
	
	
	//SpeakString("mA: "+FloatToString(mA));
	//SpeakString("mB: "+FloatToString(mB));

	float fAngle = 0.0;	
	
	if ((bFlagA) && (!bFlagB))
	{
		float fmB = atan(mB);
		if (fmB < 0.0)
			fmB = fmB * (-1);
	
		return (90.0 - fmB);
	}
	else if ((bFlagB) && (!bFlagA))
	{
		float fmA = atan(mA);
		if (fmA < 0.0)
			fmA = fmA * (-1);
	
		return (90.0 - fmA);
	}
	else if ((bFlagA) && (bFlagB))
		return 0.0;
	else {
		if ((mB * mA > -1.0 - 0.001) && (mB * mA < -1.0 + 0.001))
			return 90.0;		
		//if (mB < 0.0) 
		//	mB = mB * (-1);
		//if (mA < 0.0) 
		//	mA = mA * (-1);
			
		fAngle = atan(mB) - atan(mA);
	}
	
	if (fAngle < 0.0)
		fAngle = fAngle * (-1);
		
	return fAngle;		
}

float GetReturnAngle(float fHitAngle, float fFacing, float fFireAngle)
{
	/*
	SpeakString("fHitAngle: "+FloatToString(fHitAngle));
	SpeakString("fFacing: "+FloatToString(fFacing));
	SpeakString("fFireAngle: "+FloatToString(fFireAngle));
	*/
	
	float fReturnAngle;

	float fReturnAngleA = fFacing + (90 - fHitAngle);
	float fReturnAngleB = fFacing - (90 - fHitAngle);
		
	float fCheckA = (fReturnAngleA - fFireAngle);
	float fCheckB = (fReturnAngleB - fFireAngle);
	
	
	if (fCheckA < 0.0) fCheckA = fCheckA * (-1);
	if (fCheckB < 0.0) fCheckB = fCheckB * (-1);
	
	fCheckA = 180 - fCheckA;
	fCheckB = 180 - fCheckB;
	
	if (fCheckA < 0.0) fCheckA = fCheckA * (-1);
	if (fCheckB < 0.0) fCheckB = fCheckB * (-1);
	
	if (fCheckA >= fCheckB)
		return fReturnAngleA;
	else
		return fReturnAngleB;
	
	return fReturnAngle;
}

// Is fire angle valid?
int CheckFireAngle(float fFireAngle, float fTargetFacingAngle)
{
    fFireAngle = GetNormalizedDirection(fFireAngle);
	fTargetFacingAngle = GetNormalizedDirection(fTargetFacingAngle);
	
	float fMin = fTargetFacingAngle - 90.0;
	float fMax = fTargetFacingAngle + 90.0;
	
	if ((fFireAngle >= fMin) && (fFireAngle <= fMax))
		return FALSE;
	
	return TRUE;
}

// Returns location just X steps to the left
location GetXStepsLeftLocation(object oTarget, float fSteps)
{
    float fDir = GetFacing(oTarget);
    float fAngle = GetLeftDirection(fDir);
    return GenerateNewLocation(oTarget,
                               fSteps,
                               fAngle,
                               fDir);
}

// Returns location just X step to the right
location GetXStepsRightLocation(object oTarget, float fSteps)
{
    float fDir = GetFacing(oTarget);
    float fAngle = GetRightDirection(fDir);
    return GenerateNewLocation(oTarget,
                               fSteps,
                               fAngle,
                               fDir);
}

// Determine whether a point is inside
// an interval or not
int GetIsPointInInterval(vector vPoint, vector vIntervalStart, vector vIntervalEnd)
{	
	/*
	SpeakString("vPoint: " + VectorToString(vPoint));
	SpeakString("vIntervalStart: " + VectorToString(vIntervalStart));
	SpeakString("vIntervalEnd: " + VectorToString(vIntervalEnd));
	*/
	
	float fPercision = 0.01;
	if ((vPoint.x < vIntervalStart.x - fPercision) && (vPoint.x < vIntervalEnd.x - fPercision))
		return FALSE;
	if ((vPoint.x > vIntervalStart.x + fPercision) && (vPoint.x > vIntervalEnd.x + fPercision))
		return FALSE;
	if ((vPoint.y < vIntervalStart.y - fPercision) && (vPoint.y < vIntervalEnd.y - fPercision))
		return FALSE;
	if ((vPoint.y > vIntervalStart.y + fPercision) && (vPoint.y > vIntervalEnd.y + fPercision))
		return FALSE;
	
	return TRUE;
}

// Get the intersection point of two straight lines,
// each line defined by two points.
vector GetIntersectionPoint(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
{
	vector vResult = Vector(0.0,0.0);

    float a1, a2, b1, b2, c1, c2;
    float denom;

	  a1 = y2-y1;
	  b1 = x1-x2;
	  c1 = x2*y1 - x1*y2;
	
	  a2 = y4-y3;
	  b2 = x3-x4;
	  c2 = x4*y3 - x3*y4;
	
	  denom = a1*b2 - a2*b1;
	  if ((denom < 0.001) && (denom > -0.001)) {
	    return vResult;
	}
	
	  float x = (b1*c2 - b2*c1)/denom;
	  float y = (a2*c1 - a1*c2)/denom;
	  
	  if (x < 0.0) x = x * (-1);
	  if (y < 0.0) y = y * (-1);
	  
	  vResult.x = x;
	  vResult.y = y;
	  	 
	  
	return vResult;	 
}

// Shot off map - do malfunction visual
void MissedShot(object oShooter)
{
	effect eEnergy = EffectVisualEffect(VFX_BEAM_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oShooter, 2.0f);
}

// Shoot at intersection point (but off target)
void ShootOffTarget(location lLoc)
{
	object oBox = CreateObject(OBJECT_TYPE_PLACEABLE, "hv_p_h_c_box", lLoc);
	
	// Create beam to object
	effect eEnergy = EffectVisualEffect(VFX_BEAM_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oBox, 1.5f);
	
	// Put object on fire
	eEnergy = EffectVisualEffect(VFX_DUR_FIRE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oBox, 2.5f);
	
	// Destroy object after 6 seconds
	DelayCommand(4.0, DestroyObject(oBox));
}

// Final puzzel stage - open the door for 30 seconds.
void OpenPuzzleDoor()
{
	// Hit crystal control panel
	object oControlPanel = GetNearestObjectByTag("hv_p_h_c_panel", OBJECT_SELF);
	
	// Create beam to object
	effect eEnergy = EffectVisualEffect(VFX_BEAM_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oControlPanel, 5.0f);
	
	// Extra visuals 
	eEnergy = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, OBJECT_SELF, 3.0);
	
	// Open the door for 30 seconds
	object oDoor = GetNearestObjectByTag("hv_p_h_mirrors_door", OBJECT_SELF);
	//AssignCommand(oDoor, DelayCommand(3.8, SetLocked(oDoor, FALSE)));
	AssignCommand(oDoor, DelayCommand(4.0, ActionOpenDoor(oDoor)));
	AssignCommand(oDoor, DelayCommand(3.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_MAGIC), oDoor)));
	//AssignCommand(oDoor, DelayCommand(29.5, SetLocked(oDoor, TRUE)));
	AssignCommand(oDoor, DelayCommand(20.0, ActionCloseDoor(oDoor)));
}

// Shoot a target
void ShootTarget(object oTarget, float fShootingAngle)
{
	// Create beam to object
	effect eEnergy = EffectVisualEffect(VFX_BEAM_LIGHTNING);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnergy, oTarget, 1.0f);
	
	// If it's the key crystal, do final puzzel phase
	if (GetTag(oTarget) == KEY_CRYSTAL) {
		AssignCommand(oTarget, OpenPuzzleDoor());
		return;
	}
	
	// Determine return angle
	object oShooter = OBJECT_SELF;
	//SpeakString("I'm here.");
	float fHitAngle = GetHitAngle(oShooter, oTarget, fShootingAngle);
	//SpeakString("Hit Angle: " + FloatToString(fHitAngle));
	fShootingAngle = GetReturnAngle(fHitAngle, GetFacing(oTarget), fShootingAngle);
	//SpeakString("Return Angle: " + FloatToString(fShootingAngle));
	
	// Fire at next target
	AssignCommand(oTarget, DelayCommand(0.1, TryToFireAtTarget(fShootingAngle)));
}

// Reset mirrors that were hit last time
void ResetMirrorsPassCheck(object oArea)
{
	int i = 0;
	for (i = 1; i <= TOTAL_MIRRORS; i++) {
		SetLocalInt(oArea, "Mirror" + IntToString(i), 0);		
	}	
}

// Fire away!
void TryToFireAtTarget(float fShootingAngle)
{
	object oShooter = OBJECT_SELF;
	object oTarget = GetNearestHitTarget(oShooter, fShootingAngle);
	
	int nHops = GetLocalInt(GetArea(oShooter), "hv_max_hops");
	if (GetIsObjectValid(oTarget)) {
		if (nHops <= MAX_HOPS) {
			SetLocalInt(GetArea(oShooter), "hv_max_hops", nHops + 1);			
			
			// Mark that the lightning passed through the target
			SetLocalInt(GetArea(oTarget), GetName(oTarget), 1);
			ShootTarget(oTarget, fShootingAngle);					
		}
		else
			MissedShot(oShooter);	
	}
		
	// Missed the target!
	else 
	{
		vector vNewLocation = GetChangedPosition(GetPosition(oShooter), 10.0, fShootingAngle + 180.0);
		location lLoc = Location(GetArea(oShooter), vNewLocation , 0.0);
				
		// If Location still invalid, do malfunction
		if (!GetIsLocationValid(lLoc)) { MissedShot(oShooter); }
		else { ShootOffTarget(lLoc); }
	}
}

// Return TRUE if we hit the KeyCrystal
// FALSE if we don't
int CheckPossibleKeyCrystalHit(object oShooter, object oTarget, float fShootingAngle)
{
	vector vIntersectionPoint;
	vector vPointA = GetPosition(oShooter);
	
	if (GetIsObjectValid(oTarget))
	{
		// Get the straight line which represents the line of fire
		vector vPointB = GetAdditionalPoint(vPointA, fShootingAngle);
		
		float x1 = vPointA.x;
		float y1 = vPointA.y;
		float x2 = vPointB.x;
		float y2 = vPointB.y;
		
		// Get the straight line which represents the target
		location lLeftPoint = GenerateNewLocationFromLocation(GetLocation(oTarget), 1.0, fShootingAngle + 90.0, 0.0);
		location lRightPoint = GenerateNewLocationFromLocation(GetLocation(oTarget), 1.0, fShootingAngle - 90.0, 0.0);
		//location lLeftPoint = GetXStepsLeftLocation(oTarget, MIRROR_WIDTH / 2);
		//location lRightPoint = GetXStepsRightLocation(oTarget, MIRROR_WIDTH / 2);
		vector vPointC = GetPositionFromLocation(lRightPoint);
		vector vPointD = GetPositionFromLocation(lLeftPoint);
		
		float x3 = vPointC.x;
		float y3 = vPointC.y;
		float x4 = vPointD.x;
		float y4 = vPointD.y;
		
		// Get their intersection point		
		vIntersectionPoint = GetIntersectionPoint(x1,y1,x2,y2,x3,y3,x4,y4);		
		
		//SpeakString("vIntersectionPointCrystal: " + VectorToString(vIntersectionPoint));
		
		// Is the intersection point within the target?
		if (GetIsPointInInterval(vIntersectionPoint, vPointC, vPointD) == TRUE)
		{
			// Can hit the target!
			return TRUE;
		}
	}
	
	// Can't hit target =(
	return FALSE;
}

// Return TRUE if oShooter hits oTarget, FALSE otherwise
int CheckPossibleTarget(object oShooter, object oTarget, float fShootingAngle)
{
	vector vIntersectionPoint;
	vector vPointA = GetPosition(oShooter);
	
	if (GetIsObjectValid(oTarget))
	{
		// Get the straight line which represents the line of fire
		vector vPointB = GetAdditionalPoint(vPointA, fShootingAngle);
		
		float x1 = vPointA.x;
		float y1 = vPointA.y;
		float x2 = vPointB.x;
		float y2 = vPointB.y;
		
		// Get the straight line which represents the target
		location lLeftPoint = GetXStepsLeftLocation(oTarget, MIRROR_WIDTH / 2);
		location lRightPoint = GetXStepsRightLocation(oTarget, MIRROR_WIDTH / 2);
		vector vPointC = GetPositionFromLocation(lRightPoint);
		vector vPointD = GetPositionFromLocation(lLeftPoint);
		
		float x3 = vPointC.x;
		float y3 = vPointC.y;
		float x4 = vPointD.x;
		float y4 = vPointD.y;
		
		// Get their intersection point		
		vIntersectionPoint = GetIntersectionPoint(x1,y1,x2,y2,x3,y3,x4,y4);		
		
		//SpeakString("vIntersectionPoint: " + VectorToString(vIntersectionPoint));
		
		// Is the intersection point within the target?
		if ((GetIsPointInInterval(vIntersectionPoint, vPointC, vPointD) == TRUE) && (CheckFireAngle(fShootingAngle, GetFacing(oTarget)) == TRUE))
		{
			// Can hit the target!
			return TRUE;
		}
	}
	
	// Can't hit target =(
	return FALSE;
}

// Check if lightning passed through all mirrors.
// return TRUE if it did, false if it didn't
int CheckPassedAllMirrors(object oArea)
{
	int i = 0;
	for (i = 1; i <= TOTAL_MIRRORS; i++) {
		//SpeakString(IntToString(i)+": "+ IntToString(GetLocalInt(oArea, "Mirror" + IntToString(i))));
		if (GetLocalInt(oArea, "Mirror" + IntToString(i)) == 0)
			return FALSE;
	}
	return TRUE;
}

// Return the crystal object if the key crystal is hit,
// OBJECT_INVALID otherwise
object CheckKeyCrystalHit(object oShooter, float fShootingAngle)
{
	// Check if lightning passed through all mirrors
	if (CheckPassedAllMirrors(GetArea(oShooter)) == FALSE)
		return OBJECT_INVALID;
	
	//SpeakString("I'm here..");	
		
	// Check if it is in hit angle
	object oKeyCrystal = GetNearestObjectByTag(KEY_CRYSTAL, oShooter);
	if (CheckPossibleKeyCrystalHit(oShooter, oKeyCrystal, fShootingAngle) == TRUE) {
		//SpeakString("I'm here..");
		return oKeyCrystal;
	}
		
	return OBJECT_INVALID;
}

// Return the closest object that can be hit.
// if none can be hit, return OBJECT_INVALID.
object GetNearestHitTarget(object oShooter, float fShootingAngle)
{
	// Check if the key crystal is hit
	object oKeyCrystal = CheckKeyCrystalHit(oShooter, fShootingAngle);
	if (GetIsObjectValid(oKeyCrystal) == TRUE)
		return oKeyCrystal;

	// Go over each mirror, and see if we hit it
	int i = 0;
	object oMirror;
	for (i = 0; i < TOTAL_MIRRORS; i++)
	{
		oMirror = GetNearestObjectByTag(MIRROR_TAG, oShooter, i + 1);
		
		// Can I hit it?
		if (CheckPossibleTarget(oShooter, oMirror, fShootingAngle) == TRUE)
		{
			return oMirror;
		}
	}
	
	return OBJECT_INVALID;
}

// Return the mirror that corresponds to sName
object GetMirrorByName(string sName)
{
	object oSelf = OBJECT_SELF;
	// Go over each mirror
	int i = 0;
	object oMirror;
	for (i = 0; i < TOTAL_MIRRORS; i++)
	{
		oMirror = GetNearestObjectByTag(MIRROR_TAG, oSelf, i + 1);
				
		if (GetName(oMirror) == sName)
		{
			return oMirror;
		}
	}
	
	return OBJECT_INVALID;
}

// Determine whether the golem is free to take commands.
// return TRUE is it is, FALSE otherwise
int GetIsGolemFree(object oGolem)
{
	int bBusy = GetLocalInt(oGolem, "hv_golem_busy");
	if (bBusy == TRUE)
		return FALSE;
		
	return TRUE;
}

// Order golem to move oMirror to face fAngle
void GolemSetMirrorAngle(object oMirror, float fAngle)
{
	object oGolem = GetNearestObjectByTag(GOLEM, oMirror);
	
	if (GetIsGolemFree(oGolem) == FALSE) {
		SendMessageToPC(OBJECT_SELF, "<C=red>The golem is busy.");
		return;
	}
	
	// Mark golem as busy
	SetLocalInt(oGolem, "hv_golem_busy", TRUE);
	AssignCommand(oGolem, SpeakString("<C=lightgreen>Command acknowledged. Executing. . ."));
	
	// Determine delay based on distance
	float fDistance = GetDistanceBetween(oGolem, oMirror);
	float fDelay = fDistance / 2;
	
	//Move to the mirror
	AssignCommand(oGolem, ActionForceMoveToObject(oMirror, FALSE, 1.0, fDelay));
	
	// Set mirror facing new direction
	AssignCommand(oMirror, DelayCommand(fDelay, SetFacing(fAngle)));
	
	// Visual on mirror
	AssignCommand(oMirror, DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_MAGIC), oMirror)));
	
	// Golem is not busy anymore
	AssignCommand(oGolem, DelayCommand(fDelay + 0.1, SpeakString("<C=lightgreen>Command executed.")));
	AssignCommand(oGolem, DelayCommand(fDelay + 0.2, SetLocalInt(oGolem, "hv_golem_busy", FALSE)));
}

// Find location for the golem to stand
// before creating new mirror
location GetSafeGolemLocation(location lLoc, float fFacingDirection)
{
	location lSafeLoc;
	int i = 0;
	float fAngle = 0.0;
	while (i < 4)
	{
		lSafeLoc = GenerateNewLocationFromLocation(lLoc, 3.0, fAngle, fFacingDirection);	
		
		// Check if it's valid
		if (GetIsLocationValid(lSafeLoc)) return lSafeLoc;
		
		// Search on...
		i++;
		fAngle += 45.0;
	}
	
	return lSafeLoc;
}

// for moving mirrors around
vector GetChangedMirrorPosition(vector vOriginal, float fDistance, float fAngle)
{
    vector vChanged;
    vChanged.z = vOriginal.z;
    vChanged.x = vOriginal.x + GetChangeInX(fDistance, fAngle);
    //if (vChanged.x < 0.0)
    //    vChanged.x = - vChanged.x;
    vChanged.y = vOriginal.y + GetChangeInY(fDistance, fAngle);
    //if (vChanged.y < 0.0)
    //    vChanged.y = - vChanged.y;

    return vChanged;
}

// For moving mirrors around
location GetNewMirrorLocation(object oTarget, float fDistance, float fAngle, float fOrientation)
{
    object oArea = GetArea(oTarget);
    vector vNewPos = GetChangedMirrorPosition(GetPosition(oTarget),
                                        fDistance,
                                        fAngle);
    return Location(oArea, vNewPos, fOrientation);
}

// Create object wrapper that returns void
void CreateMirror(location lLoc, string sName, object oCrystal = OBJECT_INVALID)
{
	object oMirror = CreateObject(OBJECT_TYPE_PLACEABLE, MIRROR_TAG, lLoc);
	SetFirstName(oMirror, sName);
	
	// Visual
	AssignCommand(oMirror, DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_ALCHEMY), oMirror)));
	DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_BEAM_MAGIC), oMirror, 1.0));
}

// Order golem to move oMirror in sDirection
// n Steps.
void GolemMoveMirror(object oMirror, string sDirection, int nSteps)
{
	object oGolem = GetNearestObjectByTag(GOLEM, oMirror);
	
	if (GetIsGolemFree(oGolem) == FALSE) {
		SendMessageToPC(OBJECT_SELF, "<C=red>The golem is busy.");
		return;
	}
	
	// Create a new location based on parameters
	float fAngle = 0.0;
	if 		(sDirection == "north") fAngle = 90.0;
	else if (sDirection == "south") fAngle = 270.0;
	else if (sDirection == "east")  fAngle = 0.0;
	else if (sDirection == "west")  fAngle = 180.0;
	
	float fSteps = IntToFloat(nSteps);
	location lNewLoc = GetNewMirrorLocation(oMirror,fSteps,fAngle,GetFacing(oMirror));
	
	// Generate new location for golem to stand in
	location lGolemLoc = GetSafeGolemLocation(lNewLoc, GetFacing(oMirror));
	
	// Check if new locations are valid
	if ((GetIsLocationValid(lNewLoc) == FALSE) || (GetIsLocationValid(lGolemLoc) == FALSE)) {
		AssignCommand(oGolem, SpeakString("<C=lightgreen>Cannot move target to specified location. . ."));
		return;
	}
	
	// Store current mirror location for future use
	location lOld = GetLocation(oMirror);
	string sName = GetName(oMirror);
	
	// Mark golem as busy
	SetLocalInt(oGolem, "hv_golem_busy", TRUE);
	AssignCommand(oGolem, SpeakString("<C=lightgreen>Command acknowledged. Executing. . ."));
	
	// Determine delay based on distance
	float fDistance = GetDistanceBetween(oGolem, oMirror);
	float fDelay = fDistance / 2;
	
	//Move to the mirror
	AssignCommand(oGolem, ActionForceMoveToObject(oMirror, FALSE, 1.0, fDelay + 1.0));
	
	// Destroy mirror and visual
	AssignCommand(oGolem, DelayCommand(fDelay + 0.1, DestroyObject(oMirror)));
	
	// Visual on mirror
	AssignCommand(oMirror, DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_ALCHEMY), oMirror)));
	
	// Get new fDelay based on distances
	float fDelay2 = GetDistanceBetweenLocations(lOld, lGolemLoc) / 2;
	
	// Move to new location
	AssignCommand(oGolem, DelayCommand(fDelay + 0.5, ActionForceMoveToLocation(lGolemLoc, FALSE, fDelay2 + 1.0)));
	
	// Create mirror in new location (plus visual)
	AssignCommand(oGolem, DelayCommand(fDelay2 + fDelay, CreateMirror(lNewLoc, sName)));	
	
	// Golem is not busy anymore
	AssignCommand(oGolem, DelayCommand(fDelay + 0.1 + fDelay2, SpeakString("<C=lightgreen>Command executed.")));
	AssignCommand(oGolem, DelayCommand(fDelay + 0.2 + fDelay2, SetLocalInt(oGolem, "hv_golem_busy", FALSE)));
}

// Order crystal to set mirror angle
void CrystalSetMirrorAngle(object oCrystal, object oMirror, float fAngle)
{
	// Visual on mirror
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_BEAM_MAGIC), oMirror, 1.0);
	AssignCommand(oMirror, DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_MAGIC), oMirror)));
	
	// Set mirror to new angle
	AssignCommand(oMirror, DelayCommand(0.2, SetFacing(fAngle)));
}

// Order crystal to move mirror
void CrystalMoveMirror(object oCrystal, object oMirror, string sDirection, int nSteps)
{
	// Create a new location based on parameters
	float fAngle = 0.0;
	if 		(sDirection == "north") fAngle = 90.0;
	else if (sDirection == "south") fAngle = 270.0;
	else if (sDirection == "east")  fAngle = 0.0;
	else if (sDirection == "west")  fAngle = 180.0;
	
	float fSteps = IntToFloat(nSteps);
	location lNewLoc = GetNewMirrorLocation(oMirror,fSteps,fAngle,GetFacing(oMirror));
	
	// Check if new location is valid
	if (GetIsLocationValid(lNewLoc) == FALSE) {
		SpeakString("<C=lightgreen><i>*Cannot move target to specified location. . .*");
		return;
	}
	
	string sName = GetName(oMirror);
	
	// Visual on mirror
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_BEAM_MAGIC), oMirror, 1.0);
	AssignCommand(oMirror, DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION), oMirror)));
	
	// Destroy mirror
	DestroyObject(oMirror, 0.3);
	
	// Create mirror in new location
	DelayCommand(1.5, CreateMirror(lNewLoc, sName, oCrystal));
}