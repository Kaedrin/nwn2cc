string sTagString=GetLocalString(OBJECT_SELF, "NewTag");
int iInstance=-1; 

void PrepForDestruction(object oTarget)
{
	SetPlotFlag(oTarget,FALSE);
    SetImmortal(oTarget,FALSE);
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
}

void Destroy(float fDelay = 0.0)
{
    if (iInstance == -1)
    {  
        int iInst = 0;
        object oObject = GetObjectByTag(sTagString, iInst);

        while (GetIsObjectValid(oObject))
        {
			PrepForDestruction(oObject);
            DestroyObject (oObject, fDelay);
            iInst ++;
            oObject = GetObjectByTag(sTagString, iInst);
        }
    }
    else
    {   
		object oTarget = GetObjectByTag(sTagString,iInstance);
		if(GetIsObjectValid(oTarget))
		{
			PrepForDestruction(oTarget);
        	DestroyObject (oTarget, fDelay);
		}
    }
}



void main(float fDelay)
{
    string sNewString = sTagString;
    int iLen = GetStringLength(sTagString);
    int iCommaPos = FindSubString( sNewString, "," ); 

    while(iCommaPos != -1)
    {
        string sTempString = GetSubString(sNewString , 0, iCommaPos);
        Destroy(fDelay);

        sNewString  = GetSubString(sNewString, iCommaPos + 1, iLen);
        iLen = GetStringLength(sNewString);
        iCommaPos = FindSubString(sNewString, "," );
    }

    Destroy(fDelay);
}