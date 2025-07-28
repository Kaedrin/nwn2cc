//::///////////////////////////////////////////////
//:: Child of Night, Dance of the Shadows
//:: cmi_s2_dnceshadow
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 3, 2009
//:://////////////////////////////////////////////

#include "x2_inc_spellhook" 

#include "cmi_includes"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

	int nSpellId = SPELLABILITY_CHLDNIGHT_DANCE_SHADOWS;
	
    effect eDisplace = EffectConcealment(50);
    effect eVis = EffectVisualEffect( VFX_DUR_SPELL_DISPLACEMENT );
    effect eLink = EffectLinkEffects(eDisplace, eVis);
	eLink = SetEffectSpellId(eLink,nSpellId);
	eLink = SupernaturalEffect(eLink);
	
    int nDuration = GetLevelByClass(CLASS_CHILD_NIGHT,OBJECT_SELF);

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}