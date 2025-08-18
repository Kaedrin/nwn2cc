//::///////////////////////////////////////////////
//:: Leonal's Roar
//:: cmi_s0_leonalroar
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 25, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_includes"

void ApplyBlasphemyEffect(object oTarget, int nHD, int nCasterHD)
{

	effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BESTOW_CURSE );
	
	float fDazeDur = ApplyMetamagicDurationMods(TurnsToSeconds(1));
	
	int nPara = d10();
	float fParaDur = ApplyMetamagicDurationMods(TurnsToSeconds(nPara));
	
	int nWeakStr = d6(2);
	int nWeakDur = d4(2);
	float fWeakDur = ApplyMetamagicDurationMods(RoundsToSeconds(nWeakDur));
			
	int SpellDC = 20 + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);	
	float fDelay = GetRandomDelay(0.4, 1.1);
	int SpellId = LION_TALISID_LEONALS_ROAR;
			
	//Para Effect;
	effect ePara = EffectParalyze(SpellDC,SAVING_THROW_WILL); 
							
	//Weak Effect;
	effect eWeak = EffectAbilityDecrease(ABILITY_STRENGTH, nWeakStr);
				
	//Daze Effect;					
	effect eDaze = EffectDazed();
	eDaze = EffectLinkEffects(eVis,eDaze);	

	if (nHD > nCasterHD)
	{
		//No Effect
	}
	else if (nHD == nCasterHD)
	{
	
		RemoveEffectsFromSpell(oTarget,SpellId);		
	
		//Daze
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, fDazeDur);
	
	}
	else if ((nHD < nCasterHD) && (nHD > (nCasterHD - 5)))
	{
		
		RemoveEffectsFromSpell(oTarget, SpellId);	

		//Daze
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, fDazeDur);
		
		//Weak		
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeak, oTarget, fWeakDur);
		
	}
	else if ((nHD <= (nCasterHD - 5) && (nHD > (nCasterHD - 10))))
	{
	
		RemoveEffectsFromSpell(oTarget, SpellId);
	
		//Daze
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, fDazeDur);
				
		//Weak		
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeak, oTarget, fWeakDur);

		//Para	
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fParaDur);		
	}
	else
	{
	
		RemoveEffectsFromSpell(oTarget, SpellId);
			
		//Daze
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, fDazeDur);
		
		//Weak		
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeak, oTarget, fWeakDur);
			
		//Para	
		SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SpellId, FALSE));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fParaDur);		
		
		//Death
		effect eDeath = EffectDeath();						
	    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);	
		
	}
	
	if (!MySavingThrow(SAVING_THROW_FORT, oTarget, SpellDC))
	{
		effect eDamage = EffectDamage(d6(2), DAMAGE_TYPE_SONIC);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);	
	}							

					
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    	
	int nCasterHD = GetHitDice(OBJECT_SELF);
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
		
			if (GetAlignmentGoodEvil(oTarget) != ALIGNMENT_GOOD)
			{
			
			
	         	if (MyResistSpell(OBJECT_SELF, oTarget))
	         	{
					// Spell resisted, no effect
	        	}	
				else
				{
				
					int nHD = GetHitDice(oTarget);

					//Banish Effect;
					if (GetSubRace(oTarget) == RACIAL_SUBTYPE_OUTSIDER)
					{	
						if (!MySavingThrow(SAVING_THROW_WILL, oTarget, (GetSpellSaveDC()+4)))
	            		{
						    effect eVis = EffectVisualEffect( VFX_HIT_AOE_ABJURATION );
							effect eDeath = EffectDeath();
							effect eBanishLink = EffectLinkEffects(eVis, eDeath);						
	                		ApplyEffectToObject(DURATION_TYPE_INSTANT, eBanishLink, oTarget);
	           			}
						else
						{
							ApplyBlasphemyEffect(oTarget,nHD,nCasterHD);
						}
					}
					else
					{
						ApplyBlasphemyEffect(oTarget,nHD,nCasterHD);
					}						
								
				}
			}	
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_TREMENDOUS, GetLocation(OBJECT_SELF));
    }	
	
}      