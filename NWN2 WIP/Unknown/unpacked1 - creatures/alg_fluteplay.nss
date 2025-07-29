void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
ClearAllActions();

ActionPlayAnimation(ANIMATION_LOOPING_GUITARPLAY,1.0,600.0);

}