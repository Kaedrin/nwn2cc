#include "x2_inc_itemprop"


void main()	
{


	object oPC = GetLastOpenedBy();
	//SetXP(oPC,209000);
	SetXP(oPC,540000);
	
	object oCrush = GetObjectByTag("Crush");
	object oSlash = GetObjectByTag("Slash");
	object oPierce = GetObjectByTag("Pierce");	
	
	effect eSR = EffectSpellResistanceIncrease(20);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSR, oCrush);	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSR, oSlash);	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSR, oPierce);	
	
	
	
	/*
	SpeakString("Opening GUI for: " + GetName(oPC), TALKVOLUME_SHOUT);
	DisplayGuiScreen(oPC, "screen1", FALSE, "myfile.xml");			
	SetGUIObjectText(oPC, "screen1", "title", -1, "ABC");
	*/		
	
	/*
	int nType;
	effect eEffect = GetFirstEffect(oPC);
	while(GetIsEffectValid(eEffect))
   	{
      nType = GetEffectType(eEffect);
      if(nType == EFFECT_TYPE_DAMAGE_INCREASE)
	  {
	  	SendMessageToPC(oPC, "Name" + IntToString(GetEffectSpellId(eEffect)));
	  	SendMessageToPC(oPC, "0:" + IntToString(GetEffectInteger(eEffect, 0)));
	  	SendMessageToPC(oPC, "1:" + IntToString(GetEffectInteger(eEffect, 1)));
	  	SendMessageToPC(oPC, "2:" + IntToString(GetEffectInteger(eEffect, 2)));	  	
		SendMessageToPC(oPC, "3:" + IntToString(GetEffectInteger(eEffect, 3)));
		SendMessageToPC(oPC, "4:" + IntToString(GetEffectInteger(eEffect, 4)));
	  	SendMessageToPC(oPC, "5:" + IntToString(GetEffectInteger(eEffect, 5)));	
		RemoveEffect(oPC,eEffect);					
      }
      eEffect = GetNextEffect(oPC);
   	}
	
	object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
	itemproperty iProp = GetFirstItemProperty(oWeapon);
	while (GetIsItemPropertyValid(iProp))
	{

		if (GetItemPropertyType(iProp)==ITEM_PROPERTY_ENHANCEMENT_BONUS)
		{
		  	SendMessageToPC(oPC, "GetItemPropertyCostTable: " + IntToString(GetItemPropertyCostTable(iProp)));
		  	SendMessageToPC(oPC, "GetItemPropertyCostTableValue: " + IntToString(GetItemPropertyCostTableValue(iProp)));
		  	SendMessageToPC(oPC, "GetItemPropertyParam1: " + IntToString(GetItemPropertyParam1(iProp)));
		  	SendMessageToPC(oPC, "GetItemPropertyParam1Value: " + IntToString(GetItemPropertyParam1Value(iProp)));	  	
			SendMessageToPC(oPC, "GetItemPropertySubType: " + IntToString(GetItemPropertySubType(iProp)));
			SendMessageToPC(oPC, "GetItemPropertyType: " + IntToString(GetItemPropertyType(iProp)));
		  	SendMessageToPC(oPC, "GetItemPropertyDurationType: " + IntToString(GetItemPropertyDurationType(iProp)));				
		  	SendMessageToPC(oPC, "****");		
		}				
		iProp=GetNextItemProperty(oWeapon);
	}	
	*/
	
	//FeatAdd(oPC, 814, FALSE);
	
	
	
	
	/*
	object oNew = GetObjectByTag("shandra_xtc");
	object oOld = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
	SendMessageToPC(oPC,GetName(oOld));
	SendMessageToPC(oPC,GetName(oNew));
	//SetOwnersControlledCompanion(oOld,oNew);
	
	//AddHenchman(oPC,oNew);
	
	AddRosterMemberByTemplate("loganlogan","loganlogan");
	AddRosterMemberByTemplate("logandeslen2","logandeslen2");
	AddRosterMemberByTemplate("loganlogan","loganlogan");
	AddRosterMemberByTemplate("logandeslen2","logandeslen2");
	
	object oCom = GetObjectByTag("logandeslen2");	
	SetXP(oCom, 540000);
	oCom = GetObjectByTag("loganlogan");	
	SetXP(oCom, 540000);	
	*/
			
	/*
	effect eEff = EffectModifyAttacks(5);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	effect eLink = EffectLinkEffects(eEff,eVis);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink, oPC, 18.0f);
	SendMessageToPC(oPC,"Tes2t");
	*/

/*
	object oPC = GetLastOpenedBy();
	SetXP(oPC,540000);
	
	effect eAB = EffectAttackIncrease(20);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAB, oPC, 36.0f);	
	
	object oTroll = GetObjectByTag("c_troll");
	effect eConc = EffectConcealment(50);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,eConc, oTroll);
*/
	
	/*
	
		
	
	int nNum = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
	int nNum2 = GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE);
	int nNum3 = GetSubRace(oPC);
	string sVal = Get2DAString("racialsubtypes","DexAdjust",nNum3);
	
	SendMessageToPC(oPC,IntToString(nNum));
	SendMessageToPC(oPC,IntToString(nNum2));
	SendMessageToPC(oPC,IntToString(nNum3));
	SendMessageToPC(oPC,sVal);			



	effect eEffect = GetFirstEffect(oPC);
	while(GetIsEffectValid(eEffect))
	{
		RemoveEffect(oPC,eEffect);
		eEffect = GetNextEffect(oPC);
	}
	
	effect eBABMin = EffectBABMinimum(25);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBABMin, oPC, 18.0f);
	
	
	*/
	
	/*
	object oArrows = CreateItemOnObject("nw_wamar001", oPC, 99);
	itemproperty t1 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGEBONUS_1d6);
	itemproperty t2 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, IP_CONST_DAMAGEBONUS_1d6);
	IPSafeAddItemProperty(oArrows, t1, 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
	IPSafeAddItemProperty(oArrows, t2, 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING);	
	*/

	/*
	object oFletchKit = GetItemPossessedBy(oPC, "cmi_fletch_kit");
	if (oFletchKit == OBJECT_INVALID)
		oFletchKit = CreateItemOnObject("cmi_fletch_kit", oPC);	
	

	string sMold = "Invalid";
	string sIngot = "Invalid";
	string sWood = "Invalid";
	string sGems = "Invalid";
					
    object oItem = GetFirstItemInInventory(oFletchKit);
    while (GetIsObjectValid(oItem) == TRUE)
    {
	
		string resref = GetResRef(oItem);
		if (resref == "cmi_mold_arrow")
		{
			sMold = resref;
		}
		else
		if (resref == "n2_crft_ingiron")
		{
			sIngot = "n2_crft_ingiron";
		}
		else
		if (resref == "n2_crft_plkwood")
		{
			sWood = "n2_crft_plkwood";
		}		

		
		oItem = GetNextItemInInventory(oFletchKit);
    }
	
	if (sMold != "Invalid" && sIngot != "Invalid" && sWood != "Invalid")
	{
		object oArrows = CreateItemOnObject("nw_wamar001", oPC, 99);
	
	}
	
	*/
	
	
}