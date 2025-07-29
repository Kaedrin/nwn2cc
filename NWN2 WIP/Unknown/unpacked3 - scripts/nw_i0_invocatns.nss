//::///////////////////////////////////////////////
//:: Warlock Invocations Include
//:: NW_I0_INVOCATIONS
//:://////////////////////////////////////////////
/*
    Warlock Eldritch Essence & Blast Shape Invocations
    can be combined together (one of each) to modify
    the basic Eldritch Blast (Feat) behavior.
    Eldritch Essence Invocations apply extra effects to
    the target(s), whereas Blast Shape Invocations
    modify the # of targets affected.

    Internally, these combined invocations prioritize
    on the Blast Shape Invocations as the primary Spell.
    What this means is that the Blast Shape will always
    be the stored "Spell" in the UI, with the Essences
    being "Metamagics" that are applied to it.  This is
    because Blast Shapes control Ranges/AoE, and also so
    that only the Blast Shape Scripts need to worry about
    whether they have combined effects...
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Reynolds (JLR - OEI)
//:: Created On: August 19, 2005
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Brian Fox (BDF - OEI)
//:: Modified On: 6/29/06
//:: Modified the "Shape" functions to check for essences and create corresponding EffectVisualEffect
//:: Also modified the parameters of DoEldritchBlast, DoEldritchCombinedEffects, and DoEssenceXXX to recognize if they were called by "shapes"
//:://////////////////////////////////////////////
//:: AFW-OEI 02/20/2007: Added effects of Eldritch Master: +2 to the touch attack rolls and 50% extra damage.
//:: AFW-OEI 02/21/2007: Added the Epic Eldritch Blast chain: +1d6 to eldritch blast damage per Epic Eldritch Blast feat.
//:: AFW-OEI 05/08/2007: Added Hindering and Binding Blast Eldritch Essences.
//::PKM-OEI: 05.30.07: Touch attacks now do critical hit damage

//Modified by DM_Nocturne for Dalelands Beyond, to include 'noc_warlock_corruption'
//and shift Warlock alignments as they use their power. Last Modified: 17 October 2013
#include "nw_i0_spells"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "nwn2_inc_spells"
#include "ginc_debug"
#include "cmi_ginc_spells"
#include "noc_warlock_corruption"

const int STRREF_HELLFIRE_BONUS    		= 220796;  // Bonus Damage (Hellfire): ( in use )
const int STRREF_HELLFIRE_SHIELD_NAME   = 220779;  // Hellfire Shield ( in use )
const int STRREF_HELLFIRE_BLAST_NAME    = 220783;  // Hellfire Blast ( in use )
//const int STRREF_HELLFIRE_SHIELD_1 		= 220804;  //  drains  									REMOVED!!!
const int STRREF_HELLFIRE_FEEDBACK   = 220805;  // 's Constitution by 						CHANGED
const int STRREF_HELLFIRE_SHIELD_NO_CON = 233608; //Constitution isn't high enough to use Hellfire Shied.
//const int STRREF_HELLFIRE_SHIELD_START  = 220802;  //  is surrounded by an aura of hellfire.    REMOVED!!!
//const int STRREF_HELLFIRE_SHIELD_STOP   = 220803;  //  is no longer protected by hellfire.      REMOVED!!!
//const int STRREF_HELLFIRE_SHIELD_NO_CONST = 220806; // 's Constitution isn't high enough to use REMOVED!!!

// JWR-OEI: 09/24/2008 - Global Variable to track CON damage output
int nHellfireConDmg = 0;

// JWR - OEI 06/18/2008 -- Hellfire Warlock Damage Bonus functions
void HellfireShieldFeedbackMsg(int x, int strref, object oCaster);
int IsHellfireBlastActive(object oCaster=OBJECT_SELF);
int GetHellfireBlastDiceBonus(object oCaster=OBJECT_SELF);
void PrintHellfireBonusMsg(int nDice);

// JLR - OEI 07/20/05 -- Warlock Funcs
// Returns the highest level of Eldritch Blast available
int GetEldritchBlastLevel(object oCaster);

// Returns the base damage from the Eldritch Blast
int GetEldritchBlastDmg(object oCaster, object oTarget, int nAllowReflexSave=FALSE, int nIgnoreResists=FALSE, int nHalfDmg=FALSE, int nTouch=1, int bCalledFromShape=FALSE,  int iMetaMagic = -1);

// Does the actual Eldritch Blast...returns TRUE if it succeeded (so can do secondary effects)
int DoEldritchBlast(object oCaster, 
					object oTarget, 
					int bCalledFromShape = FALSE,
					int bDoTouchTest = TRUE, 
					int nDmgType = DAMAGE_TYPE_MAGICAL, 
					int nAllowReflexSave = FALSE, 
					int nIgnoreResists = FALSE, 
					int nHalfDmg = FALSE, 
					int nVFX = VFX_BEAM_ELDRITCH,
					int iMetaMagic = -1
					);

// Does the Metamagic Combined Effects
int DoEldritchCombinedEffects(object oTarget, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE, int iMetaMagic = -1);
void DoEldritchCombinedEffectsWrapper(object oTarget, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);

// These do the Eldritch Essence Effects:
int DoEssenceDrainingBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceFrightfulBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceBeshadowedBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
void RunEssenceBrimstoneBlastImpact(object oTarget, object oCaster, int nRoundsLeft);
int DoEssenceBrimstoneBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceHellrimeBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceBewitchingBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceNoxiousBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
void RunEssenceVitriolicBlastImpact(object oTarget, object oCaster, int nRoundsLeft);
int DoEssenceVitriolicBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceUtterdarkBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceHinderingBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);
int DoEssenceBindingBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE);

// cmi_ code
int DoEssenceUndBaneBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE, int iMetaMagic = -1);
int DoEssenceRepellBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE, int iMetaMagic = -1);
int DoEssenceTempestBlast(object oCaster, object oTarget, int bCalledFromShape = FALSE, int bDoTouchTest = TRUE, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE, int iMetaMagic = -1);

int DoShapeMetaDoom(int nMetaMagic = -1);
// end cmi_ code

// These do the Blast Shape Effects:
int DoShapeEldritchSpear();
int DoShapeHideousBlow();
int DoShapeEldritchChain();
int DoShapeEldritchCone();
int DoShapeEldritchDoom();



//::///////////////////////////////////////////////
//:: Functions
//::///////////////////////////////////////////////
// -------------------------------------------------------------------
// Printes Hellfire message JWR-OEI
// -------------------------------------------------------------------
void HellfireShieldFeedbackMsg(int x, int strref, object oCaster)
{
	string sLocalizedTextMsg = GetStringByStrRef( STRREF_HELLFIRE_FEEDBACK );
	string sLocalizedTextName = GetStringByStrRef( strref ); // is it hellfire blast or shield?
	string sName = GetName( oCaster );
	string sHellfireFeedbackMsg = "<c=tomato>" + sName + ": " + sLocalizedTextName + sLocalizedTextMsg + IntToString(x)+ ". </c>";
	//	SendMessageToPC( oCaster, sHellfireFeedbackMsg );
	FloatingTextStringOnCreature(sHellfireFeedbackMsg, oCaster);
}

// -------------------------------------------------------------------
// Prints the Hellfire Bonus if you have the HellfireEffect active JWR-OEI
// -------------------------------------------------------------------
void PrintHellfireBonusMsg(int nDice)
{
	string sLocalizedText = GetStringByStrRef( STRREF_HELLFIRE_BONUS );
	string sDiceBonus = " ("+IntToString(nDice)+"d6)";
	string sHellfireFeedbackMsg = "<c=tomato>" + sLocalizedText + " </c>"+sDiceBonus;
	SendMessageToPC( OBJECT_SELF, sHellfireFeedbackMsg );
}
// -------------------------------------------------------------------
// Returns the damage bonus provided by Hellfire Blast JWR-OEI
// -------------------------------------------------------------------
int GetHellfireBlastDiceBonus(object oCaster)
{
	return 2*GetLevelByClass(CLASS_TYPE_HELLFIRE_WARLOCK, oCaster);
}

// -------------------------------------------------------------------
// Determines if Hellfire Blast is active JWR-OEI
// -------------------------------------------------------------------
int IsHellfireBlastActive(object oCaster=OBJECT_SELF)
{

	// check CON
	int nCurrCon = GetAbilityScore( oCaster, ABILITY_CONSTITUTION );
	int x = GetActionMode(oCaster, ACTION_MODE_HELLFIRE_BLAST);
	//	PrettyDebug("Testing Hellfire Blast Mode: "+IntToString(x));
	if ( x )
	{
		//FIX: if immune to ability damage, no hellfire for you!
		if ( nCurrCon < 1 || GetIsImmune(oCaster, IMMUNITY_TYPE_ABILITY_DECREASE) )
		{
			SetActionMode(oCaster, ACTION_MODE_HELLFIRE_BLAST, 0);
			return FALSE;
		}
		//	PrettyDebug("Hellfire Mode Active!");
		return TRUE;
	}
	else
	{
		//	PrettyDebug("Hellfire Mode InActive!");
		return FALSE;	
	}
	return FALSE;
}

// -------------------------------------------------------------------
// Returns the highest level of Eldritch Blast available
// AFW-OEI 02/21/2007: Removed hard damage cap.
int GetEldritchBlastLevel(object oCaster)
{
    int nBlstLvl = 0;
	
	int nCasterLevel = GetWarlockCasterLevel(oCaster);
	int iED = GetLevelByClass(CLASS_ELDRITCH_DISCIPLE, oCaster);
	if (iED > 0 && (!GetHasFeat(FEAT_ELDDISC_SPELLCASTING_WARLOCK, oCaster)))
		nCasterLevel += iED;
	
	if (nCasterLevel > 21)
	{
		nBlstLvl = ((nCasterLevel - 20) / 2) + 9;
	}
	else
	if (nCasterLevel > 10)
	{
		nBlstLvl = ((nCasterLevel - 8) / 3) + 5;
	}
	else
	{
		nBlstLvl = (nCasterLevel + 1) / 2;
	}
    
    // AFW-OEI 02/21/2007: Epic Eldritch Blasts
	if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_1, oCaster) )
	{
	    if      (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_10, oCaster))      { nBlstLvl += 10; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_9, oCaster) )      { nBlstLvl +=  9; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_8, oCaster) )      { nBlstLvl +=  8; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_7, oCaster) )      { nBlstLvl +=  7; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_6, oCaster) )      { nBlstLvl +=  6; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_5, oCaster) )      { nBlstLvl +=  5; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_4, oCaster) )      { nBlstLvl +=  4; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_3, oCaster) )      { nBlstLvl +=  3; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_2, oCaster) )      { nBlstLvl +=  2; }
	    else if (GetHasFeat(FEAT_EPIC_ELDRITCH_BLAST_1, oCaster) )      { nBlstLvl +=  1; }
	}
	
	object oNeck = GetItemInSlot(INVENTORY_SLOT_NECK, oCaster);
	if ( GetIsObjectValid(oNeck))
	{
		string sTag = GetStringLeft(GetTag(oNeck), 12);
		if (sTag == "cmi_amulet01")
			nBlstLvl++;
		else
		if (sTag == "cmi_amulet02")
			nBlstLvl += 2;					
	}
    return nBlstLvl;
}

int MyResistInvocation(object oCaster, object oTarget, float fDelay=0.0f)
{
    if (fDelay > 0.5)
    {
        fDelay = fDelay - 0.1;
    }
	
	//Get caster level of oCaster
	int nCasterLvl = GetWarlockCasterLevel(oCaster);		
	//Get the target spell resistance
	int nTargetSR = GetSpellResistance(oTarget);
	
	//Immunity
	//Mantles
	//Globe		
	int nIgnoreAbsorb = 0;
	int nGlobe = GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY, oTarget);
	if (nGlobe)
		nIgnoreAbsorb = TRUE;
	nGlobe = GetHasSpellEffect(SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE, oTarget);
	if (nGlobe)
		nIgnoreAbsorb = TRUE;
	nGlobe = GetHasSpellEffect(SPELL_LESSER_GLOBE_OF_INVULNERABILITY, oTarget);
	if (nGlobe)
		nIgnoreAbsorb = TRUE;
		
	//Declare variables for SR check
	int nSRMods = 0;				
	int nRoll;
	int nMySRCheck;
		
	int nResist = ResistSpell(oCaster, oTarget);
    effect eSR = EffectVisualEffect( VFX_DUR_SPELL_SPELL_RESISTANCE );	// uses NWN2 VFX
    effect eGlobe = EffectVisualEffect( VFX_DUR_SPELL_GLOBE_INV_LESS );	// uses NWN2 VFX
    effect eMantle = EffectVisualEffect( VFX_DUR_SPELL_SPELL_MANTLE );	// uses NWN2 VFX
			
    if(nResist == 1 || nResist == 0 || (nResist == 2 && nIgnoreAbsorb))
    {
		if(nTargetSR > 0)
		{

			//Check if oCaster has feats to overcome spell resistance
			if(GetHasFeat(FEAT_SPELL_PENETRATION, oCaster))
			{
				if(GetHasFeat(FEAT_EPIC_SPELL_PENETRATION, oCaster))
					nSRMods = 6;
				else		
				if(GetHasFeat(FEAT_GREATER_SPELL_PENETRATION, oCaster))
					nSRMods = 4;
				else			
					nSRMods = 2;
			}
			if (GetHasFeat(FEAT_EPIC_LORD_OF_ALL_ESSENCES, oCaster))
			{
				nSRMods +=4;
			}	
				
			string sFeedback = "<c=cyan>" + GetName(oTarget) + " is attempting to resist your invocation: ";			
			
			nRoll = d20();
			nMySRCheck = nRoll + nCasterLvl + nSRMods;
			if((nMySRCheck <= nTargetSR || nRoll == 1) && nRoll != 20 )
			{
				nResist = 1;
				sFeedback += "success (" + " modified roll of " + IntToString(nMySRCheck) + "  vs " + IntToString(nTargetSR) +  " SR ).</c>";
	        	DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSR, oTarget));
			}
			else
			{
				sFeedback += "failure (" + " modified roll of " + IntToString(nMySRCheck) + "  vs " + IntToString(nTargetSR) +  " SR ).</c>";				
				nResist = 0;
			}	
			//Display feedback
			SendMessageToPC(oCaster, sFeedback);			
		}
		else
		{
			//No Spell resistance
			nResist = 0;
		}		
    }
    else if(nResist == 2) //Globe
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGlobe, oTarget));
    }
    else if(nResist == 3) //Spell Mantle
    {
		ResistSpell(oCaster, oTarget); //Fire the resist off twice so that the mantle is correctly depleted.
        if (fDelay > 0.5)
        {
            fDelay = fDelay - 0.1;
        }
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMantle, oTarget));
    }
	return nResist;
}    


// Returns the base damage from the Eldritch Blast
int GetEldritchBlastDmg(object oCaster, object oTarget, int nAllowReflexSave, int nIgnoreResists, int nHalfDmg, int nTouch/*=1*/, int bCalledFromShape=FALSE,  int iMetaMagic = -1)
{

    int nMetaMagic = GetMetaMagicFeat();
	if (iMetaMagic != -1)
		nMetaMagic = iMetaMagic;
			
    int nDmg = 0;
	int nSpellId = GetSpellId();
    // Note: Caster Lvl is /2 for purposes of Spell Resistance (done internally in code)
    //Make SR Check
    if ( nIgnoreResists || (!MyResistInvocation(oCaster, oTarget)) )
    {
        int nDmgDice = GetEldritchBlastLevel(oCaster);
		
		if (nMetaMagic == METAMAGIC_INVOC_UNDBANE_BLAST)
		{
			if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
				nDmgDice += 2;
		}
		
		int nBonusDice = 0; // default
        nDmg = d6(nDmgDice);
		// JWR-OEI 06/18/2008: Hellfire Warlock can modify this into "Hellfire Blast"
		//SpeakString("Checking to add Hellfire Damage:");
		if (IsHellfireBlastActive(oCaster))
		{ 
			int nHellfireDice = GetHellfireBlastDiceBonus();
		     if (WARLOCK_HELLBLAST_PART_OF_BASE_DAMAGE) {
		        // just add the extra damage to base since the RULES said not to track them seperately
		        nDmgDice += nHellfireDice;
		     } else
		     {
			    nBonusDice = nHellfireDice;
			    // gotcha... any call to d6(0) results in d6(1)
			    // this die roll MUST be here or you end up with +1d6 damage
		            nDmg += d6(nBonusDice);  
		     }
		     PrintHellfireBonusMsg(nHellfireDice);
		}	
		
		//Maximize Eldritch Blast
		if (GetLocalInt(oCaster, "MaxEldBlast"))
		{
			// add the max for the nDmgDice
			nDmg += 6 * nDmgDice;
		}
		
		int nCrit = (nTouch == 2 && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT));
		if (nSpellId != SPELL_Eldritch_Glaive)
			nDmg += GetRangedTouchSpecDamage(oCaster, nDmgDice+nBonusDice, FALSE);	
		//else
		//	nDmg += GetMeleeTouchSpecDamage(oCaster, nDmgDice+nBonusDice, FALSE);	
		
			
		//Critical hit
		if (nCrit)
		{
			if (WARLOCK_CRITS_ONLY_BASE_NEVER_MAXED)
				nDmg = nDmg + d6(nDmgDice);
			else
				nDmg = nDmg * 2;

		}
        
        // AFW-OEI 02/20/2007: Eldritch Master increases damage by 50%
        if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, oCaster))
        {
        	if (WARLOCK_EPICELDMASTER_ONLY_BASE_NEVER_MAXED)
		    {
		        // I dont actually know if PnP seperates this but for consistance we can...
		        // it makes more sense 
		        nDmg = nDmg + d6(nDmgDice)/2;
		    } else {
		        nDmg = nDmg + nDmg/2;
		    }
        }
		
		//Empower Eldritch Blast		
		if (GetLocalInt(oCaster, "EmpEldBlast"))
		{
			if (WARLOCK_EMPBLAST_ONLY_BASE_NEVER_MAXED)
		    {
		        nDmg = nDmg + d6(nDmgDice)/2;
		    } else {
			    nDmg = nDmg + nDmg/2;
		    }
		}
		
        
        if ( nHalfDmg == 1 )
        {
            nDmg = nDmg / 2;
            if ( nDmg == 0 )
            {
                nDmg = 1;
            }
        }

        // Some Invocations allow chance to halve the damage
        if ( nAllowReflexSave )
        {
            nDmg = GetReflexAdjustedDamage(nDmg, oTarget, GetWarlockDC(OBJECT_SELF, FALSE));
        }
		
		int iSpear = 0;
		if (nSpellId == SPELL_I_ELDRITCH_SPEAR)
			iSpear = 1;
		if ( !bCalledFromShape || iSpear) // Allow sneak attacks
		{
				//include sneak attack damage
				nDmg += EvaluateSneakAttack(oTarget, OBJECT_SELF);		
		}
    }
	
	if (nSpellId == SPELL_Eldritch_Glaive)
	{
		//NOCTURNE - Can add Eldritch Glaive corruption call here.
		AddCorruption (OBJECT_SELF, 2);
		if (GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, OBJECT_SELF))
			nDmg = nDmg/2;
	}
	
	if (GetHasFeat(FEAT_EPIC_AUTOMATIC_QUICKEN_1, OBJECT_SELF))
		nDmg = nDmg/2;
		
    return nDmg;
}


//int METAMAGIC_ELDRITCH_SHAPES = (METAMAGIC_INVOC_ELDRITCH_SPEAR | METAMAGIC_INVOC_HIDEOUS_BLOW | METAMAGIC_INVOC_ELDRITCH_CHAIN | METAMAGIC_INVOC_ELDRITCH_CONE | METAMAGIC_INVOC_ELDRITCH_DOOM);


int DoEldritchBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nDmgType, int nAllowReflexSave, int nIgnoreResists, int nHalfDmg, int nVFX, int iMetaMagic = -1)
{
	int nReturn = FALSE;
    // Default Blast w/no mods
    int nMetaMagic = GetMetaMagicFeat();
	if (iMetaMagic != -1)
		nMetaMagic = iMetaMagic;
		
	int nHitVFX = VFX_INVOCATION_ELDRITCH_HIT;	// default is Edlritch
	int nTouch;
    //if ( nMetaMagic != METAMAGIC_NONE )
    //if ( !(nMetaMagic & METAMAGIC_ELDRITCH_SHAPES) )

	//SendMessageToPC(oCaster, "DoEldritchBlast Meta: " + IntToString(nMetaMagic));
	//SendMessageToPC(oCaster, "DoEldritchBlast nSpell: " + IntToString(GetSpellId()));
	
		
	// adjust the VFX according to the essence
	if 	   ( nMetaMagic == METAMAGIC_INVOC_UNDBANE_BLAST )     { nHitVFX = VFX_INVOCATION_UTTERDARK_HIT; }
    else if ( nMetaMagic == METAMAGIC_INVOC_REPELL_BLAST )     { nHitVFX = VFX_INVOCATION_BINDING_HIT; }
    else if ( nMetaMagic == METAMAGIC_INVOC_TEMPEST_BLAST )    { nHitVFX = VFX_INVOCATION_BEWITCHING_HIT; }

	else if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )    { nHitVFX = VFX_INVOCATION_DRAINING_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { nHitVFX = VFX_INVOCATION_FRIGHTFUL_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { nHitVFX = VFX_INVOCATION_BESHADOWED_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { nHitVFX = VFX_INVOCATION_BRIMSTONE_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { nHitVFX = VFX_INVOCATION_HELLRIME_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { nHitVFX = VFX_INVOCATION_BEWITCHING_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { nHitVFX = VFX_INVOCATION_NOXIOUS_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { nHitVFX = VFX_INVOCATION_VITRIOLIC_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { nHitVFX = VFX_INVOCATION_UTTERDARK_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { nHitVFX = VFX_INVOCATION_HINDERING_HIT; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { nHitVFX = VFX_INVOCATION_BINDING_HIT; }

    effect eBeam = EffectBeam(nVFX, oCaster, BODY_NODE_HAND);
	
	// JWR-OEI 06/18/2008: Hellfire Warlock can modify this into "Hellfire Blast"
	//	SpeakString("Checking to do Con Damage");
	if (IsHellfireBlastActive() && 
	(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE && 
	oTarget != OBJECT_SELF && 
	GetIsReactionTypeHostile(oTarget)))
	{
		effect eConst = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);
		eConst = SetEffectSpellId(eConst, -1); // set to invalid spell ID for stacking
		eConst = ExtraordinaryEffect(eConst);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConst, oCaster);
		if (!bCalledFromShape)
		{
			// we're not called from a shape so this is just a regular eldritch blast
			nHellfireConDmg = 1;
			HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, oCaster);
		}
		else
		{
			// we are called from a shape, so we're gonna display output later.
			// SpeakString("Incrementing Con Counter ("+IntToString(nHellfireConDmg)+") Name: "+GetName(oTarget));
			nHellfireConDmg++;
		}
	}	

    if(bDoTouchTest) //These are all ranged
    {
        // AFW-OEI 02/20/2007: Eldritch Master adds +2 to the attack roll.
        int nBonus = 0;
		
        if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, oCaster))
        {
            nBonus += 2;			
        }		
		
		int nBadBonus1RH;
		int nBadBonus2RH;
		object oScepter = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oScepter))
		{
			if (GetTag(oScepter) == "cmi_wlkscptr01")
				nBonus += 2;
				
			nBadBonus1RH = IPGetWeaponEnhancementBonus(oScepter);
			nBadBonus2RH = IPGetWeaponEnhancementBonus(oScepter, ITEM_PROPERTY_ATTACK_BONUS);
		}
		object oScepter2 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
		if (GetIsObjectValid(oScepter2) && IPGetIsMeleeWeapon(oScepter2))
		{
			int nBadBonus1LH = IPGetWeaponEnhancementBonus(oScepter2);
			int nBadBonus2LH = IPGetWeaponEnhancementBonus(oScepter2, ITEM_PROPERTY_ATTACK_BONUS);		
			if (nBadBonus1LH > nBadBonus1RH)
				nBadBonus1RH = nBadBonus1LH;
			if (nBadBonus2LH > nBadBonus2RH)
				nBadBonus2RH = nBadBonus2LH;				
		}
		if (nBadBonus2RH > nBadBonus1RH)
			nBadBonus1RH = nBadBonus2RH;
		
		nBonus = nBonus - nBadBonus1RH;	 //Remove the bonus provided by a weapon.
		
		if (GetHasFeat(FEAT_POINT_BLANK_SHOT, oCaster))
		{
			//nBonus += 1;
			if(  GetDistanceToObject(oTarget) <= 9.144f ) // this is in point blank range
			{
				nBonus += 1;
			}						
		}
		
	    if (GetHasEffect( EFFECT_TYPE_POLYMORPH, oCaster))
		{
			if (!GetHasFeat(FEAT_GUTTURAL_INVOCATIONS, oCaster))
			{
				nBonus -= 20;
				SendMessageToPC(oCaster,"You are exploiting the casting of spells while polymorphed without the Guttural Invocations feat. Your touch attack has been penalized 20 points.");			
			}				
		}
	
		if (GetActionMode(oCaster, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE) == TRUE)
		nBonus -= 6;
		else
		if (GetActionMode(oCaster, ACTION_MODE_COMBAT_EXPERTISE) == TRUE)
		nBonus -= 3;
			
		int nSpellId = GetSpellId();  
		if (nSpellId != SPELL_Eldritch_Glaive)
			nTouch = TouchAttackRanged(oTarget, TRUE, nBonus);
		else
			nTouch = TouchAttackMelee(oTarget, TRUE, nBonus);
					
		if (GetLocalInt(OBJECT_SELF, "NW_EB_TOUCH_RESULT")) //collect only when requested
		{
		    SetLocalInt(OBJECT_SELF, "NW_EB_TOUCH_RESULT", nTouch);
		}
		
        //if ( TouchAttackRanged( oTarget, TRUE, nBonus ) == TOUCH_ATTACK_RESULT_MISS )
		if (nTouch == TOUCH_ATTACK_RESULT_MISS)
        {
            // We only want to display the beam visual effect if the blast was NOT called from any of the Shape spells; otherwise, the shape will already have been displayed.
            if ( !bCalledFromShape )
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            }
            // Failed
			if (oTarget != oCaster)
            	SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), TRUE));
            return FALSE;
        }
    }


    // Spell Effects not allowed to stack...
    // FIX: moved to essence code, to prevent losing effects if target saves from new attack
    //RemoveEffectsFromSpell(oTarget, GetSpellId());

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) == TRUE)
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));

        int nDmg = GetEldritchBlastDmg(oCaster, oTarget, nAllowReflexSave, nIgnoreResists, nHalfDmg, nTouch, bCalledFromShape, nMetaMagic);

        if ( nDmg > 0 )  // Make sure wasn't resisted
        {
            //Fire cast spell at event for the specified target
			if (oTarget != oCaster)
            	SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), TRUE));
            //Set damage effect
            float fDelay = 0.0;
            effect eDam = EffectDamage(nDmg, nDmgType);
            effect eVis = EffectVisualEffect( nHitVFX );
            
            //Apply the damage effect
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
            DelayCommand( fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget) );

			// We only want to display the beam visual effect if the blast was NOT called from any of the Shape spells; otherwise, the shape will already have been displayed.
			if ( !bCalledFromShape )
			{
            	DelayCommand( fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0) );
			}
			
            nReturn = TRUE;
        }
        if ( !bCalledFromShape && !nReturn )
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
        }
    }

	if (GetLocalInt(oCaster, "MaxEldBlast"))
		SendMessageToPC(oCaster, "Maximizing Eldritch Blast");
	if (GetLocalInt(oCaster, "EmpEldBlast"))
		SendMessageToPC(oCaster, "Empowering Eldritch Blast");		
	SetLocalInt(oCaster, "MaxEldBlast", 0);
	SetLocalInt(oCaster, "EmpEldBlast", 0);		
	
    return nReturn;
}


// -------------------------------------------------------------------
int DoEldritchCombinedEffects(object oTarget, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg, int iMetaMagic = -1)
{

    int nMetaMagic = GetMetaMagicFeat();
	if (iMetaMagic != -1)
		nMetaMagic = iMetaMagic;
		
	//NOCTURNE - If statements modified to call corruption script before the ability executes.
    if ( nMetaMagic == METAMAGIC_INVOC_UNDBANE_BLAST )    	   {AddCorruption(OBJECT_SELF, 3); return DoEssenceUndBaneBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg, nMetaMagic); }
	else if ( nMetaMagic == METAMAGIC_INVOC_REPELL_BLAST )     {AddCorruption(OBJECT_SELF, 6); return DoEssenceRepellBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg, nMetaMagic); }
	else if ( nMetaMagic == METAMAGIC_INVOC_TEMPEST_BLAST )    {AddCorruption(OBJECT_SELF, 4); return DoEssenceTempestBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg, nMetaMagic); }		
 						
    else if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )    {AddCorruption(OBJECT_SELF, 2); return DoEssenceDrainingBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   {AddCorruption(OBJECT_SELF, 2); return DoEssenceFrightfulBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  {AddCorruption(OBJECT_SELF, 4); return DoEssenceBeshadowedBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   {AddCorruption(OBJECT_SELF, 3); return DoEssenceBrimstoneBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    {AddCorruption(OBJECT_SELF, 4); return DoEssenceHellrimeBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  {AddCorruption(OBJECT_SELF, 4); return DoEssenceBewitchingBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     {AddCorruption(OBJECT_SELF, 6); return DoEssenceNoxiousBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   {AddCorruption(OBJECT_SELF, 6); return DoEssenceVitriolicBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   {AddCorruption(OBJECT_SELF, 8); return DoEssenceUtterdarkBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   {AddCorruption(OBJECT_SELF, 4); return DoEssenceHinderingBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     {AddCorruption(OBJECT_SELF, 7); return DoEssenceBindingBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, nAllowReflexSave, nHalfDmg); }
    else
    {
        // No extra effects
		//SpeakString("DoEldritchCombinedEffects(...): No blast invocation.");	// DEBUG!
		//NOCTURNE - Here is where the call for the base blast (ESL 1, should go)
        if(GetIsPC(OBJECT_SELF))
		{
			AddCorruption(OBJECT_SELF, 1); //Basic Blast Corruption
		}
		return DoEldritchBlast(OBJECT_SELF, oTarget, TRUE, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, nMetaMagic);
    }
}

void DoEldritchCombinedEffectsWrapper(object oTarget, int nAllowReflexSave=FALSE, int nHalfDmg=FALSE)
{
    DoEldritchCombinedEffects(oTarget, FALSE, nAllowReflexSave, nHalfDmg);
}


// -------------------------------------------------------------------
// Eldritch Essence Effects:
int DoEssenceDrainingBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_DRAINING_RAY) )
    {
        // Additional Effects: (Slow Effect)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
            {
                float fDuration = RoundsToSeconds(1);

                effect eSlow = EffectSlow();
                effect eDur = EffectVisualEffect( VFX_IMP_SLOW );
                effect eLink = EffectLinkEffects(eSlow, eDur);
                //effect eVis = EffectVisualEffect( VFX_INVOCATION_DRAINING_HIT );	// handled by DoEldritchBlast()
                eLink = SetEffectSpellId(eLink, SPELL_I_DRAINING_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_DRAINING_BLAST);

                //Apply the slow effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
                return TRUE;
            }
        }
    }
    return FALSE;
}


int DoEssenceFrightfulBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_FRIGHTFUL_RAY) )
    {
        // Additional Effects: (Cause Fear Effect)
        if ((GetHitDice(oTarget) < 6) && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, FALSE), SAVING_THROW_TYPE_FEAR))
            {
                float fDuration = RoundsToSeconds(10);

                effect eScare = EffectFrightened();
                effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_MIND_SPELLS);
                effect eMind = EffectVisualEffect( VFX_DUR_SPELL_FEAR );
                //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);	// handled by VFX_DUR_SPELL_FEAR
                effect eDamagePenalty = EffectDamageDecrease(2);
                effect eAttackPenalty = EffectAttackDecrease(2);
                effect eLink = EffectLinkEffects(eMind, eScare);
                effect eLink2 = EffectLinkEffects(eSave, eDamagePenalty);
                eLink2 = EffectLinkEffects(eLink2, eAttackPenalty);
                eLink2 = EffectLinkEffects(eLink2, eLink);
                eLink2 = SetEffectSpellId(eLink2, SPELL_I_FRIGHTFUL_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_FRIGHTFUL_BLAST);

                //Apply linked effects and VFX impact
                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, fDuration);
                return TRUE;
            }
        }
    }
    return FALSE;
}


int DoEssenceBeshadowedBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BESHADOWED_RAY) )
    {
        // Additional Effects: (Darkness)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            //Make Fort save
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
            {
                float fDuration = RoundsToSeconds(1);
				int nDex = GetAbilityScore( oTarget, ABILITY_DEXTERITY );
				

                //effect eDark = EffectDarkness();
				effect eDark = EffectBlindness();
				effect eAC = EffectACDecrease( 2 );
				effect eLink = EffectLinkEffects( eDark, eAC );
                //effect eDur = EffectVisualEffect(VFX_INVOCATION_BESHADOWED_HIT);	// handled by DoEldritchBlast()
                //effect eLink = EffectLinkEffects(eDark, eDur);	// handled by DoEldritchBlast()
                eLink = SetEffectSpellId(eLink, SPELL_I_BESHADOWED_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_BESHADOWED_BLAST);

                //Apply the effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
				
				if (nDex > 10)
				{
					int nDecr = (nDex-10);
					effect eDex = EffectAbilityDecrease( ABILITY_DEXTERITY, nDecr);
					eDex = SetEffectSpellId(eDex, SPELL_I_BESHADOWED_BLAST);
					
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oTarget, fDuration);
				}
                return TRUE;
            }
        }
    }
    return FALSE;
}


void RunEssenceBrimstoneBlastImpact(object oTarget, object oCaster, int nRoundsLeft)
{
	//SpeakString("RunEssenceBrimstoneBlastImpact(...): Entering function.");	// DEBUG!
	
	// AFW-OEI 07/06/2006: Can't "dispel" fire, so no need to check effects
    //if (GZGetDelayedSpellEffectsExpired(SPELL_I_BRIMSTONE_BLAST, oTarget, oCaster))
    //{
    //    return;
    //}

	
    if ((GetIsDead(oTarget) == FALSE) && (nRoundsLeft > 0))
    {
        int nDC = GetDelayedSpellInfoSaveDC(SPELL_I_BRIMSTONE_BLAST, oTarget, oCaster);

		
        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_FIRE))
        {
            int nDmg = d6(2);
            effect eDmg = EffectDamage(nDmg,DAMAGE_TYPE_FIRE);
            

            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, 6.0);	// handled by DoEldritchBlast()

            nRoundsLeft = nRoundsLeft - 1;
            DelayCommand(RoundsToSeconds(1), RunEssenceBrimstoneBlastImpact(oTarget, oCaster, nRoundsLeft));	// Delay for one more round
        }
        else
        {
            RemoveDelayedSpellInfo(SPELL_I_BRIMSTONE_BLAST, oTarget, oCaster);
            //GZRemoveSpellEffects(SPELL_I_BRIMSTONE_BLAST, oTarget);
        }
    }
}


int DoEssenceBrimstoneBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
	//SpeakString("DoEssenceBrimstoneBlast(...): Entering function.");	// DEBUG!
//	int nHasSpellEffect = GetHasSpellEffect(GetSpellId(), oTarget);
	int nHasSpellEffect = GetHasSpellEffect(SPELL_I_BRIMSTONE_BLAST, oTarget);

    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_FIRE, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BRIMSTONE_RAY) )
    {
        // Additional Effects: (Combust)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
			
            // Doesn't Stack!
            if (nHasSpellEffect == 1)
            {
                //FloatingTextStrRefOnCreature(100775, OBJECT_SELF, FALSE);
                return FALSE;
            }

            int nCasterLvl = GetWarlockCasterLevel(OBJECT_SELF);
            int nRoundsLeft;
            if ( nCasterLvl >= 20 )       { nRoundsLeft = 4; }
            else if ( nCasterLvl >= 15 )  { nRoundsLeft = 3; }
            else if ( nCasterLvl >= 10 )  { nRoundsLeft = 2; }
            else                          { nRoundsLeft = 1; }

            int nDC = GetWarlockDC(OBJECT_SELF, FALSE);		
			
            SaveDelayedSpellInfo(SPELL_I_BRIMSTONE_BLAST, oTarget, oCaster, nDC);
			effect eVFX = ExtraordinaryEffect(EffectVisualEffect(894));
			eVFX = SetEffectSpellId(eVFX, SPELL_I_BRIMSTONE_BLAST); //needed to keep different essences stack, if using same shape
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, RoundsToSeconds(nRoundsLeft));	
			DelayCommand(RoundsToSeconds(1), RunEssenceBrimstoneBlastImpact(oTarget, oCaster, nRoundsLeft));	// First check should be one round after the blast hit
				
	        return TRUE;
        }
    }
    return FALSE;
}


int DoEssenceHellrimeBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_COLD, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_HELLRIME_RAY) )
    {
        // Additional Effects: (Dex Penalty)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
            {
                float fDuration = RoundsToSeconds(10);

                effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, 4);
                //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
				//effect eVis = EffectVisualEffect( VFX_INVOCATION_HELLRIME_HIT );	// handled by DoEldritchBlast()
               // effect eLink = EffectLinkEffects(eDex, eDur);
                eDex = SetEffectSpellId(eDex, SPELL_I_HELLRIME_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_HELLRIME_BLAST);

                //Apply the effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oTarget, fDuration);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
                return TRUE;
            }
        }
    }
    return FALSE;
}


int DoEssenceBewitchingBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BEWITCHING_RAY) )
    {
        // Additional Effects: (Confusion)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, FALSE), SAVING_THROW_TYPE_MIND_SPELLS))
            {
                float fDuration = RoundsToSeconds(1);

                //effect eVis = EffectVisualEffect( VFX_INVOCATION_BEWITCHING_HIT );	// handled by DoEldritchBlast()
                effect eConfuse = EffectConfused();
                effect eMind = EffectVisualEffect( VFX_DUR_SPELL_CONFUSION );
                //effect eDur = EffectVisualEffect( VFX_INVOCATION_BEWITCHING_HIT );
                //Link duration VFX and confusion effects
                effect eLink = EffectLinkEffects(eMind, eConfuse);
                //eLink = EffectLinkEffects(eLink, eDur);
                eLink = SetEffectSpellId(eLink, SPELL_I_BEWITCHING_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_BEWITCHING_BLAST);

                //Apply linked effect and VFX Impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
                return TRUE;
            }
        }
    }
    return FALSE;
}


int DoEssenceNoxiousBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_NOXIOUS_RAY) )
    {
        // Additional Effects: (Daze)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
            {
                float fDuration = RoundsToSeconds(10);

                effect eMind = EffectVisualEffect( VFX_DUR_SPELL_DAZE );
                effect eDaze = EffectDazed();
                //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                effect eLink = EffectLinkEffects(eMind, eDaze);
                //eLink = EffectLinkEffects(eLink, eDur);
                //effect eVis = EffectVisualEffect( VFX_INVOCATION_NOXIOUS_HIT );	// handled by DoEldritchBlast()
                eLink = SetEffectSpellId(eLink, SPELL_I_NOXIOUS_BLAST); //needed to keep different essences stack, if using same shape

                // Spell Effects not allowed to stack...
                RemoveEffectsFromSpell(oTarget, SPELL_I_NOXIOUS_BLAST);

                //Apply the effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
                return TRUE;
            }
        }
    }
    return FALSE;
}


void RunEssenceVitriolicBlastImpact(object oTarget, object oCaster, int nRoundsLeft)
{
// AFW-OEI 07/06/2006: Vitriolic Blast has no save and ignores spell resistance!.

// JLR-OEI 06/30/06: Delayed spell info not desired here...because no associated effect keyed to target
//    if (GZGetDelayedSpellEffectsExpired(SPELL_I_VITRIOLIC_BLAST, oTarget, oCaster))
//    {
//        return;
//    }

	//SpeakString("RunEssenceVitriolicBlastImpact(...): Entering function.");	// DEBUG!

    if ((GetIsDead(oTarget) == FALSE) && (nRoundsLeft > 0))
    {
//        int nDC = GetDelayedSpellInfoSaveDC(SPELL_I_VITRIOLIC_BLAST, oTarget, oCaster);
//        {
            int nDmg = d6(2);
            effect eDmg = EffectDamage(nDmg,DAMAGE_TYPE_ACID);
            //effect eVFX = EffectVisualEffect( VFX_IMP_ACID_S );	// handled by DoEldritchBlast()

            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);	// handled by DoEldritchBlast()

            nRoundsLeft = nRoundsLeft - 1;
            DelayCommand(RoundsToSeconds(1), RunEssenceVitriolicBlastImpact(oTarget, oCaster, nRoundsLeft));	// Delay for one more round
//        }
    }
    else
    {
//        RemoveDelayedSpellInfo(SPELL_I_VITRIOLIC_BLAST, oTarget, oCaster);
//        GZRemoveSpellEffects(SPELL_I_VITRIOLIC_BLAST, oTarget);
    }
}


int DoEssenceVitriolicBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
	//SpeakString("DoEssenceVitriolicBlast(...): Entering function.");	// DEBUG!

	int nHasSpellEffect = GetHasSpellEffect(SPELL_I_VITRIOLIC_BLAST, oTarget);

    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_ACID, nAllowReflexSave, TRUE, nHalfDmg, VFX_INVOCATION_VITRIOLIC_RAY) )
    {
        // Additional Effects: (Acid)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            int nDC = GetWarlockDC(OBJECT_SELF, FALSE);
            {
                // Doesn't Stack!
                //if (GetHasSpellEffect(GetSpellId(),oTarget))    // JLR-OEI 06/30/06: This will always return true due to above eldritch blast dmg effect that gets applied
                if (nHasSpellEffect == 1)
				{
                    //FloatingTextStrRefOnCreature(100775, OBJECT_SELF, FALSE);
                    return FALSE;
                }

                int nCasterLvl = GetWarlockCasterLevel(OBJECT_SELF);
                int nRoundsLeft;
                if ( nCasterLvl >= 20 )       { nRoundsLeft = 4; }
                else if ( nCasterLvl >= 15 )  { nRoundsLeft = 3; }
                else if ( nCasterLvl >= 10 )  { nRoundsLeft = 2; }
                else                          { nRoundsLeft = 1; }

				// JLR-OEI 06/30/06: Delayed spell info not desired here...because no associated effect keyed to target
//                SaveDelayedSpellInfo(SPELL_I_VITRIOLIC_BLAST, oTarget, oCaster, nDC);

                DelayCommand(RoundsToSeconds(1), RunEssenceVitriolicBlastImpact(oTarget, oCaster, nRoundsLeft)); // First check should be one round after the blast hit

                //Apply the effect and VFX impact
//                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                return TRUE;
            }
        }
    }
    return FALSE;
}


int DoEssenceUtterdarkBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_NEGATIVE, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_UTTERDARK_RAY) )
    {
        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
        {
            effect eVis = EffectVisualEffect( VFX_DUR_SPELL_ENERGY_DRAIN );
            effect eDrain = EffectNegativeLevel(2);
            //eDrain = SupernaturalEffect(eDrain);
			effect eLink = EffectLinkEffects( eDrain, eVis );
            eLink = SupernaturalEffect(eLink); //FIX: whole link needs to be supernatural
            eLink = SetEffectSpellId(eLink, SPELL_I_UTTERDARK_BLAST); //needed to keep different essences stack, if using same shape

            // Spell Effects not allowed to stack...
            RemoveEffectsFromSpell(oTarget, SPELL_I_UTTERDARK_BLAST);
			
			//effect eDmg = EffectDamage(12, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL, TRUE);
			
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
            //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDmg, oTarget);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oTarget, HoursToSeconds(1));
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            return TRUE;
        }
    }
    return FALSE;
}

int DoEssenceHinderingBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_HINDERING_RAY) )
    {
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
        {
            effect eVis = EffectVisualEffect( VFX_DUR_SPELL_SLOW );
            effect eSlow = EffectSlow();
            eSlow = SupernaturalEffect(eSlow);
			effect eLink = EffectLinkEffects( eSlow, eVis );
            eLink = SetEffectSpellId(eLink, 1130); //needed to keep different essences stack, if using same shape

            // Spell Effects not allowed to stack...
             RemoveEffectsFromSpell(oTarget, 1130);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
            return TRUE;
        }
    }
    return FALSE;
}

int DoEssenceBindingBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg)
{
	//SpeakString("nw_i0_invocatns: DoEssenceBindingBlast");

    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BINDING_RAY) )
    {
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
        {
            effect eVis = EffectVisualEffect( VFX_DUR_STUN );
            effect eStun = EffectStunned();
            eStun = SupernaturalEffect(eStun);
			effect eLink = EffectLinkEffects( eStun, eVis );
            eLink = SetEffectSpellId(eLink, 1131); //needed to keep different essences stack, if using same shape

            // Spell Effects not allowed to stack...
            RemoveEffectsFromSpell(oTarget, 1131);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
            return TRUE;
        }
    }
    return FALSE;
}

// -------------------------------------------------------------------
// Blast Shape Effects:
//NOCTURNE - Edited all Blast Shapes to add corruption.
int DoShapeEldritchSpear()
{
	AddCorruption(OBJECT_SELF,  2);	
    //Declare major variables
    object oTarget = GetSpellTargetObject();


    int nMetaMagic = GetMetaMagicFeat();
	
	if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         { return DoEssenceDrainingBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { return DoEssenceFrightfulBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { return DoEssenceBeshadowedBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { return DoEssenceBrimstoneBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { return DoEssenceHellrimeBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { return DoEssenceBewitchingBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { return DoEssenceNoxiousBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { return DoEssenceVitriolicBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { return DoEssenceUtterdarkBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { return DoEssenceHinderingBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { return DoEssenceBindingBlast( OBJECT_SELF, oTarget, FALSE, TRUE ); }
	else
    {
        // No extra effects
		//SpeakString("DoEldritchCombinedEffects(...): No blast invocation.");	// DEBUG!
        return DoEldritchBlast( OBJECT_SELF, oTarget, FALSE, TRUE );
    }

    //return FALSE;
}


int DoShapeHideousBlow()
{
	AddCorruption(OBJECT_SELF,  1);
	
    //Declare major variables
    object oTarget = GetSpellTargetObject();

    // Handle combined Eldritch Essence Effects, if any
    return DoEldritchCombinedEffects(oTarget, FALSE);
		
}


int DoShapeEldritchChain()
{
	AddCorruption(OBJECT_SELF,  4);
	//SpeakString("DoShapeEldritchChain(): Entering function.");	// DEBUG!

    //Declare major variables
    int nCasterLvl = GetWarlockCasterLevel(OBJECT_SELF);
    //Limit caster level
    // June 2/04 - Bugfix: Cap the level BEFORE the damage calculation, not after. Doh.
    int nNumAffected = 0;
    int nMetaMagic = GetMetaMagicFeat();
	
	int nChain1VFX = VFX_INVOCATION_ELDRITCH_CHAIN;	// default Chain1 is Eldritch
	int nChain2VFX = VFX_INVOCATION_ELDRITCH_CHAIN2;	// default Chain2 is Eldritch
	int nHitVFX = VFX_INVOCATION_ELDRITCH_HIT;	// default nHitVFX is Eldritch

	// adjust the VFX according to the essence
    if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         
	{ 
		nChain1VFX = VFX_INVOCATION_DRAINING_CHAIN; 
		nChain2VFX = VFX_INVOCATION_DRAINING_CHAIN2;
		nHitVFX = VFX_INVOCATION_DRAINING_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   
	{ 
		nChain1VFX = VFX_INVOCATION_FRIGHTFUL_CHAIN; 
		nChain2VFX = VFX_INVOCATION_FRIGHTFUL_CHAIN2; 
		nHitVFX = VFX_INVOCATION_FRIGHTFUL_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  
	{ 
		nChain1VFX = VFX_INVOCATION_BESHADOWED_CHAIN; 
		nChain2VFX = VFX_INVOCATION_BESHADOWED_CHAIN2; 
		nHitVFX = VFX_INVOCATION_BESHADOWED_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   
	{ 
		nChain1VFX = VFX_INVOCATION_BRIMSTONE_CHAIN; 
		nChain2VFX = VFX_INVOCATION_BRIMSTONE_CHAIN2; 
		nHitVFX = VFX_INVOCATION_BRIMSTONE_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    
	{ 
		nChain1VFX = VFX_INVOCATION_HELLRIME_CHAIN; 
		nChain2VFX = VFX_INVOCATION_HELLRIME_CHAIN2; 
		nHitVFX = VFX_INVOCATION_HELLRIME_HIT;
	}
    else if ( ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST ) || (nMetaMagic & METAMAGIC_INVOC_TEMPEST_BLAST)   )  
	{ 
		nChain1VFX = VFX_INVOCATION_BEWITCHING_CHAIN; 
		nChain2VFX = VFX_INVOCATION_BEWITCHING_CHAIN2; 
		nHitVFX = VFX_INVOCATION_BEWITCHING_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     
	{ 
		nChain1VFX = VFX_INVOCATION_NOXIOUS_CHAIN; 
		nChain2VFX = VFX_INVOCATION_NOXIOUS_CHAIN2; 
		nHitVFX = VFX_INVOCATION_NOXIOUS_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   
	{ 
		nChain1VFX = VFX_INVOCATION_VITRIOLIC_CHAIN; 
		nChain2VFX = VFX_INVOCATION_VITRIOLIC_CHAIN2; 
		nHitVFX = VFX_INVOCATION_VITRIOLIC_HIT;
	}
    else if (nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST)  
	{ 
		nChain1VFX = VFX_INVOCATION_UTTERDARK_CHAIN; 
		nChain2VFX = VFX_INVOCATION_UTTERDARK_CHAIN2; 
		nHitVFX = VFX_INVOCATION_UTTERDARK_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   
	{ 
		nChain1VFX = VFX_INVOCATION_HINDERING_CHAIN; 
		nChain2VFX = VFX_INVOCATION_HINDERING_CHAIN2; 
		nHitVFX = VFX_INVOCATION_HINDERING_HIT;
	}
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )
	{ 
		nChain1VFX = VFX_INVOCATION_BINDING_CHAIN; 
		nChain2VFX = VFX_INVOCATION_BINDING_CHAIN2; 
		nHitVFX = VFX_INVOCATION_BINDING_HIT;
	}
	
    //Declare lightning effect connected the casters hands
    effect eLightning = EffectBeam( nChain1VFX, OBJECT_SELF, BODY_NODE_HAND );
    effect eVis  = EffectVisualEffect( nHitVFX );
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    //Hit the initial target

    //if ( TouchAttackRanged( oTarget ) == TOUCH_ATTACK_RESULT_MISS )
    //{
    //    // Failed
    //    return FALSE;
    //}

    //setting this to non-zero will trigger collecting touch attack success info from DoEldritchCombinedEffects
    SetLocalInt(OBJECT_SELF, "NW_EB_TOUCH_RESULT", 1);

    //Apply effect to the first target and the VFX impact.
    if(DoEldritchCombinedEffects(oFirstTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);


    //Reinitialize the lightning effect so that it travels from the first target to the next target
    eLightning = EffectBeam(nChain2VFX, oFirstTarget, BODY_NODE_CHEST);


    float fDelay = 0.2;
    int nCnt = 0;
    // Warlock Counts
    int nMaxCnt;
    //if ( nCasterLvl >= 30 )      { nMaxCnt = 6; }
    //else if ( nCasterLvl >= 25 ) { nMaxCnt = 5; }
    //else 
	if ( nCasterLvl >= 20 ) { nMaxCnt = 4; }
    else if ( nCasterLvl >= 15 ) { nMaxCnt = 3; }		
    else if ( nCasterLvl >= 10 ) { nMaxCnt = 2; }
    else                         { nMaxCnt = 1; }


    // *
    // * Secondary Targets
    // *

	float fArc = RADIUS_SIZE_COLOSSAL;	

    // AFW-OEI 02/20/2007: Eldritch Master adds +2 to the attack roll.
    int nBonus = 0;
    if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, OBJECT_SELF))
    {
        nBonus = 2;
		//fArc = fArc * 2;
		
    }   
	
	object oScepter = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	if (GetIsObjectValid(oScepter) && (GetTag(oScepter) == "cmi_wlkscptr01"))
		nBonus += 2; 
		
	    if (GetHasEffect( EFFECT_TYPE_POLYMORPH, OBJECT_SELF))
		{
			if (!GetHasFeat(FEAT_GUTTURAL_INVOCATIONS, OBJECT_SELF))
			{
				nBonus -= 20;
				SendMessageToPC(OBJECT_SELF,"You are exploiting the casting of spells while polymorphed without the Guttural Invocations feat. Your touch attack has been penalized 20 points.");			
			}				
		}
	
		if (GetActionMode(OBJECT_SELF, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE) == TRUE)
		nBonus -= 6;
		else
		if (GetActionMode(OBJECT_SELF, ACTION_MODE_COMBAT_EXPERTISE) == TRUE)
		nBonus -= 3;		
			   
    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fArc, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE );

    int nTouch = GetLocalInt(OBJECT_SELF, "NW_EB_TOUCH_RESULT");
    DeleteLocalInt(OBJECT_SELF, "NW_EB_TOUCH_RESULT");
    if ( nTouch == TOUCH_ATTACK_RESULT_MISS )
    {
        //FIX: show Con damage feedback even on miss
        if (IsHellfireBlastActive() && nHellfireConDmg > 0)
        {
        	HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
        	nHellfireConDmg = 0;
        }	
	    // Failed
		return FALSE;
	}
    while (GetIsObjectValid(oTarget) && nCnt < nMaxCnt)
    {
		//SpeakString("DoShapeEldritchChain(): Chain target while loop iteration.");	// DEBUG!

        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
		    nTouch = TouchAttackRanged( oTarget, TRUE, nBonus );
		    if ( nTouch == TOUCH_ATTACK_RESULT_MISS )
            {
                //FIX: show Con damage feedback even on miss
                if (IsHellfireBlastActive() && nHellfireConDmg > 0)
                {
                	HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
                	nHellfireConDmg = 0;
                }			
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));
    			    // Failed
    				return FALSE;
    		}
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));
            {
                if ( nTouch == TOUCH_ATTACK_RESULT_CRITICAL && !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT) )
                {
                    DelayCommand(fDelay, DoEldritchCombinedEffectsWrapper(oTarget,FALSE));
                }
                else
                {
                    DelayCommand(fDelay, DoEldritchCombinedEffectsWrapper(oTarget,FALSE,TRUE));
                }
                //FIX: Incrementing Con Counter here, since doing the same in
                //     DoEldritchBlast() doesn't matter, due to use of DelayCommand.
                if (IsHellfireBlastActive())
                {
                    nHellfireConDmg++;
				}
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
            }
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                eLightning = EffectBeam( nChain2VFX, oHolder, BODY_NODE_CHEST );
            }
            else
            {
                // * April 2003 trying to make sure beams originate correctly
                effect eNewLightning = EffectBeam( nChain2VFX, oHolder, BODY_NODE_CHEST );
                if(GetIsEffectValid(eNewLightning))
                {
                    eLightning =  eNewLightning;
                }
            }

            fDelay = fDelay + 0.1f;
	        //Count the number of targets that have been hit.
	        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE && !GetIsDead(oTarget))	// added the GetIsDead check to keep from cheating the player when corpses are hit, which were counting against the max count
	        {
	            nCnt++;
	        }
        }
		
        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fArc, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    }
	if (IsHellfireBlastActive() && nHellfireConDmg > 0)
	{
		HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
		nHellfireConDmg = 0;
	}	
	
	if (GetLocalInt(OBJECT_SELF, "MaxEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Maximizing Eldritch Blast");
	if (GetLocalInt(OBJECT_SELF, "EmpEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Empowering Eldritch Blast");		
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 0);
	SetLocalInt(OBJECT_SELF, "EmpEldBlast", 0);	

    return TRUE;
}


int DoShapeEldritchCone()
{
	AddCorruption(OBJECT_SELF,  5);
	//SpawnScriptDebugger();
    //Declare major variables
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    float fMaxDelay = 1.0;
    int nMetaMagic = GetMetaMagicFeat();
	int nConeVFX = VFX_INVOCATION_ELDRITCH_CONE;	// default cone is Eldritch

	// adjust the VFX according to the essence
    if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         { nConeVFX = VFX_INVOCATION_DRAINING_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { nConeVFX = VFX_INVOCATION_FRIGHTFUL_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { nConeVFX = VFX_INVOCATION_BESHADOWED_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { nConeVFX = VFX_INVOCATION_BRIMSTONE_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { nConeVFX = VFX_INVOCATION_HELLRIME_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { nConeVFX = VFX_INVOCATION_BEWITCHING_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { nConeVFX = VFX_INVOCATION_NOXIOUS_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { nConeVFX = VFX_INVOCATION_VITRIOLIC_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { nConeVFX = VFX_INVOCATION_UTTERDARK_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { nConeVFX = VFX_INVOCATION_HINDERING_CONE; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { nConeVFX = VFX_INVOCATION_BINDING_CONE; }

	effect eCone = EffectVisualEffect( nConeVFX );
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
	
	float fCone = RADIUS_SIZE_VAST;
    //if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, OBJECT_SELF))	
	//	fCone = fCone * 2;
	
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, fCone, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (oTarget != OBJECT_SELF)
        {
        // Handle combined Eldritch Essence Effects, if any
        DoEldritchCombinedEffects(oTarget, FALSE, TRUE);
        }

        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, fCone, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
	if (IsHellfireBlastActive() && nHellfireConDmg > 0)
	{
		HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
		nHellfireConDmg = 0;
	}
	
	if (GetLocalInt(OBJECT_SELF, "MaxEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Maximizing Eldritch Blast");
	if (GetLocalInt(OBJECT_SELF, "EmpEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Empowering Eldritch Blast");		
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 0);
	SetLocalInt(OBJECT_SELF, "EmpEldBlast", 0);
			
    return TRUE;
}

int DoShapeMetaDoom(int nMetaMagic = -1)
{	
	int nDoomVFX = VFX_INVOCATION_ELDRITCH_AOE;	// default Doom is Eldritch

	// adjust the VFX according to the essence
	
    if ( nMetaMagic == METAMAGIC_INVOC_UNDBANE_BLAST  )   { nDoomVFX = VFX_INVOCATION_UTTERDARK_DOOM; }
    else if ( nMetaMagic == METAMAGIC_INVOC_REPELL_BLAST )     { nDoomVFX = VFX_INVOCATION_BINDING_DOOM; }
    else if ( nMetaMagic == METAMAGIC_INVOC_TEMPEST_BLAST  )   { nDoomVFX = VFX_INVOCATION_BEWITCHING_DOOM; } 	
	
    else if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         { nDoomVFX = VFX_INVOCATION_DRAINING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { nDoomVFX = VFX_INVOCATION_FRIGHTFUL_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { nDoomVFX = VFX_INVOCATION_BESHADOWED_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { nDoomVFX = VFX_INVOCATION_BRIMSTONE_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { nDoomVFX = VFX_INVOCATION_HELLRIME_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { nDoomVFX = VFX_INVOCATION_BEWITCHING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { nDoomVFX = VFX_INVOCATION_NOXIOUS_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { nDoomVFX = VFX_INVOCATION_VITRIOLIC_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { nDoomVFX = VFX_INVOCATION_UTTERDARK_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { nDoomVFX = VFX_INVOCATION_HINDERING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { nDoomVFX = VFX_INVOCATION_BINDING_DOOM; }

	//Declare major variables
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();

    // Visual on the Location itself...
    effect eExplode = EffectVisualEffect( nDoomVFX );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

	float fRadius = RADIUS_SIZE_HUGE;
    //if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, OBJECT_SELF))	
	//	fRadius = fRadius * 2;
	
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        // Handle combined Eldritch Essence Effects, if any
    if ( spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF )
    {	
		DoEldritchCombinedEffects(oTarget, TRUE, FALSE, FALSE, nMetaMagic);
    }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
	if (IsHellfireBlastActive() && nHellfireConDmg > 0)
	{
		HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
		nHellfireConDmg = 0;
	}	
	
	if (GetLocalInt(OBJECT_SELF, "MaxEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Maximizing Eldritch Blast");
	if (GetLocalInt(OBJECT_SELF, "EmpEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Empowering Eldritch Blast");		
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 0);
	SetLocalInt(OBJECT_SELF, "EmpEldBlast", 0);
		
    return TRUE;	
	

}


int DoShapeEldritchDoom()
{
	AddCorruption(OBJECT_SELF,  8);
	
    int nMetaMagic = GetMetaMagicFeat();		
	int nDoomVFX = VFX_INVOCATION_ELDRITCH_AOE;	// default Doom is Eldritch

	// adjust the VFX according to the essence
    if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         { nDoomVFX = VFX_INVOCATION_DRAINING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { nDoomVFX = VFX_INVOCATION_FRIGHTFUL_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { nDoomVFX = VFX_INVOCATION_BESHADOWED_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { nDoomVFX = VFX_INVOCATION_BRIMSTONE_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { nDoomVFX = VFX_INVOCATION_HELLRIME_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { nDoomVFX = VFX_INVOCATION_BEWITCHING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { nDoomVFX = VFX_INVOCATION_NOXIOUS_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { nDoomVFX = VFX_INVOCATION_VITRIOLIC_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { nDoomVFX = VFX_INVOCATION_UTTERDARK_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { nDoomVFX = VFX_INVOCATION_HINDERING_DOOM; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { nDoomVFX = VFX_INVOCATION_BINDING_DOOM; }

   //Declare major variables
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();

    // Visual on the Location itself...
    effect eExplode = EffectVisualEffect( nDoomVFX );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        // Handle combined Eldritch Essence Effects, if any
    if ( spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF )
    {	
        if ( !((nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST)&& ((GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD) || (GetLevelByClass(CLASS_TYPE_UNDEAD, oTarget)>0))) )
            {
            // Handle combined Eldritch Essence Effects, if any	
            DoEldritchCombinedEffects(oTarget, FALSE, TRUE);
            }
    }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
	if (IsHellfireBlastActive() && nHellfireConDmg > 0)
	{
		HellfireShieldFeedbackMsg(nHellfireConDmg, STRREF_HELLFIRE_BLAST_NAME, OBJECT_SELF);
		nHellfireConDmg = 0;
	}	
	
	if (GetLocalInt(OBJECT_SELF, "MaxEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Maximizing Eldritch Blast");
	if (GetLocalInt(OBJECT_SELF, "EmpEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Empowering Eldritch Blast");		
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 0);
	SetLocalInt(OBJECT_SELF, "EmpEldBlast", 0);
				
    return TRUE;	
	

	
}

// cmi_ code
int DoEssenceUndBaneBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg, int nMetaMagic = -1)
{
    // First, do Base Effects:
    DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_UTTERDARK_RAY, nMetaMagic);
    return TRUE;
}
int DoEssenceRepellBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg, int nMetaMagic = -1)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_MAGICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BINDING_RAY, nMetaMagic) )
    {
        // Additional Effects: (Dex Penalty)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            //Make SR Check
            if(!MyResistSpell(oCaster, oTarget))
            {		
	            if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
	            {
	                float fDuration = 6.0f;
	
	                effect eKD = EffectKnockdown();
	                //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
					//effect eVis = EffectVisualEffect( VFX_INVOCATION_HELLRIME_HIT );	// handled by DoEldritchBlast()
	               // effect eLink = EffectLinkEffects(eDex, eDur);
	                eKD = SetEffectSpellId(eKD, SPELL_I_REPELL_BLAST); //needed to keep different essences stack, if using same shape
	
	                // Spell Effects not allowed to stack...
	                RemoveEffectsFromSpell(oTarget, SPELL_I_REPELL_BLAST);
	
	                //Apply the effect and VFX impact
	                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKD, oTarget, fDuration);
	                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
	                return TRUE;
	            }
			}
        }
    }
    return FALSE;
}
int DoEssenceTempestBlast(object oCaster, object oTarget, int bCalledFromShape, int bDoTouchTest, int nAllowReflexSave, int nHalfDmg, int nMetaMagic = -1)
{
    // First, do Base Effects:
    if ( DoEldritchBlast(oCaster, oTarget, bCalledFromShape, bDoTouchTest, DAMAGE_TYPE_ELECTRICAL, nAllowReflexSave, FALSE, nHalfDmg, VFX_INVOCATION_BINDING_RAY, nMetaMagic) )
    {
        // Additional Effects: (Dex Penalty)
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetWarlockDC(OBJECT_SELF, FALSE)))
            {
                float fDuration = RoundsToSeconds(1);

                effect eDaze = EffectDazed();
                eDaze = SetEffectSpellId(eDaze, SPELL_I_TEMPEST_BLAST); //needed to keep different essences stack, if using same shape
                RemoveEffectsFromSpell(oTarget, SPELL_I_TEMPEST_BLAST);
                //Apply the effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, fDuration);
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);	// handled by DoEldritchBlast()
                return TRUE;
            }
        }
    }
    return FALSE;
}
// end new cmi_ code


//void main() {}	// keep this line uncommented before saving/checking in; used only for compiling purposes

// -------------------------------------------------------------------