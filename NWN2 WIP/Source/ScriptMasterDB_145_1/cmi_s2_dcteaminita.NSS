//::///////////////////////////////////////////////
//:: Teamwork (Nightsong Infiltrator)
//:: cmi_s2_niteamworka
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: November 8, 2007
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "cmi_includes"
//#include "cmi_ginc_spells"

void main()
{
	object oTarget = GetEnteringObject();
	object oCaster = GetAreaOfEffectCreator();
	
	if (oTarget != oCaster)
	{
	    if(spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, oCaster))
	    {
			if (!GetHasSpellEffect(SPELLABILITY_AURA_DC_TEAMINIT, oTarget))
			{
				int nClassLevel = GetLevelByClass(CLASS_DREAD_COMMANDO, oCaster);
								
				float fDuration = HoursToSeconds( 12 );
				
				itemproperty iBonusFeat, iBonusFeat2;
				if (nClassLevel > 4)
				{
					iBonusFeat = ItemPropertyBonusFeat(84); // Imp Init
					iBonusFeat2 = ItemPropertyBonusFeat(IPRP_FEAT_EPIC_SUPERIOR_INITIATIVE);
				}	
				else	
					iBonusFeat = ItemPropertyBonusFeat(84); // Imp Init
						
				effect eVis = EffectVisualEffect(VFX_DUR_SPELL_PREMONITION);				
				eVis = SupernaturalEffect(eVis);
				eVis = SetEffectSpellId (eVis, SPELLABILITY_AURA_DC_TEAMINIT);
				
				SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELLABILITY_AURA_DC_TEAMINIT, FALSE));		

	
			    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration));
				if (oTarget != oCaster)
				{
					object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
					if (oArmorNew == OBJECT_INVALID)
					{
						oArmorNew = CreateItemOnObject("x2_it_emptyskin", oTarget, 1, "", FALSE);
						AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
						if (nClassLevel > 4)
							AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat2,oArmorNew,fDuration);
						DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));
						DelayCommand(0.1, AssignCommand(oTarget, ActionEquipItem(oArmorNew, INVENTORY_SLOT_CARMOUR)));	
					}
					else
					{
				        IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );
						if (nClassLevel > 4)
							IPSafeAddItemProperty(oArmorNew, iBonusFeat2, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
					}
				}						
			}
			
		}
		
	}	
	
}