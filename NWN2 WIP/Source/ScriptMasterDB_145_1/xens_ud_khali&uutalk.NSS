//Author: Xeneize
//Convo between Khaliizi and Uuthli

//Put this script OnEnter
void main()

{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetHitDice(oPC) > 15)
   return;

if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYxenq_ud_uuthli")>= 861260)
   return;
if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYxenq_ud_khaliizi")>= 861270)
   return;
   if (GetLocalInt(OBJECT_SELF, "bLocked") == TRUE)
        return;

    SetLocalInt(OBJECT_SELF, "bLocked", TRUE);
   {
   DelayCommand(3.0, AssignCommand(GetObjectByTag("gac_xen_ud_uuthli_quest"), ActionSpeakString("Usstan have a new technique to carve out a heart lined up.")));

   DelayCommand(10.0, AssignCommand(GetObjectByTag("gac_xen_ud_khaliizi_quest"), ActionSpeakString("That's B'wael and all but what will dos test it on? Usstan got a Gol right here, clear up the altar already!")));

   DelayCommand(20.0, AssignCommand(GetObjectByTag("gac_xen_ud_uuthli_quest"), ActionSpeakString("Oh Xas? And with what are dos going to do it? Dos lost dossta  dagger.")));

   DelayCommand(30.0, AssignCommand(GetObjectByTag("gac_xen_ud_khaliizi_quest"), ActionSpeakString("Hush! Usstan will get ussa dagger soon, meanwhile dos can stare at ussa Gol.. but not touch *She grins at her*")));

   DelayCommand(40.0, AssignCommand(GetObjectByTag("gac_xen_ud_uuthli_quest"), ActionSpeakString("Ussa sacrifice is on its way. As for staring at dossta, usstan will when usstan need a reminder of what dos look like *She smirks* ")));
   
   DelayCommand(40.1, SetLocalInt(OBJECT_SELF, "bLocked", FALSE));
   }
}
