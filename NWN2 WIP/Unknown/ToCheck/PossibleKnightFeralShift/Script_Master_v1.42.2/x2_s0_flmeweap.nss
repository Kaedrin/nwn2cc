//::///////////////////////////////////////////////
//:: Flame Weapon
//:: X2_S0_FlmeWeap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
//  Gives a melee weapon 1d4 fire damage +1 per caster
//  level to a maximum of +10.
  3.5: Gives a melee weapon +1d6 fire damage (flat).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 29, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-15: Complete Rewrite to make use of Item Property System


// (Update JLR - OEI 07/26/05) -- 3.5 Update
// (Update BDF - OEI 08/29/05) -- Corrected the spellID param value of ItemPropertyOnHitCastSpell
// AFW-OEI 07/23/2007: If it's going to be fixed fire damage, forget the fancy on-hit spell and just
//	go with our elemental damage item property.  Also, increase to 1d8.
// RPGplayer1 03/19/2008: Won't replace non-fire elemental damage
// RPGplayer1 01/11/2009: Corrected duration to 1 turn/level


#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"



void main()
{
    if (!X2PreSpellCastCode())
    {   // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
	
	float 	fDuration	=	TurnsToSeconds(nDuration);
	object oTarget = GetSpellTargetObject();
	int bValid = FALSE;	

	
	object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();		
	if (GetIsObjectValid(oMyWeapon))
	{
		itemproperty ipFlame = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d8);
	
		//IPSafeAddItemProperty(oMyWeapon, ipElectrify, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE, FALSE);	// AFW-OEI 08/14/2007: Let Subtypes be different.
		IPSafeAddItemProperty(oMyWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		bValid = TRUE;
	}
	
	if (GetIsObjectValid(oTarget) && (GetObjectType(oTarget) != OBJECT_TYPE_ITEM))	
	{
		itemproperty ipFlame = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d8);	
		object oCWeapon  = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget);
		if (GetIsObjectValid(oCWeapon))
		{
			bValid = TRUE;
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}
		
		oCWeapon  = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget);		
		if (GetIsObjectValid(oCWeapon))
		{
			bValid = TRUE;
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}
		
		oCWeapon  = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget);		
		if (GetIsObjectValid(oCWeapon))
		{		
			bValid = TRUE;
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}	
		
		oCWeapon  = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);		
		if (GetIsObjectValid(oCWeapon))
		{	
			bValid = TRUE;			
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}	
		
		oCWeapon  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);		
		if (GetIsObjectValid(oCWeapon) && IPGetIsMeleeWeapon(oCWeapon))
		{	
			bValid = TRUE;			
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}
		
		oCWeapon  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);		
		if (GetIsObjectValid(oCWeapon) && IPGetIsMeleeWeapon(oCWeapon))
		{	
			bValid = TRUE;			
			IPSafeAddItemProperty(oCWeapon, ipFlame, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);	// FIX: should work with shock weapons too
		}		
	}	
	
	if (!bValid)
	 {
		FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
		return;
	 }
}