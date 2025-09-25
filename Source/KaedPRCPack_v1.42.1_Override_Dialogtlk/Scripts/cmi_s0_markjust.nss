//::///////////////////////////////////////////////
//:: Mark of Justice
//:: cmi_s0_markjust.nss
//:://////////////////////////////////////////////\

//Based on Bestow Curse by OEI

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 

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
    //effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	// NWN1 VFX
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_BESTOW_CURSE );	// NWN2 VFX
    effect eCurse = EffectCurse(4, 4, 4, 4, 4, 4);

    //Make sure that curse is of type supernatural not magical
    eCurse = SupernaturalEffect(eCurse);
	effect eLink = EffectLinkEffects( eCurse, eVis );
	if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
	{
        //Signal spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BESTOW_CURSE));
         //Make SR Check
         if (!MyResistSpell(OBJECT_SELF, oTarget))
         {
            //Make Will Save
            if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()))
            {
                //Apply Effect and VFX
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// NWN1 VFX
            }
        }
    }
}