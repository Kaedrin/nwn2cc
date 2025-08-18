//::///////////////////////////////////////////////
//:: Greater Magic Weapon
//:: cmi_hx_grmagwpn
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////


#include "x2_inc_spellhook"
#include "cmi_ginc_spells"


void  AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //Declare major variables
    effect eDur = EffectVisualEffect( VFX_DUR_SPELL_GREATER_MAGIC_WEAPON );
    int nDuration = GetHexbladeCasterLevel();
    int nCasterLvl = nDuration / 4;	
	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        nDuration = nDuration * 2;
    }	
	
    //Limit nCasterLvl to 5, so it max out at +5 enhancement to the weapon.
    if(nCasterLvl > 5)
    {
        nCasterLvl = 5;
    }

    object oMyWeapon   =  cmi_GetTargetedOrEquippedMeleeWeapon();

    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, (HoursToSeconds(nDuration)), nCasterLvl);
			
			object oMyWeapon2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
			if (GetIsObjectValid(oMyWeapon2) && IPGetIsMeleeWeapon(oMyWeapon2))
			{
				AddGreaterEnhancementEffectToWeapon(oMyWeapon2,HoursToSeconds(nDuration), nCasterLvl);	
			}				
        }
        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}