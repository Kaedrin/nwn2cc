
#include "hcr2_persistence_c"

void main()
{

object oPC = GetPCSpeaker();
   location lLoc = h2_GetSavedPCLocation(oPC);

   //only jump to saved location if the PC hasn't logged into this server
   //session previously. If they have been on before in this session, then
   //they will be placed at their last logout location by the server.
   //In short, persistent location data is only needed if the server has reset
   //between the PC's last logout and this login.			
   if (!GetLocalInt(oPC, "HSS_SERVER_SESSION"))
      {
      if (GetIsObjectValid(GetAreaFromLocation(lLoc)))
         {
	     AssignCommand(oPC, ClearAllActions());
	     AssignCommand(oPC, JumpToLocation(lLoc));
	     }
	     else
	     {
         SendMessageToPC(oPC, "No saved location or invalid saved location.");	  
	     }
	  SetLocalInt(oPC, "HSS_SERVER_SESSION", 1);
	  //SetGUIObjectHidden(oPC, "SCREEN_PLAYERMENU", "CLOCK_BUTTON", FALSE);//	 		  
	  }						
	
}