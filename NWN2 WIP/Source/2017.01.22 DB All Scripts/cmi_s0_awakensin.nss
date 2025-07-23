//::///////////////////////////////////////////////
//:: Awaken Sin
//:: cmi_s0_awakensin
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On:  July 5, 2007
//:://////////////////////////////////////////////

#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	object oTarget = GetSpellTargetObject();
	
	if (GetAlignmentGoodEvil(oTarget) != ALIGNMENT_EVIL)
	{
		SpeakString("Awaken Sin only affects evil targets.  Spell failed.");
		return;
	}
	
	int nCasterLvl = GetPalRngCasterLevel();
	int nMetaMagic = GetMetaMagicFeat();
		
	int nNumDice = nCasterLvl;
	if (nNumDice > 10)
		nNumDice = 10;
	int nDamage = MaximizeOrEmpower(6, nNumDice, nMetaMagic);
	effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
    effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);	
    effect eStun = EffectStunned();		
	
    if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
    {	
		if (!GetIsImmune(oTarget, IMMUNITY_TYPE_DOMINATE, OBJECT_SELF))
		{
	        if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
		    {
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));	
		    	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
				ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
				ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1));
	             	
		    }
		}	
	}
		
}      