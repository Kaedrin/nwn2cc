// ga_conversation_self
/*
   start a conversation file with yourself.

   Parameters:
     string sConversation = Conversation file to start.
*/
// ChazM 2/25/06
// MustangSVT 04/10/2011

// #include "ginc_param_const"
	
void main(string sConversation)
{
	//object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	//AssignCommand(oPC, ActionStartConversation(oPC, sConversation, TRUE, FALSE));
	SendMessageToPC(GetFirstPC(TRUE), "Duh2");	
	SetXP(GetFirstPC(TRUE), 119000);
}