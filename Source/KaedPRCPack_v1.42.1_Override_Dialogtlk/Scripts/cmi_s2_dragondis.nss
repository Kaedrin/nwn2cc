//::///////////////////////////////////////////////
//:: Sacred Flesh
//:: cmi_s2_sacredflesh
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: March 23, 2008
//:://////////////////////////////////////////////

//#include "cmi_ginc_spells"
#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_ginc_chars"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
	int nSpellId = FEAT_DRAGON_DIS_IMMUNITY;
	
	if (GetHasSpellEffect(nSpellId,OBJECT_SELF))
	{
		RemoveSpellEffects(nSpellId, OBJECT_SELF, OBJECT_SELF);
	}	
	
	int nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");
	if (nDragonDis == 0)
	{
		SetupDragonDis();
		nDragonDis = GetLocalInt(OBJECT_SELF, "DragonDisciple");	
	}
	
	int nDamageType = DAMAGE_TYPE_FIRE;	
	if (nDragonDis == 2)
		nDamageType = DAMAGE_TYPE_ACID;
	else
	if (nDragonDis == 3)
		nDamageType = DAMAGE_TYPE_ELECTRICAL;	
	else
	if (nDragonDis == 4)
		nDamageType = DAMAGE_TYPE_COLD;	
	
	effect eImmunity = EffectDamageResistance(nDamageType, 9999, 0);

	eImmunity = SetEffectSpellId(eImmunity,nSpellId);
	eImmunity = SupernaturalEffect(eImmunity);
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity, OBJECT_SELF);
	
}      