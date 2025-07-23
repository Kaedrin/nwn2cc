/*
Filename:           hcr2_playerrest_i
System:             player rest (include script)
Author:             Edward Beck (0100010)
Date Created:       Nov. 13th, 2006
Summary:
HCR2 player rest function definition script.
Consumed as an include directive in player rest scripts.

-----------------
Revision: v1.05
Fix for tracking rest time, spells, feats, and health 
for companions on rest

*/

#include "hcr2_core_i"
#include "hcr2_playerrest_c"


const string H2_LAST_PC_REST_TIME = "H2_LAST_PC_RESTTIME";
const string H2_REST_TRIGGER = "H2_REST_TRIGGER";
const string H2_IGNORE_MINIMUM_REST_TIME = "H2_IGNORE_MINIMUM_REST_TIME";
const string H2_REST_FEEDBACK = "H2_REST_FEEDBACK";
const string H2_CAMPFIRE_BURN = "H2_CAMPFIRE_BURN";
const string H2_CAMPFIRE_START_TIME = "H2_CAMPFIRE_START_TIME";
const string H2_CAMPFIRE_LIGHT_VAR = "H2_CAMPFIRE_LIGHT_VAR";
const string H2_CAMPFIRE_FIREFX_VAR = "H2_CAMPFIRE_FIREFX_VAR";

//This function saves a value derived from the time since the server was started
//when oPC finishes a rest in which their spells and feats were allowed to be recovered
//properly. This value is used in determining the elapsed time since their last recovery
//rest when oPC next tries to rest.
void h2_SaveLastRecoveryRestTime(object oPC)
{
	oPC = GetOwnedCharacter(oPC);
    int nRestTime = h2_GetSecondsSinceServerStart();
    string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
    h2_SetModLocalInt(sUniquePCID + H2_LAST_PC_REST_TIME, nRestTime);
}

// Change by Ella - add to nCurrTime X minutes as a function of
// character level, so that resting time scales according to level
// (1 minute per level, max 16);
int addTimeToPCRest(object oPC)
{
	int pcLevel = GetTotalLevels(oPC, FALSE);
	if (pcLevel < H2_MINIMUM_SPELL_RECOVERY_REST_TIME) {
		return (H2_MINIMUM_SPELL_RECOVERY_REST_TIME - (pcLevel * 60));
	}
	else {
		return 0;
	}
}

//Returns the amount of time in real seconds that are remaining
//before recovery in rest is allowed according to H2_MINIMUM_SPELL_RECOVERY_REST_TIME
//and the time elapsed since the last time oPC recovered during rest.
int h2_RemainingTimeForRecoveryInRest(object oPC)
{
	oPC = GetOwnedCharacter(oPC);
    int nCurrTime = h2_GetSecondsSinceServerStart() + addTimeToPCRest(oPC);
    string sUniquePCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
    int nLastrest = h2_GetModLocalInt(sUniquePCID + H2_LAST_PC_REST_TIME);
    int nElapsedTime = nCurrTime - nLastrest;
    if (nLastrest > 0 &&  nElapsedTime < H2_MINIMUM_SPELL_RECOVERY_REST_TIME)
        return H2_MINIMUM_SPELL_RECOVERY_REST_TIME - nElapsedTime;
    else
        return 0;
}

void h2_DestroyCampfire(object oCampfire)
{
	object oLight = GetLocalObject(oCampfire, H2_CAMPFIRE_LIGHT_VAR);     
	object oFire = GetLocalObject(oCampfire, H2_CAMPFIRE_FIREFX_VAR);
	DestroyObject(oLight);
	DestroyObject(oFire);
	DestroyObject(oCampfire);		 
}

void h2_CheckIfCampfireIsOut(object oCampfire)
{
    int starttime = GetLocalInt(oCampfire, H2_CAMPFIRE_START_TIME);
    int currTime = h2_GetSecondsSinceServerStart();
    int burnHours = GetLocalInt(oCampfire, H2_CAMPFIRE_BURN);
    float burnTime = IntToFloat(currTime - starttime);
    if (HoursToSeconds(burnHours) <= burnTime)	
    	h2_DestroyCampfire(oCampfire);		
    else
        DelayCommand(HoursToSeconds(burnHours) - burnTime, h2_CheckIfCampfireIsOut(oCampfire));
}

void h2_UseFirewood(object oPC, object oFirewood)
{
    object oTarget = GetItemActivatedTarget();
    if (GetIsObjectValid(oTarget))
    {
        if (GetTag(oTarget) == H2_CAMPFIRE)
        {
            int burnHours = GetLocalInt(oTarget, H2_CAMPFIRE_BURN);
            burnHours +=3;
            SetLocalInt(oTarget, H2_CAMPFIRE_BURN, burnHours);
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
            DestroyObject(oFirewood);
        }
        else
            SendMessageToPC(oPC, H2_TEXT_CANNOT_USE_ON_TARGET);
    }
    else
    {
        location loc = GetItemActivatedTargetLocation();
        object oCampfire = CreateObject(OBJECT_TYPE_PLACEABLE, H2_CAMPFIRE, loc);
		vector vLight = GetPositionFromLocation(loc);
		vLight.z  = vLight.z + 0.3;
        object oLight = CreateObject(OBJECT_TYPE_LIGHT, H2_CAMPFIRE_LIGHT, Location(GetAreaFromLocation(loc), vLight, 0.0));
		object oFire = CreateObject(OBJECT_TYPE_PLACED_EFFECT, H2_CAMPFIRE_FIREFX, loc);
		SetLocalInt(oCampfire, H2_CAMPFIRE_BURN, 3);
		SetLocalObject(oCampfire, H2_CAMPFIRE_LIGHT_VAR, oLight);		
		SetLocalObject(oCampfire, H2_CAMPFIRE_FIREFX_VAR, oFire);        
		int nStarttime = h2_GetSecondsSinceServerStart();
        SetLocalInt(oCampfire, H2_CAMPFIRE_START_TIME, nStarttime);
        DelayCommand(HoursToSeconds(3), h2_CheckIfCampfireIsOut(oCampfire));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
        DestroyObject(oFirewood);
    }

}