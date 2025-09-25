/*
	Constants and help functions for custom grenades
*/

#include "x2_I0_SPELLS"
#include "NW_I0_SPELLS"


object IPGetTargetedOrEquippedWeapon()
{
  object oTarget = GetSpellTargetObject();
  if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
  {
  
   if (IPGetIsMeleeWeapon(oTarget) || IPGetIsRangedWeapon(oTarget))
    {
        return oTarget;
    }
    else
    {
        return OBJECT_INVALID;
    }

  }

  object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && (IPGetIsRangedWeapon(oWeapon1) || IPGetIsMeleeWeapon(oWeapon1)))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
  if (GetIsObjectValid(oWeapon1) && (IPGetIsRangedWeapon(oWeapon1) || IPGetIsMeleeWeapon(oWeapon1)))
  {
    return oWeapon1;
  }
  
   oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  } 

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }

  oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  }
  
   oWeapon1 = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
  if (GetIsObjectValid(oWeapon1))
  {
    return oWeapon1;
  } 

  return OBJECT_INVALID;

}

// Gets the die and number of dice to roll.
// Returns the result.
int RollDice(int nDie, int nDiceNum)
{
	int nResult = 0;
	int i;
	for (i = 0; i < nDiceNum; i++)
		nResult += Random(nDie) + 1;
		
	return nResult;
}

void DoDamageGrenade(int nDamageType, effect eVis, effect eHit, int nSavingThrowType)
{
	object oItem     = GetSpellCastItem();
	location lTarget = GetSpellTargetLocation();
	float fDelay;
	effect eDam;
	int nDamage;
	int nEffectDC;
	
	// Get data from item
	int nDie = GetLocalInt(oItem, "ev_die");
	int nDieNum = GetLocalInt(oItem, "ev_die_num");
	int nDC = GetLocalInt(oItem, "ev_crafter_skill");
	
	// Skill bonuses
	int nBonusDamage = nDC / 5;
	nDC += (nDC / 10);
	
	// Explosion visual
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
	
	// Sonic additions
	if (nDamageType == DAMAGE_TYPE_SONIC) {
	
		// Get data from item;
		nEffectDC = GetLocalInt(oItem, "ev_dc_secondary");
	
		// Skill bonuses
		nEffectDC += (GetLocalInt(oItem, "ev_crafter_skill") / 10);	
	}
	
	
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);    
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE,OBJECT_SELF) )
        {
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
			
            //Roll damage for each target
            nDamage = RollDice(nDie, nDieNum) + nBonusDamage;		
			
			//Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSavingThrowType);		
			
			// Divine only hits undead
			if (nDamageType == DAMAGE_TYPE_DIVINE && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD) {
				nDamage = 0;	
			}
			
			//Set the damage effect
            eDam = EffectDamage(nDamage, nDamageType);
			
            if(nDamage > 0)
            {
	            // Apply effects to the currently selected target.
	            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
				
				// Damage effect
	            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
				
				// Hit visual
	            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));				
             }  
			 
			 // Sonic addition
			 if (nDamageType == DAMAGE_TYPE_SONIC &&  !MySavingThrow(SAVING_THROW_REFLEX, oTarget, nEffectDC)) {
			 	DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDeaf(), oTarget, RoundsToSeconds(5)));
			 }	 
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	}	
} 


void DoEffectGrenade(int nRounds, string sEffect, effect eVis, effect eHit)
{
	object oItem     = GetSpellCastItem();
	location lTarget = GetSpellTargetLocation();
	float fDelay;
	effect eEffect;
	effect eLink;
	
	// Get data from item;
	int nDC = GetLocalInt(oItem, "ev_dc_secondary");
	
	// Skill bonuses
	nDC += (GetLocalInt(oItem, "ev_crafter_skill") / 10);
	
	if (sEffect == "entangle") {
		eEffect = EffectEntangle();
		eEffect = EffectLinkEffects(eEffect, EffectVisualEffect(VFX_DUR_ENTANGLE));
		
		effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE, "", "", "", "");
		ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, 1.5);
	}
	else if (sEffect == "sicken") {
	
		// Link several effects to get the sicken stuff
		eEffect = EffectLinkEffects(EffectAttackDecrease(2), EffectDamageDecrease(2));
		eEffect = EffectLinkEffects(eEffect, EffectSavingThrowDecrease(SAVING_THROW_TYPE_ALL, 2));
		eEffect = EffectLinkEffects(eEffect, EffectSkillDecrease(SKILL_ALL_SKILLS, 2));
		eEffect = EffectLinkEffects(eEffect, EffectAbilityDecrease(ABILITY_CHARISMA, 2));
		eEffect = EffectLinkEffects(eEffect, EffectAbilityDecrease(ABILITY_CONSTITUTION, 2));
		eEffect = EffectLinkEffects(eEffect, EffectAbilityDecrease(ABILITY_DEXTERITY, 2));
		eEffect = EffectLinkEffects(eEffect, EffectAbilityDecrease(ABILITY_INTELLIGENCE, 2));
		eEffect = EffectLinkEffects(eEffect, EffectAbilityDecrease(ABILITY_STRENGTH, 2));
		eEffect = EffectLinkEffects(eEffect, EffectVisualEffect(VFX_DUR_SICKENED));
		
		// Set id
		SetEffectSpellId(eEffect, -828);
		
	}
	else if (sEffect == "flash") {
		eEffect = EffectSanctuary(nDC);	
		eEffect = EffectLinkEffects(eEffect, EffectVisualEffect(VFX_DUR_INVISIBILITY));	
	}
	
	// Explosion visual
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
	
	
	object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);    
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget,SPELL_TARGET_STANDARDHOSTILE,OBJECT_SELF) )
        {
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;			
			
            // Apply effects to the currently selected target.
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
			
			// Hit visual
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
			
			
			
			// Make reflex save
             if(sEffect != "flash" && !MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC)) {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, RoundsToSeconds(nRounds)));
             }
			 else if (sEffect == "flash") {
			 	DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, RoundsToSeconds(nRounds)));
			 }								  	
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	}	
} 


void DoAcidGrenade()
{		                  
    DoDamageGrenade(DAMAGE_TYPE_ACID, EffectVisualEffect(VFX_HIT_AOE_ACID), EffectVisualEffect(VFX_IMP_ACID_L), SAVING_THROW_TYPE_ACID);
}

void DoFireGrenade()
{		                  
    DoDamageGrenade(DAMAGE_TYPE_FIRE, EffectVisualEffect(VFX_HIT_AOE_FIRE), EffectVisualEffect(VFX_IMP_FLAME_M), SAVING_THROW_TYPE_FIRE);
}

void DoColdGrenade()
{		                  
    DoDamageGrenade(DAMAGE_TYPE_COLD, EffectVisualEffect(VFX_HIT_AOE_ICE), EffectVisualEffect(VFX_IMP_FROST_L), SAVING_THROW_TYPE_COLD);
}

void DoElectGrenade()
{		                  
    DoDamageGrenade(DAMAGE_TYPE_ELECTRICAL, EffectVisualEffect(VFX_HIT_AOE_LIGHTNING), EffectVisualEffect(VFX_IMP_LIGHTNING_M), SAVING_THROW_TYPE_ELECTRICITY);
}

void DoSonicGrenade()
{
	DoDamageGrenade(DAMAGE_TYPE_SONIC, EffectVisualEffect(VFX_HIT_AOE_SONIC), EffectVisualEffect(VFX_IMP_SONIC), SAVING_THROW_TYPE_SONIC);
}

void DoEntangleGrenade()
{
	DoEffectGrenade(5, "entangle", EffectVisualEffect(VFX_HIT_AOE_POISON), EffectVisualEffect(VFX_DUR_ENTANGLE)); 
}

void DoSickenGrenade()
{
	DoEffectGrenade(5, "sicken", EffectVisualEffect(VFX_HIT_AOE_ACID), EffectVisualEffect(VFX_DUR_ENTANGLE)); 
}

void DoHolyGrenade()
{	
	DoDamageGrenade(DAMAGE_TYPE_DIVINE, EffectVisualEffect(VFX_HIT_AOE_HOLY), EffectVisualEffect(VFX_HIT_SPELL_HOLY), SAVING_THROW_TYPE_DIVINE);
}

void DoFlashGrenade()
{
	DoEffectGrenade(3, "flash", EffectVisualEffect(VFX_HIT_AOE_HOLY), EffectVisualEffect(VFX_DUR_ENTANGLE));
}

void DoCinderFire()
{
	object oItem   = GetSpellCastItem();
	int nCasterLvl = GetLocalInt(oItem, "ev_crafter_skill");	
	int rounds = 30 + nCasterLvl;
	if (rounds > 70) rounds = 70;
	float fDuration = RoundsToSeconds(rounds);
    object oMyWeapon   =  IPGetTargetedOrEquippedWeapon();
	itemproperty ipAnointWpn;
	int nItemVisual = ITEM_VISUAL_FIRE;
	effect eDmgIncrease = EffectDamageIncrease(DAMAGE_BONUS_1, DAMAGE_TYPE_FIRE);
	
	if(GetIsObjectValid(oMyWeapon) )
    {
		// Apply Elem Dmg to Char
        DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmgIncrease, OBJECT_SELF, fDuration)); 
		IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(nItemVisual), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);//Make the sword glow        
    }
}