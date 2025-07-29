//Goes on creature's spawn in
void main()
{


object oTarget=OBJECT_SELF;


effect eEffect;
eEffect = EffectPetrify();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}