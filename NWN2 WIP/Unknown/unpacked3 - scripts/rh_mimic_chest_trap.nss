void main ()
{
	object oChest	=	OBJECT_SELF;
	object oOpen	=	GetLastDisarmed();
	location lChest	=	GetLocation(oChest);
	effect eSpawn	=	EffectNWN2SpecialEffectFile("shaughn_mimic_spawn");
	string sTag		=	GetLocalString(oChest,"mimic_tag");
	int nOnce		=	GetLocalInt(oChest,"once");
	
	if (nOnce != 0)return;
	SetLocalInt(oChest,"once",1);
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSpawn,lChest);
	DestroyObject(oChest);
		
	CreateObject(OBJECT_TYPE_CREATURE,"c_mimic_shaughn",lChest,FALSE,sTag);
	
	object oMimic	= GetNearestObjectByTag(sTag,oOpen);
	
	ChangeToStandardFaction(oMimic,STANDARD_FACTION_HOSTILE);
	AssignCommand(oMimic,ActionAttack(oOpen,FALSE));
}