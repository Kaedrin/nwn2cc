//::///////////////////////////////////////////////
//:: Scourge
//:: cmi_s0_scourge
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Sept 25, 2007
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
  
	int nStrMod = ApplyMetamagicVariableMods(d6(),6);
	int nDexMod = ApplyMetamagicVariableMods(d6(),6);
	
	effect eCurse = EffectCurse(nStrMod,nDexMod,0,0,0,0);	
		
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_BESTOW_CURSE);
	effect eLink = EffectLinkEffects(eVis, eCurse);
	eLink = SupernaturalEffect(eLink);
	
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
		
			if (!GetIsImmune(oTarget,IMMUNITY_TYPE_DISEASE))
			{
		
				if (!MyResistSpell(OBJECT_SELF, oTarget))
				{
					if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()))
					{
					    float fDelay = GetRandomDelay(0.4, 1.1);
									
			            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
			            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
					}
				}
			}					
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_VAST, GetLocation(OBJECT_SELF));
    }	
	
}      