int StartingConditional()
{
	int iOpen = GetLocked(OBJECT_SELF);
	if (iOpen == TRUE) {return TRUE;} else {return FALSE;}
}