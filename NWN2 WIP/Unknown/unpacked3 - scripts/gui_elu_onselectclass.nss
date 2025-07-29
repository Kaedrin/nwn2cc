#include "elu_functions_i"

void main(int nClass)
{
	object oControlledChar = GetControlledCharacter(OBJECT_SELF);	
	SetLocalInt(oControlledChar, LAST_SELECTED_CLASS, nClass);
}