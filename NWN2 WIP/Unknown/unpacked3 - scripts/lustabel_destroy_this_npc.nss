void PrepForDestruction(object oTarget)
{
	SetPlotFlag(oTarget,FALSE);
    SetImmortal(oTarget,FALSE);
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
}


void main(float fDelay)
{
	object oTarget = OBJECT_SELF;
	if(GetIsObjectValid(oTarget))
	{
		PrepForDestruction(oTarget);
       	DestroyObject (oTarget, fDelay);
	}
}