//::///////////////////////////////////////////////
//:: Delayed Blast Fireball: On Enter
//:: NW_S0_DelFireA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster creates a trapped area which detects
    the entrance of enemy creatures into 3 m area
    around the spell location.  When tripped it
    causes a fiery explosion that does 1d6 per
    caster level up to a max of 20d6 damage.
*/
//:://////////////////////////////////////////////
//:: Georg: Removed Spellhook, fixed damage cap
//:: Created By: Preston Watamaniuk
//:: Created On: July 27, 2001
//:://////////////////////////////////////////////
//:: RPGplayer1 04/09/2008: Only enemies will trigger explosion

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

int GetSonicReserveDamageDice(object oCaster)
{

	if ( GetHasSpell(1038,oCaster) || GetHasSpell(1820,oCaster) )
		return 8;
	if ( GetHasSpell(445,oCaster) )
		return 6;
	if ( GetHasSpell(1016,oCaster) || GetHasSpell(900,oCaster) || GetHasSpell(1813,oCaster) || GetHasSpell(2027,oCaster))
		return 5;
	if ( GetHasSpell(1861,oCaster) || GetHasSpell(373,oCaster) || GetHasSpell(1037,oCaster) || GetHasSpell(1743,oCaster) || GetHasSpell(1173,oCaster)  || GetHasSpell(1209,oCaster))
		return 4;		
	if ( GetHasSpell(1753,oCaster) || GetHasSpell(1829,oCaster) || GetHasSpell(441,oCaster) )
		return 3;
				
	return 0;
}

void main()
{

    //Declare major variables
    object oTarget = GetEnteringObject();
    object oCaster = GetAreaOfEffectCreator();
    location lTarget = GetLocation(OBJECT_SELF);
    int nDamage;
    int nIce = GetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_RUNE_THUNDER");
	
	int nDamageDice = GetSonicReserveDamageDice(oCaster);
	int nDC = GetReserveSpellSaveDC(nDamageDice,oCaster);
	nDamageDice = nDamageDice * 2;
				
    effect eDam;
    effect eExplode = EffectVisualEffect(VFX_RUNE_THUNDER);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    //Check the faction of the entering object to make sure the entering object is not in the casters faction
    if(nIce == 0)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
        {
            SetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_RUNE_THUNDER",TRUE);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
			SendMessageToPC(oCaster, "Rune activated with " + IntToString(nDamageDice) + "d6 power.");
            //Cycle through the targets in the explosion area
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            while(GetIsObjectValid(oTarget))
            {
                if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_DELAYED_BLAST_FIREBALL));
                    {
                        nDamage = d6(nDamageDice);
                        //Change damage according to Reflex, Evasion and Improved Evasion
                        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_SONIC, oCaster);
                        //Set up the damage effect
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                        if(nDamage > 0)
                        {
                            //Apply VFX impact and damage effect
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        }
                    }
                }
                //Get next target in the sequence
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            }
            DestroyObject(OBJECT_SELF, 1.0);	
        }
    }
}