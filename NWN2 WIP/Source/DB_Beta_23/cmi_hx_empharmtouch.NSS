//::///////////////////////////////////////////////
//:: Harm Touch
//:: cmi_hx_harmtouch
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 24, 2010
//:://////////////////////////////////////////////

void main()
{

	int nEmpowerHarmTouch = GetLocalInt(OBJECT_SELF, "EmpowerHarmTouch");	
	if (nEmpowerHarmTouch)
	{
		SetLocalInt(OBJECT_SELF, "EmpowerHarmTouch", 0);
		SendMessageToPC(OBJECT_SELF, "You are no longer empowering your Harm Touch ability.");	
	}
	else
	{
		SetLocalInt(OBJECT_SELF, "EmpowerHarmTouch", 1);
		SendMessageToPC(OBJECT_SELF, "You are now empowering your Harm Touch. It will deal twice the normal damage but you will take 2 points of damage per level of Vengeance Taker.");
			
	}
}