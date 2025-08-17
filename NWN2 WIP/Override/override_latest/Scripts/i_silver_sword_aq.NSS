// i_silver_sword_aq
/*
   OnAcquire script for The Silver Sword of Gith - dynamically assigns attributes based on PC class.
*/
// CG OEI 7/17/06

#include "x2_inc_itemprop"
#include "ginc_debug"
#include "cmi_includes"

void AddStandardProps(object oItem)
{
	itemproperty ipDmgBonus = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d12);
	itemproperty ipMagDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d4);
	itemproperty ipDR1 = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGERESIST_5);	
	itemproperty ipDR2 = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGERESIST_5);
	itemproperty ipDR3 = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGERESIST_5);
	itemproperty ipDR4 = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGERESIST_5);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 1);
	itemproperty ipIntelligence = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 1);
	itemproperty ipCharisma = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 1);
	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 1);
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 1);
	itemproperty ipConstitution = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 1);

	itemproperty ipSSwordAttack = ItemPropertyCastSpell(641, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE);
	itemproperty ipShardShield = ItemPropertyCastSpell(642, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE);
	itemproperty ipShardAttack = ItemPropertyCastSpell(643, IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE);
	itemproperty ipSwordRecharge = ItemPropertyCastSpell(645, IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE);
	
	IPSafeAddItemProperty(oItem, ipDmgBonus, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipMagDmgBonus, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipDR1, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipDR2, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipDR3, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipDR4, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipDexterity, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipIntelligence, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipCharisma, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipStrength, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipWisdom, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipConstitution, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);

	IPSafeAddItemProperty(oItem, ipSwordRecharge, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipSSwordAttack, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipShardShield, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
	IPSafeAddItemProperty(oItem, ipShardAttack, 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);

	SetLocalInt(oItem, "SS_Stop_Ability", 0);
}

void AddItemPropsBarbarian(object oItem)
{
	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 3);
	itemproperty ipConstitution = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2);
//	itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3, IP_CONST_DAMAGESOAK_5_HP);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(5);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_1d10);
	itemproperty ipMCrit = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10);
	itemproperty ipERage = ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_RAGE);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipConstitution, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDR, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipMCrit, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipERage, oItem); 

	AddStandardProps(oItem);
}

void AddItemPropsBard(object oItem)
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);
//	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipSThrow1 = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 3);
	itemproperty ipSThrow2 = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 3);
	itemproperty ipSThrow3 = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 3);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(3);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d6);
//	itemproperty ipESpell4 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD, 4);
//	itemproperty ipESpell5 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD, 5);
	itemproperty ipEMusic = ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_MUSIC);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipCharisma, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSThrow1, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSThrow2, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSThrow3, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell4, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell5, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEMusic, oItem);

	AddStandardProps(oItem);
}

void AddItemPropsCleric(object oItem)
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);
	itemproperty ipConstitution = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d8);
	itemproperty ipOnHit = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE, IP_CONST_ONHIT_SAVEDC_18, IP_CONST_RACIALTYPE_UNDEAD);
//	itemproperty ipESpell7 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC, 7);
//	itemproperty ipESpell8 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC, 8);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipConstitution, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipOnHit, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell7, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell8, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsDruid(object oItem)
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipRegen = ItemPropertyRegeneration(1);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE, IP_CONST_DAMAGEBONUS_1d8);
//	itemproperty ipESpell7 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID, 7);
//	itemproperty ipESpell8 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID, 8);
	itemproperty ipEWShape = ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_WILD_SHAPE);
//	itemproperty ipEWShape = ItemPropertyBonusFeat(92);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipRegen, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell7, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell8, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEWShape, oItem);

	AddStandardProps(oItem);
}

void AddItemPropsFighter(object oItem)
{
	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
//	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipConstitution = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 3);
	itemproperty ipKeen = ItemPropertyKeen();
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(5);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_2d6);
	itemproperty ipMeleeDmgBonus1 = ItemPropertyExtraMeleeDamageType(IP_CONST_DAMAGETYPE_PIERCING);
	itemproperty ipMeleeDmgBonus2 = ItemPropertyExtraMeleeDamageType(IP_CONST_DAMAGETYPE_BLUDGEONING);
//	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);	
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipConstitution, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipKeen, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipMeleeDmgBonus1, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipMeleeDmgBonus2, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsMonk(object oItem)
{
//	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE, IP_CONST_DAMAGEBONUS_1d8);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);	
//	itemproperty ipRegen = ItemPropertyRegeneration(1);
	itemproperty ipOnHit = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, IP_CONST_ONHIT_SAVEDC_18, IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS);
	itemproperty ipEStunAttk = ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_STUNNING_ATTACK);
				
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipRegen, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipOnHit, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEStunAttk, oItem);

	AddStandardProps(oItem);
}

void AddItemPropsPaladin(object oItem)
{
	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
	itemproperty ipConstitution = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2);
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d10);
//	itemproperty ipAlignEnhance = ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, 8);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);	
//	itemproperty ipSkillBonus = ItemPropertySkillBonus(SKILL_DISCIPLINE, 10);
	itemproperty ipESmiteEvil = ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_SMITING);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipConstitution, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipAlignEnhance, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipESmiteEvil, oItem);

	AddStandardProps(oItem);
}

void AddItemPropsRanger(object oItem)
{
//	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 3);
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_1d10);
//	itemproperty ipRaceAttkBonus = ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, 6);	
	itemproperty ipACBonus = ItemPropertyACBonus(2);
	itemproperty ipSkillBonus1 = ItemPropertySkillBonus(SKILL_SPOT, 5);
	itemproperty ipSkillBonus2 = ItemPropertySkillBonus(SKILL_LISTEN, 5);
	itemproperty ipSkillBonus3 = ItemPropertySkillBonus(SKILL_SURVIVAL, 5);
				
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipRaceAttkBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipACBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus1, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus2, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus3, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsRogue(object oItem)
{
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 4);
//	itemproperty ipIntelligence = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(3);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_1d6);
//	itemproperty ipACBonus = ItemPropertyACBonus(4);
	itemproperty ipOnHit = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_18, IP_CONST_DAMAGETYPE_SLASHING);
//	itemproperty ipSkillBonus1 = ItemPropertySkillBonus(SKILL_SEARCH, 10);
	itemproperty ipSkillBonus2 = ItemPropertySkillBonus(SKILL_HIDE, 5);
	itemproperty ipSkillBonus3 = ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 5);
//	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB);
	itemproperty ipFreeMove = ItemPropertyFreeAction();
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipIntelligence, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipACBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipOnHit, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus1, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus2, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus3, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipFreeMove, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsSorcerer(object oItem)
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 4);
//	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(3);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d4);
	itemproperty ipSkillBonus = ItemPropertySkillBonus(SKILL_CONCENTRATION, 10);
	itemproperty ipSpellResist = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
//	itemproperty ipESpell7 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_SORCERER, 7);
//	itemproperty ipESpell8 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_SORCERER, 8);
			
	AddItemProperty(DURATION_TYPE_PERMANENT, ipCharisma, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSpellResist, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell7, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell8, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsWarlock(object oItem)
{
	itemproperty ipCharisma = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 3);
//	itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(3);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d8);
//	itemproperty ipSkillBonus = ItemPropertySkillBonus(SKILL_CONCENTRATION, 10);
	itemproperty ipSpellResist = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16);
	itemproperty ipOnHit = ItemPropertyOnHitProps(IP_CONST_ONHIT_BLINDNESS, IP_CONST_ONHIT_SAVEDC_18, IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS);
			
	AddItemProperty(DURATION_TYPE_PERMANENT, ipCharisma, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipStrength, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSpellResist, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipOnHit, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsWizard(object oItem)
{
//	itemproperty ipDexterity = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
	itemproperty ipIntelligence = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 4);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(3);
//	itemproperty ipDmgBonus = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_1d4);
	itemproperty ipSkillBonus = ItemPropertySkillBonus(SKILL_CONCENTRATION, 10);
	itemproperty ipSpellResist = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
//	itemproperty ipESpell7 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD, 7);
//	itemproperty ipESpell8 = ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD, 8);
			
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDexterity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipIntelligence, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipDmgBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSkillBonus, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipSpellResist, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell7, oItem);
//	AddItemProperty(DURATION_TYPE_PERMANENT, ipESpell8, oItem);
	
	AddStandardProps(oItem);
}

void AddItemPropsFSSS(object oItem)
{
	itemproperty ipWisdom = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 3);
	itemproperty ipCharisma = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 2);
	itemproperty ipImmunity = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
	itemproperty ipEnhancement = ItemPropertyEnhancementBonus(4);
	itemproperty ipOnHit = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE, IP_CONST_ONHIT_SAVEDC_18, IP_CONST_RACIALTYPE_UNDEAD);
				
	AddItemProperty(DURATION_TYPE_PERMANENT, ipWisdom, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipCharisma, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunity, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipEnhancement, oItem);
	AddItemProperty(DURATION_TYPE_PERMANENT, ipOnHit, oItem);
	
	AddStandardProps(oItem);
}

void main()
{
    // * This code runs when the item is acquired
    object oPC      = GetModuleItemAcquiredBy();
    object oItem    = GetModuleItemAcquired();
    int iStackSize  = GetModuleItemAcquiredStackSize();
    object oFrom    = GetModuleItemAcquiredFrom();
	
	if (GetIsOwnedByPlayer(oPC) == TRUE)
	{
		IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
	}
	
	else
	{
		return;
	}
	
	int nNewClass = CLASS_TYPE_BARBARIAN;
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_BARD, oPC))
	{
		nNewClass = CLASS_TYPE_BARD;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_CLERIC, oPC))
	{
		nNewClass = CLASS_TYPE_CLERIC;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_DRUID, oPC))
	{
		nNewClass = CLASS_TYPE_DRUID;
	}	
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_FIGHTER, oPC))
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_MONK, oPC))
	{
		nNewClass = CLASS_TYPE_MONK;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_PALADIN, oPC))
	{
		nNewClass = CLASS_TYPE_PALADIN;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_RANGER, oPC))
	{
		nNewClass = CLASS_TYPE_RANGER;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
	{
		nNewClass = CLASS_TYPE_ROGUE;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_SORCERER, oPC))
	{
		nNewClass = CLASS_TYPE_SORCERER;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_WARLOCK, oPC))
	{
		nNewClass = CLASS_TYPE_WARLOCK;
	}
	
	if (GetLevelByClass(nNewClass, oPC) < GetLevelByClass(CLASS_TYPE_WIZARD, oPC))
	{
		nNewClass = CLASS_TYPE_WIZARD;
	}
	
	//New Content by Kaedrin	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_FAVORED_SOUL, oPC ) )
	{
		nNewClass = CLASS_TYPE_FAVORED_SOUL;
	}
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_SPIRIT_SHAMAN, oPC ) )
	{
		nNewClass = CLASS_TYPE_FAVORED_SOUL;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_THUG, oPC ) )
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_SCOUT, oPC ) )
	{
		nNewClass = CLASS_TYPE_RANGER;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_NINJA, oPC ) )
	{
		nNewClass = CLASS_TYPE_ROGUE;
	}	
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_TYPE_SWASHBUCKLER, oPC ) ) 
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}
	
	if ( GetLevelByClass( nNewClass, oPC ) < GetLevelByClass( CLASS_HEXBLADE, oPC ) ) 
	{
		nNewClass = CLASS_TYPE_FIGHTER;
	}						
								
	
    switch ( nNewClass )
    {
        case 0:     // BARBARIAN
            nNewClass = CLASS_TYPE_BARBARIAN;
			AddItemPropsBarbarian(oItem);
            break;
        case 1:     // BARD
            nNewClass = CLASS_TYPE_BARD;
			AddItemPropsBard(oItem);
            break;
        case 2:     // CLERIC
            nNewClass = CLASS_TYPE_CLERIC;
			AddItemPropsCleric(oItem);
            break;
        case 3:     // DRUID
            nNewClass = CLASS_TYPE_DRUID;
			AddItemPropsDruid(oItem);
            break;
        case 4:     // FIGHTER
            nNewClass = CLASS_TYPE_FIGHTER;
			AddItemPropsFighter(oItem);
            break;
        case 5:     // MONK
            nNewClass = CLASS_TYPE_MONK;
			AddItemPropsMonk(oItem);
            break;
		case 58:	// FAVORED SOUL / SPIRIT SHAMAN
			AddItemPropsFSSS( oItem );
			break;			
        case 6:     // PALADIN
            nNewClass = CLASS_TYPE_PALADIN;
			AddItemPropsPaladin(oItem);
            break;
        case 7:     // RANGER
            nNewClass = CLASS_TYPE_RANGER;
			AddItemPropsRanger(oItem);
            break;
        case 8:     // ROGUE
            nNewClass = CLASS_TYPE_ROGUE;
			AddItemPropsRogue(oItem);
            break;
        case 9:     // SORCERER
            nNewClass = CLASS_TYPE_SORCERER;
			AddItemPropsSorcerer(oItem);
            break;
        case 39:    // WARLOCK
            nNewClass = CLASS_TYPE_WARLOCK;
			AddItemPropsWarlock(oItem);
            break;
        case 10:	// WIZARD
            nNewClass = CLASS_TYPE_WIZARD;
			AddItemPropsWizard(oItem);
            break;
    }
}	