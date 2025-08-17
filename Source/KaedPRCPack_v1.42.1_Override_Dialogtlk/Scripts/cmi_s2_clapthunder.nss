//::///////////////////////////////////////////////
//:: Clap of Thunder
//:: cmi_s2_clapthunder
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 11, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"
#include "cmi_ginc_spells"

int GetSonicReserveDamageDice()
{

	if ( GetHasSpell(1038) || GetHasSpell(1820) )
		return 8;
	if ( GetHasSpell(445) )
		return 6;
	if ( GetHasSpell(1016) || GetHasSpell(900) || GetHasSpell(1813) || GetHasSpell(2027))
		return 5;
	if ( GetHasSpell(1861) || GetHasSpell(373) || GetHasSpell(1037) || GetHasSpell(1743) || GetHasSpell(1173)  || GetHasSpell(1209))
		return 4;		
	if ( GetHasSpell(1753) || GetHasSpell(1829) || GetHasSpell(441) )
		return 3;
				
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nDamageDice = 0;
	
	nDamageDice = GetSonicReserveDamageDice();
		 
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
			//int nDamage = d6(nDamageDice);
			int nDamage = HandleReserveMeta(nDamageDice, 6);
						
			int nMeleeTouch = TouchAttackMelee(oTarget);
			if (nMeleeTouch != TOUCH_ATTACK_RESULT_MISS)
			{
						
				nDamage += GetMeleeTouchSpecDamage(OBJECT_SELF, nDamageDice, FALSE);
				if (nMeleeTouch == TOUCH_ATTACK_RESULT_CRITICAL)
					nDamage = nDamage * 2;
										
				//include sneak attack damage
				nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);
				
				if (GetLocalInt(GetModule(), "SonicMightAffectsClapofThunder"))
				{
				    if (GetHasSpellEffect(FEAT_LYRIC_THAUM_SONIC_MIGHT, OBJECT_SELF) == TRUE)
						nDamage += d6(nDamageDice);
				}
									
				effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_SONIC);
				
				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));				

				//Apply the effects
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
				
				int nDC = GetReserveSpellSaveDC(nDamageDice,OBJECT_SELF);
				effect eStatusEffect = EffectDeaf();	
                if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStatusEffect, oTarget, 6.0f);				
			
			}
		}	
	}			



}