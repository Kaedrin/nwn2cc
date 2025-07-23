//::///////////////////////////////////////////////
//:: Summon Familiar
//:: NW_S2_Familiar
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell summons an Arcane casters familiar
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//:://////////////////////////////////////////////

void main()
{
    //Yep thats it
    SummonFamiliar();
	
	int nCL = GetLevelByClass(CLASS_TYPE_WIZARD);
	nCL +=  GetLevelByClass(CLASS_TYPE_SORCERER);

	if (nCL > 10)
	{
		object oMyPet = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, OBJECT_SELF);
		effect eSR = EffectSpellResistanceIncrease(nCL+5);
		eSR = SupernaturalEffect(eSR);	
		DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR, oMyPet));				
	}
}