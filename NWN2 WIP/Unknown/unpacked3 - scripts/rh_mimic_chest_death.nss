void main()
{
	object oChest	=	OBJECT_SELF;
	location lChest	=	GetLocation(oChest);
	object oKiller	=	GetLastKiller();
	effect eDeath	=	EffectNWN2SpecialEffectFile("shaughn_mimic_spawn");
	effect eDamage	=	EffectDamage(100,DAMAGE_TYPE_ALL,DAMAGE_POWER_NORMAL,TRUE);
	string sTag		=	GetLocalString(oChest,"mimic_tag");
	int nOnce		=	GetLocalInt(oChest,"once");
	
	if (nOnce != 0)return;
	SetLocalInt(oChest,"once",1);
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eDeath,lChest);
	DestroyObject(oChest);
	
	CreateObject(OBJECT_TYPE_CREATURE,"c_mimic_shaughn",lChest,FALSE,sTag);
	object oMimic	= GetNearestObjectByTag(sTag,oKiller);
	
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oMimic);
	PlayVoiceChat(VOICE_CHAT_DEATH,oMimic);
}