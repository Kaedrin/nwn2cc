//::///////////////////////////////////////////////
//:: Lesser Aura of Cold - OnEnter
//:: cmi_s0_lauracolda
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

	object oTarget = GetEnteringObject();
	object	oCaster	= GetAreaOfEffectCreator();
		
	int nDamValue;
	effect eColdDamage;
	effect eColdHit = EffectVisualEffect(VFX_COM_HIT_FROST);
	
	int nHasPierceCold = FALSE;	
	if (GetHasFeat(FEAT_FROSTMAGE_PIERCING_COLD, oCaster))
	{
		nHasPierceCold = TRUE;
	}	

	nDamValue =	d6();
	nDamValue =	ApplyMetamagicVariableMods(nDamValue, 6);

	if (GetIsObjectValid(oTarget))
	{
		if ( spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster) && (oTarget != oCaster ) )
		{
			SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
			
			if (!MyResistSpell(oCaster, oTarget))
			{	
				eColdDamage	= EffectDamage(nDamValue, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL, nHasPierceCold);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eColdDamage, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, eColdHit, oTarget);
			}
		}
	}	
		
}
	
			

	
	
	