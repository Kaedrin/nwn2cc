// script_name qk_od_gworg
/*
	Description: It spawns a default goblin based on a reflex save after
	             worg's death
	
*/
// Name_Date Qk -20-1-09


void main()
{
	object oWorg = OBJECT_SELF;
	string sGobRef = GetLocalString(oWorg,"SpawnedMob");
	location lLoc = GetLocation(OBJECT_SELF);
	
	object oGob = 	CreateObject(OBJECT_TYPE_CREATURE,sGobRef,lLoc);
	int nDam = GetReflexAdjustedDamage(2*d6(),oGob,SAVING_THROW_REFLEX);
	
	effect eDamage = EffectDamage(nDam,DAMAGE_TYPE_ALL);
	effect eKnock = EffectKnockdown();
	
	
	if (nDam > 0)
	{
	DelayCommand(0.4,ApplyEffectToObject(0,eKnock,oGob));

	DelayCommand(0.5,ApplyEffectToObject(0,eDamage,oGob));
	}
}