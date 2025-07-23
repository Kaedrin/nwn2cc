#include "elu_functions_i"

void main(string sSpellID, string sClassIndex, string sMetaMagicID)
{
	string sButtonData = "P" + sSpellID + ":" + sClassIndex + ":" + sMetaMagicID; //add other data as needed
	SetHotBarButtonData(sButtonData);	
}