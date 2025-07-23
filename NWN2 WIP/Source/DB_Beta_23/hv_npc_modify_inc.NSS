// Constants

const int IP_CONST_BIGBY_1 = 211;
const int IP_CONST_BIGBY_2 = 212;
const int IP_CONST_BIGBY_3 = 213;
const int IP_CONST_BIGBY_4 = 214;

const int IP_CONST_FEAT_EPIC_DODGE = 436;
const int IP_CONST_FEAT_CONCEAL_10 = 437;
const int IP_CONST_FEAT_CONCEAL_20 = 438;
const int IP_CONST_FEAT_CONCEAL_30 = 439;
const int IP_CONST_FEAT_CONCEAL_40 = 440;
const int IP_CONST_FEAT_CONCEAL_50 = 441;


// Functions for NPC Modification GUI

// Empty creature skin tag
const string EMPTY_SKIN = "hv_empty_skin";

// Declaration

// Get ecl of creature
int GetECL(object oNPC);

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel, object oNPC);

// Set new create level and package
void SetNewLevelAndPackage(object oNPC, int nPackage, int nLevel);

// Increase base ability score by 1
void IncreaseAbilityScore(object oNPC, int nAbility, string sAction);

// Get the creature skin properties if oNPC has one
void ExamineCreatureSkinProperties(object oNPC, object oDM);

// Initialize gui panel
void InitializeUIPanel(object oDM);

// Create creature skin with selected properties,
// and equip it to the selected npc
void CreateAndEquipSkin(object oNPC, string sProperty1, string sProperty2, string sProperty3);

// Get creature's skin. If it doesn't have one,
// Create a new one on the creature and return it.
object GetCreatureSkin(object oNPC);

// Remove all properties from oItem
void RemoveAllProperties(object oItem);

// Add misc immunities to creature's skin
void AddMiscImmunities(object oNPC, string sDeath, string sCritial, string sSneak, string sKnock, string sMind, string sPara, string sBigby, string sSpells, string sSpellsLevel, string sKeepOld);

// Get requested immunity percentage
int GetImmunityPercentage(string sPercentage);

// Add physical immunities (slashing/bludge/piercing)
void AddPhysicalImmunities(object oNPC, string sSlashing, string sSlashingPercentage, string sBludgeoning, string sBludgeoningPercentage, string sPiercing, string sPiercingPercentage, string sKeepOld);

// Add elemtal immunities (fire/cold/acid/elect.)
void AddElementalImmunities(object oNPC, string sFire, string sFirePercentage, string sCold, string sColdPercentage, string sAcid, string sAcidPercentage, string sElect, string sElectPercentage, string sKeepOld);

// Add magical immunities (magic/sonic/negative/positive)
void AddMagicalImmunities(object oNPC, string sMagical, string sMagicalPercentage, string sSonic, string sSonicPercentage, string sNegative, string sNegativePercentage, string sPositive, string sPositivePercentage, string sKeepOld);

// Add misc properties
void AddMiscProperties(object oNPC, string sHaste, string sTrueSeeing, string sListenSpot, string sRegen, string sRegenAmount, string sKeepOld);

// Add feats
void AddFeats(object oNPC, string sDodge, string sConceal, string sConcealPercentage, string sKeepOld);

// Get the feat ID of the requested concealemnt percentage
int GetConcealmentFeatID(string sConcealmentPercentage);

// Re-equip skin to apply changes
void ReequipCreatureSkin(object oNPC, object oSkin);

// Implementation

// Get level (1-30) and return it in XP value
int GetXPForLevel(int nLevel, object oNPC)
{
	int nECL = GetECL(oNPC);
	nLevel = nLevel + nECL;
	int nXP = (nLevel * (nLevel - 1) / 2) * 1000;
	return nXP;
}

// Set new create level and package
void SetNewLevelAndPackage(object oNPC, int nPackage, int nLevel)
{	
	SetLevelUpPackage(oNPC, nPackage);
	int nXP = GetXPForLevel(nLevel, oNPC);
	ResetCreatureLevelForXP(oNPC, nXP, FALSE);
	ForceRest(oNPC);
}

// Increase base ability score by 1
void IncreaseAbilityScore(object oNPC, int nAbility, string sAction)
{
	int nCurrentScore = GetAbilityScore(oNPC, nAbility, TRUE);
	
	if (sAction == "inc")
		SetBaseAbilityScore(oNPC, nAbility, nCurrentScore + 1);
	else if (sAction == "dec")
		SetBaseAbilityScore(oNPC, nAbility, nCurrentScore - 1);
		
	ForceRest(oNPC);
}

// Get the creature skin properties if oNPC has one
void ExamineCreatureSkinProperties(object oNPC, object oDM)
{
	// Check if creature is wearing skin
	object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oNPC);
	if (GetIsObjectValid(oSkin) == FALSE) {
		SendMessageToPC(oDM, "<C=pink>Creature doesn't have a skin.");
		return;
	}
		
	ActionExamine(oSkin);
}

// Initialize gui panel
void InitializeUIPanel(object oDM)
{
	ClearListBox(oDM, "hv_npc_modify", "PACKAGES_LIST");
	string sName = "PACKAGE_NAME=Barbarian";
	string sIcon = "PACKAGE_ICON=ic_b_barbarian.tga";
	string sVariables = "0=0";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row1",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Bard";
	sIcon = "PACKAGE_ICON=ic_b_bard.tga";
	sVariables = "0=1";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row2",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Cleric";
	sIcon = "PACKAGE_ICON=ic_b_cleric.tga";
	sVariables = "0=2";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row3",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Druid";
	sIcon = "PACKAGE_ICON=ic_b_druid.tga";
	sVariables = "0=3";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row4",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Fighter";
	sIcon = "PACKAGE_ICON=ic_b_fighter.tga";
	sVariables = "0=4";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row5",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Monk";
	sIcon = "PACKAGE_ICON=ic_b_monk.tga";
	sVariables = "0=5";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row6",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Paladin";
	sIcon = "PACKAGE_ICON=ic_b_paladin.tga";
	sVariables = "0=6";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row7",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Ranger";
	sIcon = "PACKAGE_ICON=ic_b_ranger.tga";
	sVariables = "0=7";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row8",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Rogue";
	sIcon = "PACKAGE_ICON=ic_b_rogue.tga";
	sVariables = "0=8";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row9",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Sorcerer";
	sIcon = "PACKAGE_ICON=ic_b_sorcerer.tga";
	sVariables = "0=9";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row10",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Wizard";
	sIcon = "PACKAGE_ICON=ic_b_wizard.tga";
	sVariables = "0=10";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row11",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Warlock";
	sIcon = "PACKAGE_ICON=ic_b_warlock.tga";
	sVariables = "0=131";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row12",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Arcane Archer";
	sIcon = "PACKAGE_ICON=ic_b_arcanearcher.tga";
	sVariables = "0=65";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row13",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Assassin";
	sIcon = "PACKAGE_ICON=ic_b_assassin.tga";
	sVariables = "0=66";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row14",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Blackguard";
	sIcon = "PACKAGE_ICON=ic_b_blackguard.tga";
	sVariables = "0=67";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row15",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Dwarven Defender";
	sIcon = "PACKAGE_ICON=ic_b_dwarvendefender.tga";
	sVariables = "0=89";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row16",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Pale Master";
	sIcon = "PACKAGE_ICON=ic_b_palemaster.tga";
	sVariables = "0=110";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row17",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Dragon Disciple";
	sIcon = "PACKAGE_ICON=ic_b_reddragondisciple.tga";
	sVariables = "0=111";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row18",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Favored Soul";
	sIcon = "PACKAGE_ICON=ic_b_favoredsoul.tga";
	sVariables = "0=166";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row19",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Red Wizard ";
	sIcon = "PACKAGE_ICON=ic_b_redwizard.tga";
	sVariables = "0=173";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row20",sName,sIcon,sVariables,"");
	
	sName = "PACKAGE_NAME=Spirit Shaman";
	sIcon = "PACKAGE_ICON=ic_b_spiritshaman.tga";
	sVariables = "0=182";
	AddListBoxRow(oDM,"hv_npc_modify","PACKAGES_LIST","Row21",sName,sIcon,sVariables,"");
	
	SetListBoxRowSelected(oDM, "hv_npc_modify", "PACKAGES_LIST", "Row1");
}

// Get ecl of creature
int GetECL(object oNPC)
{
	int iSubRace = GetSubRace(oNPC);
    int iLevelAdj = 0;
	
	// see what the level adjustment is for subrace type
    switch (iSubRace)
    {
       case RACIAL_SUBTYPE_AASIMAR: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_TIEFLING: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_AIR_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_EARTH_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_FIRE_GENASI: iLevelAdj = 1; break;
	   case RACIAL_SUBTYPE_WATER_GENASI: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_GRAY_DWARF: iLevelAdj = 1; break;
       case RACIAL_SUBTYPE_DROW: iLevelAdj = 2; break;
       case RACIAL_SUBTYPE_SVIRFNEBLIN: iLevelAdj = 3; break;
	   case RACIAL_SUBTYPE_YUANTI: iLevelAdj = 2; break;
	   case RACIAL_SUBTYPE_GRAYORC: iLevelAdj = 1; break;
       default:  iLevelAdj = 0; break;
    }
	
	return iLevelAdj;
}

void CreateAndEquipSkin(object oNPC, string sProperty1, string sProperty2, string sProperty3)
{
	// Delete old skin
	object oOldSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oNPC);
	if (GetIsObjectValid(oOldSkin)) {
		DestroyObject(oOldSkin);
	}

	// Create enpty skin
	object oSkin = CreateItemOnObject(EMPTY_SKIN, oNPC);
	
	itemproperty ipProp;
	// Haste
	if (sProperty1 == "1") {
		ipProp = ItemPropertyHaste();
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	// Crit immunity
	if (sProperty2 == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
		
	AssignCommand(oNPC, ClearAllActions());
	AssignCommand(oNPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
}

// Get creature's skin. If it doesn't have one,
// Create a new one on the creature and return it.
object GetCreatureSkin(object oNPC)
{
	// Get current skin
	object oOldSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oNPC);
	if (GetIsObjectValid(oOldSkin)) {
		return oOldSkin;
	}

	// Create empty skin
	object oSkin = CreateItemOnObject(EMPTY_SKIN, oNPC);
	
	// Equip it
	AssignCommand(oNPC, ClearAllActions());
	AssignCommand(oNPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
	
	return oSkin;
}

// Remove all properties from oItem
void RemoveAllProperties(object oItem)
{
	itemproperty ipProp = GetFirstItemProperty(oItem);
	while (GetIsItemPropertyValid(ipProp)) {
		RemoveItemProperty(oItem, ipProp);
		ipProp = GetNextItemProperty(oItem);
	}
}

// Add misc immunities to creature's skin
void AddMiscImmunities(object oNPC, string sDeath, string sCritial, string sSneak, string sKnock, string sMind, string sPara, string sBigby, string sSpells, string sSpellsLevel, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;

	if (sDeath == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	
	if (sCritial == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sSneak == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sKnock == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sMind == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sPara == "1") {
		ipProp = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sBigby == "1") {
		ipProp = ItemPropertySpellImmunitySpecific(IP_CONST_BIGBY_1);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
		
		ipProp = ItemPropertySpellImmunitySpecific(IP_CONST_BIGBY_2);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
		
		ipProp = ItemPropertySpellImmunitySpecific(IP_CONST_BIGBY_3);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
		
		ipProp = ItemPropertySpellImmunitySpecific(IP_CONST_BIGBY_4);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}	
	
	if (sSpells == "1") {
		int nSpellsLevel = StringToInt(sSpellsLevel);
		if ((nSpellsLevel < 1) || (nSpellsLevel > 9))
			return;
			
		ipProp = ItemPropertyImmunityToSpellLevel(nSpellsLevel + 1);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
}

// Add physical immunities (slashing/bludge/piercing)
void AddPhysicalImmunities(object oNPC, string sSlashing, string sSlashingPercentage, string sBludgeoning, string sBludgeoningPercentage, string sPiercing, string sPiercingPercentage, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;
	int nPercentage;
	
	if (sSlashing == "1") {
		nPercentage = GetImmunityPercentage(sSlashingPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SLASHING, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sBludgeoning == "1") {
		nPercentage = GetImmunityPercentage(sBludgeoningPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sPiercing == "1") {
		nPercentage = GetImmunityPercentage(sPiercingPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_PIERCING, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
}

// Get requested immunity percentage
int GetImmunityPercentage(string sPercentage)
{
	if (sPercentage == "5")   return 1;
	if (sPercentage == "10")  return 2;
	if (sPercentage == "25")  return 3;
	if (sPercentage == "50")  return 4;
	if (sPercentage == "75")  return 5;
	if (sPercentage == "90")  return 6;
	if (sPercentage == "100") return 7;
	
	return 0;
}

// Add elemtal immunities (fire/cold/acid/elect.)
void AddElementalImmunities(object oNPC, string sFire, string sFirePercentage, string sCold, string sColdPercentage, string sAcid, string sAcidPercentage, string sElect, string sElectPercentage, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;
	int nPercentage;
	
	if (sFire == "1") {
		nPercentage = GetImmunityPercentage(sFirePercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sCold == "1") {
		nPercentage = GetImmunityPercentage(sColdPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_COLD, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sAcid == "1") {
		nPercentage = GetImmunityPercentage(sAcidPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ACID, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sElect == "1") {
		nPercentage = GetImmunityPercentage(sElectPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ELECTRICAL, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
}

// Add magical immunities (magic/sonic/negative/positive)
void AddMagicalImmunities(object oNPC, string sMagical, string sMagicalPercentage, string sSonic, string sSonicPercentage, string sNegative, string sNegativePercentage, string sPositive, string sPositivePercentage, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;
	int nPercentage;
	
	if (sMagical == "1") {
		nPercentage = GetImmunityPercentage(sMagicalPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_MAGICAL, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sSonic == "1") {
		nPercentage = GetImmunityPercentage(sSonicPercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SONIC, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sNegative == "1") {
		nPercentage = GetImmunityPercentage(sNegativePercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_NEGATIVE, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sPositive == "1") {
		nPercentage = GetImmunityPercentage(sPositivePercentage);
		
		if (nPercentage == 0)
			return;
		
		ipProp = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_POSITIVE, nPercentage);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
}

// Add misc properties
void AddMiscProperties(object oNPC, string sHaste, string sTrueSeeing, string sListenSpot, string sRegen, string sRegenAmount, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;

	if (sHaste == "1") {
		ipProp = ItemPropertyHaste();
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	
	if (sTrueSeeing == "1") {
		ipProp = ItemPropertyTrueSeeing();
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sListenSpot == "1") {
		ipProp = ItemPropertySkillBonus(SKILL_LISTEN, 50);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
		
		ipProp = ItemPropertySkillBonus(SKILL_SPOT, 50);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sRegen == "1") {
		int nRegenAmount = StringToInt(sRegenAmount);
		
		if ((nRegenAmount < 1) || (nRegenAmount > 20))
			return;
		
		ipProp = ItemPropertyRegeneration(nRegenAmount);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
}

// Add feats
void AddFeats(object oNPC, string sDodge, string sConceal, string sConcealPercentage, string sKeepOld)
{
	object oSkin = GetCreatureSkin(oNPC);
	
	// Remove old properties if requested
	if (sKeepOld != "1")
		RemoveAllProperties(oSkin);
	
	itemproperty ipProp;

	if (sDodge == "1") {
		ipProp = ItemPropertyBonusFeat(IP_CONST_FEAT_EPIC_DODGE);
		AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
	}
	
	if (sConceal == "1") {
		int nConcealFeat = GetConcealmentFeatID(sConcealPercentage);
		if (nConcealFeat != -1) {
			ipProp = ItemPropertyBonusFeat(nConcealFeat);
			AddItemProperty(DURATION_TYPE_PERMANENT, ipProp, oSkin);
		}
	}
}

// Get the feat ID of the requested concealemnt percentage
int GetConcealmentFeatID(string sConcealmentPercentage)
{
	if (sConcealmentPercentage == "10") return IP_CONST_FEAT_CONCEAL_10;
	if (sConcealmentPercentage == "20") return IP_CONST_FEAT_CONCEAL_20;
	if (sConcealmentPercentage == "30") return IP_CONST_FEAT_CONCEAL_30;
	if (sConcealmentPercentage == "40") return IP_CONST_FEAT_CONCEAL_40;
	if (sConcealmentPercentage == "50") return IP_CONST_FEAT_CONCEAL_50;
	
	return -1;
}

// Re-equip skin to apply changes
void ReequipCreatureSkin(object oNPC, object oSkin)
{
	AssignCommand(oNPC, ClearAllActions());
	AssignCommand(oNPC, ActionUnequipItem(oSkin));
	AssignCommand(oNPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
}