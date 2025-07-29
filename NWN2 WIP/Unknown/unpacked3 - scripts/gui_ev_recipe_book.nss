#include "ginc_param_const"


// Populate the list of recipes
void populateRecipeBook(object oPC);

// Take recipe out of book and create it in player's inventory
void takeRecipeOut(object oPC, string recipeTag);

// Destroy recipe from player's inventory and
// create in the the book
void storeRecipe(object oPC, string recipe);

// Extract the number of recipes in the book.
// recipeString is of the format "[recipe name]#[number of recipes]"
int getNumberOfRecipes(string recipeString);

// Extract the recipe name
string getRecipeName(string recipeString);

// Decrease the recipe number by one
void decreaseRecipeNumber(object book, string recipeTag);

// Increase the recipe number by one
void increaseRecipeNumber(object book, string recipeTag, string recipeName);

void main(string command = "", string arg1 = "")
{
	object oPC = OBJECT_SELF;
	if (command == "init") {
		populateRecipeBook(oPC);
	}
	
	else if (command == "pick") {
		takeRecipeOut(oPC, arg1);
	}
	
	else if (command == "store") {
		storeRecipe(oPC, arg1);
	}
}

void populateRecipeBook(object oPC)
{
	ClearListBox(oPC, "ev_recipe_book", "RECIPES_LISTBOX");
	
	object book = GetLocalObject(oPC, "ev_recipe_book");
	
	// Go over all the recipes (variables)
	int totalVars = GetVariableCount(book);
	int i;
	string varName;
	string text;
	string recipeString;
	for (i = 0; i < totalVars; i++) {
		
		varName = GetVariableName(book, i);
		if (GetSubString(varName, 0, 5) == "ench_") {
			recipeString = GetLocalString(book, varName);
			
			if (getNumberOfRecipes(recipeString) <= 0) {
				continue;
			}
			
			text = getRecipeName(recipeString) + " ("+IntToString(getNumberOfRecipes(recipeString)) +")";
			AddListBoxRow(oPC, "ev_recipe_book", "RECIPES_LISTBOX", varName, "RECIPE_NAME=" + text, "", "0="+varName, "");
		}	
	}
}

void takeRecipeOut(object oPC, string recipeTag)
{
	object book = GetLocalObject(oPC, "ev_recipe_book");
	
	decreaseRecipeNumber(book, recipeTag);
	
	CreateItemOnObject(recipeTag, oPC);
	
	SetLocalGUIVariable(oPC, "ev_recipe_book", 0, "");
	
	populateRecipeBook(oPC);
	
	ExportSingleCharacter(oPC);
}

void storeRecipe(object oPC, string recipeObjectString)
{
	object recipe = StringToObject(recipeObjectString);
	
	if (GetSubString(GetTag(recipe), 0, 5) != "ench_") {
		SendMessageToPC(oPC, "Recipe was not recognized.");
		return;
	}
	
	object book = GetLocalObject(oPC, "ev_recipe_book");
	
	increaseRecipeNumber(book, GetTag(recipe), GetName(recipe));
	
	DestroyObject(recipe);
	
	populateRecipeBook(oPC);
	
	ExportSingleCharacter(oPC);
}

int getNumberOfRecipes(string recipeString)
{
	if (recipeString == "") return 0;
	return StringToInt(GetStringParam(recipeString, 1, "#"));
}

string getRecipeName(string recipeString)
{
	return GetStringParam(recipeString, 0, "#");
}

void decreaseRecipeNumber(object book, string recipeTag)
{
	string recipeString = GetLocalString(book, recipeTag);
	int numOfRecipes = getNumberOfRecipes(recipeString);
	string nameOfRecipe = getRecipeName(recipeString);
	string newRecipeString;
	if (numOfRecipes > 0) {
		newRecipeString = nameOfRecipe + "#" + IntToString(numOfRecipes - 1);
	}
	SetLocalString(book, recipeTag, newRecipeString);
}

void increaseRecipeNumber(object book, string recipeTag, string recipeName)
{
	string recipeString = GetLocalString(book, recipeTag);
	int numOfRecipes = getNumberOfRecipes(recipeString);
	string newRecipeString;
	newRecipeString = recipeName + "#" + IntToString(numOfRecipes + 1);
	SetLocalString(book, recipeTag, newRecipeString);
}