//Script for Old Skulls Inn Cooks quest
//this part fires when player clicks on the rock spoawned from 
//the conversation

object oTarget;

void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;
//check for quest started
if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYalg_chef")>= 50)
   {
   //debug
   SendMessageToAllDMs("inside journal entry chef call and player " + GetName(oPC));
   //give player item
   CreateItemOnObject("alg_mudwart", oPC);
   oTarget = OBJECT_SELF;
   //journal functions
   DelayCommand(30.0, AddJournalQuestEntry("alg_chef", 60, oPC, FALSE, FALSE));
   ExecuteScript("alg_journalscript", oPC);
   //destroy the rock so someone else can do the quest
   DestroyObject(oTarget, 0.0);
  
   }
}