





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
    int nSpellID = GetSpellId();
    //int nDuration = GetCasterLevel(OBJECT_SELF) + 3;
    effect eSummon = EffectSummonCreature("c_treant", VFX_HIT_SPELL_SUMMON_CREATURE);
		
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(),HoursToSeconds(24));
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF, 0, 0));

}