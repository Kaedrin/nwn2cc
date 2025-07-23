//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death. 
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
// chazm 5/6/05 added DeathScript
// ChazM 7/28/05 removed call to user defined event for onDeath
// ChazM - 1/26/07 - EvenFlw modifications
// ChazM -5/17/07 - Spirits don't drop crafting items, removed re-equip weapon code
// JSH-OEI 5/28/08 - NX2 campaign version.

void HostileBoss(); // declare function

#include "x2_inc_compon"
#include "x0_i0_spawncond"

void main()
{
ExecuteScript("iq_bb_death",OBJECT_SELF); 

 
   
ExecuteScript("pwfxp",OBJECT_SELF);
	string sDeathScript = GetLocalString(OBJECT_SELF, "DeathScript");
	if (sDeathScript != "")
		ExecuteScript(sDeathScript, OBJECT_SELF);
	
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
	
	/*if (!GetIsSpirit(OBJECT_SELF))
    	craft_drop_items(oKiller);*/
		
	HostileBoss();
	
}

// Here I want to check if all four summoners were killed.
// If so, make boss say something and turn hostile.
void HostileBoss()
{
	object oArea = GetArea(OBJECT_SELF);
	int nSummonersKilled = GetLocalInt(oArea, "hv_hostile_boss");
	
	// Increment by one since this one just died
	nSummonersKilled++;
	SetLocalInt(oArea, "hv_hostile_boss", nSummonersKilled);
	
	if (nSummonersKilled == 4) {
		
		// Make boss speak
		object oBoss = GetObjectByTag("hv_temple_boss");
		if (GetIsObjectValid(oBoss)) {
			AssignCommand(oBoss, SpeakString("You cannot ssstop me foolss! I ssshall enter your realm and dessstroy you all! The summoning will continue!"));
		
			// Make it hostile
			DelayCommand(2.0f, ChangeToStandardFaction(oBoss, STANDARD_FACTION_HOSTILE));
			
			// For area heartbeat - signal to start creating
			// the glowing orbs from the pillars
			SetLocalInt(oArea, "hv_create_orbs", 1);
			
			// Make pillars destructible
			// 8 pillars
			int i;
			object oPillar;
			for (i = 0; i < 8; i++) {
				oPillar = GetObjectByTag("hv_green_pillar", i);
				SetPlotFlag(oPillar, FALSE);
			}
		}
	}
}