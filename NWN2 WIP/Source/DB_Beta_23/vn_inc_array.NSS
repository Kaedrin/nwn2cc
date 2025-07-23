// inc_array - array API
// fast but no bounds / object checking.

//------------------------------------------------------------------------------
//                     Interface
//------------------------------------------------------------------------------

// Int
void SetArrayInt(object oObject, string sArray, int nIndex, int nValue);
int GetArrayInt(object oObject, string sArray, int nIndex);
void DeleteArrayInt(object oObject, string sArray, int nIndex);

// Float
void SetArrayFloat(object oObject, string sArray, int nIndex, float fValue);
float GetArrayFloat(object oObject, string sArray, int nIndex);
void DeleteArrayFloat(object oObject, string sArray, int nIndex);

// Location
void SetArrayLocation(object oObject, string sArray, int nIndex, location lLoc);
location GetArrayLocation(object oObject, string sArray, int nIndex);
void DeleteArrayLocation(object oObject, string sArray, int nIndex);

// String
void SetArrayString(object oObject, string sArray, int nIndex, string sString);
string GetArrayString(object oObject, string sArray, int nIndex);
void DeleteArrayString(object oObject, string sArray, int nIndex);

// Object
void SetArrayObject(object oObject, string sArray, int nIndex, object oObject);
object GetArrayObject(object oObject, string sArray, int nIndex);
void DeleteArrayObject(object oObject, string sArray, int nIndex);


//------------------------------------------------------------------------------
//                     Implementation
//------------------------------------------------------------------------------

// Int
void SetArrayInt(object oObject, string sArray, int nIndex, int nValue)
{
	SetLocalInt(oObject, sArray + IntToString(nIndex), nValue);
	
}

int GetArrayInt(object oObject, string sArray, int nIndex)
{
	return GetLocalInt(oObject, sArray + IntToString(nIndex));
}

void DeleteArrayInt(object oObject, string sArray, int nIndex)
{
	DeleteLocalInt(oObject, sArray + IntToString(nIndex));
}

// float
void SetArrayFloat(object oObject, string sArray, int nIndex, float fValue)
{
	SetLocalFloat(oObject, sArray + IntToString(nIndex), fValue);
	
}

float GetArrayFloat(object oObject, string sArray, int nIndex)
{
	return GetLocalFloat(oObject, sArray + IntToString(nIndex));
}

void DeleteArrayFloat(object oObject, string sArray, int nIndex)
{
	DeleteLocalFloat(oObject, sArray + IntToString(nIndex));
}


// Location
void SetArrayLocation(object oObject, string sArray, int nIndex, location lLoc)
{
	SetLocalLocation(oObject, sArray + IntToString(nIndex), lLoc);
}

location GetArrayLocation(object oObject, string sArray, int nIndex)
{
	return GetLocalLocation(oObject, sArray + IntToString(nIndex));
}

void DeleteArrayLocation(object oObject, string sArray, int nIndex)
{
	DeleteLocalLocation(oObject, sArray + IntToString(nIndex));
}

// String
void SetArrayString(object oObject, string sArray, int nIndex, string sString)
{
	SetLocalString(oObject, sArray + IntToString(nIndex), sString);
}

string GetArrayString(object oObject, string sArray, int nIndex)
{
	return GetLocalString(oObject, sArray + IntToString(nIndex));
}

void DeleteArrayString(object oObject, string sArray, int nIndex)
{
	DeleteLocalString(oObject, sArray + IntToString(nIndex));
}

// Object
void SetArrayObject(object oObject, string sArray, int nIndex, object oValue)
{
	SetLocalObject(oObject, sArray + IntToString(nIndex), oValue);
}

object GetArrayObject(object oObject, string sArray, int nIndex)
{
	return GetLocalObject(oObject, sArray + IntToString(nIndex));
}

void DeleteArrayObject(object oObject, string sArray, int nIndex)
{
	DeleteLocalObject(oObject, sArray + IntToString(nIndex));
}