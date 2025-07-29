//Goes on creature's spawn in
void main()
{
	// Heal 'em!
	ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal(200) ,OBJECT_SELF );

	// Freeze 'em!
	effect eFreeze = SupernaturalEffect( EffectVisualEffect( VFX_DUR_FREEZE_ANIMATION ) );
    ApplyEffectToObject( DURATION_TYPE_PERMANENT,eFreeze,OBJECT_SELF );
	
	// Add yellow glow
	eFreeze = SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLOW_YELLOW));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, OBJECT_SELF);
}