//::///////////////////////////////////////////////
//:: Poison
//:: NW_S0_Poison.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Must make a touch attack. If successful the target
    is struck down with wyvern poison.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 22, 2001
//:://////////////////////////////////////////////
//:: PKM-OEI 07.12.06 VFX Change

#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
	
	int nDC = 12 + GetAbilityModifier(ABILITY_WISDOM) + (GetBlackguardCasterLevel(OBJECT_SELF)/2);
	nDC = nDC / 5;
	int nPoison = 6;
	if (nDC >= 8)
		nPoison = 65;
	else
	if (nDC >= 7)
		nPoison = 64;	
	else
	if (nDC >= 6)
		nPoison = 63;	
	else
	if (nDC >= 5)
		nPoison = 62;	
	else
	if (nDC >= 4)
		nPoison = 61;	
	else
	if (nDC >= 3)
		nPoison = 60;									
	
	
    effect ePoison = EffectPoison(nPoison);
	//effect eHit = EffectVisualEffect(VFX_HIT_SPELL_POISON);//This is redundant
    int nTouch = TouchAttackMelee(oTarget);//
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POISON));
        //Make touch attack
        if (nTouch > 0)
        {
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Apply the poison effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoison, oTarget);
				//ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);//This is redundant, if the target receives poison the VFX will play anyway
            }
        }
    }
}