void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYalg_chef");

if (nInt < 50)
   return;

if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, 15))
   {
   CreateItemOnObject("alg_mudwart", oPC);
   AddJournalQuestEntry("alg_chef", 60, oPC, FALSE, FALSE);

   }
}