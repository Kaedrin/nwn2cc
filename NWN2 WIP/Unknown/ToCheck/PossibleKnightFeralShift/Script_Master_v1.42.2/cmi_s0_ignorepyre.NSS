//::///////////////////////////////////////////////
//:: Ignore the Pyre
//:: cmi_s0_ignorepyre
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: January 10, 2010
//:://////////////////////////////////////////////

#include "nwn2_inc_spells"
#include "nw_i0_spells"

#include "x2_inc_spellhook" 
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
    float fDuration = HoursToSeconds(24);

	int nCasterLevel = GetWarlockCasterLevel(OBJECT_SELF);
	int nDmgResType = DAMAGE_TYPE_ACID;
	
	int nSpellId = GetSpellId();
	if (nSpellId == Ignore_The_Pyre_A || nSpellId == SPELL_I_IGNOREPYRE)
		nDmgResType = DAMAGE_TYPE_ACID;
	else
	if (nSpellId == Ignore_The_Pyre_C)
		nDmgResType = DAMAGE_TYPE_COLD;
	else
	if (nSpellId == Ignore_The_Pyre_E)
		nDmgResType = DAMAGE_TYPE_ELECTRICAL;	
	else
	if (nSpellId == Ignore_The_Pyre_F)
		nDmgResType = DAMAGE_TYPE_FIRE;
	else
	if (nSpellId == Ignore_The_Pyre_S)
		nDmgResType = DAMAGE_TYPE_SONIC;						
	
	effect eDmgRes = EffectDamageResistance(nDmgResType, 999);
	effect eDur = EffectVisualEffect(VFX_DUR_INVOCATION_DARKONESLUCK);
    effect eLink = EffectLinkEffects(eDur, eDmgRes);

	eLink = SetEffectSpellId(eLink, SPELL_I_IGNOREPYRE);
    RemoveEffectsFromSpell(OBJECT_SELF, SPELL_I_IGNOREPYRE);

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_I_IGNOREPYRE, FALSE));

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
}