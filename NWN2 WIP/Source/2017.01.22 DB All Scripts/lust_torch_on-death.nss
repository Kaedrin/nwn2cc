#include "lust_torch_functions"

void main()
{
	lust_switch_ondeath(OBJECT_SELF);
	SetLocalInt(OBJECT_SELF,"Destroyed",1);
}