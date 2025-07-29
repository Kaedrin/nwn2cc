//user defined

#include "maid_inc" 
void main()
{
int iTalk = GetListenPatternNumber();
int iUser = GetUserDefinedEventNumber();
object oPC = GetLastSpeaker();
object oBarmaid = OBJECT_SELF;

if (iTalk == 2001 || iTalk == 2002)
   {
    ActionWait(1.0);
    AssignCommand(oBarmaid, ActionMoveToObject(oPC));
    AssignCommand(oBarmaid, ActionStartConversation(oPC,"",TRUE,FALSE,FALSE,FALSE));
   }

return; 
}       