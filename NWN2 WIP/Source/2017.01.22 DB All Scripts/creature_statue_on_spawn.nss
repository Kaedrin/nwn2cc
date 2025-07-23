//LUNA - Have a creature that spawns in turn into a statue


void spawnInStatue(object oPC)
{
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectPetrify(), oPC);
	SetPlotFlag( oPC, 1);
	SetBumpState(oPC, BUMPSTATE_UNBUMPABLE);
	SetCustomHeartbeat( oPC, 500000);
}

void main()
{
	DelayCommand(6.0, spawnInStatue(OBJECT_SELF));
}