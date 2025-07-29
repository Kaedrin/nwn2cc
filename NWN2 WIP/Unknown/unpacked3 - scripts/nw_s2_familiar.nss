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
	// Check if PC has improved familiar feat
	int nImprovedFamiliarFeat = 2274;
	if (GetHasFeat(nImprovedFamiliarFeat)) {
		// Summon Imp based on master level
		int nLevel = GetHitDice(OBJECT_SELF);
		string sImpTag = "";
		if (nLevel <= 5) 		sImpTag = "fami_imp0";
		else if (nLevel <= 10)  sImpTag = "fami_imp1";
		else if (nLevel <= 15)  sImpTag = "fami_imp2";
		else if (nLevel <= 20)  sImpTag = "fami_imp3";
		else if (nLevel <= 25)  sImpTag = "fami_imp4";
		else 					sImpTag = "fami_imp5";
		
		SummonFamiliar(OBJECT_SELF, sImpTag);
	}
	else	
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