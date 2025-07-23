#include "lust_torch_functions"

void main()
{
	int iDebug = 0; //Debug mode On/Off 1/0
	if (iDebug == 1) SpeakString("<C=#777790>:: Controller Heartbeat::</C>" ,TALKVOLUME_TALK); //Debug_Line
	int i = 0;
	object MyTorch;
	string sTorchName = "Lust_GTorch_";
	int IsDay = 0; if ((GetTimeHour()>5)&&(GetTimeHour()<18)) IsDay = 1;
	int Delayer = 18; //Rounds until fire the script
	int ActualSteep = GetLocalInt(OBJECT_SELF,"ActualSteep");
	if (ActualSteep<Delayer)
	{
		if (iDebug == 1) SpeakString("<C=#777777>::Actual Steep: "+IntToString(ActualSteep)+", increasing +1::</C>" ,TALKVOLUME_TALK); //Debug_Line
		SetLocalInt(OBJECT_SELF,"ActualSteep",ActualSteep+1);
	}
	else
	{
		SetLocalInt(OBJECT_SELF,"ActualSteep",0);
		if (iDebug == 1) SpeakString("<C=#FFFF77>::Active Heartbeat::</C>" ,TALKVOLUME_TALK); //Debug_Line
		while (i<512) //Maximun lights allowed = n-1
			{
				if (iDebug == 1) SpeakString("<C=#777777>::Target: "+sTorchName+IntToString(i)+"::</C>" ,TALKVOLUME_TALK); //Debug_Line
				MyTorch = GetObjectByTag(sTorchName+IntToString(i));
				if (GetIsObjectValid(MyTorch)==FALSE) break; //If there are no more lights, then stop!
				if (d2(1)==1)
				{//Do not lit or extinguish all the torches at the same time
					if (iDebug == 1) SpeakString("<C=#777777>::d2 Success!::</C>" ,TALKVOLUME_TALK); //Debug_Line
					if((GetLocalInt(MyTorch,"Active")==1)&&(IsDay==1))
					{
						AssignCommand(MyTorch,lust_switch(MyTorch));
						if (iDebug == 1) SpeakString("<C=#FF7777>::Unlit a torch::</C>" ,TALKVOLUME_TALK); //Debug_Line
					}
					if((GetLocalInt(MyTorch,"Active")==0)&&(IsDay==0))
					{
						AssignCommand(MyTorch,lust_switch(MyTorch));
						if (iDebug == 1) SpeakString("<C=#FF7777>::Lit a torch::</C>" ,TALKVOLUME_TALK); //Debug_Line
					}
				}
				i++;
			}
		}
	if ((iDebug == 1)&&(IsDay ==1)) SpeakString("<C=#779077>::It's Day-time::</C>" ,TALKVOLUME_TALK); //Debug_Line
	if ((iDebug == 1)&&(IsDay ==0)) SpeakString("<C=#777790>::It's Night-time::</C>" ,TALKVOLUME_TALK); //Debug_Line
	if (iDebug == 1) SpeakString("<C=#303030>::Time: "+IntToString(GetTimeHour())+", minutes: "+IntToString(GetTimeMinute())+", end::</C>" ,TALKVOLUME_TALK); //Debug_Line
}