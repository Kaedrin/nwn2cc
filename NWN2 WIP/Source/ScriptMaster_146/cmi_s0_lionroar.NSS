//::///////////////////////////////////////////////
//:: Lion's Roar
//:: cmi_s0_lionroar
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 8, 2007
//:://////////////////////////////////////////////

float RADIUS_SIZE_LIONROAR =  36.57f; // 120'

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	int nHPBonus = nCasterLvl;
	float fDuration = TurnsToSeconds(nCasterLvl);
	if (nHPBonus > 20)
		nHPBonus = 20;
	nCasterLvl = nCasterLvl/2;
    int nDmgDice;
    if ( nCasterLvl > 10 )
    {
        nDmgDice = 10;
    }
    else
    {
        nDmgDice = nCasterLvl;
    }
    int nDamage, nDamage2;
    float fDelay;
    effect eVisHit = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
    effect eDam;
	effect eStun = EffectStunned();	
	effect eTempHP;
	effect eAB = EffectAttackIncrease(1);
	effect eFearSave = EffectSavingThrowIncrease(SAVING_THROW_TYPE_FEAR,1);
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	effect eLink = EffectLinkEffects(eAB,eFearSave);
	eLink = EffectLinkEffects(eLink,eVis);
		
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Apply the ice storm VFX at the location captured above.
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LIONROAR, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF) //Additional target check to make sure that the caster cannot be harmed by this spell
        {
            fDelay = GetRandomDelay(0.15, 0.35);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
				nDamage = d8(nDmgDice);
				nDamage = ApplyMetamagicVariableMods(nDamage, nDmgDice * 8);
							
				int FortSave = FortitudeSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SONIC);
				if (FortSave == SAVING_THROW_CHECK_FAILED)
				{
					//Apply Stun
					DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1)));	
				}
				else
				{
					nDamage = nDamage / 2;
				}
				eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
				DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHit, oTarget));			
            }
        }
		else
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF) && oTarget != OBJECT_SELF)	
		{
			//Apply Buff
			eTempHP = EffectTemporaryHitpoints(d8()+nHPBonus);
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,fDuration));	
			DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTempHP, oTarget, fDuration));	
			
		}
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LIONROAR, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}