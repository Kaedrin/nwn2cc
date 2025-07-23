#include "x2_inc_switches"

void main()
{
	object caster = GetLastSpellCaster();
	
	if (caster != OBJECT_INVALID)
	{
		int done = FALSE;

		if(GetLocalInt(caster, "ps_anti_magic_zone") != 0)
		{
			SendMessageToPC(caster, "You are in an anti-magic zone where spells do not work!");
			SetModuleOverrideSpellScriptFinished();
			done = TRUE;
		}
		
		if (!done)
		{
			// check if a spell was cast from outside of the zone into a target inside the zone
			object target = GetSpellTargetObject();
			if (target != OBJECT_INVALID)
			{
				if(GetLocalInt(target, "ps_anti_magic_zone") != 0)
				{
					SendMessageToPC(caster, "Your target is in an anti-magic zone where spells do not work!");
					SetModuleOverrideSpellScriptFinished();
				}
			}
			else
			{
			}
		}
	}
	else
	{
		object target = GetSpellTargetObject();
		if (target != OBJECT_INVALID)
		{
			if(GetLocalInt(target, "ps_anti_magic_zone") != 0)
			{
				SendMessageToPC(target, "You are in an anti-magic zone where spells do not work!");
				SetModuleOverrideSpellScriptFinished();
			}
		}
		else
		{
		}
	}
}