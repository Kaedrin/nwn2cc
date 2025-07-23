/*
Filename:           hcr2_exportchars
System:             core (timer script to export characters)
Author:             Edward Beck (0100010)
Date Created:       Dec 9th, 2006.
Summary:
An example for an executed Timer event
which exports all  PC's each time the script is fired from the elapsed timer.

-----------------
Revision: v1.01
Removed uneeded include reference.

*/

void main()
{
	ExportAllCharacters();
	
	/*
	object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC) == TRUE)
    {
		if(GetIsDM(oPC)==FALSE)
		{
			if(GetLevelByClass(CLASS_TYPE_DRUID, oPC)==0)
			{
				ExportSingleCharacter(oPC);
			}
			else
			{
				int nDruidSave = GetGlobalInt("druid_save");
				if(nDruidSave==0)
				{
					nDruidSave++;
					SetGlobalInt("druid_save", nDruidSave);
				}
				else if(nDruidSave==3)
				{
					ExportSingleCharacter(oPC);
					SetGlobalInt("druid_save", 0);
				}
			}
		}
        oPC = GetNextPC();
	}*/		
}