//Put this script OnEnter
#include "nwnx_sql"
#include "hcr2_core_i"

#include "hv_find_players_inc"
#include "cmi_includes"
#include "alex_constants"
#include "hv_chat_commands"
#include "ginc_2da"

void main()
{
	object oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC)) return;
	
	 // Swiftblade
	 if ((GetLevelByClass(113, oPC) > 0) && (!GetHasFeat(2261, oPC)))
	  FeatAdd(oPC, 2261, FALSE, TRUE, TRUE);
	  
	 // Forest Master
	 if ((GetLevelByClass(114, oPC) > 0) && (!GetHasFeat(2262, oPC)))
	  FeatAdd(oPC, 2262, FALSE, TRUE, TRUE);
	  
	 // Canaith Lyrist
	 if ((GetLevelByClass(124, oPC) > 0) && (!GetHasFeat(2263, oPC)))
	  FeatAdd(oPC, 2263, FALSE, TRUE, TRUE);
	  
	 // Champion of the wild
	 if ((GetLevelByClass(126, oPC) > 0) && (!GetHasFeat(2264, oPC)))
	  FeatAdd(oPC, 2264, FALSE, TRUE, TRUE);
	  
	 // ELDRITCH_DISCIPLE
	 if ((GetLevelByClass(117, oPC) > 0) && (!GetHasFeat(2265, oPC)))
	  FeatAdd(oPC, 2265, FALSE, TRUE, TRUE);
	  
	 // HEARTWARDER
	 if ((GetLevelByClass(131, oPC) > 0) && (!GetHasFeat(2266, oPC)))
	  FeatAdd(oPC, 2266, FALSE, TRUE, TRUE);
	  
	 // DRAGON_DISCIPLE
	 if ((GetLevelByClass(37, oPC) > 0) && (!GetHasFeat(2267, oPC)))
	  FeatAdd(oPC, 2267, FALSE, TRUE, TRUE);
	  
	 // Child of Night
	 if ((GetLevelByClass(140, oPC) > 0) && (!GetHasFeat(2272, oPC)))
	  FeatAdd(oPC, 2272, FALSE, TRUE, TRUE);
	  
	//Run this code if a local int/DB value is not set
	//It should probably be in the login code /OOC area
    /*
    int nFavoredSoul = GetLevelByClass(CLASS_TYPE_FAVORED_SOUL);
    if (nFavoredSoul > 0)
    {
    	string sDeity = GetDeity(oPC);
        int nIndex = FindSubString(sDeity, " ");        // Deities with a first and last name are returned together by the GetDeity call
        string sDeity2;
        if (nIndex != -1)
        {
            sDeity2 = GetSubString(sDeity, 0, nIndex);
            //SendMessageToPC(oPC, "sDeity2: " + sDeity2);       
        }
        else
            sDeity2 = sDeity;
       
        int nDeity = Search2DA("nwn2_deities", "FirstName", sDeity2);
       
        //Add Prof
        int nWpnProf = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponProficiency", nDeity));
        if (!GetHasFeat(nWpnProf))
        {
            FeatAdd(oPC, nWpnProf, FALSE, TRUE, TRUE);
        }
       
        //Add Focus
        if (nFavoredSoul > 2)
        {
            nWpnProf = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponFocus", nDeity));
            if (!GetHasFeat(nWpnProf))
            {
                FeatAdd(oPC, nWpnProf, FALSE, TRUE, TRUE);
            }
        }
       
        //Add Spec
        if (nFavoredSoul > 11)
        {
            nWpnProf = StringToInt(Get2DAString("nwn2_deities", "FavoredWeaponSpecialization", nDeity));
            if (!GetHasFeat(nWpnProf))
            {
                FeatAdd(oPC, nWpnProf, FALSE, TRUE, TRUE);
            }
        }               
    }*/
	  
	object oPassport = GetItemPossessedBy(oPC,"pc_tracker"); 
	
   	// Update quests
	string sQuest = GetPersistentString(oPC, "Goblins");
	if (sQuest != "")
		AddJournalQuestEntry("Goblins", StringToInt(sQuest), oPC, FALSE, FALSE);
	
	sQuest = GetPersistentString(oPC, "alg_chef");
	if (sQuest != "")
		AddJournalQuestEntry("alg_chef", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "ellas_uber_chicken");
	if (sQuest != "")
		AddJournalQuestEntry("ellas_uber_chicken", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_captured_dryad");
	if (sQuest != "")
		AddJournalQuestEntry("hv_captured_dryad", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "alex_ghost");
	if (sQuest != "")
		AddJournalQuestEntry("alex_ghost", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "Richard");
	if (sQuest != "")
		AddJournalQuestEntry("Richard", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_historian");
	if (sQuest != "")
		AddJournalQuestEntry("hv_historian", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_beastmen");
	if (sQuest != "")
		AddJournalQuestEntry("hv_beastmen", StringToInt(sQuest), oPC, FALSE, FALSE);	

	sQuest = GetPersistentString(oPC, "hv_temple_quest");
	if (sQuest != "")
		AddJournalQuestEntry("hv_temple_quest", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_arena_survival_5");
	if (sQuest != "")
		AddJournalQuestEntry("hv_arena_survival_5", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_arena_survival_10");
	if (sQuest != "")
		AddJournalQuestEntry("hv_arena_survival_10", StringToInt(sQuest), oPC, FALSE, FALSE);	

	sQuest = GetPersistentString(oPC, "hv_arena_survival_15");
	if (sQuest != "")
		AddJournalQuestEntry("hv_arena_survival_15", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_arena_survival_20");
	if (sQuest != "")
		AddJournalQuestEntry("hv_arena_survival_20", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "redvibe_avault");
	if (sQuest != "")
		AddJournalQuestEntry("redvibe_avault", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_bandits_quest");
	if (sQuest != "")
		AddJournalQuestEntry("hv_bandits_quest", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_p_h");
	if (sQuest != "")
		AddJournalQuestEntry("hv_p_h", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "hv_cq");
	if (sQuest != "")
		AddJournalQuestEntry("hv_cq", StringToInt(sQuest), oPC, FALSE, FALSE);
		
	sQuest = GetPersistentString(oPC, "AlexGnolls");
	if (sQuest != "")
		AddJournalQuestEntry("AlexGnolls", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "xenq_deb");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_deb", StringToInt(sQuest), oPC, FALSE, FALSE);
		
	sQuest = GetPersistentString(oPC, "xenq_trollblood");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_trollblood", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "xenq_arena_30");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_arena_30", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "LegendsQuest1000");
	if (sQuest != "")
		AddJournalQuestEntry("LegendsQuest1000", StringToInt(sQuest), oPC, FALSE, FALSE);	
	
	sQuest = GetPersistentString(oPC, "drow_lore_test");
	if (sQuest != "")
		AddJournalQuestEntry("drow_lore_test", StringToInt(sQuest), oPC, FALSE, FALSE);
		
	sQuest = GetPersistentString(oPC, "xenq_ud_evvnark");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_evvnark", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "xenq_ud_beetlemeatbounty");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_beetlemeatbounty", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
	sQuest = GetPersistentString(oPC, "xenq_ud_yathrinquest");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_yathrinquest", StringToInt(sQuest), oPC, FALSE, FALSE);
		
	sQuest = GetPersistentString(oPC, "xenq_ud_uuthli");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_uuthli", StringToInt(sQuest), oPC, FALSE, FALSE);
		
	sQuest = GetPersistentString(oPC, "xenq_ud_khaliizi");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_khaliizi", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magmyconid");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magmyconid", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magderro");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magderro", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magazer");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magazer", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magroper");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magroper", StringToInt(sQuest), oPC, FALSE, FALSE);	
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magkuotoa");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magkuotoa", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magbeholder");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magbeholder", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		sQuest = GetPersistentString(oPC, "xenq_ud_magminotaur");
	if (sQuest != "")
		AddJournalQuestEntry("xenq_ud_magminotaur", StringToInt(sQuest), oPC, FALSE, FALSE);
		
		
		
		
		
		
		
		
				
			
	if (GetXP(oPC)==0)
	{
   		GiveGoldToCreature(oPC, 1000, TRUE);
   		GiveXPToCreature(oPC,1000);
		CreateItemOnObject("pc_tracker", oPC);
		//SetLocalInt(oPC, FIND_PLAYERS_VAR, 2);
		//SetPersistentInt(oPC, FIND_PLAYERS_VAR, 2, 0, "dbtools");
	}
	
	/*
	if (GetItemPossessedBy(oPC, "alex_rulesbook")==OBJECT_INVALID)
   	{
   		CreateItemOnObject("alex_rulesbook", oPC);
   	}
	*/
	
	// Persistent scry tool retrieval
	SetLocalInt(oPC, FIND_PLAYERS_VAR, GetPersistentInt(oPC, FIND_PLAYERS_VAR, "dbtools"));
	
	// Persistent KO Mode
	SetLocalInt(oPC, "hv_ko_mode", GetPersistentInt(oPC, "hv_ko_mode", "dbtools"));
	
	// Persistent Tracking Mode
	SetLocalInt(oPC, "SHOW_TRACKING", GetPersistentInt(oPC, "SHOW_TRACKING", "dbtools"));

	// Persistent RP_XP total
	SetLocalInt(oPC, "RP_XP_TOTAL", StringToInt(GetPlayerInfo(oPC, "RP_XP_TOTAL", "playerinfo")));

	// Reset chat for AFK system
	SetLocalInt(oPC, AFK_CHAT, 1);
	
	// Reset timestamp on PC
	if (GetPlayerInfo(oPC, "hv_dm_interaction") == "")
		SetPlayerInfo(oPC, "hv_dm_interaction", "0");
		
   	//if they do not have a passport create one
	int nDoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

	if (nDoOnce==TRUE) return;

	SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

	//if (GetItemPossessedBy(oPC, "pc_tracker")== OBJECT_INVALID)
   	//{
   	//	CreateItemOnObject("pc_tracker", oPC);
   	//	//GiveGoldToCreature(oPC, 1000, TRUE);
   	//	//GiveXPToCreature(oPC,1000);
   	//}
	
	/*if (GetItemPossessedBy(oPC, "rp token box")== OBJECT_INVALID)
	{
		CreateItemOnObject("rp token box", oPC);
   	}*/
}