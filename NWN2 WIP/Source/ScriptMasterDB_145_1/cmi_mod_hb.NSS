//::///////////////////////////////////////////////
//:: cmi_mod_hb
//:: Purpose: Module Heartbeat
//:: Created By: Kaedrin (Matt)
//:: Created On: July 6, 2008
//:://////////////////////////////////////////////


#include "cmi_ginc_chars"
#include "nwn2_inc_spells"


void main()
{

	object oPC = GetFirstPC();
    //object oPC = GetFirstFactionMember(oPC, FALSE);
	int nElaborateParry = GetLocalInt(OBJECT_SELF, "ElaborateParry");
	
    while(GetIsObjectValid(oPC) == TRUE)
    {
		//SendMessageToPC(oPC, "You are a PC you know...");
		//SendMessageToPC(oPC, IntToString(GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE)));				
		
		if ((GetLocalInt(OBJECT_SELF, "UseTwoWpnDefense")) && (GetHasFeat(FEAT_TWO_WEAPON_DEFENSE, oPC)))
		{
			int nACBonus = 1;
			if (GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_DEFENSE, oPC))
				nACBonus = 2;
			if (GetHasFeat(FEAT_GTR_2WPN_DEFENSE, oPC))					
				nACBonus = 4;
				
			if (GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE))
			{
				if (!GetHasSpellEffect(-FEAT_TWO_WEAPON_DEFENSE,oPC))
				{

					if (IsTwoWeaponValid(oPC))
					{	
						RemoveSpellEffects(SPELLABILITY_Gtr_2Wpn_Defense, oPC, oPC);
						effect e2WpnDef = EffectACIncrease(nACBonus, AC_SHIELD_ENCHANTMENT_BONUS); 
						e2WpnDef = SetEffectSpellId(e2WpnDef, -FEAT_TWO_WEAPON_DEFENSE);
						e2WpnDef = SupernaturalEffect(e2WpnDef);
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2WpnDef, oPC, HoursToSeconds(24)));			
						SendMessageToPC(oPC, "Defensive fighting with two weapon defense active.");						
					}

				}
				else //They have it, check that it is still valid
				{
					if (!IsTwoWeaponValid(oPC))
					{
						SendMessageToPC(oPC, "Defensive fighting with two weapon defense is only valid when dual wielding.");
						RemoveSpellEffects(-FEAT_TWO_WEAPON_DEFENSE, OBJECT_SELF, oPC);
					}					
				}				
				
			}
			else
			{
				if (GetHasSpellEffect(-FEAT_TWO_WEAPON_DEFENSE,oPC))
				{
					RemoveSpellEffects(-FEAT_TWO_WEAPON_DEFENSE, OBJECT_SELF, oPC);
					SendMessageToPC(oPC, "Defensive fighting with two weapon defense disabled.");						
				}
				if (GetHasFeat(FEAT_GTR_2WPN_DEFENSE , oPC))
					ExecuteScript("cmi_s2_gtr2wpndef", oPC);
		
			}			
		}
		
		//Elaborate Parry
		if (nElaborateParry > 0)
		{
		
			if (GetLevelByClass(CLASS_TYPE_DUELIST, oPC ) > 6)
			{
				//SendMessageToPC(oPC, "Over 6");		
				if (GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_PARRY) )
				{
					//SendMessageToPC(oPC, "1742 - Elaborate Parry");
					if (!GetHasSpellEffect(-1742,oPC))
					{
						SendMessageToPC(oPC, "Elaborate Parry enabled.");	
						
						int nAC;
						int nDuelist = GetLevelByClass(CLASS_TYPE_DUELIST, oPC);
						if (nElaborateParry == 1)
							nAC = nDuelist;
						else
						if (nElaborateParry == 2)
							nAC = nDuelist / 3;
						else
						if (nElaborateParry == 3)
							nAC = nDuelist / 2;								
						
						effect eElabParry = EffectACIncrease(nAC);
						eElabParry = SetEffectSpellId(eElabParry, -1742);
						eElabParry = SupernaturalEffect(eElabParry);
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElabParry, oPC, HoursToSeconds(24)));			
					}				
					
				}
				else
				{
					if (GetHasSpellEffect(-1742,oPC))
					{
						RemoveSpellEffects(-1742, OBJECT_SELF, oPC);
						SendMessageToPC(oPC, "Elaborate Parry disabled.");						
					}
			
				}
			}
		}
		
		//Deadly Defense
		if (GetHasFeat(FEAT_DEADLY_DEFENSE, oPC))
		{		
			if (GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_PARRY) )
			{
				//SendMessageToPC(oPC, "1742 - Elaborate Parry");
				if (!GetHasSpellEffect(-FEAT_DEADLY_DEFENSE,oPC))
				{

					if (isDeadlyDefenseValid(oPC))
					{	
						effect eDeadlyDef = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_MAGICAL); 
						eDeadlyDef = SetEffectSpellId(eDeadlyDef, -FEAT_DEADLY_DEFENSE);
						eDeadlyDef = SupernaturalEffect(eDeadlyDef);
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeadlyDef, oPC, HoursToSeconds(24)));			
						SendMessageToPC(oPC, "Deadly Defense enabled.");						
					}

				}
				else //They have it, check that it is still valid
				{
					if (!isDeadlyDefenseValid(oPC))
					{
						SendMessageToPC(oPC, "Deadly Defense is only valid when wearing light or no armor and using a finessable weapon.");
						RemoveSpellEffects(-FEAT_DEADLY_DEFENSE, OBJECT_SELF, oPC);
					}					
				}				
				
			}
			else
			{
				if (GetHasSpellEffect(-FEAT_DEADLY_DEFENSE,oPC))
				{
					RemoveSpellEffects(-FEAT_DEADLY_DEFENSE, OBJECT_SELF, oPC);
					SendMessageToPC(oPC, "Deadly Defense disabled.");						
				}
		
			}		
		}
		
		//Dervish
		if (GetLevelByClass(CLASS_DERVISH, oPC) > 6)
		{
			if (GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE) || GetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE)  )
			{
				if (!GetHasSpellEffect(-FEAT_DERVISH_DEFENSIVE_PARRY,oPC))
				{
						effect eDefParry = EffectACIncrease(4);
						eDefParry = SetEffectSpellId(eDefParry, -FEAT_DERVISH_DEFENSIVE_PARRY);
						eDefParry = SupernaturalEffect(eDefParry);
						DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDefParry, oPC, HoursToSeconds(24)));			
						SendMessageToPC(oPC, "Defensive Parry enabled.");						
				}
			}
			else
			{
				if (GetHasSpellEffect(-FEAT_DERVISH_DEFENSIVE_PARRY,oPC))
				{
					RemoveSpellEffects(-FEAT_DERVISH_DEFENSIVE_PARRY, OBJECT_SELF, oPC);
					SendMessageToPC(oPC, "Defensive Parry disabled.");						
				}
		
			}					
		}
	
        oPC = GetNextPC(TRUE);
    }	
	
}