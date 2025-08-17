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
			if (!GetHasSpellEffect(SPELL_SPELLABILITY_AURA_NI_TEAMWORK, oTarget))
			{
				int nClassLevel = GetLevelByClass(CLASS_NIGHTSONG_INFILTRATOR, oCaster);
				
				int nReflexBonus = 1;
				int nSkillBonus = 2;
				
				switch (nClassLevel)
				{
					case 1:
					{
						nReflexBonus = 1;
						break;
					}
					case 2:
					{
						nReflexBonus = 1;
						break;
					}
					case 3:
					{
						nReflexBonus = 1;
						break;
					}
					case 4:
					{
						nReflexBonus = 2;
						break;
					}
					case 5:
					{
						nReflexBonus = 2;
						break;
					}
					case 6:
					{
						nReflexBonus = 2;
						break;
					}
					case 7:
					{
						nReflexBonus = 3;
						break;
					}
					case 8:
					{
						nReflexBonus = 3;
						nSkillBonus = 4;
						break;
					}
					case 9:
					{
						nReflexBonus = 3;
						nSkillBonus = 4;
						break;
					}														
					case 10:
					{
						nReflexBonus = 4;
						nSkillBonus = 4;
						break;
					}	
				}
				
				float fDuration = HoursToSeconds( 12 );
				
				itemproperty iBonusFeat;
				if (nClassLevel > 7)
					iBonusFeat = ItemPropertyBonusFeat(33); // Sneak Attack 2
				else	
					iBonusFeat = ItemPropertyBonusFeat(32); // Sneak Attack 1
						
				effect eSkillBonusDisable = EffectSkillIncrease(SKILL_DISABLE_TRAP,nSkillBonus);
				effect eSkillBonusHide = EffectSkillIncrease(SKILL_HIDE,nSkillBonus);
				effect eSkillBonusMoveSilent = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nSkillBonus);
				effect eSkillBonusOpenLock = EffectSkillIncrease(SKILL_OPEN_LOCK,nSkillBonus);
				effect eSkillBonusSearch = EffectSkillIncrease(SKILL_SEARCH,nSkillBonus);
				effect eSkillBonusTumble = EffectSkillIncrease(SKILL_TUMBLE,nSkillBonus);
				effect eReflexBonus = EffectSavingThrowIncrease(SAVING_THROW_REFLEX,nReflexBonus,SAVING_THROW_TYPE_TRAP);
				
				effect eLink = EffectLinkEffects(eSkillBonusDisable, eSkillBonusHide);
				eLink = EffectLinkEffects(eLink, eSkillBonusMoveSilent);
				eLink = EffectLinkEffects(eLink, eSkillBonusOpenLock);
				eLink = EffectLinkEffects(eLink, eSkillBonusSearch);
				eLink = EffectLinkEffects(eLink, eSkillBonusTumble);
				eLink = EffectLinkEffects(eLink, eReflexBonus);				
				eLink = SetEffectSpellId (eLink, SPELL_SPELLABILITY_AURA_NI_TEAMWORK);
				eLink = SupernaturalEffect(eLink);
								
				SignalEvent (oTarget, EventSpellCastAt(oCaster, SPELL_SPELLABILITY_AURA_NI_TEAMWORK, FALSE));		

	
			    DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
				object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
				if (oArmorNew == OBJECT_INVALID)
				{
					oArmorNew = CreateItemOnObject("x2_it_emptyskin", oTarget, 1, "", FALSE);
					AddItemProperty(DURATION_TYPE_TEMPORARY,iBonusFeat,oArmorNew,fDuration);
					DelayCommand(fDuration, DestroyObject(oArmorNew,0.0f,FALSE));	
					DelayCommand(0.1, AssignCommand(oTarget, ActionEquipItem(oArmorNew, INVENTORY_SLOT_CARMOUR)));
				}
				else
				{
				       IPSafeAddItemProperty(oArmorNew, iBonusFeat, fDuration,X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE,FALSE );	
				}				
			}
			
		}
		
	}	
	
}