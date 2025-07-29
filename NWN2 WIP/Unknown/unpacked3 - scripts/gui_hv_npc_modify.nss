#include "hv_npc_modify_inc"

// NPC Modifications GUI
void main(string sAction, string sData1, string sData2, string sData3, string sData4, string sData5, string sData6, string sData7, string sData8, string sData9, string sData10)
{
	if (!GetIsDM(OBJECT_SELF))
		return;

	// If there is a target, make sure it's
	// NOT a pc
	object oTarget = GetPlayerCurrentTarget(OBJECT_SELF);
	if ((GetIsObjectValid(oTarget) == FALSE) || (GetIsPC(oTarget)) || (GetIsDM(oTarget))){
		SendMessageToPC(OBJECT_SELF, "<C=pink>Invalid target");
		return;
	}
	
	// sData1 - package number
	// sData2 - level to set
	if (sAction == "SetPackageAndLevel") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
	
		int nPackage = StringToInt(sData1);
		int nLevel   = StringToInt(sData2);
		
		SetNewLevelAndPackage(oNPC, nPackage, nLevel);
	}
	
	// sData1 - ability score to increase/decrease by 1
	// sData2 - "inc" to increase ability, "dec" to decrease it
	else if (sAction == "SetAbilityScore") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		int nAbility = StringToInt(sData1);
		IncreaseAbilityScore(oNPC, nAbility, sData2);
	}
	
	else if (sAction == "ExamineCreatureSkin") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		ExamineCreatureSkinProperties(oNPC, oDM);
	}
	
	else if (sAction == "AddMiscImmunities") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddMiscImmunities(oNPC, sData1, sData2, sData3, sData4, sData5, sData6, sData7, sData8, sData9, sData10);
		SendMessageToPC(oDM, "<C=pink>Properties added.");
	}
	
	else if (sAction == "AddPhysicalImmunities") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddPhysicalImmunities(oNPC, sData1, sData2, sData3, sData4, sData5, sData6, sData7);
		SendMessageToPC(oDM, "<C=pink>Properties added.");
	}
	
	else if (sAction == "AddElementalImmunities") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddElementalImmunities(oNPC, sData1, sData2, sData3, sData4, sData5, sData6, sData7,sData8,sData9);
		SendMessageToPC(oDM, "<C=pink>Properties added.");
	}
	
	else if (sAction == "AddMagicalImmunities") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddMagicalImmunities(oNPC, sData1, sData2, sData3, sData4, sData5, sData6, sData7,sData8,sData9);
		SendMessageToPC(oDM, "<C=pink>Properties added.");
	}
	
	else if (sAction == "AddMiscProperties") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddMiscProperties(oNPC, sData1, sData2, sData3, sData4, sData5, sData6);
		SendMessageToPC(oDM, "<C=pink>Properties added.");
	}
	
	else if (sAction == "AddFeats") {
		object oDM = OBJECT_SELF;
		object oNPC = GetPlayerCurrentTarget(oDM);
		
		AddFeats(oNPC, sData1, sData2, sData3, sData4);
		SendMessageToPC(oDM, "<C=pink>Feats added.");
	}
}