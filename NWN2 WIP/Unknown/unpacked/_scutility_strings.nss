/*
These are the basic Utitlities
*/
/////////////////////////////////////////////////////
//////////////// Notes /////////////////////////////
////////////////////////////////////////////////////

/*
Note these are functions included in Nwscript.nss for strings, basically here for reference since these are the primary functions i can leverage in this library

int GetStringLength(string sString); // on error ""
string GetStringUpperCase(string sString); // on error ""
string GetStringLowerCase(string sString); // on error ""
string GetStringRight(string sString, int nCount); // on error ""
string GetStringLeft(string sString, int nCount); // on error ""
string InsertString(string sDestination, string sString, int nPosition); // on error ""
string GetSubString(string sString, int nStart, int nCount); // on error ""
int FindSubString(string sString, string sSubString, int nStart = 0); // on error -1
string GetMatchedSubstring(int nString); // Dialogs
int GetMatchedSubstringsCount(); // Dialogs
string GetStringByStrRef(int nStrRef, int nGender=GENDER_MALE);
string RandomName();
int CharToASCII( string sString );


int StringCompare( string sString1, string sString2, int nCaseSensitive=FALSE ); 
	//A simple C-Style string compare
	//Returns 0 if the strings are the same
	//Returns a negative value if string 1 is less than string 2
	//Returns a positive value if string 1 is greater than string 2


int TestStringAgainstPattern(string sPattern, string sStringToTest); // on error FALSE
	Parameters
	sPattern
	A string that represents the pattern to look for (for details look at the Remarks section).
	sStringToTest
	The string that will be checked for the pattern.
	
	Description
	Returns TRUE if sStringToTest matches sPattern, otherwise FALSE.
	
	From Noel (Bioware): 
	** will match zero or more characters  and ** then a / then a ** may crash everything ( it did in NWN1 )
	*w one or more whitespace 
	*n one or more numeric 
	*p one or more punctuation 
	*a one or more alphabetic 
	| is or 
	( and ) can be used for blocks 
	
	- setting a creature to listen for "**" will match any string 
	- telling him to listen for "**funk**" will match any string that contains the word "funk". 
	- "**(bash|open|unlock)**(chest|door)" will match strings like "open the door please" or "he just bashed that chest!" 
	
	Known Bugs
	Do not test for this: 
	
	// if (TestStringAgainstPattern("** /**", ANY STRING)) 
	
	It will hang the Toolset, forcing you to shut it down by external means. And if you then reopen the Toolset, say that you want to restore the unsaved module, and go to edit that script, it will hang your Toolset once again. BioWare has been informed of this. 
	
	Both "/**" and "** /" are okay, though, it's just the "** /**" that should be avoided. <--btm: note that i added spaces since it was messing up my comment, there is no space before the slash
*/


/////////////////////////////////////////////////////
///////////////// DESCRIPTION ///////////////////////
/////////////////////////////////////////////////////


/////////////////////////////////////////////////////
///////////////// Constants /////////////////////////
/////////////////////////////////////////////////////

const string SC_CHAR_BREAK = "\n";

const int SC_ASCIITYPE_INVALID = -1;
const int SC_ASCIITYPE_CONTROL = 0;
const int SC_ASCIITYPE_TAB = 1;
const int SC_ASCIITYPE_RETURN = 2;
const int SC_ASCIITYPE_SPACE = 3;
const int SC_ASCIITYPE_PUNCTUATION = 4;
const int SC_ASCIITYPE_QUOTE = 5;
const int SC_ASCIITYPE_SEPARATOR = 6;
const int SC_ASCIITYPE_EXTENDED = 7;
const int SC_ASCIITYPE_NUMBER = 8;
const int SC_ASCIITYPE_LOWERCASE = 9;
const int SC_ASCIITYPE_UPPERCASE = 10;



/////////////////////////////////////////////////////
//////////////// Includes ///////////////////////////
/////////////////////////////////////////////////////

// need to review these
//#include "_SCUtilityConstants"
// not sure on this one, but might be useful
//#include "_SCSpell_Include_MetaConstants"


/////////////////////////////////////////////////////
//////////////// Prototypes /////////////////////////
/////////////////////////////////////////////////////

//////////////// Capitalization /////////////////////

// String Library

string CSLInitCap(string sIn);

// * takes a single character, and if it's a space or punctuation it returns a space, otherwise it returns the character, used in strProper soas to ignore
string CSLStringToProper_ReturnSpaces( string sIn, string sPrevIn = " " );

// * Takes a given string and makes it proper case, accounting for exceptions like DM, PC, McGnome and for Apostrophe's ( O'Reilly for example )
string CSLStringToProper( string sIn );

//////////////// Language /////////////////////
// String Library

// * appends an S to the end of a string
string CSLAddS(string sIn, int iIn, string sS = "s");

// * appends an and to the end of a string
string CSLAddAnd(string sIn);

// * returns one of the provided strings based on the sex of oPC
string CSLSexString(object oPC, string sMale, string sFemale);

//////////////// Reordering Characters /////////////////////

// * Randomly sorts the letters in the string --> hello becomes  olelh
string CSLStringShuffle ( string sIn );

// * Reverses the letters in the string --> hello becomes olleh
string CSLStringReverse( string sIn );

//////////////// Padding and Trimming /////////////////////

// * Trims leading and trailing spaces, removing them from the string, note that the sPadChar is used to remove other characters besides spaces
string CSLTrim( string sIn, string sPadChar = " " );

// * Trims leading spaces, removing them from the string, note that the sPadChar is used to remove other characters besides spaces
string CSLTrimLeft( string sIn, string sPadChar = " " );

// * Trims trailing spaces, removing them from the string, note that the sPadChar is used to remove other characters besides spaces
string CSLTrimRight( string sIn, string sPadChar = " " );

// * Repeats a given string by the given amount, makes a "0" into "0000" for example if sIn is 0 and iRepeatCount is 4
string CSLStringRepeat( string sIn, int iRepeatCount );

// * Makes a string a given length, adding sPadChar to the left until the total length is the given length, if it is already longer it does nothing
string CSLPadLeft( string sIn, int iLength, string sPadChar = " ");

// * Makes a string a given length, adding sPadChar to the right until the total length is the given length, if it is already longer it does nothing
string CSLPadRight( string sIn, int iLength, string sPadChar = " ");

// * Makes a string a given length, adding sPadChar to the left and right until the total length is the given length with the original text centered, if it is already longer it does nothing
string CSLPadBoth( string sIn, int iLength, string sPadChar = " ");

//////////////// Splicing and Splitting /////////////////////

// * Inserts sGlue Every Given Number of characters, can make HELLO into "H E L L O" or into "HE, LL, 0" or into "H-E-L-L-0"
string CSLStringSplit( string sIn, int iLength = 1, string sGlue = "," );

// OEI Based Remove part of a string beginning at nIndex.  nIndex is a zero based index into the string.
// example:
// SpliceString("Hello, 1, 3) returns "Ho"
string CSLStringSplice(string sString, int nIndex, int nCount);

//////////////// Finding and Replacing /////////////////////

//Using the new string array simulator, this function cycles through a
//full length string counting every time it reaches the searched string
//This is like FindSubString except it counts the total instead of returning
//the first.
//sFull - The string that contains all the information.
//sLookFor - The substring we're looking for, each instance of this is counted once.
//Created by: DragonWR12LB
int CSLStringGetSubStringCount(string sFull, string sLookFor);

// No longer needed thanks to grinning fool
// Find the position of sSubstring inside sString, adds in missing parameter from NWN1 so only use if you need that.
// * Return value on error: -1
//int CSLFindSubString(string sString, string sSubString, int iVal );

// OEI Based Replace first instance of sMatch in sString with sReplace
string CSLReplaceSubString(string sString, string sMatch, string sReplace);

// OEI Based Replace all instances of sMatch in sString with sReplace (from left to right);
string CSLReplaceAllSubStrings(string sString, string sMatch, string sReplace);

// * Changes all instances of sMatch character with sReplace, note that this is for single characters only
string CSLStringSwapChars(string sString, string sMatchChar, string sReplaceChar);

// * This swaps out the given character with another character
// * But the given character and the replaced character actually can be multiple
// * ie  CSLStringTranslateChars( "Hello World", "eol", "301" ) will return "H3110 W0rld", note that it is not case sensitive
// * this is probably something better used on small strings
string CSLStringTranslateChars(string sString, string sMatchList, string sReplaceList);

int CSLStringStartsWith(string sIn, string sMatch, int bCaseSensitive = TRUE );

// DMFI did this
string CSLRemovePrefix(string sIn, string sPrefix);

// Lilac Soul
string CSLGetIllegalCharacterFreeString(string sString, string sIllegalCharacters=" ");

// Lilac Soul
string CSLGetLegalCharacterString(string sString, string sLegalCharacters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");

//////////////// Lists /////////////////////
string CSLDelimList(string s1="", string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="");



// based on realbasic
//string SCNthField( string sIn, string sDelimiter, int iOccurance );

// based on realbasic
//string SCCountFields( string sIn, string sDelimiter );


// CSLColorText(sString, int nColor);							FILE: dmfi_inc_sendtex
// This function will make sString be the specified color as specified in nColor.  
// Obsidian's COLOR constants are all included.  Hex valus for colors are available
// in nwn2_colors.2da
string CSLColorText(string sString, int nColor);

// need to rework this, soas to use NWNX on a server, and string functions when not
string CSLInQs(string sIn);

//////////////// ASCII /////////////////////

// * Returns a space on an error, does not deal with " very well yet, this probably is not very efficient, focuses on manual ascii operations
string CSLASCIIToChar( int iIn );

// this figures out what category a character is, note that a made more categories soas to support the "strproper" function
int CSLGetCharASCIIType( string sIn );

//////////////// Other /////////////////////

// * Takes a given block of text, and drops in line breaks at a given width, but will respect words
// Very simple at first, will add more sophisticated exceptions later
string CSLWordWrap( string sIn, int iWidth, string sBreakChar = SC_CHAR_BREAK );

string CSLFormatFloat(float fVal, int iDec=2);
string CSLAppendLocalString(object oObj, string sVar, string sIn);
int CSLGetIsNumber(string sWord);

// Delimiter Type Functions

string CSLStringBefore(string sIn, string sDelimiter=".");
string CSLRemoveParsed(string sIn,string sParsed,string sDelimiter=".");

// GetWord
/*
example:
GetWord("VFX_IMP_ACID", 3, "_");
returns "ACID"
another example:
GetWord("Hello, it's nice to see you again!", 5, " ");
returns "see"
*/
//string CSLGetNthString(string sIn, int iOccurance, string sDelimiter=",");

// Array Type Functions







/////////////////////////////////////////////////////
//////////////// Implementation /////////////////////
/////////////////////////////////////////////////////

//////////////// Capitalization /////////////////////
string CSLInitCap(string sIn)
{
	return GetStringUpperCase(GetStringLeft(sIn,1)) + GetStringLowerCase(GetStringRight(sIn, GetStringLength(sIn)-1));
}

// * takes a single character, and if it's a space or punctuation it returns a space, otherwise it returns the character, used in strProper soas to ignore
string CSLStringToProper_ReturnSpaces( string sIn, string sPrevIn = " " )
{
	if ( sIn == "" || sIn == " " )
	{
		return " "; 
	}
	
	int iType = CSLGetCharASCIIType(sIn);
	
	if ( iType >= SC_ASCIITYPE_EXTENDED ) // all letters, digits and things i don't know about
	{
		return sIn;
	}
	else if ( iType >= SC_ASCIITYPE_QUOTE ) // quotes and things like dashes, which can be in middle of a word ( like Don't and Super-charge ) but are spaces if not
	{
		if ( sPrevIn == " " )
		{
			return " ";
		}
		else
		{
			return "'";
		}
	}
	else // treat everything else like a space, since if it precedes a character, it will work
	{
		return " ";
	}
	return sIn;
}


string CSLStringToProper( string sIn )
{
	string sOut;
	string sLower = GetStringLowerCase( sIn );
	
	// start them all out as spaces, these are so the function can look forward and back
	string sPrePrePreChar = " ";
	string sPrePreChar = " ";
	string sPreChar = " ";
	string sChar = " ";
	string sPostChar = " ";	
	
	sChar = CSLStringToProper_ReturnSpaces(GetStringLowerCase( GetSubString(sIn, 0, 1) ) );
	
	int iCount;
	int iLength = GetStringLength( sIn );
	for ( iCount = 0; iCount < iLength; iCount++)
	{
		sPostChar = CSLStringToProper_ReturnSpaces( GetStringLowerCase( GetSubString(sIn, iCount+1, 1) ), sChar );
		
		if ( sChar == " " )
		{
			sChar = " "; 
		}
		// it's uppper, previous space or a McNelly type of name
		else if ( sPreChar == " " || ( sPrePrePreChar == " " && sPrePreChar == "m" &&  sPreChar  =="c" ) )
		{
			sOut += GetStringUpperCase( GetSubString( sIn, iCount, 1) );
		} 
		// next look for DM and PC and other 2 letter abbreviations
		else if (
				sPrePreChar == " " &&  sPostChar == " "   && 
				( sPreChar == "d" && sChar == "m" ) || ( sPreChar == "p" && sChar == "c" )
				) 
		{
			sOut += GetStringUpperCase( GetSubString(sIn, iCount, 1) );
		}
		else
		{
			//Legal character, add to sOutPut
			sOut += GetSubString(sIn, iCount, 1);
		}
		
		// offset the previous characters, this is how we iterate the string
		sPrePrePreChar = sPrePreChar;
		sPrePreChar = sPreChar;
		sPreChar = sChar;
		sChar = sPostChar;
	}
	return sOut;
}


//////////////// Language /////////////////////

string CSLAddS(string sIn, int iIn, string sS = "s")
{
	if (iIn==1) return sIn;
	return sIn + sS;
}

string CSLAddAnd(string sIn)
{
   if (sIn!="") sIn += " and ";
   return sIn;
}

string CSLSexString(object oPC, string sMale, string sFemale)
{
   return ( GetGender(oPC)==GENDER_FEMALE ) ? sFemale : sMale;
}

//////////////// Reordering Characters /////////////////////

// * Randomly sorts the letters in the string
string CSLStringShuffle ( string sIn )
{
	if (sIn == "")
	{
		return "";
	}
	
	string sOut = "";
	int iRand = 0;
	
	while ( GetStringLength( sIn ) )
	{
		iRand = Random( GetStringLength( sIn ) - 1 );
		sOut += GetSubString( sIn, iRand, 1);
		
		sIn =  GetStringLeft( sIn, iRand )+ GetStringRight( sIn, GetStringLength( sIn )-(iRand+1) );
	}
	
	return sOut;
}

// * Reverses the letters in the string
string CSLStringReverse( string sIn )
{
    string sOut = "";
    int iCounter;

    for ( iCounter = GetStringLength( sIn ); iCounter >= 0; iCounter-- )
    {
       sOut += GetSubString(sIn, iCounter, 1);;
    }

    return sOut;
}

//////////////// Padding and Trimming /////////////////////

string CSLTrim( string sIn, string sPadChar = " " )
{
	// make sure sPadChar is good
	if ( sPadChar == "") { return sIn; }
	else if ( GetStringLength( sPadChar ) > 1 ) { sPadChar = GetStringLeft( sPadChar, 1 ); }

	int iLen = GetStringLength(sIn);
	while (iLen > 0)
	{
		if ( GetStringRight(sIn,1)==sPadChar )
		{
			sIn = GetStringLeft(sIn, iLen - 1);
		}
		else if ( GetStringLeft(sIn,1)==sPadChar )
		{
			sIn = GetStringRight(sIn, iLen - 1);
		}
		else
		{
			break;
		}
		iLen = iLen - 1;
	}
	return sIn;
}



/*********************************************************************/
/*********************************************************************/
// written by caos as part of dm inventory system, integrating
//string GetTrimmedString(string sValue, int iMaxLength = 17) 
string CSLTruncate(string sIn, int iMaxLength = 17, string sTruncateSymbol = "..." ) 
{
	if (GetStringLength(sIn) > iMaxLength)
	{
		sIn = GetStringLeft(sIn, iMaxLength - 1) + sTruncateSymbol;
	}
	
	return sIn;
}



string CSLTrimLeft( string sIn, string sPadChar = " " )
{
	// make sure sPadChar is good
	if ( sPadChar == "") { return sIn; }
	else if ( GetStringLength( sPadChar ) > 1 ) { sPadChar = GetStringLeft( sPadChar, 1 ); }

	while ( GetStringLeft( sIn, 1 ) == sPadChar)
	{
		sIn = GetStringRight( sIn, GetStringLength( sIn )-1 );
	}
	
	return sIn;
}


string CSLTrimRight( string sIn, string sPadChar = " " )
{
	// make sure sPadChar is good
	if ( sPadChar == "") { return sIn; }
	else if ( GetStringLength( sPadChar ) > 1 ) { sPadChar = GetStringLeft( sPadChar, 1 ); }

	while ( GetStringRight( sIn, 1 ) == sPadChar)
	{
		sIn = GetStringLeft( sIn, GetStringLength( sIn )-1 );
	}
	
	return sIn;
}


// * Repeats a given string by the given amount, makes a "0" into "0000" for example
string CSLStringRepeat( string sIn, int iRepeatCount )
{
	string sOut = "";
    int iCounter;

    for ( iCounter = 0; iCounter <= iRepeatCount; iCounter++ )
    {
       sOut += sIn;
    }
    return sOut;
}



//Returns A such that GetStringLength(A)=B by appending sPadChar
string CSLPadLeft( string sIn, int iLength, string sPadChar = " ")
{
	if ( sPadChar == "")
	{
		return sIn;
	}
	else if ( GetStringLength( sPadChar ) > 1 )
	{
		sPadChar = GetStringLeft( sPadChar, 1 );
	}
	
	int iLenIn = GetStringLength( sIn );
	if ( iLenIn > iLength )
	{
		sIn = CSLTrimLeft( sIn, sPadChar );
	}
	
	// need to start of since it might of been padding that just got removed
	iLenIn = GetStringLength( sIn );
	
	if ( iLenIn < iLength )
	{
		int iPadLength = iLength - iLenIn;
		sIn = sIn + CSLStringRepeat( sPadChar, iPadLength );
		// sIn = GetStringRight( sIn, iLength );
	}
	return sIn;
}


//Returns A such that GetStringLength(A)=B by appending sPadChar
string CSLPadRight( string sIn, int iLength, string sPadChar = " ")
{
	if ( sPadChar == "")
	{
		return sIn;
	}
	else if ( GetStringLength( sPadChar ) > 1 )
	{
		sPadChar = GetStringRight( sPadChar, 1 );
	}
	
	int iLenIn = GetStringLength( sIn );
	if ( iLenIn > iLength )
	{
		sIn = CSLTrimRight( sIn, sPadChar );
	}
	
	// need to start of since it might of been padding that just got removed
	iLenIn = GetStringLength( sIn );
	if ( iLenIn < iLength )
	{
		int iPadLength = iLength - iLenIn;
		sIn =  CSLStringRepeat( sPadChar, iPadLength ) + sIn;
		// sIn = GetStringLeft( sIn, iLength );
	}
	return sIn;
}




//Returns A such that GetStringLength(A)=B by appending sPadChar
string CSLPadBoth( string sIn, int iLength, string sPadChar = " ")
{
	if ( sPadChar == "")
	{
		return sIn;
	}
	else if ( GetStringLength( sPadChar ) > 1 )
	{
		sPadChar = GetStringRight( sPadChar, 1 );
	}
	
	int iLenIn = GetStringLength( sIn );
	if ( iLenIn > iLength )
	{
		sIn = CSLTrimLeft( sIn, sPadChar );
	}
	
	// need to start of since it might of been padding that just got removed
	iLenIn = GetStringLength( sIn );
	if ( iLenIn < iLength )
	{
		int iPadLength = ( iLength - iLenIn );
		iPadLength = ( iPadLength % 2 ) ? (iPadLength/2) : ( (iPadLength/2) + 1 ) ; // that does the equivalent of a ceil function
		string sPadding = CSLStringRepeat( sPadChar, iPadLength );
		sIn =  sPadding + sIn + sPadding;
		sIn = GetStringLeft( sIn, iLength ); // catch any errors
	}
	return sIn;
}

//////////////// Splicing and Splitting /////////////////////
// example:
// CSLStringSplit("Hello, 1, "-") returns "H-e-l-l-o"
string CSLStringSplit( string sIn, int iLength = 1, string sGlue = "," )
{
    if( iLength > 0)
    {
        string sOut = "";
        while( GetStringLength( sIn ) > iLength )
        {
            if ( sOut != "" )
			{
				sOut += sGlue;
			}
			sOut += GetStringLeft( sIn, iLength );
			sIn = GetStringRight( sIn, GetStringLength( sIn )-iLength );
        }
        return sOut;
    }
    return sIn;
}


// OEI Based Remove part of a string beginning at nIndex.  nIndex is a zero based index into the string.
// example:
// SpliceString("Hello, 1, 3) returns "Ho"
string CSLStringSplice(string sString, int nIndex, int nCount)
{
	int nStringLeftLength = nIndex; // These are equal because we want to not include where we are pointing to on the left side.
	int nStringRightLength = GetStringLength(sString) - nCount - nStringLeftLength;
	sString = GetStringLeft(sString, nStringLeftLength) + GetStringRight(sString, nStringRightLength);
	return (sString);
}


//////////////// Finding and Replacing /////////////////////

//Using the new string array simulator, this function cycles through a
//full length string counting every time it reaches the searched string
//This is like FindSubString except it counts the total instead of returning
//the first.
//sFull - The string that contains all the information.
//sLookFor - The substring we're looking for, each instance of this is counted once.
//Created by: DragonWR12LB
int CSLStringGetSubStringCount(string sFull, string sLookFor)
{
	int iLength = GetStringLength(sFull);
	int i,iLocate,iTotal;
	while(i<iLength)
	{
		iLocate = FindSubString(sFull, sLookFor, i);
		//No more found.
		if(iLocate == -1)
		{
			i += iLength;
			//Match IS found.
		}
		else
		{
			//Save the count.
			iTotal++;
			//Tack that distance onto the loop so we don't check it again.
			i = (iLocate+1);
		}
	}
	//Created by: DragonWR12LB
	return iTotal;
}

// No longer needed thanks to grinning fool
// Find the position of sSubstring inside sString, adds in missing parameter from NWN1 so only use if you need that.
// * Return value on error: -1
//int CSLFindSubString(string sString, string sSubString, int iVal )
//{
//	return FindSubString( GetStringRight(sString, GetStringLength(sString)-iVal ), sSubString );
//}



// OEI Based Replace first instance of sMatch in sString with sReplace
// same as JXStringReplace exactly
string CSLReplaceSubString(string sString, string sMatch, string sReplace)
{
	int nPosition = FindSubString(sString, sMatch);
	if (nPosition != -1)
	{
		int nStringLeftLength = nPosition+1;
		int nStringRightLength = GetStringLength(sString) - GetStringLength(sMatch) - nStringLeftLength;
		sString = GetStringLeft(sString, nStringLeftLength) + sReplace + GetStringRight(sString, nStringRightLength);
	}
	return (sString);
}


// Replace a token by the specified value in a source string, and returns the result.
// If the source string contains many occurences of the token, all occurences are replaced.
// - sSource String that contains the substrings to replace
// - iCustomTokenNumber Token number (from 0 to 9999)
// - sTokenValue Value for the token
// * Returns the modified source string
// same as JXStringReplaceToken
string CSLStringReplaceToken(string sSource, int iCustomTokenNumber, string sTokenValue, string sTokenName = "CUSTOM")
{
	string sToken = "<" + sTokenName + IntToString(iCustomTokenNumber) + ">";

	return CSLReplaceSubString(sSource, sToken, sTokenValue);
}



// OEI Based Replace all instances of sMatch in sString with sReplace (from left to right)
string CSLReplaceAllSubStrings(string sString, string sMatch, string sReplace)
{
	string sSearchString = sString;
	string sWorkingString = "";
	int nMatchLength = GetStringLength(sMatch);
	int nStringLeftLength;
	int nStringRightLength;
	
	int nSSPosition = FindSubString(sSearchString, sMatch);
	while (nSSPosition != -1)
	{
		nStringLeftLength = nSSPosition + nMatchLength; // number of chars up to replacement
		nStringRightLength = GetStringLength(sSearchString) - nStringLeftLength;
		
		sWorkingString = GetStringLeft(sSearchString, nStringLeftLength);
		sSearchString = GetStringRight(sSearchString, nStringRightLength);
		
		sWorkingString += GetStringLeft(sWorkingString, nSSPosition + 1) + sReplace;
		nSSPosition = FindSubString(sSearchString, sMatch);
	}
	// all matches replaced, now tack on remaining right part of string.
	sWorkingString += sSearchString;
	
	return (sWorkingString);
}


// * Changes all instances of sMatch character with sReplace, note that this is for single characters only
string CSLStringSwapChars(string sString, string sMatchChar, string sReplaceChar)
{
	int n=0;
	string sLetter, sFinal;
	
	sLetter = GetSubString(sString, n, 1);
	while ( sLetter!="" )
	{
		if (sLetter==sMatchChar)	
		{
			sFinal = sFinal + sReplaceChar;
		}
		else
		{
			sFinal = sFinal + sLetter;
		}
		n++;
		sLetter = GetSubString(sString, n, 1);
	}
	return sFinal;
}


// * This swaps out the given character with another character
// * But the given character and the replaced character actually can be multiple
// * ie  CSLStringTranslateChars( "Hello World", "eol", "301" ) will return "H3110 W0rld", note that it is not case sensitive
// * this is probably something better used on small strings
string CSLStringTranslateChars(string sString, string sMatchList, string sReplaceList)
{
	int n=0;
	string sLetter, sFinal;
	
	sLetter = GetSubString(sString, n, 1);
	while ( sLetter!="" )
	{
		int iPosition = FindSubString(sMatchList, sLetter);
		if ( iPosition > -1 )	
		{
			sFinal = sFinal + GetSubString( sReplaceList, iPosition, 1 );
		}
		else
		{
			sFinal = sFinal + sLetter;
		}
		n++;
		sLetter = GetSubString(sString, n, 1);
	}
	return sFinal;
}



int CSLStringStartsWith(string sIn, string sMatch, int bCaseSensitive = TRUE )
{
	if ( ! bCaseSensitive ) // this means its not case sensitive
	{
		return (GetStringLowerCase(GetStringLeft(sIn, GetStringLength(sMatch)))==GetStringLowerCase(sMatch));
	}	
	return (GetStringLeft(sIn, GetStringLength(sMatch))==sMatch);
}

// DMFI did this
string CSLRemovePrefix(string sIn, string sPrefix)
{ // PURPOSE: Removes sPrefix from sIn and returns the result
  // Original Scripter: Demetrious
  // Last Modified By: Demetrious  6/26/6
  string sReturn;
  int nLength = GetStringLength(sIn);
  int nPrefixLength = GetStringLength(sPrefix);
  sReturn = GetStringRight(sIn, nLength - nPrefixLength);

  return sReturn;
}

//  Lilac Soul wrote this long time ago
string CSLGetIllegalCharacterFreeString(string sString, string sIllegalCharacters=" ")
{
	string sOutPut, sChar;
	int nCount;
	for (nCount=0; nCount < GetStringLength(sString); nCount++)
	{
		//Is this a legal character?
		sChar=GetSubString(sString, nCount, 1);
		if ( !TestStringAgainstPattern("**"+sChar+"**", sIllegalCharacters) )
		//Legal character, add to sOutPut
		sOutPut=sOutPut+sChar;
	}
	return sOutPut;
}

//  Lilac Soul wrote this long time ago
string CSLGetLegalCharacterString(string sString, string sLegalCharacters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
{
	string sOutPut, sChar;
	int nCount;
	for (nCount=0; nCount<GetStringLength(sString); nCount++)
	{
		//Is this a legal character?
		sChar=GetSubString(sString, nCount, 1);
		if (TestStringAgainstPattern("**"+sChar+"**", sLegalCharacters))
		{
			//Legal character, add to sOutPut
			sOutPut=sOutPut+sChar;
		}
	}
	return sOutPut;
}

int CSLGetIsSpam(string sText)
{
   if(TestStringAgainstPattern("**http:**|**www.**|**.*a.**|*n.*n.*n.*n", sText)) return TRUE;
   return FALSE;
}

//////////////// Lists /////////////////////




// need to rework this, soas to use NWNX on a server, and string functions when not
string CSLInQs(string sIn)
{ // Encodes Special Chars and Encloses a string in Single Quotes
	
	return "'" + NWNXGetString("SQL", "GET ESCAPE STRING", sIn, 0) + "'";
	//return "'" + SQLEncodeSpecialChars(sIn) + "'";
	return "'" + sIn + "'";
}

string CSL_QUOTE = "";

// * requires custom waypoint object to make this work universally until someone shows me a better way
string CSLGetQuote()
{
	//string sQuote = CSL_QUOTE;
	if ( CSL_QUOTE == "" )
	{
		string sQuote;
		sQuote = GetLocalString( GetModule(), "CSL_QUOTE" );
		if ( sQuote == "" )
		{
			object oQuoteHolder = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypointquote", GetStartingLocation(), FALSE, "nw_waypointquote"); 
			sQuote = GetLocalString( oQuoteHolder, "QUOTE" );
			DestroyObject(oQuoteHolder, 0.0f, FALSE);

			SetLocalString(GetModule(), "CSL_QUOTE", sQuote );
		}	
		CSL_QUOTE = sQuote; // cache this for later use in the same script
		return sQuote;
	}
	return CSL_QUOTE;
}

//////////////// ASCII /////////////////////

// * Returns a space on an error, does not deal with " very well yet, this probably is not very efficient, focuses on manual ascii operations
string CSLASCIIToChar( int iIn )
{
	int iSubIn = iIn / 10;
	
	switch ( iSubIn )
	{
		case 3:
		switch ( iIn )
		{
			case 33: return "!"; break;
			case 34: return CSLGetQuote(); break; // this is a ", not sure how to do it yet "/"" won't compile, might have to pull it from a tlk value
			case 35: return "#"; break;
			case 36: return "$"; break;
			case 37: return "%"; break;
			case 38: return "&"; break;
			case 39: return "'"; break;
		}
		break;
		
		case 4:
		switch ( iIn )
		{
			case 40: return "("; break;
			case 41: return ")"; break;
			case 42: return "*"; break;
			case 43: return "+"; break;
			case 44: return ","; break;
			case 45: return "-"; break;
			case 46: return "."; break;
			case 47: return "/"; break;
			case 48: return "0"; break;
			case 49: return "1"; break;
		}
		break;
		
		case 5:
		switch ( iIn )
		{
			case 50: return "2"; break;
			case 51: return "3"; break;
			case 52: return "4"; break;
			case 53: return "5"; break;
			case 54: return "6"; break;
			case 55: return "7"; break;
			case 56: return "8"; break;
			case 57: return "9"; break;
			case 58: return ":"; break;
			case 59: return ";"; break;
			case 60: return "<"; break;
		}
		break;
		
		case 6:
		switch ( iIn )
		{
			case 61: return "="; break;
			case 62: return ">"; break;
			case 63: return "?"; break;
			case 64: return "@"; break;
			case 65: return "A"; break;
			case 66: return "B"; break;
			case 67: return "C"; break;
			case 68: return "D"; break;
			case 69: return "E"; break;
			case 70: return "F"; break;
		}
		break;
		
		case 7:
		switch ( iIn )
		{
			case 71: return "G"; break;
			case 72: return "H"; break;
			case 73: return "I"; break;
			case 74: return "J"; break;
			case 75: return "K"; break;
			case 76: return "L"; break;
			case 77: return "M"; break;
			case 78: return "N"; break;
			case 79: return "O"; break;
			case 80: return "P"; break;
		}
		break;
		
		case 8:
		switch ( iIn )
		{
			case 81: return "Q"; break;
			case 82: return "R"; break;
			case 83: return "S"; break;
			case 84: return "T"; break;
			case 85: return "U"; break;
			case 86: return "V"; break;
			case 87: return "W"; break;
			case 88: return "X"; break;
			case 89: return "Y"; break;
			case 90: return "Z"; break;
		}
		break;
		
		case 9:
		switch ( iIn )
		{
			case 91: return "["; break;
			case 92: return "\\"; break; // not sure if this will work, but hopefully it will, this is an escape character
			case 93: return "]"; break;
			case 94: return "^"; break;
			case 95: return "_"; break;
			case 96: return "`"; break;
			case 97: return "a"; break;
			case 98: return "b"; break;
			case 99: return "c"; break;
			case 100: return "d"; break;
		}
		break;
		
		case 10:
		switch ( iIn )
		{
			case 101: return "e"; break;
			case 102: return "f"; break;
			case 103: return "g"; break;
			case 104: return "h"; break;
			case 105: return "i"; break;
			case 106: return "j"; break;
			case 107: return "k"; break;
			case 108: return "l"; break;
			case 109: return "m"; break;
			case 110: return "n"; break;
		}
		break;
		
		case 11:
		switch ( iIn )
		{
			case 111: return "o"; break;
			case 112: return "p"; break;
			case 113: return "q"; break;
			case 114: return "r"; break;
			case 115: return "s"; break;
			case 116: return "t"; break;
			case 117: return "u"; break;
			case 118: return "v"; break;
			case 119: return "w"; break;
			case 120: return "x"; break;
		}
		break;
		
		case 12:
		switch ( iIn )
		{
			case 121: return "y"; break;
			case 122: return "z"; break;
			case 123: return "{"; break;
			case 124: return "|"; break;
			case 125: return "}"; break;
			case 126: return "~"; break;
		}
	}
	return " ";
}



// this figures out what category a character is, note that a made more categories soas to support the "strproper" function
int CSLGetCharASCIIType( string sIn )
{
	int iDecValue = CharToASCII(sIn);
	if ( iDecValue == 9 ) // "\t" if that even exists in game
	{
		return SC_ASCIITYPE_TAB;
	}
	else if ( iDecValue == 10 || iDecValue == 13 ) // for "\n"
	{
		return SC_ASCIITYPE_RETURN;
	}
	else if ( iDecValue == 32 ) // " "
	{
		return SC_ASCIITYPE_SPACE;
	}
	else if ( iDecValue > 127 && iDecValue < 256 ) // all that foreign stuff, need to make this more accurate to deal with tilde's and the like, this is based on font/encoding
	{
		return SC_ASCIITYPE_EXTENDED;
	}
	else if ( iDecValue >= 65 && iDecValue <= 90 ) // a-z
	{
		return SC_ASCIITYPE_LOWERCASE;
	}
	else if ( iDecValue >= 97 && iDecValue <= 122 ) // A-Z
	{
		return SC_ASCIITYPE_UPPERCASE;
	}
	else if ( iDecValue >= 48 && iDecValue <= 57 ) // 0-9
	{
		return SC_ASCIITYPE_NUMBER;
	}
	else if ( iDecValue == 127 || ( iDecValue >= 0 && iDecValue <= 31 ) ) // all those odd characters
	{
		return SC_ASCIITYPE_CONTROL;
	}
	else if ( iDecValue == 34 || iDecValue == 39 ) // handles " and '
	{
		return SC_ASCIITYPE_QUOTE;
	}
	else if ( iDecValue == 45 || iDecValue == 33 || iDecValue == 63 ) // handles - ! ? which might be treated like a letter
	{
		return SC_ASCIITYPE_SEPARATOR;
	}
	else if ( iDecValue >= 35 && iDecValue <= 64 ) // # $ % & ' ( ) * + ' - . /  : ; < = > ? Note that some are repeats but they are already handled like a-z
	{
		return SC_ASCIITYPE_PUNCTUATION;
	}
	else if ( iDecValue >= 91 && iDecValue <= 96 ) // [ \ ] ^ _ `
	{
		return SC_ASCIITYPE_PUNCTUATION;
	}
	else if ( iDecValue >= 123 && iDecValue <= 126 ) // { | } ~
	{
		return SC_ASCIITYPE_PUNCTUATION;
	}
	return SC_ASCIITYPE_INVALID;
}




//////////////// Other /////////////////////

// * Takes a given block of text, and drops in line breaks at a given width, but will respect words
// Very simple at first, will add more sophisticated exceptions later
string CSLWordWrap( string sIn, int iWidth, string sBreakChar = SC_CHAR_BREAK )
{
	string sOut = "";
	
	
	
	
	return sOut;
}

/*
function word_wrap($chars,$str)
{
	$cpy=strip_tags($str);
	$chk=array_reverse(preg_split('`\s`',$cpy));
	$chk2=array_reverse(preg_split('`\s`',$str));
	$len=0;
	$retVal='';
	
	// we want to work backwards on this
	for( $i = count($chk)-1; $i >= 0; $i-- ) 
	{
		// $len is the current segment length in the stripped string
		if($len>0 && ($len + strlen($chk[$i])) > $chars)
		{
			// add a line break
			$retVal.='<br />'."\n";
			$len=0;
		}
		else if($len>0)
		{
			// space between words needs to be counted
			$len++;
		}
		
		// add the necessary pieces to the string
		$pop1 = array_pop($chk); // get next piece from each version
		$pop2 = array_pop($chk2);
		$retVal.=$pop2.' ';
		$len+=strlen($pop1);
		$pattern='`'.preg_quote($pop1).'`';
		while(!preg_match($pattern,strip_tags($pop2)))
		{
			// if pop1 and pop2 are not referencing the same element
			$pop2=array_pop($chk2);
			$retVal.=$pop2.' ';
			if($pop2==NULL) break;
		}
	}
	return $retVal;
}
*/


/*
public static string[] Wrap(string text, int maxLength)
{
	text = text.Replace("\n", " ");
	text = text.Replace("\r", " ");
	text = text.Replace(".", ". ");
	text = text.Replace(">", "> ");
	text = text.Replace("\t", " ");
	text = text.Replace(",", ", ");
	text = text.Replace(";", "; ");
	text = text.Replace("
	", " ");
	text = text.Replace(" ", " ");
	 
	string[] Words = text.Split(' ');
	int currentLineLength = 0;
	ArrayList Lines = new ArrayList(text.Length / maxLength);
	string currentLine = "";
	bool InTag = false;
	 
	foreach (string currentWord in Words)
	{
		//ignore html
		if (currentWord.Length > 0)
		{
			 
			if (currentWord.Substring(0,1) == "<")
			InTag = true;
			 
			if (InTag)
			{
				//handle filenames inside html tags
				if (currentLine.EndsWith("."))
				{
					currentLine += currentWord;
				}
				else
				{
					currentLine += " " + currentWord;
				}
				
				if (currentWord.IndexOf(">") > -1)
				{
					InTag = false;
				}
				 
			}
			else
			{
				if (currentLineLength + currentWord.Length + 1 < maxLength)
				{
					currentLine += " " + currentWord;
					currentLineLength += (currentWord.Length + 1);
				}
				else
				{
					Lines.Add(currentLine);
					currentLine = currentWord;
					currentLineLength = currentWord.Length;
				}
			}
		}
	}
	 
	if (currentLine != "")
	{
		Lines.Add(currentLine);
	}
	string[] textLinesStr = new string[Lines.Count];
	Lines.CopyTo(textLinesStr, 0);
	return textLinesStr;
}
*/
/*
// {{{ wordwrap
function wordwrap( str, int_width, str_break, cut ) {
    // Wraps a string to a given number of characters
    // 
    // +    discuss at: http://kevin.vanzonneveld.net/techblog/article/javascript_equivalent_for_phps_wordwrap/
    // +       version: 810.819
    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Nick Callen
    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Sakimori
    // *     example 1: wordwrap('Kevin van Zonneveld', 6, '|', true);
    // *     returns 1: 'Kevin |van |Zonnev|eld'
    // *     example 2: wordwrap('The quick brown fox jumped over the lazy dog.', 20, '<br />\n');
    // *     returns 2: 'The quick brown fox <br />\njumped over the lazy<br />\n dog.'
    // *     example 3: wordwrap('Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');
    // *     returns 3: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod \ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat.'

    // PHP Defaults
    var m = ((arguments.length >= 2) ? arguments[1] : 75   );
    var b = ((arguments.length >= 3) ? arguments[2] : "\n" );
    var c = ((arguments.length >= 4) ? arguments[3] : false);

    var i, j, l, s, r;

    str += '';

    if (m < 1) {
        return str;
    }

    for (i = -1, l = (r = str.split("\n")).length; ++i < l; r[i] += s) {
        for(s = r[i], r[i] = ""; s.length > m; r[i] += s.slice(0, j) + ((s = s.slice(j)).length ? b : "")){
            j = c == 2 || (j = s.slice(0, m + 1).match(/\S*(\s)?$/))[1] ? m : j.input.length - j[0].length || c == 1 && m || j.input.length + (j = s.slice(m).match(/^\S* /)).input.length;
        }
    }

    return r.join("\n");
}// }}}

*/


// Convert float to string and remove the white spaces
// that normally occur in FloatToString
// fVal : Float
// iDec : Decimal place
// Nytir
string CSLFormatFloat(float fVal, int iDec=2)
{
	string sInt = IntToString(FloatToInt(fVal));
	string sFlt = FloatToString(fVal,18,iDec);
	int    iLen = GetStringLength(sInt) + 1 + iDec;
	return GetStringRight(sFlt, iLen);
}


// * appends given string to the local string var, from Nytir codebase and returns the result
string CSLAppendLocalString(object oObj, string sVar, string sIn)
{
	SetLocalString(oObj, sVar, GetLocalString(oObj, sVar) + sIn);
	return GetLocalString(oObj, sVar);
}


// from DMFI
int CSLGetIsNumber(string sWord)
{   //Purpose: Returns whether sWord is a number or not
    //Original Scripter: Demetrious
    //Last Modified By: Demetrious 6/20/6
    int n;
    string sTest;

    n = StringToInt(sWord);
    sTest = IntToString(n);

    if (sWord!=sTest)
    {
        return FALSE;
	}
    return TRUE;
}








string CSLColorText( string sString, int nColor)
{ // PURPOSE: To convert sString to specified color:  Note a few
  // colors I went to "light" versions.  This was based on my 
  // preference.  A complete list of supported colors are in 
  // nwn2_color.2da	
  //Original Scripter: Demetrious
  //Last Modified By: Demetrious 11/13/6
  //Last Modified By: Pain 04/15/09
  
  // uses fog color constants in nwscript.nss
  
  if (nColor==COLOR_BLACK) { return "<color=black>"+sString+"</color>"; }
  else if (nColor==COLOR_BLUE) { return "<color=cornflowerblue>"+sString+"</color>"; }
  else if (nColor==COLOR_BLUE_DARK) { return "<color=steelblue>"+sString+"</color>"; }
  else if (nColor==COLOR_BROWN) { return "<color=burlywood>"+sString+"</color>"; }
  else if (nColor==COLOR_BROWN_DARK) { return "<color=saddlebrown>"+sString+"</color>"; }
  else if (nColor==COLOR_CYAN) { return "<color=cyan>"+sString+"</color>"; }
  else if (nColor==COLOR_GREEN) { return "<color=lightgreen>"+sString+"</color>"; }
  else if (nColor==COLOR_GREEN_DARK) { return "<color=darkgreen>"+sString+"</color>"; }
  else if (nColor==COLOR_GREY) { return "<color=lightgrey>"+sString+"</color>"; }
  else if (nColor==COLOR_MAGENTA) { return "<color=magenta>"+sString+"</color>"; }
  else if (nColor==COLOR_ORANGE) { return "<color=orange>"+sString+"</color>"; }
  else if (nColor==COLOR_ORANGE_DARK) { return "<color=darkorange>"+sString+"</color>"; }
  else if (nColor==COLOR_RED) { return "<color=red>"+sString+"</color>"; }
  else if (nColor==COLOR_RED_DARK) { return "<color=darkred>"+sString+"</color>"; }
  else if (nColor==COLOR_WHITE) { return "<color=white>"+sString+"</color>"; }
  else if (nColor==COLOR_YELLOW) { return "<color=yellow>"+sString+"</color>"; }
  else if (nColor==COLOR_YELLOW_DARK) { return "<color=gold>"+sString+"</color>"; }
	
  return sString;
}



string CSLBoldText(string sString)
{
	return "<b>"+sString+"</b>"; 
}

string CSLItalicText(string sString)
{
	return "<i>"+sString+"</i>"; 
}


/* Delimiter ( Pseudo Array ) Type functions */

// * Hard coded for using a comma as the delimiter
string CSLDelimList(string s1="", string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="")
{
   string sDelimiter=",";
   if (s2=="") { return s1; } else { s1 += sDelimiter + s2; }
   if (s3=="") { return s1; } else { s1 += sDelimiter + s3; }
   if (s4=="") { return s1; } else { s1 += sDelimiter + s4; }
   if (s5=="") { return s1; } else { s1 += sDelimiter + s5; }
   if (s6=="") { return s1; } else { s1 += sDelimiter + s6; }
   if (s7=="") { return s1; } else { s1 += sDelimiter + s7; }
   if (s8=="") { return s1; } else { s1 += sDelimiter + s8; }
   if (s9=="") { return s1; } else { s1 += sDelimiter + s9; }
   return s1;
}

// * Allows you to choose the delimter for the items in the list
string CSLDelimit(string sDelimiter=",", string s1="", string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="")
{
   if (s2=="") { return s1; } else { s1 += sDelimiter + s2; }
   if (s3=="") { return s1; } else { s1 += sDelimiter + s3; }
   if (s4=="") { return s1; } else { s1 += sDelimiter + s4; }
   if (s5=="") { return s1; } else { s1 += sDelimiter + s5; }
   if (s6=="") { return s1; } else { s1 += sDelimiter + s6; }
   if (s7=="") { return s1; } else { s1 += sDelimiter + s7; }
   if (s8=="") { return s1; } else { s1 += sDelimiter + s8; }
   if (s9=="") { return s1; } else { s1 += sDelimiter + s9; }
   return s1;
}


// changing CSLParse to CSLStringBefore
string CSLStringBefore(string sIn, string sDelimiter=".")
{ // PURPOSE: To find portion of string that occurs before sDelimiter
	// Original Scripter: Deva B. Winblood
	// Last Modified By: Deva B. Winblood  04/24/2006
	
	int iPosition = FindSubString( sIn, sDelimiter );
	if ( iPosition == -1 ) // Delimiter not found so the entire string is returned
	{ 
		return sIn;
	}
	else if ( iPosition == 0 ) // The delimter is in the first position which makes it return nothing
	{ 
		return "";
	}
	return GetStringLeft( sIn, iPosition );
}


string CSLStringAfter(string sIn, string sDelimiter=".")
{ // PURPOSE: To find portion of string that occurs before the first occurance of sDelimiter
	// Original Scripter: Deva B. Winblood
	// Last Modified By: Deva B. Winblood  04/24/2006
	
	int iPosition = FindSubString( sIn, sDelimiter );
	if ( iPosition == -1 ) // Delimiter not found so nothing is returned
	{ 
		return "";
	}
	else if ( iPosition == 0 ) // The delimter is in the first position which makes it return nothing
	{ 
		//return "";
		return sIn;
	}
	return GetStringRight( sIn, GetStringLength(sIn)-(iPosition+1) );

}

// Purpose, gets the contents of the string after the first occurance of the given character
// DMFI did this
string CSLRemoveParsed(string sIn,string sParsed,string sDelimiter=".")
{ // PURPOSE: To remove the parsed portion of the string
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   04/24/2006
  string sRet="";
  if (GetStringLength(sParsed)<=GetStringLength(sIn))
  { // okay lengths
    sRet=GetStringRight(sIn,GetStringLength(sIn)-GetStringLength(sParsed));
    while(GetStringLeft(sRet,1)==sDelimiter&&GetStringLength(sDelimiter)>0)
    { // strip prefix delimiter
      sRet=GetStringRight(sRet,GetStringLength(sRet)-1);
    } // strip prefix delimiter
  } // okay lengths
  return sRet;
}



// * int iStart Makes the string sIn to start working at the given new location, returns count of items in the given string
int CSLGetNthCount( string sIn, string sDelimiter=",", int iStart = 0 )
{
	
	if ( sIn == "" )
	{
		return 0;
	}
	
	int iCount = 0;
	
	int iPosition = 0;
	iPosition = FindSubString( sIn, sDelimiter, iStart );
	if ( iPosition == -1 ) // no more to find
	{ 
		return 1; // delimiter not present, must be a single element
	}
	
	//iStart = iPosition+1;
	iCount = 1;
	
	while( iPosition > -1 )
	{	
		iCount++;
		iPosition = FindSubString( sIn, sDelimiter, iPosition+1 );
		if ( iPosition == -1 ) // no more to find
		{
			return iCount;
		}
		//else
		//{
			/*
				it is crashin when i uncomment the following lines
				which is why this is in an else statement now
			*/
			//iCount = iCount + 1;
			//iStart = iPosition + 1;
		
			//
			
			//iStart = iPosition;
		//}
		
	}
	return iCount;
}




// * int iStart Makes the string sIn to start working at the given new location
int CSLGetNthPosition( string sIn, int iOccurance = 1, string sDelimiter=",", int iStart = 0 )
{
	if ( iOccurance == 1 )
	{
		return iStart;
	}
	
	int iPosition = FindSubString( sIn, sDelimiter, iStart );
	if ( iPosition == -1 ) // no more to find
	{ 
		return -1;
	}
	//iStart = iPosition+1;
	iOccurance--;
	
	while( iOccurance > 1 )
	{
		iPosition = FindSubString( sIn, sDelimiter, iPosition+1 );
		if ( iPosition == -1 ) // no more to find
		{ 
			return -1;
		}
		//iStart = iPosition+1;
		iOccurance--;
	}
	return iPosition+1;
}

//* this is used with a given start position, and gets the length to the next delimiter with a given start position
int CSLGetNthLength( string sIn, int iPosition, string sDelimiter="," )
{
	//iPosition = CSLGetNthPosition( sIn, iIndex, sDelimiter );
	int iNextPosition = FindSubString( sIn, sDelimiter, iPosition );
	
	if ( iNextPosition == -1 ) // no more delimters are present
	{
		iNextPosition = GetStringLength( sIn );	
	}
	
	
	if ( iNextPosition >= iPosition ) // make sure it's result is 0 or higher
	{
		return iNextPosition-iPosition;
	}
	return 0;
}


// GetWord
/*
example:
GetWord("VFX_IMP_ACID", 3, "_");
returns "ACID"
another example:
GetWord("Hello, it's nice to see you again!", 5, " ");
returns "see"
CSLGetNthString delimiter defaults to "_", changed to ",", need to update all scripts that use this
*/
string CSLGetNthString(string sIn, int iOccurance, string sDelimiter=",")
{
	if ( GetStringLength( sDelimiter ) != 1 )
	{
		return "";
	}
	
	if ( FindSubString( sIn, sDelimiter ) == -1 )
	{
		if ( iOccurance == 1 )
		{
			return sIn;
		}
		else
		{
			return "";
		}
	}
	
	sIn = sIn+sDelimiter;
	
	int nNth = 0;
	int nLength = GetStringLength(sIn);
	string sSub;
	string sWord;
	int nCount=0;
	while (nNth < nLength)
	{
		sSub = GetSubString(sIn, nNth, 1);
		if (sSub==sDelimiter)
		{
			sWord = GetStringLeft(sIn, nNth);
			
			nCount++;
			if (nCount==iOccurance)
			{
				return sWord;
			}
			sIn = GetStringRight( sIn, nLength-(nNth+1) );
			
			nLength = GetStringLength(sIn);
			nNth = -1;
		}
		nNth++;
	}
	return "";
}

struct CSLStringArray {
    int iActive;
	int iCount;
	int iCurrentIndex;
	int iPosition;
	int iLength;
	string sArray;
	string sDelimiter;
};

// * This does an in memory array which is one based
struct CSLStringArray strSA; // put it into global scope


void CSLStringArrayDelete(  )
{
	strSA.iCount = 0;
	strSA.iCurrentIndex = -1;
	strSA.iPosition = -1;
	strSA.iLength = -1;
	strSA.sArray = "";
	strSA.sDelimiter = "";
	strSA.iActive = FALSE;
}


string CSLStringArrayPrint(  )
{
	return " Elements="+IntToString(strSA.iCount)+" Active="+IntToString(strSA.iActive)+" Index="+IntToString(strSA.iCurrentIndex)+"  Position="+IntToString(strSA.iPosition)+"  Length="+IntToString(strSA.iLength)+"  Delimter="+strSA.sDelimiter+" ArrayData="+strSA.sArray;
}


string CSLStringArrayCurrent(  )
{
	return GetSubString( strSA.sArray, strSA.iPosition, strSA.iLength );
}

int CSLStringArrayCurrentIndex( )
{
	return strSA.iCurrentIndex;
}

string CSLStringArrayIndex( int iIndex )
{
	string sDelimiter = strSA.sDelimiter;
	string sArray = strSA.sArray;
	int iArrayCount = strSA.iCount;
	int iLength = strSA.iLength;
	int iPosition = strSA.iPosition;
	
	if ( iIndex > iArrayCount || iArrayCount < 1)
	{
		return ""; // it's a higher value than what is in the array
	}
	
	if ( strSA.iCurrentIndex == iIndex ) // we already have this value, so no need to relookup the result
	{
		return GetSubString( sArray, iPosition, iLength );
	}
	
	
	
	if ( iArrayCount == 1 )
	{
		strSA.iPosition = 0;
		strSA.iLength = 0;
		return strSA.sArray; // only one value anyway, so no need to iterate the array
	}
	
	iPosition = CSLGetNthPosition( sArray, iIndex, sDelimiter );
	
	if ( iArrayCount == iIndex ) // iIndex ==  )
	{
		// these guys when not commented cause crashing
		iLength = GetStringLength( sArray );
		iLength = iLength-iPosition;
	}
	else
	{
		// these guys when not commented cause crashing
		iLength = FindSubString( sArray, sDelimiter, iPosition );
		iLength = iLength-iPosition;
	}
	
	strSA.iPosition = iPosition;
	strSA.iLength = iLength;
	strSA.iCurrentIndex = iIndex;
	
	return GetSubString( sArray, iPosition, iLength );
}



int CSLStringArrayCreate( string sIn, string sDelimiter = "," )
{
	
	int iActive = strSA.iActive; // seems to crash if used directly
	if ( iActive == TRUE ) { return FALSE; } // don't let a new one be started if it's already being used
	strSA.sArray = sIn;
	strSA.sDelimiter = sDelimiter;
	strSA.iCount = CSLGetNthCount( strSA.sArray, strSA.sDelimiter );
	CSLStringArrayIndex( 1 );
	return TRUE;
}


string CSLStringArrayFirst(  )
{
	return CSLStringArrayIndex( 1 );
}

string CSLStringArrayLast(  )
{
	return CSLStringArrayIndex( strSA.iCount );
}

string CSLStringArrayNext(  )
{
	return CSLStringArrayIndex( strSA.iCurrentIndex+1 );
}

string CSLStringArrayPrev(  )
{
	return CSLStringArrayIndex( strSA.iCurrentIndex-1 );
}

string CSLStringArrayGet(  )
{
	return strSA.sArray;
}

// returns last element, removing it from the array
string CSLStringArrayPop(  )
{
	if ( strSA.iCount == 1 )
	{
		strSA.iCount = 0;
		strSA.iCurrentIndex = -1;
		strSA.iPosition = -1;
		strSA.iLength = -1;
		strSA.sArray = "";
		return strSA.sArray;
	}
	else if ( strSA.iCount == 0 )
	{
		return "";
	}
	
	strSA.iPosition = CSLGetNthPosition( strSA.sArray, strSA.iCurrentIndex, strSA.sDelimiter  );
	
	
	string sCurrent = GetStringRight(strSA.sArray, GetStringLength(strSA.sArray)-(strSA.iPosition) );
	strSA.sArray = GetStringLeft(strSA.sArray, strSA.iPosition-1 );
	
	strSA.iCount--;
	strSA.iCurrentIndex = -1;
	strSA.iPosition = -1;
	strSA.iLength = -1;
	
	return sCurrent;
	
}

// adds elements to the end of the array and returns the entire array
void CSLStringArrayPush( string sElement )
{
	
	strSA.iPosition = GetStringLength( strSA.sArray );
	strSA.iLength = GetStringLength( sElement );
	
	if ( strSA.iPosition == 0 )
	{
		strSA.sArray = sElement;
	}
	else
	{
		strSA.iPosition++;
		strSA.sArray += strSA.sDelimiter+sElement;
	}
	strSA.iCount++;	
	
}

// returns the first element of an array and removes it
string CSLStringArrayShift( )
{
	
	if ( strSA.iCount == 1 )
	{
		strSA.iCount = 0;
		strSA.iCurrentIndex = -1;
		strSA.iPosition = -1;
		strSA.iLength = -1;
		strSA.sArray = "";
		return strSA.sArray;
	}
	else if ( strSA.iCount == 0 )
	{
		return "";
	}
	
	int iPosition = FindSubString( strSA.sArray, strSA.sDelimiter );
	//int iLength = CSLGetNthLength( strSA.sArray, iPosition, strSA.sDelimiter )
	
	string sCurrent = GetStringLeft(strSA.sArray, iPosition );
	strSA.sArray = GetStringRight(strSA.sArray, GetStringLength(strSA.sArray)-(iPosition+1) );
	
	strSA.iCount--;
	strSA.iCurrentIndex = -1;
	strSA.iPosition = -1;
	strSA.iLength = -1;
	
	return sCurrent;
	
	//return "";
}

// adds an items to the front of an array
void CSLStringArrayUnShift( string sElement )
{
	
	strSA.iPosition = 0;
	strSA.iLength = GetStringLength( sElement );
	
	if ( strSA.sArray == "" )
	{
		strSA.sArray = sElement;
	}
	else
	{
		strSA.sArray = sElement + strSA.sDelimiter + strSA.sArray;
	}
	strSA.iCount++;
	
}

// replaces given value at the given index with the new element
void CSLStringArrayReplace( string sElement, int iIndex )
{
	
	int iArrayCount = strSA.iCount;
	
	if ( (iIndex > iArrayCount) || (iArrayCount < 1) || (sElement == "") )
	{
		return; // it's a higher value than what is in the array
	}
	
	string sDelimiter = strSA.sDelimiter;
	//string sArray = strSA.sArray;
	int iLength = strSA.iLength;
	int iPosition = strSA.iPosition;
	

	
	if ( iArrayCount == 1 ) // only one element, very easy to change it
	{
		iPosition = 0;
		strSA.sArray = sElement; // only one value anyway, so no need to iterate the array
	}
	else if ( iIndex == iArrayCount )
	{
		iPosition = CSLGetNthPosition( strSA.sArray, iIndex, sDelimiter );
		iLength = CSLGetNthLength( strSA.sArray, iPosition, sDelimiter );
		strSA.sArray = GetStringLeft(strSA.sArray, iPosition-1 ) + sDelimiter + sElement;
	}
	else if ( iIndex == 1 )
	{
		iPosition = 0;
		iLength = CSLGetNthLength( strSA.sArray, iPosition, sDelimiter );
		strSA.sArray = sElement + sDelimiter + GetStringRight(strSA.sArray, GetStringLength(strSA.sArray)-iLength-iPosition-1);
	}
	else
	{
		iPosition = CSLGetNthPosition( strSA.sArray, iIndex, sDelimiter );
		iLength = CSLGetNthLength( strSA.sArray, iPosition, sDelimiter );
		strSA.sArray = GetStringLeft(strSA.sArray, iPosition-1) + sDelimiter + sElement + sDelimiter + GetStringRight(strSA.sArray, GetStringLength(strSA.sArray)-iLength-iPosition-1);
	}
	
	
	//strSA.sArray = sArray;
	strSA.iLength = GetStringLength( sElement );
	strSA.iPosition = iPosition;
	strSA.iCurrentIndex = iIndex;
	
}






/*
function addslashes( str ) {
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Ates Goral (http://magnetiq.com)
    // +   improved by: marrtins
    // +   improved by: Nate
    // +   improved by: Onno Marsman
    // *     example 1: addslashes("kevin's birthday");
    // *     returns 1: 'kevin\'s birthday'
 
    return (str+'').replace(/([\\"'])/g, "\\$1").replace(/\0/g, "\\0");
}
*/