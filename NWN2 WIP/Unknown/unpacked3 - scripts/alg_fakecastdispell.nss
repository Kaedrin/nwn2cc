void main()
{

	object oPC = GetEnteringObject();

	if (!GetIsPC(oPC)) return;
	
	if (GetItemPossessedBy(oPC, "zhent")!=OBJECT_INVALID)
   		return;  

	object oCaster;
	oCaster = GetNearestObjectByTag("sd_dispeller");

	object oTarget;
	oTarget = oPC;

	//AssignCommand(oCaster, ActionCastFakeSpellAtObject(SPELL_GREATER_DISPELLING, oTarget, PROJECTILE_PATH_TYPE_DEFAULT));

}