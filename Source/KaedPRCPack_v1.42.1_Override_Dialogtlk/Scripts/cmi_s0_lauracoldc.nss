//::///////////////////////////////////////////////
//:: Lesser Aura of Cold - OnHeartbeat
//:: cmi_s0_lauracoldc
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 23, 2010
//:://////////////////////////////////////////////

#include "nw_i0_spells"
#include "x2_inc_spellhook" 
#include "nwn2_inc_metmag"
#include "cmi_ginc_spells"

void main()
{
    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

//Declare Major variables

	object oTarget;
	object oCreator = GetAreaOfEffectCreator();
	int nDamValue;
	effect eColdDamage;
	effect eColdHit = EffectVisualEffect(VFX_COM_HIT_FROST);
		
	//If the caster is dead, kill the AOE
	if (!GetIsObjectValid(oCreator))
	{
		DestroyObject(OBJECT_SELF);
	}
	
	int nHasPierceCold = FALSE;	
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD, oCreator))
	{
		nHasPierceCold = TRUE;
	}		
	
	//Find our first target
	oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
	
	//This loop validates target, makes it save, burns it, then finds the next target and repeats
	while(GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCreator) && (oTarget != oCreator) )
		{
			SignalEvent(oTarget, EventSpellCastAt(oCreator, GetSpellId()));
			
			if (!MyResistSpell(oCreator, oTarget))
			{
				//Determine damage
				nDamValue =	d6();
				nDamValue =	ApplyMetamagicVariableMods(nDamValue, 6);

				eColdDamage	= EffectDamage(nDamValue, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, nHasPierceCold);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eColdDamage, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eColdHit, oTarget);
			}
		}
		oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
	}
}
	
	