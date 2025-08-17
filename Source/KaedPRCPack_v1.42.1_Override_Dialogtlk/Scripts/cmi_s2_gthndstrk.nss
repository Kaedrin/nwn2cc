//::///////////////////////////////////////////////
//:: Stormsingers Greater Thunderstrike
//:: cmi_s2_gthndstrk
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: April 16, 2008
//:://////////////////////////////////////////////

//Based on Lightning Bolt by OEI

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "ginc_debug"
#include "cmi_ginc_chars"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook
	
	int nSpellID = STORMSINGER_GTR_THUNDERSTRIKE;

	int nBaseDamage = GetSkillRank(SKILL_PERFORM);
	

	if (nBaseDamage < 17) //Short circuit
	{
		SendMessageToPC(OBJECT_SELF, "Insufficient Perform skill, you need 17 or more to use this ability.");
		return;
	}
	if (!GetHasFeat(257))
	{
		SpeakString("No uses of the Bard Song ability are available");
		return;
	}
	else
	{
		DecrementRemainingFeatUses(OBJECT_SELF, 257);
		DecrementRemainingFeatUses(OBJECT_SELF, 257);		
	}
		
	nBaseDamage += 2; //Stormpower
	
	int nDC = 10 + GetLevelByClass(CLASS_STORMSINGER) + GetAbilityModifier(ABILITY_CHARISMA);
	nDC += GetDCBonusByLevel(OBJECT_SELF);	
			
    int nDamage;
    //Set the lightning stream to start at the caster's hands
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
    effect eDamage;
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
	location lTarget2 = GetSpellTargetLocation();
	
	//string sTarget2 = "wp_lbolttrgt2";
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;
	
	// If you target a location, this will spawn in an invisible creature to act as the endpoint on the beam, then delete itself
	object oPoint = CreateObject(OBJECT_TYPE_CREATURE, "c_attachspellnode" , lTarget2);
	SetScriptHidden(oPoint, TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oPoint, 1.0);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPoint);
	DestroyObject(oPoint, 2.0);
	
	//CreateObject(OBJECT_TYPE_WAYPOINT, sTarget2, lTarget2);
	//object oPoint = GetObjectByTag(sTarget2);
	//ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oPoint, 1.0);
	//PrettyDebug("Lightning bolt!  Woo Hoo!");
    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget2, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
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
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, STORMSINGER_GTR_THUNDERSTRIKE));
                   //Make an SR check
                   if (!MyResistSpell(OBJECT_SELF, oTarget))
        	       {
                        //Roll damage
                        nDamage =  d20();
						if (nDamage == 20)
							nDamage = 40 + (nBaseDamage * 2);
						else
							nDamage = nDamage + nBaseDamage;
							
                        //Adjust damage based on Reflex Save, Evasion and Improved Evasion
                        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ELECTRICITY);
						
						//Set damage effect
                        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
					  		if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC))
							{
								effect eDmg2 = EffectDamage(d6(2), DAMAGE_TYPE_SONIC);
								DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg2,oTarget));
								if (!GetIsImmune(oTarget, IMMUNITY_TYPE_DEAFNESS))
									DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDeaf(),oTarget));

							}					
                        }			
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget2, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}