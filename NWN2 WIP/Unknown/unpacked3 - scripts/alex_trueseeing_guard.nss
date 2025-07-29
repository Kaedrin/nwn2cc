// NW_C2_DEFAULT9
/*
    Default OnSpawn handler
 
    To create customized spawn scripts, use the "Custom OnSpawn" script template. 
*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/11/2002
//:://////////////////////////////////////////////////
//:: Updated 2003-08-20 Georg Zoeller: Added check for variables to active spawn in conditions without changing the spawnscript
// ChazM 6/20/05 ambient anims flag set on spawn for encounter cratures.
// ChazM 1/6/06 modified call to WalkWayPoints()
// DBR 2/03/06  Added option for a spawn script (AI stuff, but also handy in general)
// ChazM 8/22/06 Removed reference to "kinc_globals".
// ChazM 3/8/07 Added campaign level creature spawn modifications script.  Moved excess commented code out to template.
// ChazM 4/5/07 Incorporeal creatures immune to non magic weapons

#include "x0_i0_anims"

#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "nwn2_inc_spells"
#include "x2_inc_spellhook" 
#include "cmi_ginc_spells"

void main()
{
	if(Random(3) == 1)
	{
		SetBaseSkillRank(OBJECT_SELF, 6, 70, FALSE);
		SetBaseSkillRank(OBJECT_SELF, 14, 70, FALSE);
		SetBaseSkillRank(OBJECT_SELF, 17, 70, FALSE);
		effect eTrueSeeing = EffectTrueSeeing();
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrueSeeing, OBJECT_SELF, 3600.0f);
	}
}