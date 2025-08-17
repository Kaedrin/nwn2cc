



#include "nwn2_inc_spells"
#include "NW_I0_SPELLS"    
#include "x2_inc_spellhook" 

#include "cmi_includes"

// Temporary cmi_options until they are moved to the new MP cmi_options include file
const int cmi_option_forcemissile_die_count = 3;     //3
const int cmi_option_forcemissile_die_size = 4;      //d4 Currently only supports d2, d3, d4, and d6
const int cmi_option_forcemissile_bonus_value = 3;   //+3 per missile (5 at level 5)
const int cmi_option_forcemage_use_flat_scaling = 0; //false, if true, use 2*(Sorc+Wiz+FM) for damage

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
	int iForceMage = GetLevelByClass(CLASS_FORCE_MAGE);
    int nMissiles = iForceMage;
    //effect eMissile = EffectVisualEffect(VFX_IMP_MIRV);	// handled by SpawnSpellProjectile()
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    float fDelay, fTime, fTime2;
	int nSpell = GetSpellId();
	int nPathType = PROJECTILE_PATH_TYPE_DEFAULT;
	location lSourceLoc = GetLocation( OBJECT_SELF );
	location lTarget = GetLocation( oTarget );
    int nCnt;
	float fTravelTime;
	

	
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_MISSILE));
        		
		if (iForceMage > 0)
		{
		
	    		RemoveEffectsFromSpell(oTarget, SPELL_SHIELD);
			
				//Apply a single damage hit for each missile instead of as a single mass
				for (nCnt = 1; nCnt <= nMissiles; nCnt++)
				{
					fTravelTime = GetProjectileTravelTime( lSourceLoc, lTarget, nPathType );
					if ( nCnt == 0 )	
						fDelay = 0.0f;
					else				
						fDelay = GetRandomDelay( 0.1f, 0.3f ) + (0.1f * IntToFloat(nCnt));
				   
		                //Roll damage
		                int nDam = d4(3) + 3; //Default value in case something is set wrong in the options
						
						if (cmi_option_forcemage_use_flat_scaling)
						{	
							nDam = iForceMage + GetLevelByClass(CLASS_TYPE_WIZARD) + GetLevelByClass(CLASS_TYPE_SORCERER);
							nDam = nDam*2;
						}
						else
						{
							if (cmi_option_forcemissile_die_size == 4)
								nDam = d4(cmi_option_forcemissile_die_count)+cmi_option_forcemissile_bonus_value;
							else						
							if (cmi_option_forcemissile_die_size == 3)
								nDam = d3(cmi_option_forcemissile_die_count)+cmi_option_forcemissile_bonus_value;
							else						
							if (cmi_option_forcemissile_die_size == 6)
								nDam = d6(cmi_option_forcemissile_die_count)+cmi_option_forcemissile_bonus_value;							
							else
							if (cmi_option_forcemissile_die_size == 2)
								nDam = d2(cmi_option_forcemissile_die_count)+cmi_option_forcemissile_bonus_value;																
						}
		
		                //Set damage effect
		                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL, TRUE);
		                //Apply the MIRV and damage effect
		                DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
		                DelayCommand(fDelay + fTravelTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
						DelayCommand( fDelay, SpawnSpellProjectile(OBJECT_SELF, oTarget, lSourceLoc, lTarget, nSpell, nPathType) );
		       	}	
		}

	

	}
}