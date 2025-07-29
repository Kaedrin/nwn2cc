void main()
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);
	SetLocked(oTarget, TRUE);
	SetLockKeyRequired(oTarget);
}