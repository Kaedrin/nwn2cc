void main()
{
    effect eFreeze = SupernaturalEffect( EffectVisualEffect( VFX_DUR_FREEZE_ANIMATION ) );
    ApplyEffectToObject( DURATION_TYPE_PERMANENT,eFreeze,OBJECT_SELF );
}