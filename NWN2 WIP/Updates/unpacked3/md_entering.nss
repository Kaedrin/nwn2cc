void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

SendMessageToPC(oPC, "As you enter the city the smell of many cooking fires wafts toward you, every open spot is occupied by  tents.");

}
