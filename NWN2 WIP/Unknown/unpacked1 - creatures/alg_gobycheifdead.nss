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

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "nwnx_sql"
#include "ginc_var_ops"
#include "ginc_param_const"

void main()
{
   ExecuteScript("pwfxp",OBJECT_SELF);
	string sDeathScript = GetLocalString(OBJECT_SELF, "DeathScript");
	if (sDeathScript != "")
		ExecuteScript(sDeathScript, OBJECT_SELF);
	
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();
    while (GetIsObjectValid(GetMaster(oKiller)))
   	{
   		oKiller=GetMaster(oKiller);
   	}

   	if (!GetIsPC(oKiller)) return;

   	int nInt;
	object nItem;
	object oPassport;

	// Loop on killer's party and advance quest
	// for those who have it.
	object oMember = GetFirstFactionMember(oKiller, TRUE);
	while (GetIsObjectValid(oMember)) {
				
  		nInt=GetLocalInt(oMember, "NW_JOURNAL_ENTRYGoblins");
   		nItem=GetItemPossessedBy(oMember, "shar_dagger");

    	if (nInt!=10 || nItem!=OBJECT_INVALID || GetDistanceBetween(oKiller, oMember) > 30.0)
	{
   			oMember = GetNextFactionMember(oKiller, TRUE);
    }
		else {

    		CreateItemOnObject("shar_dagger", oMember);

			oPassport = GetItemPossessedBy(oMember,"pc_tracker");	
			AddJournalQuestEntry("Goblins",20, oMember, FALSE, FALSE, TRUE);
    		SetPersistentInt(oMember, "Goblins", 20);
    		SetLocalInt(oPassport,"Goblins", 20);
	
			oMember = GetNextFactionMember(oKiller, TRUE);
		}
	}
	
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
	
}