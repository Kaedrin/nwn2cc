#include "lust_torch_functions"

int iIsDay(){ if ((GetTimeHour()>5)&&(GetTimeHour()<18)) return TRUE; else return FALSE; }

void count_master()
{
	if (GetLocalInt(OBJECT_SELF, "Initallized")==FALSE)
	{
		SetLocalInt(OBJECT_SELF, "Initallized", TRUE);
		string sTag = GetTag(OBJECT_SELF);
		int bDebug = FALSE; //Set to TRUE if you want to review if you must to delete any object manually, otherwise it will be automatic
		object oObject;
		int TorchCount = 0;
		oObject = GetObjectByTag(sTag, 0);
		while (GetIsObjectValid(oObject))
		{
			TorchCount++;
			if (bDebug == TRUE) SendMessageToPC(GetFirstPC(),sTag + " <C=Cyan>found</C> on Area: "+GetTag(GetArea(oObject)));
			oObject = GetObjectByTag(sTag, TorchCount);
			if (TorchCount>=1 && GetIsObjectValid(oObject)) //You can't use more than 1 LightMaster, and I won't tolerate it
			{
				if (bDebug == FALSE)DestroyObject(oObject); //Destroy the object!
				if (bDebug == TRUE ) SendMessageToPC(GetFirstPC(),sTag + " <C=Red>must be destroyed</C> on area: "+GetTag(GetArea(oObject)));
			}
		}
	}
}

void Torch_System(string Tag, int Inverse)
{
	int TorchCount = 0;
	if (GetLocalInt(OBJECT_SELF,"ActualSteep")>0) //If the counter is bigger than 0
	{
		SetLocalInt(OBJECT_SELF,"ActualSteep",GetLocalInt(OBJECT_SELF,"ActualSteep")-1); //Decrease the counter
	}
	else //If the counter is 0 then fire the function that lights or extinguises the torches
	{
		SetLocalInt(OBJECT_SELF,"ActualSteep",30); //Delay in Rounds before firing the script again
		object oObject;
		
		oObject = GetObjectByTag(Tag, 0);
		while (GetIsObjectValid(oObject))
		{
			TorchCount++;
			if ((d4()==1)||(Inverse)) //25% of chances to extinguish/light the flame
			{
				lust_initialize (oObject);
				if (!Inverse)
				{
					if ((GetLocalInt(oObject,"Active")==0)&&(iIsDay()==0)) lust_switch(oObject);
					if ((GetLocalInt(oObject,"Active")==1)&&(iIsDay()==1)) lust_switch(oObject);
				}
				else
				{
					if ((GetLocalInt(oObject,"Active")==1)&&(iIsDay()==0)) lust_switch(oObject);
					if ((GetLocalInt(oObject,"Active")==0)&&(iIsDay()==1)) lust_switch(oObject);
				}
			}
			oObject = GetObjectByTag(Tag, TorchCount);
		}
		TorchCount = 0;
		oObject = GetObjectByTag("GabiraWindow", 0);
		while (GetIsObjectValid(oObject))
		{
			TorchCount++;
			lust_initialize (oObject);
			if ((GetLocalInt(oObject,"Active")==1)&&(iIsDay()==0)) lust_switch(oObject);
			if ((GetLocalInt(oObject,"Active")==0)&&(iIsDay()==1)) lust_switch(oObject);
			oObject = GetObjectByTag("GabiraWindow", TorchCount);
		}
	}
}

int iDayChange() //This function allows to know if there's a night to day or day to night change
{
	if (iIsDay()!=GetLocalInt(OBJECT_SELF, "Last_Result"))
	{ 
		SetLocalInt(OBJECT_SELF, "Last_Result", iIsDay());
		return TRUE;
	}
	else
	{
		SetLocalInt(OBJECT_SELF, "Last_Result", iIsDay());
		return FALSE;
	}
}

void main()
{
	count_master();
	if (iDayChange()) SetLocalInt(OBJECT_SELF,"ActualSteep",0); //On the Night/Day transition the torches will be fired Yes or Yes
	Torch_System("GabiraTorch", FALSE); //My torches are called "GabiraTorch" because my main town it's called gabira *shrugs*
}