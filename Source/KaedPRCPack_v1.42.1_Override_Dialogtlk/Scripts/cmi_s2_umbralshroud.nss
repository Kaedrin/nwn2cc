//::///////////////////////////////////////////////
//:: Umbral Shroud
//:: cmi_s2_umbralshroud
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 23, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

int GetDarkReserveLevel()
{

	if (GetHasSpell(110))
		return 8;
	if (GetHasSpell(160) || GetHasSpell(71) )
		return 7;		
	if (GetHasSpell(159))
		return 4;
/*
110	Mass Blindness and Deafness	8
159	Shadow Conjuration	4
160	Shadow Shield	7
*/
								
	return 0;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	object oTarget = GetSpellTargetObject();
	int nDarkLevel = 0;
	int nSpellId = GetSpellId();
	nDarkLevel = GetDarkReserveLevel();
		 
	if (nDarkLevel == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
	}
	else
	if (GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
		{		
			effect eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
			effect eConcealVision = EffectMissChance(nDarkLevel*5);

				//Fire cast spell at event for the specified target
				SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId));				

				//Apply the effects
				if (!(GetHasFeat(408, oTarget, TRUE)))  // Doesn't work if they have blind-fight
				{
					int nDC = GetReserveSpellSaveDC(nDarkLevel,OBJECT_SELF);
	                if  (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_EVIL))
					{	
						if (GetHasSpellEffect(nSpellId,oTarget))
							RemoveEffectsFromSpell(oTarget,nSpellId);
						ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConcealVision, oTarget, 6.0f);
						ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);				
					}
				}
		}	
	}			



}