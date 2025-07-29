// Return the row number of sClass in the classes.2da
// return -1 if no row was found.
int GetClassRow(string sClass)
{
	string sClasses2DA = "classes";
	// Get total number of rows
	int nRows = GetNum2DARows(sClasses2DA);
	 
	// Loop through them all until our class is found
	int i = 0;
	string sClassName = "";
	for (i = 0; i < nRows; i++) 
	{ 
		// Get class name
		sClassName = Get2DAString(sClasses2DA, "Label", i);
	 
	 	// Compare
	 	if (sClassName == sClass) 
		{
	  		// return current row
	 		return i;
	 	}
	}
	// If we got here no row was found
 	return -1;
}