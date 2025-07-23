#include "x2_inc_spellhook" 

void main()
{
    if (!X2PreSpellCastCode())
    {	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	object oTarget = GetSpellTargetObject();
	object oCaster = OBJECT_SELF;
	string sSelf;
	
	if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
	{
		sSelf = IntToString(ObjectToInt(OBJECT_SELF));
	}
	else
	{
		SendMessageToPC(OBJECT_SELF, "Only hostile targets can be cloned.");	
		return;	
	}
	
	int nTargetHD = GetHitDice(oTarget);
	int nCasterLevel = GetHitDice(OBJECT_SELF);
	nCasterLevel = (nCasterLevel*2)/3;
	nCasterLevel += GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
	nCasterLevel = nCasterLevel / 2;
	
	if (nTargetHD > (nCasterLevel/2))
	{	// It the target has more than double the caster's level, the target is immune.
		SendMessageToPC(OBJECT_SELF, "This target is too strong to clone. Spell Failed.");	
		return;
	}
	
	if (GetLocalInt(oTarget, "isBoss"))
	{	// It the target has more than double the caster's level, the target is immune.
		SendMessageToPC(OBJECT_SELF, "This spell may not affect boss creatures. Spell Failed.");	
		return;
	}
		
	if (GetIsPossessedFamiliar(OBJECT_SELF))
	{
		// Using a familiar allows two copies at once time. Exploit fix.
		SendMessageToPC(OBJECT_SELF, "This spell may not be used while possessing a familiar. Spell Failed.");	
		return;	
	}
	
	string sTag = GetTag(oTarget);	
	if (FindSubString(sTag, sSelf) != -1)
	{
		SendMessageToPC(OBJECT_SELF, "You may not create a copy of a clone. Spell Failed.");
		return;
	}
	
	if (GetIsPC(oTarget))
	{
		SendMessageToPC(OBJECT_SELF, "You may not create a copy of another player. Spell Failed.");
		return;
	}
	
	string sNewTag = IntToString(ObjectToInt(OBJECT_SELF)) + "_" + sTag;	// Create "unique" tag
	int nNewHP = (GetCurrentHitPoints(oTarget)*3)/4;	// Copy has 3/4 the HP of the target
    effect eSummon = EffectSummonCopy(oTarget, VFX_HIT_AOE_SONIC, 0.0f, sNewTag, nNewHP, "hv_buff_shadow");

    //Check for metamagic extend
    int nDuration = nCasterLevel;
	
    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
	SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), FALSE));
	
	DelayCommand(6.0f, BuffSummons(OBJECT_SELF));
}