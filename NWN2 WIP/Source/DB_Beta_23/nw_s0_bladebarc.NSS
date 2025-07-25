//::///////////////////////////////////////////////
//:: Blade Barrier: Heartbeat
//:: NW_S0_BladeBarA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a wall 10m long and 2m thick of whirling
    blades that hack and slice anything moving into
    them.  Anything caught in the blades takes
    2d6 per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 20, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    //Declare major variables
    object oTarget;
	object oCreator = GetAreaOfEffectCreator();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(oCreator);
	
	
    //Make level check
    if (nLevel > 15)
    {
        nLevel = 15;
    }

    //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // Add damage to placeables/doors now that the command support bit fields
    //--------------------------------------------------------------------------
    oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR);

    //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail. Its better to remove the barrier then
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(oCreator))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
	
			int nDC = GetSpellSaveDC();
			if (nDC >= 100)
			{
				nDC = GetLocalInt(GetAreaOfEffectCreator(), "DC5");
				if (nDC == 0)
					nDC = 19;
			}	

    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCreator))
        {
            //Fire spell cast at event
            SignalEvent(oTarget, EventSpellCastAt(oCreator, SPELL_BLADE_BARRIER));
            //Make SR Check
            if (!MyResistSpell(oCreator, oTarget) )
            {
                //Roll Damage
                int nDamage = d6(nLevel);
                //Enter Metamagic conditions
                if(nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nLevel * 6;//Damage is at max
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC))
                {
                    nDamage = nDamage/2;
                }
                //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
				
				//Link Effects
				effect eLink = EffectLinkEffects( eDam, eVis );
                //Apply damage and VFX
				ApplyEffectToObject( DURATION_TYPE_INSTANT, eLink, oTarget);
				
                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            	//ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
		}
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR);
    }
}