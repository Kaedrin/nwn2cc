void RemoveAntimagic(object creature)
{
	effect eEffect = GetFirstEffect(creature);
	while(GetIsEffectValid(eEffect))
	{
		int nType = GetEffectType(eEffect);

		if(nType == EFFECT_TYPE_SPELL_FAILURE)
		{
			RemoveEffect(creature, eEffect);
		}
		
		if(nType == EFFECT_TYPE_SILENCE)
		{
			RemoveEffect(creature, eEffect);
		}
		
		eEffect = GetNextEffect(creature);
	}
	
	SetLocalInt(creature, "ps_anti_magic_zone", 0);
}

void main()
{
	object exitingChar = GetExitingObject();
	RemoveAntimagic(exitingChar);
}