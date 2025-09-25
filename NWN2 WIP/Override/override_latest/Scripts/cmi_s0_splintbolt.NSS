
//::///////////////////////////////////////////////
//:: Splinterbolt
//:: cmi_s0_splintbolt
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 

#include "cmi_inc_sneakattack"
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
	int nDamageType = DAMAGE_TYPE_PIERCING;
	
	if (GetLastSpellCastClass() == CLASS_TYPE_SPIRIT_SHAMAN)
		nDamageType = DAMAGE_TYPE_MAGICAL;
	
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMissiles = (nCasterLvl + 1)/4;
    if (nMissiles > 3)
    {
		nMissiles = 3;
	}	

	effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    float fDelay;
	int nSpell = GetSpellId();
	int nPathType = PROJECTILE_PATH_TYPE_ACCELERATING;
	location lSourceLoc = GetLocation( OBJECT_SELF );
	location lTarget = GetLocation( oTarget );
    int nCnt;
	float fTravelTime;
	int nTouch;
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
		//Apply a single damage hit for each missile instead of as a single mass
		for (nCnt = 1; nCnt <= nMissiles; nCnt++)
		{
			nTouch = TouchAttackRanged(oTarget, TRUE);
			if (nTouch != TOUCH_ATTACK_RESULT_MISS)
			{
				fTravelTime = GetProjectileTravelTime( lSourceLoc, lTarget, nPathType );
				fDelay = 0.1f * IntToFloat(nCnt);		        
				
				int nDam = d6(4);
	            nDam = ApplyMetamagicVariableMods(nDam, 24);
				
				if ( nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT) )
		        {
					nDam = nDam * 2;
					nDam += GetRangedTouchSpecDamage(OBJECT_SELF, 4, TRUE);		
				}
				else
				{
					nDam += GetRangedTouchSpecDamage(OBJECT_SELF, 4, FALSE);
				}	
								
				//include sneak attack damage
				if (nCnt == 1)
				{
					if (StringToInt(Get2DAString("cmi_options","Value",CMI_OPTIONS_SneakAttackSpells)))
						nDam += EvaluateSneakAttack(oTarget, OBJECT_SELF);						
				}
				
				//Set damage effect
				effect eDam = EffectDamage(nDam, nDamageType);
				//Apply the MIRV and damage effect
				DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
				DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
				DelayCommand(fDelay, SpawnSpellProjectile(OBJECT_SELF, oTarget, lSourceLoc, lTarget, nSpell, nPathType) );
			}
		}
	}
}