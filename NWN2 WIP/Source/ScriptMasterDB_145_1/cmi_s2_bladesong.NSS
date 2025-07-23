//::///////////////////////////////////////////////
//:: Bladesong Style
//:: cmi_s2_bladesong
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: Jan 19, 2008
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwn2_inc_spells"
#include "cmi_includes"
#include "cmi_ginc_chars"

/*
void ApplyACBuff(object oPC, int nSpellId)
{
		int nLevel = GetLevelByClass(CLASS_BLADESINGER,oPC);
		int nAC = nLevel;	
		int nInt = GetAbilityScore(oPC, ABILITY_INTELLIGENCE);	
		int nIntBonus = 0;
					
		if (nInt > 11)
			nIntBonus = (nInt - 10)/2;
					
		if (nLevel > nIntBonus)
			nAC = nIntBonus;

		if (nAC == 0)
			return;
				
		effect eAC = SupernaturalEffect(EffectACIncrease(nAC, AC_DODGE_BONUS));				
		eAC = SetEffectSpellId(eAC,nSpellId);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oPC, 6.0f);		
		
}
*/

/*
void Bladesong(object oPC, int nSpellId, int bInitial, int nRandom)
{
	int bBladesongStyleValid = IsBladesingerValid();
	int bHasBladesongStyle = GetHasSpellEffect(nSpellId,oPC);
	
	RemoveSpellEffects(nSpellId, oPC, oPC);
	
	if (bBladesongStyleValid)
	{		

		if (!bHasBladesongStyle)	
			//SendMessageToPC(oPC,"Bladesong Style enabled." + IntToString(nRandom));
			SendMessageToPC(oPC,"Bladesong Style enabled.");			
		ApplyACBuff(oPC, nSpellId);								
	}
	else
	{
		if (bHasBladesongStyle)
			SendMessageToPC(oPC,"Bladesong Style disabled, it is only valid when wielding a longsword or rapier in one hand (and nothing in the other) and wearing light or no armor.");			
	}
	if (bInitial)
		DelayCommand(6.0f, Bladesong(oPC, nSpellId, TRUE, nRandom));	
}
*/

void ApplyACBuff()
{
		//SendMessageToPC(OBJECT_SELF, "ApplyACBuff()");
		int nLevel = GetLevelByClass(CLASS_BLADESINGER,OBJECT_SELF);
		int nAC;	
		int nInt = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE);	
		int nIntBonus = 0;
					
		if (nInt > 11)
			nIntBonus = (nInt - 10)/2;
			
		nAC = nIntBonus;
			
		int nIB = GetLevelByClass(CLASS_TYPE_INVISIBLE_BLADE);
		int nDuel = GetLevelByClass(CLASS_TYPE_DUELIST);
		if (nIB > nDuel)
			nDuel = nIB;
		if (nLevel > nDuel)
		{
			nLevel = nLevel - nDuel;
		}
		else
			return;
			
		if (nIntBonus > nLevel)
			nAC = nLevel;			

		if (nAC == 0)
			return;
				
		effect eAC = SupernaturalEffect(EffectACIncrease(nAC, AC_DODGE_BONUS));				
		eAC = SetEffectSpellId(eAC,BLADESINGER_BLADESONG_STYLE);
		if (!GetHasSpellEffect(BLADESINGER_BLADESONG_STYLE,OBJECT_SELF))
			DelayCommand(0.1f, cmi_ApplyEffectToObject(BLADESINGER_BLADESONG_STYLE, DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, HoursToSeconds(48)));		
		
}

void Bladesong(object oPC)
{
	int bBladesongStyleValid = IsBladesingerValid();
	int bHasBladesongStyle = GetHasSpellEffect(BLADESINGER_BLADESONG_STYLE,oPC);
	
	RemoveSpellEffects(BLADESINGER_BLADESONG_STYLE, oPC, oPC);
	
	if (bBladesongStyleValid)
	{		

		if (!bHasBladesongStyle)	
			SendMessageToPC(oPC,"Bladesong Style enabled.");			
		DelayCommand(0.1f,ApplyACBuff());								
	}
	else
	{
		RemoveSpellEffects(BLADESINGER_SONG_FURY, oPC, oPC);	
		if (bHasBladesongStyle)
			SendMessageToPC(oPC,"Bladesong Style disabled, it is only valid when wielding a longsword or rapier in one hand (and nothing in the other) and wearing light or no armor.");			
	}
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }	
	DelayCommand(0.1f, Bladesong(OBJECT_SELF));
}      