//::///////////////////////////////////////////////
//:: Inspirational Boost
//:: cmi_s0_inspboost
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Oct 22, 2007
//:://////////////////////////////////////////////

//#include "cmi_includes"
#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nCasterLvl = GetCasterLevel(OBJECT_SELF);
	float fDuration = TurnsToSeconds( nCasterLvl );
	fDuration = ApplyMetamagicDurationMods(fDuration);
	
	effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);
	eVis = SetEffectSpellId(eVis, SPELL_Inspirational_Boost);
	SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration);
	
    int nSingingSpellId = FindEffectSpellId(EFFECT_TYPE_BARDSONG_SINGING);
	//SendMessageToPC(OBJECT_SELF, "SpellID: " + IntToString(nSingingSpellId));
	string sScript;
	if (nSingingSpellId == SPELLABILITY_SONG_INSPIRE_COURAGE)
	{			
		sScript = "nw_s2_sngincour";
		SendMessageToPC(OBJECT_SELF, "You need to restart Inspire Courage for the bonus to take effect.");
	}	
	//ExecuteScript(sScript ,OBJECT_SELF);	
	
	
}      