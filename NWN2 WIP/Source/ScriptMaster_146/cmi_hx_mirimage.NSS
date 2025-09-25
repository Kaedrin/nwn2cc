//::///////////////////////////////////////////////
//:: Mirror Image
//:: cmi_hx_mirimage
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: August 24, 2011
//:://////////////////////////////////////////////



#include "cmi_ginc_chars"
#include "x2_inc_spellhook" 

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

	// Prevent stacking
	int nID = SPELL_MIRROR_IMAGE;
	if ( GetHasSpellEffect(nID) )
	{
		effect eEffect = GetFirstEffect( OBJECT_SELF );
		while ( GetIsEffectValid(eEffect) )
		{
			if ( GetEffectSpellId(eEffect) == nID )
			{
				RemoveEffect( OBJECT_SELF, eEffect );
			}
			
			eEffect = GetNextEffect( OBJECT_SELF );
		}
	}

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetHexbladeCasterLevel();
	float fDuration = TurnsToSeconds(nCasterLvl);	
    if(GetHasFeat(FEAT_HEXBLADE_ARCANE_MASTERY)) // arcane mastery
    {
        fDuration = fDuration * 2;
    }	
	
	//Cap out caster level at 15 for purposes of AC bonus
	if (nCasterLvl > 15)
	{
		nCasterLvl = 15;
	}
	//Define AC bonus
	int nACBonus = (2 + ( nCasterLvl / 3 ));
	
	//Determine how many images will be created
    int nImages = d4( 1 ) + ( nCasterLvl / 3 );
	
	//Max out Images at 8
	if( nImages > 8 )  
	{ 
		nImages = 8; 
	}

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nID, FALSE));
	
	//This determines how long to wait between spawning the images. 
	float fSpin = ( 1.5 / nImages );
	float fDelay = ( 0.0 );
	string sImg = ("sp_mirror_image_1.sef");

    int i;
	
    for ( i = 0; i < nImages; i++ )
    {
        effect eAbsorb = EffectAbsorbDamage(nACBonus);
        effect eDur = EffectVisualEffect(876);
		effect eImg = EffectNWN2SpecialEffectFile( sImg, OBJECT_SELF );
        effect eLink = EffectLinkEffects(eAbsorb, eDur);
		eLink = EffectLinkEffects(eLink, eImg);
        effect eOnDispell = EffectOnDispel(0.0f, RemoveEffectsFromSpell(oTarget, SPELL_MIRROR_IMAGE));
        eLink = EffectLinkEffects(eLink, eOnDispell);
   		eLink = SetEffectSpellId(eLink, SPELL_MIRROR_IMAGE);
		eLink = SupernaturalEffect(eLink);
        DelayCommand( fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration) );
		fDelay += fSpin;		
    }
	
	/*	
	
        effect eAbsorb = EffectAbsorbDamage(nACBonus);
        effect eDur = EffectVisualEffect(876);
		effect eImg = EffectNWN2SpecialEffectFile( sImg, OBJECT_SELF );
        effect eLink = EffectLinkEffects(eAbsorb, eDur);
		eLink = EffectLinkEffects(eLink, eImg);
        effect eOnDispell = EffectOnDispel(0.0f, RemoveEffectsFromSpell(oTarget, SPELL_MIRROR_IMAGE));
        eLink = EffectLinkEffects(eLink, eOnDispell);
   		 eLink = SetEffectSpellId(eLink, SPELL_MIRROR_IMAGE);
		eLink = SupernaturalEffect(eLink);
			
    for ( i = 0; i < nImages; i++ )
    {

        DelayCommand( fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration) );
		fDelay += fSpin;		
    }
	*/
	
}