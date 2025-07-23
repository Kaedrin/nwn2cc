//Put this in ON ENTER script of a trigger.
//Creator: Xeneize @2014
//Copyrights: Dalelands Beyond Scripting Team

//Put this on Used for an item.

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetIsSkillSuccessful(oPC, SKILL_SURVIVAL, 30))
   {
   ActionStartConversation(oPC, "xenc_kemo_storage_outdoors");

   }
}



