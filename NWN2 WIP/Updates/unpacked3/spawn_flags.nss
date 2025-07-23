//
// NESS V8.0
// Spawn Flags
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

int IsFlagPresent(string sName, string sFlag)
{
    int nPos = FindSubString(sName, sFlag);
    if (nPos >= 0)   // flag found
    {
        //debug("flag " + sFlag + " present");
        return TRUE;
    }
    return FALSE;
}

// This Function parses a String for Flags
// When nGetValue is FALSE, this returns TRUE if the flag exists, FALSE otherwise.
// nDefault is unused when nGetValue is FALSE.
// When nGetValue is TRUE, it returns the value of the flag if it
// exists, or nDefault otherwise.
int GetFlagValue(string sName, string sFlag, int nDefault)
{
    int nRetValue;
    int nPos;

    nPos = FindSubString(sName, sFlag);
    if (nPos >= 0)   // flag found
    {
        // Trim to the start of the flag
        sName = GetStringRight(sName, GetStringLength(sName) -
           (nPos + GetStringLength(sFlag)));

        // find the end of the flag
        nPos = FindSubString(sName, "_");
        if (nPos >= 0)
        {
            sName = GetStringLeft(sName, nPos);
        }

        // Retreive Flag
        if (TestStringAgainstPattern("*n", GetStringLeft(sName, 1)) == FALSE)
        {
            // No value specified, use default
            nRetValue = nDefault;
            //debug("flag " + sFlag + " - def val = "  + IntToString(nRetValue));


        }
        else
        {
            // Retrieve Value
            nRetValue = StringToInt(sName);
            //debug("flag " + sFlag + " - val = "  + IntToString(nRetValue));
        }
    }

    else  // flag not found at all
    {
       nRetValue = nDefault;

    }

    // Return Value
    return nRetValue;
}
//

int IsSubFlagPresent(string sName, string sFlag, string sSubFlag)
{
    int nPos = FindSubString(sName, sFlag);
    if (nPos >= 0)
    {
        // Trim Flag
        sName = GetStringRight(sName, GetStringLength(sName) -
           (nPos + GetStringLength(sFlag)));

        nPos = FindSubString(sName, "_");
        if (nPos >= 0)
        {
            sName = GetStringLeft(sName, nPos);
        }

        // Retreive SubFlag
        nPos = FindSubString(sName, sSubFlag);
        if (nPos >= 0)
        {
            //debug("flag " + sFlag + "subflag " + sSubFlag + " present");
            return TRUE;
        }
    }

    return FALSE;
}

// This Function parses a String for a Subvalue from Flags
int GetSubFlagValue(string sName, string sFlag, string sSubFlag, int nDefault)
{
    int nRetValue;
    int nPos;

    nPos = FindSubString(sName, sFlag);
    if (nPos >= 0)
    {
        // Trim Flag
        sName = GetStringRight(sName, GetStringLength(sName) -
            (nPos + GetStringLength(sFlag)));

        nPos = FindSubString(sName, "_");

        if (nPos >= 0)
        {
            sName = GetStringLeft(sName, nPos);
        }

        // Retreive SubFlag
        nPos = FindSubString(sName, sSubFlag);
        if (nPos >= 0)
        {
            sName = GetStringRight(sName, GetStringLength(sName) -
               (nPos + GetStringLength(sSubFlag)));

            if (TestStringAgainstPattern("*n", GetStringLeft(sName, 1)) == FALSE)
            {
                nRetValue = nDefault;  // SubFlag found but no value
                //debug("flag " + sFlag + " subflag " + sSubFlag + " - def val = "  +
                //   IntToString(nRetValue));
            }
            else
            {
                // Retrieve Value
                nRetValue = StringToInt(sName);  // Subflag (with value) found
                //debug("flag " + sFlag + " subflag " + sSubFlag + " - val = "  +
                //   IntToString(nRetValue));
            }
        }
        else
        {
            nRetValue = nDefault; // subflag not found
        }
    }
    else
    {
        nRetValue = nDefault;  // Main flag not found
    }

    // Return Value
    return nRetValue;
}
//