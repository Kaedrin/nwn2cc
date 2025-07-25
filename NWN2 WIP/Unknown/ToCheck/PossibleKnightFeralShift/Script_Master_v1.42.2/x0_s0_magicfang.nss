//::///////////////////////////////////////////////
//:: Magic Fang
//:: x0_s0_magicfang.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 +1 enhancement bonus to attack and damage rolls.
 Also applys damage reduction +1; this allows the creature
 to strike creatures with +1 damage reduction.
 
 Checks to see if a valid summoned monster or animal companion
 exists to apply the effects to. If none exists, then
 the spell is wasted.
 
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: September 6, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:


// JLR - OEI 08/24/05 -- Metamagic changes
#include "nwn2_inc_spells"
#include "cmi_ginc_spells"


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

void DoMagicFang2(int nPower, int nVFX)
{
//Declare major variables
	object			oTarget		=	GetSpellTargetObject();
	object			oCaster		=	OBJECT_SELF;
	object			oWeapon1	=	GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
	object			oWeapon2	=	GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
	object			oWeapon3	=	GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
	object			oWeapon4	=	GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);	
	itemproperty	iEbonus		=	ItemPropertyEnhancementBonus(nPower);
	float			fDuration	=	TurnsToSeconds(GetPalRngCasterLevel());
	effect			eVis		=	EffectVisualEffect(nVFX);
	
//Determine duration
					fDuration	=	ApplyMetamagicDurationMods(fDuration);

//Validate target and apply effect, IPSafeAddItemProperty automatically handles stacking rules.
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster))
		{
				if (GetIsObjectValid(oWeapon1))
				{
					IPSafeAddItemProperty(oWeapon1, iEbonus, fDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
				}
				if (GetIsObjectValid(oWeapon2))
				{
					IPSafeAddItemProperty(oWeapon2, iEbonus, fDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
				}
				if (GetIsObjectValid(oWeapon3))
				{
					IPSafeAddItemProperty(oWeapon3, iEbonus, fDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
				}
				if (GetIsObjectValid(oWeapon4))
				{
					IPSafeAddItemProperty(oWeapon4, iEbonus, fDuration, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
				}				
				if (GetIsObjectValid(oWeapon1) || GetIsObjectValid(oWeapon2) || GetIsObjectValid(oWeapon3) || GetIsObjectValid(oWeapon4))
				{
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
				}
		}
	}
}

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    DoMagicFang2(1, VFX_DUR_SPELL_MAGIC_FANG);
}