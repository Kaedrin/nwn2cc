//::///////////////////////////////////////////////
//:: Shout, Greater
//:: NX_s0_shout.nss
//:: Copyright (c) 2007 Obsidian Entertainment
//:://////////////////////////////////////////////
/*
 	
	Components: V
	SoE: 30ft. cone-shaped burst
	Saving Throw: Fortitude for 1/2 damage and 
	1/2 duration of deafness and negate stunning.
	 
	Causes 10d6 sonic damage and Stunned status 
	effect for 1 round and Deaf status effect for 4d6 rounds
	 

*/
//:://////////////////////////////////////////////
//:: Created By: Patrick Mills
//:: Created On: 12.12.06
//:://////////////////////////////////////////////
//:: AFW-OEI 07/17/2007: NX1 VFX

#include "cmi_includes"
#include "nw_i0_spells"
#include "x2_inc_spellhook"  
#include "nwn2_inc_metmag"

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

//Declare major variables

	location	lTarget		=	GetSpellTargetLocation();
	object		oCaster		=	OBJECT_SELF;
	object		oTarget		=	GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	int			nDam;
	float		fDuration;
	float		fStun		=	RoundsToSeconds(1);
	effect		eDeaf		=	EffectDeaf();
	effect		eDam;
	effect		eImpact		=	EffectVisualEffect(VFX_HIT_SPELL_GREATER_SHOUT);
	effect		eCone		=	EffectVisualEffect(VFX_DUR_CONE_SONIC);	
	effect		eStun		=	EffectStunned();
	effect		eLink;
	
	while(GetIsObjectValid(oTarget))
	{
		if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
		{
			SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1038));
			if (oTarget != oCaster)
			{
				//determine duration and damage + metamagic
				nDam		=	d6(10);
				fDuration	=	RoundsToSeconds(d6(4));
				
				nDam		=	ApplyMetamagicVariableMods(nDam, 60);
				fDuration	=	ApplyMetamagicDurationMods(fDuration);
				fStun		=	ApplyMetamagicDurationMods(fStun);
				

				if (GetHasSpellEffect(FEAT_LYRIC_THAUM_SONIC_MIGHT,OBJECT_SELF))
				{
					nDam += d6(8);		
				}				
												
				if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SONIC, oCaster))
				{
					nDam	=	nDam/2;
					eDam	=	EffectDamage(nDam, DAMAGE_TYPE_SONIC);
					
					eLink	=	EffectLinkEffects(eDam, eImpact);
					
					fDuration	=	fDuration/2;
					
					DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, fDuration);
					
				}
				else
				{
					eDam	=	EffectDamage(nDam, DAMAGE_TYPE_SONIC);
					
					eLink	=	EffectLinkEffects(eDam, eImpact);
					
					DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, fDuration);
					ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fStun);
				}
			}
		}
		
		oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
	}
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, oCaster, 2.0);
}
			