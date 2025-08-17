//::///////////////////////////////////////////////
//:: Oaken Skin
//:: cmi_s2_oakenskin
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: July 13, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = FOREST_MASTER_OAKEN_SKIN;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nACBonus;
	int nForestMaster = GetLevelByClass(CLASS_FOREST_MASTER, OBJECT_SELF);
	
	if (nForestMaster > 6)
		nACBonus = 7;
	else
	if (nForestMaster > 4)
		nACBonus = 5;
	else
		nACBonus = 3;
		
	if (GetHasFeat(490, OBJECT_SELF))
		nACBonus++;	
	
	effect ACBonus =  EffectACIncrease(nACBonus, AC_NATURAL_BONUS);
	ACBonus = SetEffectSpellId(ACBonus,nSpellId);
	ACBonus = SupernaturalEffect(ACBonus);
	
	DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ACBonus, OBJECT_SELF));
	
}      