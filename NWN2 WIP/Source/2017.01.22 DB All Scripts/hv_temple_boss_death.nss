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

#include "nwnx_sql"
void TheBossIsDead(); // declare function

#include "x2_inc_compon"
#include "x0_i0_spawncond"

void main()
{
	//ExecuteScript("iq_bb_death",OBJECT_SELF); 

 
   
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
		
	TheBossIsDead();
	
}

// Give XP to the party,
// Make boss say his last words.
void TheBossIsDead()
{
	SpeakString("Nooo! Thisss isss not that lasst you'll ssee of me! I WILL be free from my prissson!");
	
	// Go through killers party to give out XP
	object oPC = GetLastKiller();
	object oMember = GetFirstFactionMember(oPC, TRUE);
	while (GetIsObjectValid(oMember)) {
		//GiveXPToCreature(oMember, 500);
		if (GetJournalEntry("hv_temple_quest", oMember) == 500) {
			object oPassport = GetItemPossessedBy(oMember,"pc_tracker");	
			int nCurrentRank = GetPersistentInt(oMember, "RANK", "RP_Rank");
			AddJournalQuestEntry("hv_temple_quest", 510, oMember, FALSE);
			SetPersistentInt(oMember, "hv_temple_quest", 510);
			SetLocalInt(oPassport,"hv_temple_quest", 510);
			SetPersistentInt(oMember, "RANK", (nCurrentRank + 1), 0, "RP_Rank");
			AssignCommand(oMember, SpeakString("<C=lightgreen><i>*A chest appears in the middle of the chamber."));
		}
		oMember = GetNextFactionMember(oPC);
	}
	
	// Create chest
	object oChestWP = GetObjectByTag("hv_temple_boss_wp");
	location lChest = GetLocation(oChestWP);
	CreateObject(OBJECT_TYPE_PLACEABLE, "hv_temple_chest", lChest);
}