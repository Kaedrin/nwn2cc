//::///////////////////////////////////////////////
//:: Storm Bolt
//:: cmi_s2_stormbolt
//:: Purpose: 
//:: Created By: Kaedrin (Matt)
//:: Created On: December 14, 2007
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook" 
#include "cmi_ginc_chars"

int GetElecReserveDamageDice()
{
	int nStormSinger = GetLevelByClass(CLASS_STORMSINGER, OBJECT_SELF);

	if (GetHasSpell(173))
		return 9 + nStormSinger;
	if (GetHasSpell(14))
		return 6 + nStormSinger;
	if (GetHasSpell(1015) || GetHasSpell(2201) )
		return 5 + nStormSinger;
	if (GetHasSpell(1827) || GetHasSpell(1162)  || GetHasSpell(1207))
		return 4 + nStormSinger;
	if ( GetHasSpell(11) || GetHasSpell(101) || GetHasSpell(526) || GetHasSpell(1753) || GetHasSpell(1814) )
		return 3 + nStormSinger;																			
		
	return nStormSinger;
}

void main()
{

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

	//Declare major variables
	int nDamageDice = 0;
	nDamageDice = GetElecReserveDamageDice();
	if (nDamageDice == 0)
	{
		SendMessageToPC(OBJECT_SELF,"You do not have any valid spells left that can trigger this ability.");	
		return;
	}
		SendMessageToPC(OBJECT_SELF, IntToString(nDamageDice) + "d6 Storm Bolt activated");
	
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
	location lTarget2 = GetSpellTargetLocation();
		
    effect eDamage;	
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_HIT_SPELL_LIGHTNING);
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;
	int nDC = GetReserveSpellSaveDC(nDamageDice,OBJECT_SELF);
	int nStormsinger = GetLevelByClass(CLASS_STORMSINGER) ;
	
	// If you target a location, this will spawn in an invisible creature to act as the endpoint on the beam, then delete itself
	object oPoint = CreateObject(OBJECT_TYPE_CREATURE, "c_attachspellnode" , lTarget2);
	SetScriptHidden(oPoint, TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oPoint, 1.0);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPoint);
	DestroyObject(oPoint, 2.0);
	
    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
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
                	SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

					int nDamage;    
					//nDamage = d6(nDamageDice);  
					nDamage = HandleReserveMeta(nDamageDice, 6);
					
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY);

                    //Set damage effect
                    eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                    fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                    //Apply VFX impcat, damage effect and lightning effect
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
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