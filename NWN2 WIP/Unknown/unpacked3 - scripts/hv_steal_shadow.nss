#include "x2_inc_spellhook" 

void main()
{
    if (!X2PreSpellCastCode())
    {	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	object oTarget = GetSpellTargetObject();
	object oCaster = OBJECT_SELF;
	
	string sTag = GetTag(oTarget);
	string sNewTag = IntToString(ObjectToInt(OBJECT_SELF)) + "_" + sTag;	// Create "unique" tag
	int nNewHP = 1;
    effect eSummon = EffectSummonCopy(oTarget, VFX_HIT_AOE_SONIC, 0.0f, sNewTag, nNewHP, "hv_buff_shadow");

    int nDuration = 24;
	
    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
	SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), FALSE));
}