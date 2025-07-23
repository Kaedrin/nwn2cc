#include "nwnx_sql"
#include "ginc_param_const"

// To put on recipe chest on open, to create
// stored recipes in chest's inventory
void main()
{
	// Get PC who opened chest
	object oPC = GetLastOpenedBy();
	
	// Update object var if it's free
	if (GetLocalObject(OBJECT_SELF, "hv_recipe_storage_user") == OBJECT_INVALID) {
		
		SetLocalObject(OBJECT_SELF, "hv_recipe_storage_user", oPC);
	}
	else { // already in use - do nothing
		return;
	}
	
	// Get string with all PC's stored recipes
	string sRecipeInfo = GetPersistentRecipes(oPC, "recipestorage");
	
	// Get molds info
	string sMoldsInfo = GetPersistentMolds(oPC, "recipestorage");
	
	string sRecipeTag = "";
	string sRecipeNum = "";
	
	int i = 0;
	int n = 0;
	
	// Get first recipe tag and number of this recipes
	sRecipeTag = GetStringParam(GetStringParam(sRecipeInfo, i, ";"), 0, ",");
	sRecipeNum = GetStringParam(GetStringParam(sRecipeInfo, i, ";"), 1, ",");
	
	// Go through all stored recipes
	while (sRecipeTag != "") {
	
		// Create recipes in chest
		for (n = 0; n < StringToInt(sRecipeNum); n++) {
			CreateItemOnObject(sRecipeTag, OBJECT_SELF);
		}
		
		// Get next recipe
		i++;
		sRecipeTag = GetStringParam(GetStringParam(sRecipeInfo, i, ";"), 0, ",");
		sRecipeNum = GetStringParam(GetStringParam(sRecipeInfo, i, ";"), 1, ",");
	}
	
	string sMoldTag = "";
	string sMoldNum = "";
	
	i = 0;
	n = 0;
	
	// Get first mold tag and number of this mold
	sMoldTag = GetStringParam(GetStringParam(sMoldsInfo, i, ";"), 0, ",");
	sMoldNum = GetStringParam(GetStringParam(sMoldsInfo, i, ";"), 1, ",");
	
	// Go through all stored recipes
	while (sMoldTag != "") {
	
		// Create recipes in chest
		CreateItemOnObject(sMoldTag, OBJECT_SELF, StringToInt(sMoldNum));
		
		// Get next recipe
		i++;
		sMoldTag = GetStringParam(GetStringParam(sMoldsInfo, i, ";"), 0, ",");
		sMoldNum = GetStringParam(GetStringParam(sMoldsInfo, i, ";"), 1, ",");
	}	
	
}