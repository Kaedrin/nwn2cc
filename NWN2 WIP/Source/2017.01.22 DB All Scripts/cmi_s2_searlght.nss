//::///////////////////////////////////////////////
//:: Searing Light (Master of Radiance)
//:: cmi_s2_searlght
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:://////////////////////////////////////////////
//:: Based on Searing Light by OEI


#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 
#include "nwn2_inc_spells"
#include "cmi_inc_sneakattack"
#include "cmi_ginc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	if (!GetHasSpellEffect(SPELLABILITY_MASTER_RADIANCE_RADIANT_AURA))
	{
        SpeakString("This ability can only be used while Radiant Aura is active.");
	}
	else
	{
		
	    //Declare major variables
	    object oCaster = OBJECT_SELF;
	    object oTarget = GetSpellTargetObject();
	
	    int nCasterLevel = GetCasterLevel(oCaster) + 2;
		int nTouch      = TouchAttackRanged(oTarget);
	    if (nCasterLevel > 10)	 // Limit caster level
	        nCasterLevel = 10;
		else if (nCasterLevel <= 0)
			nCasterLevel = 1;	
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{
	        //Fire cast spell at event for the specified target
	        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEARING_LIGHT));
	
			if (nTouch != TOUCH_ATTACK_RESULT_MISS)
		    {    //Make an SR Check
		        if (!MyResistSpell(oCaster, oTarget))
		        {
				    int nDamage;
				    int nMax;
		            //Check for racial type undead
		            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
		            {
						nDamage = d6(nCasterLevel);
		                //nMax = 8;
						nDamage = ApplyMetamagicVariableMods(nDamage, nCasterLevel*6);
						nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLevel, FALSE);
						
					
						/*if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)
						{ 
							nDamage = d6(nCasterLevel * 2);
							nDamage = ApplyMetamagicVariableMods(nDamage, (nCasterLevel*2)*6);
						}*/
		            }
		            //Check for racial type construct
		            else if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
		            {
		                nCasterLevel /= 2;
		                nDamage = d6(nCasterLevel);
		                //nMax = 6;
						nDamage = ApplyMetamagicVariableMods(nDamage, nCasterLevel*6);
						nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLevel, FALSE);
						
						/*if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL)
						{ 
							nDamage = d6(nCasterLevel * 2);
							nDamage = ApplyMetamagicVariableMods(nDamage, (nCasterLevel*2)*6);
						}*/
						
		            }
		            else
		            {
		                nCasterLevel = nCasterLevel/2;
		                nDamage = d8(nCasterLevel);
		                //nMax = 8;
						nDamage = ApplyMetamagicVariableMods(nDamage, nCasterLevel*8);
						nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLevel, FALSE);
						
						if (nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT))
						{ 
							nDamage = d8(nCasterLevel * 2);
							nDamage = ApplyMetamagicVariableMods(nDamage, (nCasterLevel*2)*8);
							nDamage += GetRangedTouchSpecDamage(OBJECT_SELF, nCasterLevel*2, FALSE);
						}					
						
		            }
		
		            //Make metamagic checks
		    		/*int nMetaMagic = GetMetaMagicFeat();
		            if (nMetaMagic == METAMAGIC_MAXIMIZE)
		            {
		                nDamage = nMax * nCasterLevel;
		            }
		            if (nMetaMagic == METAMAGIC_EMPOWER)
		            {
		                nDamage = nDamage + (nDamage/2);
		            }
					*/
					
					//include sneak attack damage
					if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
						nDamage += EvaluateSneakAttack(oTarget, OBJECT_SELF);	
	
					
		
		            //Set the damage effect
		            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
	    			effect eVis = EffectVisualEffect( VFX_HIT_SPELL_SEARING_LIGHT );
	
		            //Apply the damage effect and VFX impact
		            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
		            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
		        }
			}
	    }
	    effect eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
	    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
	
	}
}