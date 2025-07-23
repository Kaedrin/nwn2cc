#include "ginc_companion"

void main()
{
	object oEnter	=	GetEnteringObject();
	string sTag		=	GetTag(oEnter);	
	effect eGlow	=	EffectNWN2SpecialEffectFile("fx_hit_spark_aoo");
	string sChest	=	GetLocalString(OBJECT_SELF,"chest_tag");
	object oChest	=	GetNearestObjectByTag(sChest);
	location lChest	=	GetLocation(oChest);
	int nDC			=	d20(1)+13;
	
	
	if(!GetIsPC(oEnter) && !IsInParty(sTag))return;
	if(GetIsInCombat(oEnter) || IsInConversation(oEnter))return;
	
	if(GetIsSkillSuccessful(oEnter,SKILL_SPOT,nDC,FALSE))
	{
		PlayVoiceChat(VOICE_CHAT_LOOKHERE,oEnter);
		ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eGlow,lChest);
		AssignCommand(oEnter,ActionSpeakString("There is something wrong with that chest."));
	}
	
	DestroyObject(OBJECT_SELF);
}