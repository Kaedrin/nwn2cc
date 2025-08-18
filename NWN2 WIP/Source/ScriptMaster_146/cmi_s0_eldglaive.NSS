//::///////////////////////////////////////////////
//:: Eldritch Glaive
//:: cmi_s0_eldglaive
//:: Purpose: WARNING: Currently critical hits are not accounted for in the damage.
//:: 	ALSO: ONLY the Brimstone, Hellrime, Vitriolic, and Standard blast are functioning.
//::	ALSO: Melee Touch Attack Focus/Specialization is not accounted for.
//::	ALSO: This has not yet been tested.  Placeholder for getting it working.
//:: Created By: Kaedrin (Matt)
//:: Created On: Nov 11, 2007
//:://////////////////////////////////////////////

#include "nw_i0_invocatns"

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

	if (GetHasFeat(FEAT_EPIC_AUTOMATIC_QUICKEN_1))
	{
			SendMessageToPC(OBJECT_SELF, "Eldritch Glaive can not be used by characters who have the Automatic Quicken Spells feat.");
			return;
	}
		
	int nAtkCap = GetLocalInt(GetModule(), "EldGlaiveAttackCap");
	int nAllowEssence = GetLocalInt(GetModule(), "EldGlaiveAllowEssence");
	int nAllowHaste = GetLocalInt(GetModule(), "EldGlaiveAllowHasteBoost");		
	int nAllowCrit = GetLocalInt(GetModule(), "EldGlaiveAllowCrits");			
	int nHasHaste;
	
	if (nAllowHaste)
	{
	    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF) == TRUE)
			nHasHaste = 1;
		else
		if (GetHasSpellEffect( 647, OBJECT_SELF ) == TRUE) // Blinding Speed Feat
			nHasHaste = 1;
		else		
		if (GetHasSpellEffect( SPELL_MASS_HASTE, OBJECT_SELF ) == TRUE) // Mass Haste Spell
			nHasHaste = 1;			
		else		
		if (GetHasSpellEffect( SPELL_HASTE, OBJECT_SELF ) == TRUE) // Haste Spell
			nHasHaste = 1;
		else
		if (GetHasSpellEffect( SPELLABILITY_WARPRIEST_HASTE, OBJECT_SELF ) == TRUE)  //Warpriest Haste
			nHasHaste = 1;	
		else
		if (GetHasSpellEffect( SPELLABILITY_FAVORED_SOUL_HASTE, OBJECT_SELF ) == TRUE)  //FavSoul Haste
			nHasHaste = 1;		
		else
		if (GetHasSpellEffect( BLADESINGER_SONG_CELERITY, OBJECT_SELF ) == TRUE)  //Bladesinger Haste
			nHasHaste = 1;	
		else
		if (GetHasSpellEffect( LION_TALISID_LIONS_SWIFTNESS, OBJECT_SELF ) == TRUE)  //Lion's Swiftness Haste
			nHasHaste = 1;													
	}

    //Declare major variables
    object oTarget = GetSpellTargetObject();
	int nMetaMagic = GetMetaMagicFeat();
	int nDurVFX = VFX_INVOCATION_HIDEOUS_BLOW;
    //Enter Metamagic conditions

	//SendMessageToPC(OBJECT_SELF, "cmi_s0_eldglaive Meta: " + IntToString(nMetaMagic));
	//SendMessageToPC(OBJECT_SELF, "cmi_s0_eldglaive nSpell: " + IntToString(GetSpellId()));
	//SetWeaponVisibility(OBJECT_SELF, FALSE, 0);	
	//object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
	//SetWeaponVisibility(oWeaponNew, FALSE, 0);
	
	if ( nMetaMagic & METAMAGIC_INVOC_DRAINING_BLAST )         { nDurVFX = VFX_INVOCATION_DRAINING_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_FRIGHTFUL_BLAST )   { nDurVFX = VFX_INVOCATION_FRIGHTFUL_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BESHADOWED_BLAST )  { nDurVFX = VFX_INVOCATION_BESHADOWED_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BRIMSTONE_BLAST )   { nDurVFX = VFX_INVOCATION_BRIMSTONE_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_HELLRIME_BLAST )    { nDurVFX = VFX_INVOCATION_HELLRIME_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_BEWITCHING_BLAST )  { nDurVFX = VFX_INVOCATION_BEWITCHING_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_NOXIOUS_BLAST )     { nDurVFX = VFX_INVOCATION_NOXIOUS_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_VITRIOLIC_BLAST )   { nDurVFX = VFX_INVOCATION_VITRIOLIC_BLOW; }
    else if ( nMetaMagic & METAMAGIC_INVOC_UTTERDARK_BLAST )   { nDurVFX = VFX_INVOCATION_UTTERDARK_BLOW; }
	else if ( nMetaMagic & METAMAGIC_INVOC_BINDING_BLAST )     { nDurVFX = VFX_INVOCATION_BINDING_BLOW; }
	else if ( nMetaMagic & METAMAGIC_INVOC_HINDERING_BLAST )   { nDurVFX = VFX_INVOCATION_HINDERING_BLOW; }

    effect eDur = EffectVisualEffect( nDurVFX );
	
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF,6.0f);
	//Apply Damage
	
	int nBaseBAB = GetTRUEBaseAttackBonus(OBJECT_SELF);
	int nCurrentBAB = nBaseBAB;
	
	int nBonus = 0;
    if (GetHasFeat(FEAT_EPIC_ELDRITCH_MASTER, OBJECT_SELF))
    {
        nBonus = 2;
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
	
	int nAttacks = (nBaseBAB + 4) / 5;
	if (nAttacks == 0)
		nAttacks = 1;
	if (nAtkCap)
	{
		if (nAttacks > nAtkCap)
			nAttacks = nAtkCap;
	}
	int nCurrentAttack = 1;
			
	while (nCurrentBAB >= 0 && nCurrentAttack <= nAttacks)
	{
		int nHit = TouchAttackMelee(oTarget,TRUE,(nCurrentBAB - nBaseBAB + nBonus));
		if (nHit > 0)
		{
			ExecuteScript ("ray_glaiveanim", OBJECT_SELF);
			if (nAllowEssence)
			{
				if (nHit == 2 && nAllowCrit == 1)
					DoEldritchCombinedEffects(oTarget, FALSE, FALSE, 2);
				else
					DoEldritchCombinedEffects(oTarget, FALSE, FALSE );
			}
			else
			{	
				if (nHit == 2 && nAllowCrit == 1)
					DoEldritchBlast(OBJECT_SELF, oTarget,FALSE,FALSE, 2);
				else
					DoEldritchBlast(OBJECT_SELF, oTarget,FALSE,FALSE);
			}
		}
		if (nAllowHaste && nHasHaste && nCurrentAttack == 1)
			nAllowHaste = 0;
		else
		{
			nCurrentAttack++;
			nCurrentBAB -= 5;
		}
	}
	
	if (GetLocalInt(OBJECT_SELF, "MaxEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Maximizing Eldritch Blast");
	if (GetLocalInt(OBJECT_SELF, "EmpEldBlast"))
		SendMessageToPC(OBJECT_SELF, "Empowering Eldritch Blast");		
	SetLocalInt(OBJECT_SELF, "MaxEldBlast", 0);
	SetLocalInt(OBJECT_SELF, "EmpEldBlast", 0);	
}