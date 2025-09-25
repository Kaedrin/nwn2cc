//::///////////////////////////////////////////////
//:: Resonating Bolt
//:: cmi_s0_resonbolt
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: October 8, 2007
//:://////////////////////////////////////////////


#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "cmi_includes"

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
	
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);	
    if (nCasterLevel > 10)
    {
        nCasterLevel = 10;
    }
	
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
	location lTarget2 = GetSpellTargetLocation();
	
    effect eDamage;	
    effect eLightning = EffectBeam(VFX_BEAM_RESONBOLT, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_HIT_SPELL_SONIC);
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;
	
	// If you target a location, this will spawn in an invisible creature to act as the endpoint on the beam, then delete itself
	object oPoint = CreateObject(OBJECT_TYPE_CREATURE, "c_attachspellnode" , lTarget2);
	SetScriptHidden(oPoint, TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oPoint, 1.0);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPoint);
	DestroyObject(oPoint, 2.0);
	
	
    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= RADIUS_SIZE_VAST)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, RADIUS_SIZE_VAST, lTarget2, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
		//PrettyDebug("investigating target " + GetName(oTarget));
         while (GetIsObjectValid(oTarget))
        {
           //Exclude the caster from the damage effects
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
            	{
                   //Fire cast spell at event for the specified target
					//PrettyDebug("Signaling Lightning Bolt on " + GetName(oTarget));
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                   //Make an SR check
                   if (!MyResistSpell(OBJECT_SELF, oTarget))
        	       {
				   
					    int nDamage;    
						nDamage = d4(nCasterLevel);        
						nDamage = ApplyMetamagicVariableMods( nDamage, nCasterLevel*4 );

						if (GetHasSpellEffect(FEAT_LYRIC_THAUM_SONIC_MIGHT,OBJECT_SELF))
						{
							nDamage += d6(4);		
						}							
						nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SONIC);

                        //Set damage effect
                        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                        }
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, RADIUS_SIZE_VAST, lTarget2, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCnt);
    }	

		
	
}