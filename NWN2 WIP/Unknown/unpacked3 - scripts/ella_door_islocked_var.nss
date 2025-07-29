string localname = GetLocalString(OBJECT_SELF,"Door");
int StartingConditional()
{
	object Puerta = GetObjectByTag(localname);
	int iOpen = GetLocked(Puerta);
	if (iOpen == TRUE) {return TRUE;} else {return FALSE;}
}