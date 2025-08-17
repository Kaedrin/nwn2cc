//::///////////////////////////////////////////////
//:: Lesser Aura of Cold
//:: cmi_s0_lauracold
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

	object oCaster = OBJECT_SELF;
	string sSelf = ObjectToString(oCaster) + IntToString(GetSpellId());
	object oSelf = GetNearestObjectByTag(sSelf);
	effect eAOE = EffectAreaOfEffect(VFX_MOB_LESSER_AURA_COLD, "", "", "", sSelf);
	effect eVis = EffectVisualEffect(924);
	float fDuration = RoundsToSeconds(GetPalRngCasterLevel());
	effect	eLink		=	EffectLinkEffects(eAOE, eVis);
	
	//Destroy the object if it already exists before creating a new one
	if (GetIsObjectValid(oSelf))
	{
		DestroyObject(oSelf);
	}
	
	//Determine duration
	fDuration = ApplyMetamagicDurationMods(fDuration);

	//Generate the object
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaster, fDuration);
	//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oCaster, fDuration);
}