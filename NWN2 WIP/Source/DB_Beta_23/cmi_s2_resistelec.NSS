//::///////////////////////////////////////////////
//:: Stormsinger Resist Electricity
//:: cmi_s2_resistelec
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 15, 2008
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
	
	int nSpellId = STORMSINGER_RESIST_ELECTRICITY;
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nValue;
	int nClassLevel = GetLevelByClass(CLASS_STORMSINGER);
	if (nClassLevel > 7)
		nValue = 15;
	else
	if (nClassLevel > 5)
		nValue = 10;
	else
		nValue = 5;
			
	effect eDmgRes =  EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nValue);
	eDmgRes = SetEffectSpellId(eDmgRes,nSpellId);
	eDmgRes = SupernaturalEffect(eDmgRes);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDmgRes, OBJECT_SELF);
	
}      