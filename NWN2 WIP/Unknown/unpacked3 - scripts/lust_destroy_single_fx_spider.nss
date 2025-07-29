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
	object oTarget1 = GetNearestObjectByTag(sTagString+"_1");
	if(GetIsObjectValid(oTarget1)) {PrepForDestruction(oTarget1); DestroyObject (oTarget1, fDelay);}
	
	object oTarget2 = GetNearestObjectByTag(sTagString+"_2");
	if(GetIsObjectValid(oTarget2)) {PrepForDestruction(oTarget2); DestroyObject (oTarget2, fDelay);}

	object oTarget3 = GetNearestObjectByTag(sTagString+"_3");
	if(GetIsObjectValid(oTarget3)) {PrepForDestruction(oTarget3); DestroyObject (oTarget3, fDelay);}
	
	object oTarget4 = GetNearestObjectByTag(sTagString+"_4");
	if(GetIsObjectValid(oTarget4)) {PrepForDestruction(oTarget4); DestroyObject (oTarget4, fDelay);}
	
	object oTarget5 = GetNearestObjectByTag(sTagString+"_5");
	if(GetIsObjectValid(oTarget5)) {PrepForDestruction(oTarget5); DestroyObject (oTarget5, fDelay);}
	
	object oTarget6 = GetNearestObjectByTag(sTagString+"_6");
	if(GetIsObjectValid(oTarget6)) {PrepForDestruction(oTarget6); DestroyObject (oTarget6, fDelay);}
	
	object oTarget7 = GetNearestObjectByTag(sTagString+"_7");
	if(GetIsObjectValid(oTarget7)) {PrepForDestruction(oTarget7); DestroyObject (oTarget7, fDelay);}
	
	object oTarget8 = GetNearestObjectByTag(sTagString+"_8");
	if(GetIsObjectValid(oTarget8)) {PrepForDestruction(oTarget8); DestroyObject (oTarget8, fDelay);}
}