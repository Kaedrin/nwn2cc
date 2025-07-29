/*
These are the basic Utitlities
*/
/////////////////////////////////////////////////////
//////////////// Notes /////////////////////////////
////////////////////////////////////////////////////


/////////////////////////////////////////////////////
///////////////// DESCRIPTION ///////////////////////
/////////////////////////////////////////////////////


/////////////////////////////////////////////////////
///////////////// Constants /////////////////////////
/////////////////////////////////////////////////////

// Use these for bit based math
const int BIT0  =           0;
const int BIT1  =           1;
const int BIT2  =           2;
const int BIT3  =           4;
const int BIT4  =           8;
const int BIT5  =          16;
const int BIT6  =          32;
const int BIT7  =          64;
const int BIT8  =         128;
const int BIT9  =         256;
const int BIT10 =         512;
const int BIT11 =        1024;
const int BIT12 =        2048;
const int BIT13 =        4096;
const int BIT14 =        8192;
const int BIT15 =       16384;
const int BIT16 =       32768;
const int BIT17 =       65536;
const int BIT18 =      131072;
const int BIT19 =      262144;
const int BIT20 =      524288;
const int BIT21 =     1048576;
const int BIT22 =     2097152;
const int BIT23 =     4194304;
const int BIT24 =     8388608;
const int BIT25 =    16777216;
const int BIT26 =    33554432;
const int BIT27 =    67108864;
const int BIT28 =   134217728;
const int BIT29 =   268435456;
const int BIT30 =   536870912;
const int BIT31 =  1073741824;


/////////////////////////////////////////////////////
//////////////// Includes ///////////////////////////
/////////////////////////////////////////////////////

// need to review these
// not sure on this one, but might be useful
//#include "_SCSpell_Include_MetaConstants"

/////////////////////////////////////////////////////
//////////////// Prototypes /////////////////////////
/////////////////////////////////////////////////////


// * Returns the Integer Maximum of two values
int CSLGetMax(int iNum1 = 0, int iNum2 = 0);

// * Returns the Integer Minimum of two values
int CSLGetMin(int iNum1 = 0, int iNum2 = 0);

// * Returns the Float Maximum of two values
float CSLGetMaxf(float iNum1 = 0.0, float iNum2 = 0.0);

// * Returns the Float Minimum of two values
float CSLGetMinf(float iNum1 = 0.0, float iNum2 = 0.0);

int CSLIsWithinRange(int iIn, int nMin, int nMax );

int CSLGetWithinRange(int iIn, int nMin, int nMax );

// * Returns the True if the first value is between or equal to the 2nd and 3rd values
int CSLIsWithinRangef( float flValue, float flMin, float flMax );

// * Returns the True if the first value is between or equal to the 2nd and 3rd values
float CSLGetWithinRangef(float flValue, float flMin, float flMax);

int CSLMaxLocalInt(object oObject, string sKey, int iIn);

int CSLMinLocalInt(object oObject, string sKey, int iIn);

// * Increments specified local integer
int CSLIncrementLocalInt(object oObject, string sFld, int iVal = 1);

int CSLDecrementLocalInt(object oObject, string sFld, int iVal = 1, int bZeroLimit = FALSE);

float CSLIncrementLocalFloat(object oObject, string sFld, float fVal = 0.0f);

float CSLDecrementLocalFloat(object oObject, string sFld, float fVal = 0.0f, int bZeroLimit = FALSE);

// * Rounds given number to nearest specified place
int CSLRoundToNearest(int iIn, int nNearest=5);

// * Adds the bits to the given number, can be used for example to combine bit type values like metamagic
int CSLBitAdd( int iVal, int iBits );

// * Subtracts the bits to the given number, can be used for example to combine bit type values like metamagic
int CSLBitSub( int iVal, int iBits );

// * Subtracts all the given bits from the given number, enmasse
int CSLBitSubGroup( int iVal, int iBits1 = 0, int iBits2 = 0, int iBits3 = 0, int iBits4 = 0, int iBits5 = 0, int iBits6 = 0, int iBits7 = 0, int iBits8 = 0, int iBits9 = 0 );

// * acosh - based on php to javascript library
float CSLACosH( float fValue );

// * asinh - based on php to javascript library
float CSLASinH( float fValue );

// * atanh - based on php to javascript library
float CSLATanH( float fValue );

// * A timesd flag
void CSLTimedFlag( object oObject, string sFld, float fDelay );

/////////////////////////////////////////////////////
//////////////// Implementation /////////////////////
/////////////////////////////////////////////////////

int CSLGetMax(int iNum1 = 0, int iNum2 = 0)
{
	return (iNum1 > iNum2) ? iNum1 : iNum2;
}

int CSLGetMin(int iNum1 = 0, int iNum2 = 0)
{
	return (iNum1 < iNum2) ? iNum1 : iNum2;
}

float CSLGetMaxf(float iNum1 = 0.0, float iNum2 = 0.0)
{
	return (iNum1 > iNum2) ? iNum1 : iNum2;
}

float CSLGetMinf(float iNum1 = 0.0, float iNum2 = 0.0)
{
	return (iNum1 < iNum2) ? iNum1 : iNum2;
}

int CSLCeilf( float fIn )
{
	// return ( fIn % 1.0f ) ? FloatToInt( fIn ) + 1 : FloatToInt( fIn );
	return 0; // Modulo % only works on integers :(
}


// used in regenerate, useful function
int CSLRoundToNearest(int iIn, int nNearest=5)
{
	return iIn - (iIn % nNearest);
}


int CSLIsWithinRange(int iIn, int nMin, int nMax )
{
	if ( iIn < nMin )
	{
		return FALSE;
	}
	if ( iIn > nMax )
	{
		return FALSE;
	}
	return TRUE;
}


int CSLGetWithinRange(int iIn, int nMin, int nMax )
{
	if ( iIn < nMin )
	{
		return nMin;
	}
	if ( iIn > nMax )
	{
		return nMax;
	}
	return iIn;
}


int CSLIsWithinRangef( float flValue, float flMin, float flMax )
{
	if ( flValue < flMin )
	{
		return FALSE;
	}
	if ( flValue > flMax )
	{
		return FALSE;
	}
	return TRUE;
}


float CSLGetWithinRangef(float flValue, float flMin, float flMax)
{
	if ( flValue < flMin )
	{
		return flMin;
	}
	if ( flValue > flMax )
	{
		return flMax;
	}
	return flValue;
}



// Local Math Variables
// * Gets a local int, and if it's not already defined it sets a default value for it
int CSLDefineLocalInt(object oObject, string sFld, int iIn)
{
	int iCur = GetLocalInt(oObject, sFld);
	if (!iCur)
	{
		SetLocalInt(oObject, sFld, iIn);
		iCur = iIn;
	}
	return iCur;
}


// * Gets a local int, and if it's not already defined it sets a default value for it
float CSLDefineLocalFloat(object oObject, string sFld, float fValue)
{
	float fCur = GetLocalFloat(oObject, sFld);
	if ( fCur != 0.0f )
	{
		SetLocalFloat(oObject, sFld, fValue);
		fCur = fValue;
	}
	return fCur;
}


// * Takes an variable name on an object, and a value, and returns whichever is highest
int CSLMaxLocalInt(object oObject, string sKey, int iIn)
{
   int iCur = GetLocalInt(oObject, sKey);
   return CSLGetMax( iIn, iCur );
}

// * Takes an variable name on an object, and a value, and returns whichever is lowest
//   Returns provided iIn if the LocalInt is 0
int CSLMinLocalInt(object oObject, string sKey, int iIn)
{
   int iCur = GetLocalInt(oObject, sKey);
   if ( iCur == 0 ) // Zeros might be a null, so if it's 0, i'll just return the  provided value
   {
		return iIn;
   }
   return CSLGetMin( iIn, iCur );
}


// used in circle of death and a few others
void CSLTimedFlag(object oObject, string sFld, float fDelay )
{
	SetLocalInt(oObject, sFld, TRUE);
	AssignCommand(oObject, DelayCommand(fDelay, DeleteLocalInt(oObject, sFld)));
}

int CSLIncrementLocalInt(object oObject, string sFld, int iVal = 1)
{
	int nNew = GetLocalInt(oObject, sFld) + iVal;
	SetLocalInt(oObject, sFld, nNew);
	return nNew;
}

int CSLDecrementLocalInt(object oObject, string sFld, int iVal = 1, int bZeroLimit = FALSE)
{
	int nNew = GetLocalInt(oObject, sFld) - iVal;
	if ( bZeroLimit && nNew < 0 )
	{
		nNew = 0;
	}
	SetLocalInt(oObject, sFld, nNew);
	return nNew;
}


float CSLIncrementLocalFloat(object oObject, string sFld, float fVal = 0.0f)
{
	float fNew = GetLocalFloat(oObject, sFld) + fVal;
	SetLocalFloat(oObject, sFld, fNew);
	return fNew;
}

float CSLDecrementLocalFloat(object oObject, string sFld, float fVal = 0.0f, int bZeroLimit = FALSE)
{
	float fNew = GetLocalFloat(oObject, sFld) - fVal;
	if ( bZeroLimit && fNew < 0.0f )
	{
		fNew = 0.0f;
	}
	SetLocalFloat(oObject, sFld, fNew);
	return fNew;
}


void CSLIncrementLocalInt_Void( object oObject, string sField, int iVal = 1 )
{
	int nNew = GetLocalInt(oObject, sField) + iVal;
	SetLocalInt(oObject, sField, nNew);
}

void CSLDecrementLocalInt_Void(object oObject, string sField, int iVal = 1, int bZeroLimit = FALSE)
{
	int nNew = GetLocalInt(oObject, sField) - iVal;
	if ( bZeroLimit && nNew < 0 )
	{
		nNew = 0;
	}
	SetLocalInt(oObject, sField, nNew);
}

void CSLIncrementLocalFloat_Void(object oObject, string sFld, float fVal = 0.0f)
{
	float fNew = GetLocalFloat(oObject, sFld) + fVal;
	SetLocalFloat(oObject, sFld, fNew);
}

void CSLDecrementLocalFloat_Void(object oObject, string sFld, float fVal = 0.0f,  int bZeroLimit = FALSE)
{
	float fNew = GetLocalFloat(oObject, sFld) - fVal;
	if ( bZeroLimit && fNew < 0.0f )
	{
		fNew = 0.0f;
	}
	SetLocalFloat(oObject, sFld, fNew);
}

// * raises local integer for set period of time
int CSLIncrementLocalInt_Timed(object oObject, string sFld, float fDelay, int iVal = 1)
{
   int nNew = GetLocalInt(oObject, sFld) + iVal;
   SetLocalInt(oObject, sFld, nNew);
   //AssignCommand(oObject, 
   DelayCommand(fDelay, CSLDecrementLocalInt_Void(oObject, sFld, iVal, TRUE ));
   //);
   return nNew;
}

// * lowers local integer for set period of time
int CSLDecrementLocalInt_Timed(object oObject, string sFld, float fDelay, int iVal = 1)
{
   int nNew = GetLocalInt(oObject, sFld) - iVal;
   SetLocalInt(oObject, sFld, nNew);
   //AssignCommand(oObject, 
   DelayCommand(fDelay, CSLIncrementLocalInt_Void(oObject, sFld, iVal));
   //);
   return nNew;
}

// * Adds given bit to the stored integer variable
void CSLAddLocalBit(object oObject, string sVarName, int nValue)
{
	SetLocalInt( oObject, sVarName, GetLocalInt( oObject, sVarName) | nValue );
}

// * Subtracts given bit from the stored integer variable
void CSLSubLocalBit(object oObject, string sVarName, int nValue)
{
	SetLocalInt( oObject, sVarName, GetLocalInt( oObject, sVarName) & ~nValue );
}


/*
// this adds piercing to the bits of the iDescriptor
	// iDescriptor | SCMETA_DESCRIPTOR_PIERCING ;
	
	// this removes piercing to the bits of the iDescriptor
	// iDescriptor | ~SCMETA_DESCRIPTOR_PIERCING ;  <-- does not seem to work in testing
*/
// adds a single bit to an integer
int CSLBitAdd( int iVal, int iBits )
{
	return iVal | iBits;
}

// removes a single bit from an integer
int CSLBitSub( int iVal, int iBits )
{
	return iVal & ~iBits;
}

// removes multiple bits at once
int CSLBitSubGroup( int iVal, int iBits1 = 0, int iBits2 = 0, int iBits3 = 0, int iBits4 = 0, int iBits5 = 0, int iBits6 = 0, int iBits7 = 0, int iBits8 = 0, int iBits9 = 0 )
{
	return iVal & ~( iBits1 | iBits2 | iBits3 | iBits4 | iBits5 | iBits6 | iBits7 | iBits8 | iBits9 );
	/*
	iVal &= ~iBits1;
	iVal &= ~iBits2;
	iVal &= ~iBits3;
	iVal &= ~iBits4;
	iVal &= ~iBits5;
	iVal &= ~iBits6;
	iVal &= ~iBits7;
	iVal &= ~iBits8;
	iVal &= ~iBits9;
	return iVal;
	*/
}

//::///////////////////////////////////////////////
//:: Meters To Feet
//::///////////////////////////////////////////////
/*
    Convertion to Convert Meters To Feet
*/
//::///////////////////////////////////////////////
//:: Created By: Karl Nickels (Syrus Greycloak)
//:: Created On: April 21, 2003
//::///////////////////////////////////////////////
float CSLMetersToFeet(float fMeters) {
    return (fMeters/0.31);
}


int CSLGetMaxIntegerValue()
{
	return 2147483647;
}

//float SCGetMaxFloatValue()
//{
//	return 3.402823e38;
//}



//::///////////////////////////////////////////////
//:: Float Absolute Value
//::///////////////////////////////////////////////
/*
    Get the Absolute Value of a float without
    losing precision by using the included abs(int num)
    function.
*/
//::///////////////////////////////////////////////
//:: Created By: Karl Nickels (Syrus Greycloak)
//:: Created On: April 20, 2004
//::///////////////////////////////////////////////
float CSLAbsF(float fNum) {
    if(fNum<0.0) fNum = -fNum;
    return fNum;
}



float CSLACosH( float fValue )
{
    return log(fValue + sqrt(fValue*fValue-1));
}


float CSLASinH( float fValue )
{
    return log(fValue + sqrt(fValue*fValue+1));
}

float CSLATanH( float fValue )
{ 
    return 0.5 * log((1+fValue)/(1-fValue));
}


// GetIsDivisible
// little extra function :D 
// * n1 is the number that would be divided, n2 is the number to be divided by
// returns 1 (TRUE) or 0 (FALSE)
int CSLGetIsDivisible(int n1, int n2)
{
	// Probably redo this with a modulus function
	float f = IntToFloat(n1) / IntToFloat(n2);
	float f2 = IntToFloat(n1/n2);
	if ( f == f2 ) return 1;
	else return 0;
}


// * Formula for returning a weighted result based on a quadratic equation
// * Made for dealing with integers mainly
int CSLQuadratic( int iIn, float fA, float fB, float fC )
{
	// note that fA cannot be 0
	
	float fIn = IntToFloat( iIn );
	float fYout =  ( ( fA * pow( fIn, 2.0f) ) )  + ( fB * fIn ) + fC ;
	
	return FloatToInt( fYout );
}



// Private function - used in JXGetIsTargetTypeArea()
int CSLHexStringToInt(string hex)
{
	int dec = 0;

	// We don't care about the "0x" prefix
	hex = GetSubString(hex, 2, GetStringLength(hex) - 2);
	int len = GetStringLength(hex);

	int i;
	string digit;
	int multiplier;
	for (i = 0; i < len; i++)
	{
		digit = GetSubString(hex, i, 1);
		if (GetStringUpperCase(digit) == "A")
			multiplier = 10;
		else if (GetStringUpperCase(digit) == "B")
			multiplier = 11;
		else if (GetStringUpperCase(digit) == "C")
			multiplier = 12;
		else if (GetStringUpperCase(digit) == "D")
			multiplier = 13;
		else if (GetStringUpperCase(digit) == "E")
			multiplier = 14;
		else if (GetStringUpperCase(digit) == "F")
			multiplier = 15;
		else
			multiplier = StringToInt(digit);

		int j;
		int digitLoc = 1;
		for (j = 1; j < len -i; j++)
			digitLoc *= 16;
		dec += multiplier * digitLoc;
	}

	return dec;
}

/*
Note these are functions included in Nwscript.nss for mathematics
// math operations

// Maths operation: absolute value of fValue
float fabs(float fValue);

// Maths operation: cosine of fValue
float cos(float fValue);

// Maths operation: sine of fValue
float sin(float fValue);

// Maths operation: tan of fValue
float tan(float fValue);

// Maths operation: arccosine of fValue
// * Returns zero if fValue > 1 or fValue < -1
float acos(float fValue);

// Maths operation: arcsine of fValue
// * Returns zero if fValue >1 or fValue < -1
float asin(float fValue);

// Maths operation: arctan of fValue
float atan(float fValue);

// Maths operation: log of fValue
// * Returns zero if fValue <= zero
float log(float fValue);

// Maths operation: fValue is raised to the power of fExponent
// * Returns zero if fValue ==0 and fExponent <0
float pow(float fValue, float fExponent);

// Maths operation: square root of fValue
// * Returns zero if fValue <0
float sqrt(float fValue);

// Maths operation: integer absolute value of iIn
// * Return value on error: 0
int abs(int iIn);

// Convert nInteger to hex, returning the hex value as a string.
// * Return value has the format "0x????????" where each ? will be a hex digit
//   (8 digits in total).
string IntToHexString(int nInteger);



PHP Math functions - Candidates for potential implementation
acosh()	Returns the inverse hyperbolic cosine of a number	4

float acosh( float fValue )
{
    return log(fValue + sqrt(fValue*fValue-1));
}

asinh()	Returns the inverse hyperbolic sine of a number	4

function asinh(arg)
{
    return Math.log(arg + Math.sqrt(arg*arg+1));
}

atan2()	Returns the angle theta of an (x,y) point as a numeric value between -PI and PI radians	3
atanh()	Returns the inverse hyperbolic tangent of a number	4

function atanh(arg) {
    // http://kevin.vanzonneveld.net
    // +   original by: Onno Marsman
    // *     example 1: atanh(0.3);
    // *     returns 1: 0.3095196042031118
 
    return 0.5 * Math.log((1+arg)/(1-arg));
}

base_convert()	Converts a number from one base to another	3
bindec()	Converts a binary number to a decimal number	3
ceil()	Returns the value of a number rounded upwards to the nearest integer	3
cosh()	Returns the hyperbolic cosine of a number	4
decbin()	Converts a decimal number to a binary number	3
dechex()	Converts a decimal number to a hexadecimal number	3
decoct()	Converts a decimal number to an octal number	3
deg2rad()	Converts a degree to a radian number	3
exp()	Returns the value of Ex	3
expm1()	Returns the value of Ex - 1	4
floor()	Returns the value of a number rounded downwards to the nearest integer	3
fmod()	Returns the remainder (modulo) of the division of the arguments	4
getrandmax() Returns the maximum random number that can be returned by a call to the rand() function	3
hexdec()	Converts a hexadecimal number to a decimal number	3
hypot()	Returns the length of the hypotenuse of a right-angle triangle	4
is_finite()	Returns true if a value is a finite number	4
is_infinite()	Returns true if a value is an infinite number	4
is_nan()	Returns true if a value is not a number	4
lcg_value()	Returns a pseudo random number in the range of (0,1)	4
log10()	Returns the base-10 logarithm of a number	3
log1p()	Returns log(1+number)	4
mt_getrandmax()	Returns the largest possible value that can be returned by mt_rand()	3
mt_rand()	Returns a random integer using Mersenne Twister algorithm	3
mt_srand()	Seeds the Mersenne Twister random number generator	3
octdec()	Converts an octal number to a decimal number	3
pi()	Returns the value of PI	3
rad2deg()	Converts a radian number to a degree	3
rand()	Returns a random integer	3
round()	Rounds a number to the nearest integer	3
sinh()	Returns the hyperbolic sine of a number	4
srand()	Seeds the random number generator	3
tan()	Returns the tangent of an angle	3
tanh()	Returns the hyperbolic tangent of an angle	4


The following is in ginc_math
// ginc_math
// / *
//    Math related functions/
// * /
// ChazM 9/22/05
// ChazM 10/21/05 - added IsFloatNearInt()
// DBR - 2/13/06 - Adding optional parameter of precision to RandomFloat()
// BMA-OEI 5/4/06 - Added RandomFloatBetween(), RandomIntBetween()
// BMA/CGAW 5/18/06 - Updated RandomFloat(), RandomFloatBetween()
// ChazM 8/8/06 - Added SetLocalIntState(), GetLocalIntState(), SetState(), GetState()
// BMA-OEI 10/09/06 - Added GetHexStringDigitValue(), HexStringToInt()
// ChazM 1/10/07 - added include "x0_i0_position"; added GetRandom2DVector(); added optional param to GetNearbyLocation()

//void main() {}

#include "ginc_debug"
#include "x0_i0_position"
const float EPSILON	= 0.00001f;

//-------------------------------------------------
// Function Prototypes
//-------------------------------------------------
	
float RandomDelta(float fMagnitude);
float RandomFloat(float fNum);
float RandomFloatBetween( float fFloatA, float fFloatB=0.000f );
int RandomIntBetween( int nIntA, int nIntB=0 );
vector GetRandom2DVector(float fMaxMagnitude, float fMinMagnitude=0.0f);
location GetNearbyLocation(location lTarget, float fDistance, float fFacingNoise=0.0f, float fMinDistance=0.0);
//int IsIntInRange(int iVar, int iMin, int iMax);
int IsIntInRange(int iCheckValue, int iStartValue, int iEndValue);
int ScaleInt (int iNum, float fNum);
int IsFloatNearInt(float fValue, int iIn);

void SetLocalIntState(object oTarget, string sVariable, int iBitFlags, int bSet = TRUE);
int GetLocalIntState(object oTarget, string sVariable, int iBitFlags);
int SetState(int iIn, int iBitFlags, int bSet = TRUE);
int GetState(int iIn, int iBitFlags);

// Return ASCII value of hexadecimal digit sHexDigit
// * Returns -1 if sHexDigit is not a valid hex digit (0-aA)
int GetHexStringDigitValue( string sHexDigit );

// Return integer value of hexadecimal string sHexString
// * Can convert both "0x????" and "????" where "?" is a hex digit
int HexStringToInt( string sHexString );

int CompareVectors(vector v1, vector v2); //Checks if two vectors are equal.  Returns TRUE if so, FALSE if not.
int CompareVectors2D(vector v1, vector v2); //Checks if the X and Y coords of 2 vectors are equal. Ignores Z-axis.

//-------------------------------------------------
// Function Definitions
//-------------------------------------------------
	
// gives a random number between -fMagnitude and fMagnitude
// preserve 2 decimal places
float RandomDelta(float fMagnitude)
{
	float fRet = IntToFloat(Random(FloatToInt(fMagnitude * 100.0f)))/100.0f;
    if (d2()==1)
        fRet = -fRet;
	return (fRet);
}

// Returns a random float between fNum and 0. See RandomFloatBetween() for additional information.
float RandomFloat(float fNum)
{
	float fRet = RandomFloatBetween( fNum );
	return (fRet);
}

// Return a random float value between fFloatA and fFloatB
// NOTE: Maximum accuracy is produced when the difference between A and B is no more than:
// 32,767/10^N, where N = The number of contiguous digits to the right of the decimal point that are important.  
// For instance, if the float should be accurate for three decimal places: xx.000, then to have maximum
// accuracy, the difference between A and B shouldn't be more than 32,767/10^3, or 32.767.
float RandomFloatBetween( float fFloatA, float fFloatB=0.000f )
{
	float fLesserFloat;
	float fGreaterFloat;
	float fDifference;
	float fRandomFloat;
	float fMultiplier = IntToFloat( Random( 32767 ) ) / 32766.f;

	if ( fFloatA <= fFloatB )
	{
		fLesserFloat = fFloatA;
		fGreaterFloat = fFloatB;
	}
	else
	{
		fLesserFloat = fFloatB;
		fGreaterFloat = fFloatA;
	}

	fDifference = fGreaterFloat - fLesserFloat;
	fRandomFloat = ( fDifference * fMultiplier ) + fLesserFloat;

	return ( fRandomFloat );
}

// Return a random int value between nIntA and nIntB
int RandomIntBetween( int nIntA, int nIntB=0 )
{
	int nLesserInt;
	int nGreaterInt;
	int nDifference;
	int nRandomInt;

	if ( nIntA <= nIntB )
	{
		nLesserInt = nIntA;
		nGreaterInt = nIntB;
	}
	else
	{
		nLesserInt = nIntB;
		nGreaterInt = nIntA;
	}

	nDifference = nGreaterInt - nLesserInt;
	nRandomInt = Random( nDifference + 1 ) + nLesserInt;

	return ( nRandomInt );
}


// get a random vector within given Magnitude range
vector GetRandom2DVector(float fMaxMagnitude, float fMinMagnitude=0.0f)
{
	float fMagnitude = RandomFloatBetween(fMaxMagnitude, fMinMagnitude);
	float fAngle = RandomFloat(360.0f);
	
	float x = GetChangeInX(fMagnitude, fAngle);
	float y = GetChangeInY(fMagnitude, fAngle);
	return (Vector(x, y));
}

// get a location up to fDistance units from lTarget
// location lTarget - target location
// float fDistance - max random distance
// float fFacingNoise - angle from 0 to 180, max random change in facing from lTarget
// float fMinDistance - min random distance
location GetNearbyLocation(location lTarget, float fDistance, float fFacingNoise=0.0f, float fMinDistance=0.0)
{
    //vector vOld = GetPositionFromLocation(lTarget);
	//float x = RandomDelta(fDistance);
	//float y = RandomDelta(fDistance);
    //vector vNew = vOld + Vector(x, y);
	
    vector vOld = GetPositionFromLocation(lTarget);
	vector vNew = vOld + GetRandom2DVector(fDistance, fMinDistance);
	
	float fNewFacing = GetFacingFromLocation(lTarget) + RandomDelta(fFacingNoise);
	//if (fNewFacing < 0.0f) 
	//	fNewFacing = fNewFacing + 360.0f;
	//else if (fNewFacing > 360.0f) 
	//	fNewFacing = fNewFacing - 360.0f;	
	fNewFacing = GetNormalizedDirection(fNewFacing);
    location lNewLocation = Location (GetAreaFromLocation(lTarget), vNew, fNewFacing);

// / *
//	// this wouldn't work as it requires 2 points to define an angle.
//	float fMagnitude = RandomFloatBetween(fDistance, fMinDistance);
//	location lNewLocation = CalcPointAwayFromPoint(lTarget, lTarget, fMagnitude, 180.0f, TRUE);
// * /	
    return lNewLocation;
}


//int IsIntInRange(int iVar, int iMin, int iMax)	
//{
//	return((iVar >= iMin) && (iVar <= iMax));
//}
// checks if value is in specified range.  If StartValue is greater than EndValue,
// it is assumed the range requested wraps.
int IsIntInRange(int iCheckValue, int iStartValue, int iEndValue)
{
	int bRet = FALSE;
	
	if (iEndValue <= iStartValue) // wrapping range
	{
		if ((iCheckValue >= iStartValue) || (iCheckValue <= iEndValue))
			bRet = TRUE;
	}
	else // contiguous range
	{
		if ((iCheckValue >= iStartValue) && (iCheckValue <= iEndValue))
			bRet = TRUE;
	}
	
	return bRet;
}

// multiply int by float and return resulting int part	
int ScaleInt (int iNum, float fNum)	
{
	return (FloatToInt(IntToFloat(iNum) * fNum));
}

int IsFloatNearInt(float fValue, int iIn)
{
	//int iRet = FALSE;
	float fCompareValue = IntToFloat(iIn);
	if (fValue > fCompareValue + EPSILON)
		return (FALSE);

	if (fValue < fCompareValue - EPSILON)
		return (FALSE);
	
	return (TRUE);
}

// sets the bit flags on or off in the local int
void SetLocalIntState(object oTarget, string sVariable, int iBitFlags, int bSet = TRUE)
{
	int iIn = GetLocalInt(oTarget, sVariable);
	int iNewValue = SetState(iIn, iBitFlags, bSet);
	SetLocalInt(oTarget, sVariable, iNewValue);
}

// returns TRUE or FALSE 
// if multiple flags, will return true if any of iBitFlags are true.
int GetLocalIntState(object oTarget, string sVariable, int iBitFlags)
{
	int iIn = GetLocalInt(oTarget, sVariable);
	return (GetState(iIn, iBitFlags));
}

// sets state of iBitFlags in iIn and returns new value.
// if multiple flags, all will be modified
int SetState(int iIn, int iBitFlags, int bSet = TRUE)
{
    if(bSet == TRUE)
    {
        iIn = iIn | iBitFlags;
    }
    else if (bSet == FALSE)
    {
        iIn = iIn & ~iBitFlags;
    }
	return (iIn);
}

// returns state of iBitFlag in iIn.  
// if multiple flags, will return true if any are true.
int GetState(int iIn, int iBitFlags)
{
	return (iIn & iBitFlags);
}

// Return ASCII value of hexadecimal digit sHexDigit
// * Returns -1 if sHexDigit is not a valid hex digit (0-aA)
int GetHexStringDigitValue( string sHexDigit )
{
	int iIn = CharToASCII( sHexDigit );

	if ( ( iIn >= 48 ) && ( iIn <= 57 ) ) 		// 0-9 [0x30-0x39]
	{
		return ( iIn - 48 );
	}
	else if ( ( iIn >= 65 ) && ( iIn <= 70 ) )	// A-F [0x41-0x46]
	{
		return ( iIn - 55 );
	}
	else if ( ( iIn >= 97 ) && ( iIn <= 102 ) )	// a-f [0x61-0x66]
	{
		return ( iIn - 87 );
	}
	else
	{
		return ( -1 );
	}
}

// Return integer value of hexadecimal string sHexString
// * Can convert both "0x????" and "????" where "?" is a hex digit
int HexStringToInt( string sHexString )
{
	int nStringLen = GetStringLength( sHexString );
	int nReturn = 0;
	
	if ( nStringLen > 0 )
	{
		int nPos = 0;
		
		// Check for "0x" prefix
		if ( nStringLen >= 2 )
		{
			if ( GetSubString( sHexString, 0, 2 ) == "0x" )
			{
				nPos = 2;
			}
		}
		
		string sChar;
		int nChar;

		// For length of hex string
		while ( nPos < nStringLen )
		{
			// Get digit at position nPos
			sChar = GetSubString( sHexString, nPos, 1 );
			nChar = GetHexStringDigitValue( sChar );
			
			if ( nChar != -1 )
			{
				// "bitshift left 4", OR nChar
				nReturn = ( nReturn << 4 ) | nChar;
			}
			else
			{
				// Invalid hex digit found
				break;
			}
			
			nPos = nPos + 1;
		}
	}
	
	return ( nReturn );
}

int CompareVectors(vector v1, vector v2)
{
//	PrettyDebug ("v1:"+FloatToString(v1.x)+","+FloatToString(v1.y)+","+FloatToString(v1.z));
//	PrettyDebug ("v2:"+FloatToString(v2.x)+","+FloatToString(v2.y)+","+FloatToString(v2.z));
	if(v1.x != v2.x)
		return FALSE;
	
	else if(v1.y != v2.y)
		return FALSE;
	
	else if(v1.z != v2.z)
		return FALSE;
	
	else return TRUE;
}

int CompareVectors2D(vector v1, vector v2)
{
//	PrettyDebug ("v1:"+FloatToString(v1.x)+","+FloatToString(v1.y));
//	PrettyDebug ("v2:"+FloatToString(v2.x)+","+FloatToString(v2.y));
	
	if(v1.x != v2.x)
		return FALSE;
	
	else if(v1.y != v2.y)
		return FALSE;
		
	else return TRUE;
}


*/