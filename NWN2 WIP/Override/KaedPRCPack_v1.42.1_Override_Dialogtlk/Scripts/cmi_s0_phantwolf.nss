//::///////////////////////////////////////////////
//:: Phantom Bear
//:: cmi_s0_phantbear
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 14, 2008
//:://////////////////////////////////////////////

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

    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
	
    effect eSummon = EffectSummonCreature("cmi_phantwolf");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
	
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
	
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
/*
	object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
	effect eLink = IncorporealEffect(oSummon);
	effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_2d10, DAMAGE_TYPE_COLD);
	eLink = EffectLinkEffects(eDamage, eLink);

	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oSummon));
*/	
	DelayCommand(2.0f, ApplyPhantomStats(OBJECT_SELF));			
	
}