// script_name: gui_hss_no_con_2
/*
	Description:
	
	GUI script to handle adjustments to the examine screen in order to
	hide the CR if a creature is examined.
	
	Note: this package should not be considered as entirely secure in terms
	of circumvention. If a player wants to see the CR's on creatures there
	are ways to see them with this package in use. CR's should never be
	visible through the course of normal play, but extraordinary measures
	outside of the playing environment can be taken so that CR's will be
	displayed as usual. To be blunt, someone who is willing to "cheat" can
	find a way around this solution.
	
	I was hoping to see the server side switch to handle this get implemented
	by now and not need to release this package, but it doesn't seem to be on
	the near horizon.
	
	Known Issues: using the "Default Action: Examine" option in the toolset
	for placeable objects can break the examine text for that placeable. You
	can use the onclick or onuse event to assign an examine action instead.
	If the player has the "Auto-set target with Action" option set, then the
	examine text will be fine. It's only if the placeable is set to the
	default action of examine and the player has auto-set target off that
	this will be an issue. Basically, it's because I need to find the kind of
	object that is being examined so I can adjust the examine screen accordingly,
	and the default action examine doesn't require a target object selection.
	(i.e. you can have something else up in the examine window while triggering
	the examine event on a default action examine placeable).
	
*/
// Name_Date: Heed. May 10th, 2007.

void main()
{

   object oPC = OBJECT_SELF;
   object oTarget = GetPlayerCurrentTarget(oPC);
   object oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR);
   string sPad = "                                                     " +
   "                                                                   " +
   "                                                                   " +
   "                                                                   " +
   "                                                                   " +
   "                                                                   " +
   "  "; 

   if (GetIsObjectValid(oFam) && GetIsPossessedFamiliar(oFam))
      {
	  oPC = oFam;
	  oTarget = GetPlayerCurrentTarget(oFam);
	  }   
   
   //cover the entire screen for a moment   
   SetGUIObjectHidden(oPC, "SCREEN_EXAMINE", "HSS_NOCR_MASK", FALSE);

   //objects with a CR                   
   if (GetAbilityScore(oTarget, ABILITY_WISDOM) > 0)
      {
      //SetGUIObjectText(oPC, "SCREEN_EXAMINE", "HSS_NOCR_PAD", -1, " ");
      //SetGUIObjectText(oPC, "SCREEN_EXAMINE", "HSS_NOCR_PAD2", -1, " ");	  
      }
   //non CR objects
      else
      {
      SetGUIObjectText(oPC, "SCREEN_EXAMINE", "HSS_NOCR_PAD", -1, sPad);
      SetGUIObjectText(oPC, "SCREEN_EXAMINE", "HSS_NOCR_PAD2", -1, sPad);	  
      }

   //uncover the screen:	  
   //need to run a slight delay as the CR will appear for a brief moment as
   //the change between a non CR examination and a CR examination object occurs.	  	  
   DelayCommand(0.1, SetGUIObjectHidden(oPC, "SCREEN_EXAMINE",
               "HSS_NOCR_MASK", TRUE));      
  
}