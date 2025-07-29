void main()
{

object oPC = GetPCSpeaker();

ActionWait(5.0f);

ActionMoveToObject(GetObjectByTag("wp_vlv_bob"), TRUE);

object oTarget;
oTarget = OBJECT_SELF;

DestroyObject(oTarget, 0.0);

}