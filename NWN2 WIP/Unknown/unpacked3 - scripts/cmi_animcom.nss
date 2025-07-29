/*

//:: Created By: Kaedrin (Matt)
//:: cmi_animcom

This is the include file for my content and will hopefully allow others
to remap my content for their own use more easily.

*/


int GetAnimalCompanionLevel(object oPC)
{

	int nTelthor = 0;
	int nCompLevel = 0;
	
	if (GetHasFeat(FEAT_TELTHOR_COMPANION, oPC, TRUE))
	{
		int nSS = GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN , oPC);
		nSS = nSS - 3;
		if (nSS > 0)
			nCompLevel += nSS;
		nTelthor = 1;
	}		
	
	if ( GetHasFeat(1835 , oPC) && (!nTelthor) )
		nCompLevel += GetLevelByClass(CLASS_TYPE_CLERIC , oPC); //Animal Domain Cleric
		
	int nMarksman = GetLevelByClass(CLASS_MARKSMAN , oPC) ;
	if (GetHasFeat(FEAT_WILD_MARKSMAN, oPC) && (nMarksman > 3) )		
	{
		nCompLevel += (nMarksman - 3);
	}
	
	int nRanger = GetLevelByClass(CLASS_TYPE_RANGER , oPC); //Ranger
	if (nRanger > 3)
		nCompLevel += (nRanger - 3);

	nCompLevel += GetLevelByClass(CLASS_TYPE_DRUID , oPC); //Druid
	nCompLevel += GetLevelByClass(CLASS_LION_TALISID , oPC); //Lion of Talisid
	
	if (GetHasFeat(FEAT_DEVOTED_TRACKER, oPC))
	{ 
		int nPaladin = GetLevelByClass(CLASS_TYPE_PALADIN , oPC);
		nPaladin = nPaladin - 4;
		if (nPaladin > 0)
			nCompLevel += nPaladin;
			
		int nKniWild = GetLevelByClass(CLASS_KNIGHT_WILD,oPC);
		if (nKniWild > 0)
		{
			nCompLevel+=4;
			nCompLevel += nKniWild;
		}	
	}
	
	if (GetHasFeat(FEAT_IMPROVED_NATURAL_BOND, oPC))
	{
		int nHD = GetHitDice(oPC);
		if (nHD > nCompLevel)
		{
			nCompLevel += 6;
			if (nCompLevel > nHD)
				nCompLevel = nHD;
		}	
	}
	else
	if (GetHasFeat(2106, oPC)) //Natural Bond
	{
		int nHD = GetHitDice(oPC);
		if (nHD > nCompLevel)
		{
			nCompLevel += 3;
			if (nCompLevel > nHD)
				nCompLevel = nHD;
		}
	}
	
	if (GetHasFeat(1959 , oPC)) //Epic Animal Companion
		nCompLevel += 3;	
	
	//Testing
	//nCompLevel += 10;
		
	return nCompLevel;

}

int GetAnimCompRange(object oPC)
{
	int nCompLevel = GetAnimalCompanionLevel(oPC);
	int nRange;
	if (nCompLevel > 2)
		nRange = (nCompLevel / 3) + 1;
	else 
		nRange = 1;
	//SendMessageToPC(oPC, IntToString(nRange));
	//SendMessageToPC(oPC, IntToString(nCompLevel));	
	return nRange;
}

string GetElemCompRange(object oPC)
{
	int nCompLevel = GetAnimalCompanionLevel(oPC);

	int nRange = 1;
	if (nCompLevel > 27)
		nRange = 6;
	else
	if (nCompLevel > 21)
		nRange = 5;
	else
	if (nCompLevel > 15)
		nRange = 4;
	else		
	if (nCompLevel > 9)
		nRange = 3;
	else
	if (nCompLevel > 3)
		nRange = 2;				
	
	//SendMessageToPC(oPC, "Range: " + IntToString(nRange));
	//SendMessageToPC(oPC, "Level: " + IntToString(nCompLevel));	
	return IntToString(nRange);
}

void SummonCMIAnimComp(object oPC)
{
	int nTelthor = 0;
	string sBlueprint = GetLocalString(oPC, "cmi_animcomp");
	string sRange;
	int nRange = GetAnimCompRange(oPC);	    
	sRange = IntToString(nRange);	
	
	//SendMessageToPC(oPC, "sBlueprint: " + sBlueprint);
	//SendMessageToPC(oPC, "sRange: " + sRange);	
	
	if (GetHasFeat(FEAT_TELTHOR_COMPANION, oPC, TRUE))
	{
		sBlueprint = "cmi_ancom_telthor" + sRange;
		nTelthor = 1;
	}
	
	if (sBlueprint == "")
	{
		SummonAnimalCompanion();
		object oComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
		string sTag = GetTag(oComp);
		//SendMessageToPC(oPC, "Tag: " + sTag);
		//SendMessageToPC(oPC, "sRange: " + sRange);
		if (FindSubString(sTag, "blue") > -1)
		{
			sBlueprint = "c_ancom_blue" + sRange;	
		}
		else
		if (FindSubString(sTag, "bronze") > -1)
		{
			sBlueprint = "c_ancom_bronze" + sRange;	
		}
		else
		if (FindSubString(sTag, "dino") > -1)
		{
			sBlueprint = "c_ancom_dino" + sRange;	
		}
		else
		if (FindSubString(sTag, "elea") > -1)
		{
			sBlueprint = "cmi_ancom_elea" + GetElemCompRange(oPC);	
		}
		else
		if (FindSubString(sTag, "elee") > -1)
		{
			sBlueprint = "cmi_ancom_elee" + GetElemCompRange(oPC);	
		}
		else
		if (FindSubString(sTag, "elef") > -1)
		{
			sBlueprint = "cmi_ancom_elef" + GetElemCompRange(oPC);
		}
		else
		if (FindSubString(sTag, "elew") > -1)
		{
			sBlueprint = "cmi_ancom_elew" + GetElemCompRange(oPC);
		}
		else					
		if (FindSubString(sTag, "badger") > -1)
		{
			sBlueprint = "c_ancom_badger" + sRange;	
		}
		else
		if (FindSubString(sTag, "bear") > -1)
		{
			if (GetHasFeat(2270, oPC, TRUE)) {
				sBlueprint = "c_ancom_dbear" + sRange;
			}
			else {
				sBlueprint = "c_ancom_bear" + sRange;
			}
		}
		else
		if (FindSubString(sTag, "boar") > -1)
		{
			sBlueprint = "c_ancom_boar" + sRange;	
		}
		else
		if (FindSubString(sTag, "spider") > -1)
		{
			sBlueprint = "c_ancom_spider" + sRange;	
		}
		else
		if (FindSubString(sTag, "panther") > -1)
		{
			sBlueprint = "c_ancom_panther" + sRange;	
		}
		else		
		if (FindSubString(sTag, "winter") > -1)
		{
			sBlueprint = "c_ancom_winter_wolf" + sRange;	
		}
		else
		if (FindSubString(sTag, "wolf") > -1)
		{
			sBlueprint = "c_ancom_wolf" + sRange;	
		}
		else
		if (FindSubString(sTag, "white_tiger") > -1)
		{
			sBlueprint = "c_ancom_white_tiger" + sRange;	
		}	
		//SendMessageToPC(oPC, "sBlueprint2: " + sBlueprint);
	}
	
	if (GetHasFeat(2002, oPC, TRUE))
	{
	    int nAlign = GetAlignmentGoodEvil(oPC);		
		if (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL)
			sBlueprint = "c_ancom_bronze" + sRange;
		else
			sBlueprint = "c_ancom_blue" + sRange;
	}
	else
	if (GetHasFeat(FEAT_DINOSAUR_COMPANION, oPC, TRUE))
		sBlueprint = "c_ancom_dino" + sRange;
	
	if (GetTag(OBJECT_SELF) == "co_umoja")
		sBlueprint = "c_ancom_dino" + sRange;
	
	
		
	//SendMessageToPC(oPC, "sBlueprint3: " + sBlueprint);	
		
	SetLocalString(oPC, "cmi_animcomp", sBlueprint);
	SummonAnimalCompanion(oPC, sBlueprint); 
	
	if (nTelthor)
	{
		SetFirstName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), "Spirit of");
		SetLastName( GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), "the Land");
	}	
	//object oComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
	//string sTag = GetTag(oComp);
	//SendMessageToPC(oPC, "Tag: " + sTag);	
}