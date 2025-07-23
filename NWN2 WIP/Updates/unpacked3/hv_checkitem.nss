#include "ginc_var_ops"
#include "nw_i0_plot"

// if number of sItemTag item greater than nToCheck, return true
int StartingConditional(string sItemTag, int nToCheck)
{
	int nItems = 0;
	nItems = GetNumItems(OBJECT_SELF,sItemTag);
	
	if (nItems > nToCheck) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}