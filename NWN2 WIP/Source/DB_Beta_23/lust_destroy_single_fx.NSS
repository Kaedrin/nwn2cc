string sTagString=GetLocalString(OBJECT_SELF, "NewFX");
int iInstance=-1; 

void PrepForDestruction(object oTarget)
{
	SetPlotFlag(oTarget,FALSE);
    SetImmortal(oTarget,FALSE);
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
}


void main(float fDelay)
{
	object oTarget = GetNearestObjectByTag(sTagString);
	if(GetIsObjectValid(oTarget))
	{
		PrepForDestruction(oTarget);
       	DestroyObject (oTarget, fDelay);
	}
}