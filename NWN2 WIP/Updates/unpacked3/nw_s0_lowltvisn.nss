//::///////////////////////////////////////////////
//:: [Low Light Vision]
//:: [NW_S0_LowLtVisn.nss]
//:://////////////////////////////////////////////
/*
    All "party-members" gain Low-Light Vision (as
    the Elf Racial ability).
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: July 12, 2005
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: Modified March 2003 to give -2 attack and damage penalties


// JLR - OEI 08/23/05 -- Metamagic changes
#include "nwn2_inc_spells"


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ginc_henchman"
#include "cmi_ginc_spells"


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


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetPalRngCasterLevel();
    float fDuration = HoursToSeconds(nCasterLvl);

    //Enter Metamagic conditions
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);

        effect eDur = EffectVisualEffect( VFX_DUR_SPELL_LOWLIGHT_VISION );
        effect eSight = EffectLowLightVision();
        effect eLink = EffectLinkEffects(eDur, eSight);
		
	itemproperty iBonusFeat = ItemPropertyBonusFeat(IPRP_FEAT_LOWLIGHTVISION);	
    object oArmorNew;

	
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF))
        {
					//Apply the VFX impact and effects
        			ApplyEffectToObject(nDurType, eLink, oTarget, fDuration);
							
			    oArmorNew  = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);	
				if (oArmorNew == OBJECT_INVALID)
				{
					oArmorNew = CreateItemOnObject("x2_it_emptyskin", oTarget, 1, "", FALSE);
					AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);		
					DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));	
					AssignCommand(oTarget,ActionEquipItem(oArmorNew,INVENTORY_SLOT_CARMOUR));
				}
				else
				{
			        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);		
				}	
	
  					
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }	
	

}