//::///////////////////////////////////////////////
//:: cmi_Tempest
//:: Purpose: Handles the Tempest for the Equip and Unequip
//:: Created By: Kaedrin (Matt)
//:: Created On: October 18, 2007
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "cmi_includes"

int IsTempestStateValid()
{
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oWeapon2    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
	
    if (GetIsObjectValid(oWeapon2))
    {
		int nBaseItemType = GetBaseItemType(oWeapon2);
		
        if (nBaseItemType ==BASE_ITEM_LARGESHIELD ||
            nBaseItemType ==BASE_ITEM_SMALLSHIELD ||
            nBaseItemType ==BASE_ITEM_TOWERSHIELD)
        {
            oWeapon2 = OBJECT_INVALID;
        }
    }
	
	if	(GetIsObjectValid(oWeapon))
	{
		int nBaseItemType = GetBaseItemType(oWeapon);
		if (GetWeaponRanged(oWeapon))
			oWeapon = OBJECT_INVALID;
	}
	
	int nArmorValid = 0;
	if ( GetIsObjectValid(oArmor))
	{
		if ((GetArmorRank(oArmor) == ARMOR_RANK_HEAVY)  || (GetArmorRank(oArmor) ==  ARMOR_RANK_MEDIUM))
		{
			oArmor = OBJECT_INVALID;
		}
		else
			nArmorValid = TRUE;
		
	}
	else
		nArmorValid = TRUE;
	
	if ((oWeapon == OBJECT_INVALID) &&  (oWeapon2 == OBJECT_INVALID) &&  (nArmorValid == TRUE))	
	{
		object oCWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,OBJECT_SELF);
		object oCWeapon2 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,OBJECT_SELF);
		if ((oCWeapon1 != OBJECT_INVALID) &&  (oCWeapon2 != OBJECT_INVALID))
		{
			return TRUE;
		}	
		else
			return FALSE;	
	}
	else	
	if ((oWeapon != OBJECT_INVALID) &&  (oWeapon2 != OBJECT_INVALID) &&  (nArmorValid == TRUE))
	{
		return TRUE;
	}
	else
		return FALSE;

}

void EvaluateTempest()
{
		object oPC = OBJECT_SELF;
	
		int nSpellId = SPELL_Tempest_Defense;		
		int bTempestStateValid = IsTempestStateValid();
		//SendMessageToPC(oPC,"TempStateValid: "+IntToString(bTempestStateValid));
		int bHasTempestDefense = GetHasSpellEffect(nSpellId,oPC);
		if (bTempestStateValid)
		{

			RemoveSpellEffects(nSpellId, oPC, oPC);
			//else
					int nAC = 0;
					int nAB = 0;			
					int nLevel = GetLevelByClass(CLASS_TEMPEST,oPC);
					
					if (nLevel == 1) 
					{  
						nAC = 1;
					}
					else
					if (nLevel == 2) 
					{  
						nAC = 1;
						nAB = 1;				
					}	
					else
					if (nLevel == 3) 
					{  
						nAC = 2;
						nAB = 1;				
					}	
					else
					if (nLevel == 4) 
					{  
						nAC = 2;
						nAB = 2;			
					}	
					else
					if (nLevel == 5) 
					{  
						nAC = 3;
						nAB = 2;				
					}
					
					effect eLink;			
					effect eAC = SupernaturalEffect(EffectACIncrease(nAC, AC_DODGE_BONUS));	
							
					if (nAB > 0)
					{
						effect eAB = SupernaturalEffect(EffectAttackIncrease(nAB));
						eLink = SupernaturalEffect(EffectLinkEffects(eAB,eAC));
					}
					else
					{
						eLink = eAC;
					}
					eLink = SetEffectSpellId(eLink,nSpellId);
					if (!bHasTempestDefense)
						SendMessageToPC(oPC,"Tempest Defense enabled.");			
				    DelayCommand(0.1f, cmi_ApplyEffectToObject(nSpellId, DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(48)));			
				}
		else
		{
	    	RemoveSpellEffects(nSpellId, oPC, oPC);
			if (bHasTempestDefense)
				SendMessageToPC(oPC,"Tempest Defense disabled, it is only valid when wielding two weapons and wearing light or no armor.");			
		}		
}