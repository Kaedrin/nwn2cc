
#include "x0_i0_spells"
#include "cmi_includes"

void main()
{

	int nTotalLevel =  GetLevelByClass(CLASS_FOREST_MASTER);
	if (GetHasFeat(FEAT_PLANT_DOMAIN_POWER))
		nTotalLevel += GetLevelByClass(CLASS_TYPE_CLERIC);
	
    int nCha = GetAbilityModifier(ABILITY_CHARISMA);
	int nDamage;
	int nDC = nTotalLevel + 10 + nCha;
	
    effect eVis = EffectVisualEffect( VFX_HIT_TURN_UNDEAD );
	effect eDamage;
		
	location lMyLocation = GetLocation( OBJECT_SELF );
    effect eImpactVis = EffectVisualEffect(VFX_FEAT_TURN_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, lMyLocation);

	float fSize = 2.0 * RADIUS_SIZE_COLOSSAL;
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, fSize, lMyLocation, TRUE );	
    while( GetIsObjectValid(oTarget))
    {
        if( spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF )
        {
                if (GetRacialType(oTarget) == 22)
                {
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
                        DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
						nDamage = d6(nTotalLevel);
						
						if (WillSave(oTarget, nDC, SAVING_THROW_WILL, OBJECT_SELF) == SAVING_THROW_CHECK_SUCCEEDED)
						{
							nDamage = nDamage/2;
						}
						eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                        DelayCommand(0.1f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));						
                }
        }
		oTarget = GetNextObjectInShape( SHAPE_SPHERE, fSize, lMyLocation, TRUE );
    }
}