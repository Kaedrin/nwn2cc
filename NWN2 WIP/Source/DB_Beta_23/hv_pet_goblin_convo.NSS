void main()
{
int iTalk = GetListenPatternNumber();
object oPC = GetLastSpeaker();
object oGobo = OBJECT_SELF;

if (GetMaster() == oPC)

if (iTalk == 2001 || iTalk == 2002)
   {
   	AssignCommand(oGobo, SpeakString("<C=orange>Commin' mastah!"));
    ActionWait(1.0);
    AssignCommand(oGobo, ActionMoveToObject(oPC));
    AssignCommand(oGobo, ActionStartConversation(oPC,"",TRUE,FALSE,FALSE,FALSE));
   }

return; 
}       