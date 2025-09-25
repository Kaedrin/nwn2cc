//::///////////////////////////////////////////////
//:: Force Missiles
//:: cmi_s2_magmiss
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: 
//:://////////////////////////////////////////////


// JLR - OEI 08/23/05 -- Metamagic changes
#include "nwn2_inc_spells"


#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 

#include "cmi_includes"

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
    int nMissiles = d3(5);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    float fDelay, fTime, fTime2;
	int nSpell = GetSpellId();
	int nPathType = PROJECTILE_PATH_TYPE_DEFAULT;
	location lSourceLoc = GetLocation( OBJECT_SELF );
	location lTarget = GetLocation( oTarget );
    int nCnt;
	float fTravelTime;
	
	int iForceMage = GetLevelByClass(CLASS_FORCE_MAGE);
	
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_MISSILE));
		
	    		RemoveEffectsFromSpell(oTarget, SPELL_SHIELD);
			
				//Apply a single damage hit for each missile instead of as a single mass
				for (nCnt = 1; nCnt <= nMissiles; nCnt++)
				{
					fTravelTime = GetProjectileTravelTime( lSourceLoc, lTarget, nPathType );
					if ( nCnt == 0 )	
						fDelay = 0.0f;
					else				
						fDelay = GetRandomDelay( 0.1f, 0.5f ) + (0.2 * IntToFloat(nCnt));
				   
		                //Roll damage
		                int nDam = d4(1) + 2;
		
		                //Set damage effect
		                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);
		                //Apply the MIRV and damage effect
		                DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
		                DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
						DelayCommand( fDelay, SpawnSpellProjectile(OBJECT_SELF, oTarget, lSourceLoc, lTarget, nSpell, nPathType) );
		       	}	

		}
}