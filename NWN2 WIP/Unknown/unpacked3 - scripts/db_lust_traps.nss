/*//////////////////////////////////////////////////////////////////////////////////////
//main(object oPlayer, int iQuantity)
////////////////////////////////////////////////////////////////////////////////////////
//Este evento evalúa una habilidad o un skill, y dependiendo del resultado el jugador
//es enviado o no a una trampa, se teletransportaría a una localización y recibiría un
//daño asociado a la trampa.
//
//El trigger debe tener las siguientes variables:
//Ability: Debe ser una de las siguientes: CHA, CON, DEX, INT, STR, WIS, LEAPS, SURVIVAL
//Roll_To_Win: Indica el resultado a superar (CHA+d20 vs Roll_To_Win)
//Location_Name: Indica el tag del objeto a dónde se teletransportará el jugador
//Min_Damage: Indica el daño mínimo a recibir
//Max_Damage: Indica el daño máximo a recibir
//DamageType: Indica el tipo de daño
//Message: Indica la razón del fallo
//////////////////////////////////////////////////////////////////////////////////////*/
void main()
{
	object oCreature = GetEnteringObject();
	if (GetIsPC(oCreature))
	{
		int iAbility;
		string sAbility = GetLocalString(OBJECT_SELF, "Ability");
		int Roll;
		int RollNeeded = GetLocalInt(OBJECT_SELF, "Roll_To_Win");
		if (RollNeeded == 0) RollNeeded = 20;
		
		if (GetStringLength(sAbility)==3)
		{
			if (sAbility =="CHA") iAbility = ABILITY_CHARISMA; else
			if (sAbility =="CON") iAbility = ABILITY_CONSTITUTION; else
			if (sAbility =="DEX") iAbility = ABILITY_DEXTERITY; else
			if (sAbility =="INT") iAbility = ABILITY_INTELLIGENCE; else
			if (sAbility =="STR") iAbility = ABILITY_STRENGTH; else
			if (sAbility =="WIS") iAbility = ABILITY_WISDOM;
			Roll = d20() + GetAbilityScore(oCreature, iAbility);
		} else
		{
			if (sAbility =="LEAPS") iAbility = SKILL_TUMBLE; else
			if (sAbility =="SURVIVAL") iAbility = SKILL_SURVIVAL;
			Roll = d20() + GetSkillRank(iAbility, oCreature);
		}
		location lLocation = GetLocation(GetObjectByTag(GetLocalString(OBJECT_SELF, "Location_Name")));
		if (Roll<RollNeeded)
		{
			AssignCommand(oCreature, ClearAllActions());
			string sText = GetLocalString(OBJECT_SELF, "Message");
			AssignCommand(oCreature, SpeakString(sText));
			int iDamage = GetLocalInt(OBJECT_SELF, "Min_Damage")+
						  Random(GetLocalInt(OBJECT_SELF, "Max_Damage")-GetLocalInt(OBJECT_SELF, "Min_Damage"));
			AssignCommand(oCreature, JumpToLocation(lLocation));
			if (iDamage>0)
			{
				string sDamageType= GetLocalString(OBJECT_SELF, "DamageType");
				int iDamageType;
				if (sDamageType=="ACID") iDamageType = IP_CONST_DAMAGETYPE_ACID; else
				if (sDamageType=="BLUDGEONING") iDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING; else
				if (sDamageType=="COLD") iDamageType = IP_CONST_DAMAGETYPE_COLD; else
				if (sDamageType=="DIVINE") iDamageType = IP_CONST_DAMAGETYPE_DIVINE; else
				if (sDamageType=="ELECTRICAL") iDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL; else
				if (sDamageType=="FIRE") iDamageType = IP_CONST_DAMAGETYPE_FIRE; else
				if (sDamageType=="MAGICAL") iDamageType = IP_CONST_DAMAGETYPE_MAGICAL; else
				if (sDamageType=="NEGATIVE") iDamageType = IP_CONST_DAMAGETYPE_NEGATIVE; else
				if (sDamageType=="PHYSICAL") iDamageType = IP_CONST_DAMAGETYPE_PHYSICAL; else
				if (sDamageType=="PIERCING") iDamageType = IP_CONST_DAMAGETYPE_PIERCING; else
				if (sDamageType=="POSITIVE") iDamageType = IP_CONST_DAMAGETYPE_POSITIVE; else
				if (sDamageType=="SLASHING") iDamageType = IP_CONST_DAMAGETYPE_SLASHING; else
				if (sDamageType=="SONIC") iDamageType = IP_CONST_DAMAGETYPE_SONIC; else
				if (sDamageType=="SUBDUAL") iDamageType = IP_CONST_DAMAGETYPE_SUBDUAL;
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, iDamageType), oCreature);
			}
		} //else AssignCommand(oCreature, SpeakString("<C=#E1B67D>*Evades the danger Gracefully*</C> "));
	}
	
}