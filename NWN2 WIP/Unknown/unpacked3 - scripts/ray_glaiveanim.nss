//Aplies the animation and VFX
//VFX's done for the brimstone, hellrime, vitrolic and utterdark essences. 
//Other essences default to the eldritch VFX
//-Raygereio

void RayPlayCustomAnimation(object oPC, string sAnimationName)
{
	PlayCustomAnimation(oPC, sAnimationName, 0, 1.0);
}
void RaySetWeaponVisibility(object oPC, int nVisibility)
{
	SetWeaponVisibility(oPC, nVisibility);
}
void main()
{
	object oPC  = OBJECT_SELF;
	int nMetaMagic = GetMetaMagicFeat();
	RaySetWeaponVisibility(oPC, 0);
//Randomly plays attack 1-4 from O2hs stance
	int nNum = d4(1);
	string sNum = IntToString(nNum);
	string sAnim = "Glaive0"+sNum;	
	RayPlayCustomAnimation ( oPC , sAnim);
//Aplies VFX
	if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )
	{
		effect eGlaiveConj = EffectNWN2SpecialEffectFile("ray_glaive_brimstone");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlaiveConj , oPC , 3.0f);		
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST ) 
	{
		effect eGlaiveConj = EffectNWN2SpecialEffectFile("ray_glaive_hellrime");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlaiveConj , oPC , 3.0f);		
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )
	{
		effect eGlaiveConj = EffectNWN2SpecialEffectFile("ray_glaive_vitrolic");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlaiveConj , oPC , 3.0f);		
	}
	else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )
	{
		effect eGlaiveConj = EffectNWN2SpecialEffectFile("ray_glaive_utterdark");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlaiveConj , oPC , 3.0f);		
	}
	else{		
		effect eGlaiveConj = EffectNWN2SpecialEffectFile("ray_glaive_eldritch");
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlaiveConj , oPC , 3.0f);
	}
	DelayCommand(2.0f,(RaySetWeaponVisibility(oPC,1)));
			
}