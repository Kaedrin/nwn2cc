//::///////////////////////////////////////////////
//:: Breath Weapon for Dragon Disciple Class
//:: x2_s2_discbreath
//:: Copyright (c) 2003Bioware Corp.
//:://////////////////////////////////////////////
/*
  AFW-OEI 04/26/2006: Change stats to 3.5 Dragon Disciple

  Damage Type is Fire
  Save is Reflex
  Save DC = 20 + class level + Con modifier
  Shape is cone, 30' ~= RADIUS_SIZE_COLOSSAL

  Level      Damage    
  --------------------
  3           2d8
  7           4d8
  10          6d8

  after 10:
   damage: 4d8  + 1d8 per 3 levels after 10
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: June, 17, 2003
//:://////////////////////////////////////////////
//:: AFW-OEI 04/26/2006: Pass to use latest & greatest
//:: 	script functions, and update to 3.5 rules.


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "cmi_ginc_chars"

void main()
{
	if (!X2PreSpellCastCode())
	{
		return;			// If code withing PreSpellCaseHook (i.e., UMD) reports FALSE, do not run this spell
	}
	
	int nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");
	
	if (!GetHasFeat(FEAT_DRAGON_DIS_GENERAL, OBJECT_SELF))
	{
		FeatAdd(OBJECT_SELF, FEAT_DRAGON_DIS_GENERAL, FALSE);
		FeatAdd(OBJECT_SELF, FEAT_DRAGON_DIS_RED, FALSE);
		SetLocalInt(OBJECT_SELF, "DragonDisciple", 1);	
	}
	else // Has Feat
	{

		if (nDragonDis < 1)
		{
			SetupDragonDis();
			nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");
		}
	
	}
	
	int nResistType = SAVING_THROW_TYPE_FIRE;
	int nDamageType = DAMAGE_TYPE_FIRE;	
	int nHitEffect = VFX_HIT_SPELL_FIRE;
	int nConeEffect = VFX_DUR_CONE_FIRE;
		
	if (nDragonDis == 2)
	{
		nDamageType = DAMAGE_TYPE_ACID;
		nResistType = SAVING_THROW_TYPE_ACID;
		nHitEffect = VFX_HIT_SPELL_ACID;
		nConeEffect = VFX_DUR_CONE_ACID;		
	}
	else
	if (nDragonDis == 3)
	{	
		nDamageType = DAMAGE_TYPE_ELECTRICAL;
		nResistType = SAVING_THROW_TYPE_ELECTRICITY;
		nHitEffect = VFX_HIT_SPELL_LIGHTNING;
		nConeEffect = VFX_DUR_CONE_LIGHTNING;			
	}
	else
	if (nDragonDis == 4)
	{
		nDamageType = DAMAGE_TYPE_COLD;	
		nResistType = SAVING_THROW_TYPE_COLD;
		nHitEffect = VFX_HIT_SPELL_ICE;
		nConeEffect = VFX_DUR_CONE_ICE;					
	}
	
	//SendMessageToPC(OBJECT_SELF, "Dragon Dis Type is " + IntToString(nDragonDis));
	
    object oTarget;

	// Determine breath damage
	int nLevel = GetLevelByClass( CLASS_TYPE_DRAGONDISCIPLE, OBJECT_SELF);
	int nDamageDice;
    if (nLevel <7)
    {
        nDamageDice = 2;
    }
    else if (nLevel <10)
    {
        nDamageDice = 4;
    }
    else if (nLevel ==10)
    {
        nDamageDice = 6;
    }
    else
    {
      nDamageDice = 6+((nLevel -10)/3);
    }
	
		// Determine Save DC
	int nSaveDC = 13 + nLevel + GetAbilityModifier( ABILITY_CONSTITUTION, OBJECT_SELF);

    //Declare major variables
	int nPersonalDamage;		// Damage actually applied (after reflex saves)
    float fDelay;
	float fMaxDelay = 0.0f;		// Used to determine the duration of the flame cone
	effect eDmg;
    effect eVis = EffectVisualEffect( nHitEffect );		// Visual effect from taking damage from spell
	effect eBreath = EffectVisualEffect( nConeEffect );	// Visual effect of caster breathing <- PLACEHOLDER EFFECT!

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation(), TRUE,
									OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
    	int nDamage = d10(nDamageDice);	// Possible max damage (before reflex saves)
	
        nPersonalDamage = nDamage;
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
			fDelay += 2.0f;
			if( fDelay > fMaxDelay)
			{
				fMaxDelay = fDelay;				
			}

            // Make SR check, and adjust damage based on Reflex save.
            //if((!MyResistSpell(OBJECT_SELF, oTarget, fDelay)) && (oTarget != OBJECT_SELF))
			if (oTarget != OBJECT_SELF)
			{

				nPersonalDamage = GetReflexAdjustedDamage( nPersonalDamage, oTarget, nSaveDC, nResistType );
	            eDmg = EffectDamage(nPersonalDamage, nDamageType);
	            if (nPersonalDamage > 0)
	            {
	                //Apply the VFX impact and effects
	                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
	                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
	            }
			}
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation(), TRUE,
									   OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
		// Show that cone of fire!
		fMaxDelay += 0.5f;
		ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eBreath, OBJECT_SELF, fMaxDelay);
}