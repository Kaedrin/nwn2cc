// bb_onused
// by Brendan Bellina
// October, 2007

// Used as a replacement onUsed script for light objects so that they can be lit,
//  unlit, and trigger various actions.

// To allow a light to be lit by damage also use the bb_ondamaged script.

// To be selectable an object should:
// - have no walkmesh cutter around it (be in the valid walkmesh)
// - have hit points
// - not be static
// - be useable

// Replacement onUsed script capable of:
//  - apply an effect to an object
//  - remove an effect from an object
//  - (de)activate a light
//  - (un)lock an object
//  - open an object
//  - close an object
//  - (dis)arm a trap
//  - make an object (un)useable (doesn't work on triggers)
//  - destroy an object (doesn't work on triggers)
//  - set the DO_ONCE variable of an object (on FirstPC) to prevent reuse
//  - execute a speakstring
//  - start or stop playing a sound object
//  - give experience points
//  - update a Journal entry (executes bb_journal_update script)

// Can be restricted to working only when a required item is held.

// If the use action fails then a failed message is displayed. To suppress the message set nSuppressFailMsg to 1.

// UseTemplate can be used to set the variables based on standard actions. The templates require
// that related objects are named according to these standards: A light object is named with the object tag
// followed by "_light". An Ipoint object is named with the object tag followed by "_effect" (using a placed
// effect object won't work because it won't maintain the effect when you leave the area and return). For
// the light to be initially off set the light object property "On?" to false.

// The template values are:
//  Light_Candle (lights a candle using a torch with the candle effect)
//  Light_Tiki (lights a tiki using a torch with the torchglow effect)
//  Light_Blue (lights a tiki using a torch with the fx_torch_blue effect)
//  Darken_Light (turns out a light) (this hasn't been tested)
//  Toggle_Candle (allows toggling a candle on and off using a torch)
//  Toggle_Tiki (allows toggling a tiki on and off using a torch)
//  Toggle_Blue (allows toggling a tiki with blue flame on and off using a torch)
//  Toggle_Fire (allows toggling a fireplace or brazier on and off using a torch)
// The script uses NearestObject so that common objects such as lamps can all have the same tag.

//EDITED BY UNCLE FB 05/2009 - ADDED FIRE TEMPLATE
//change definition of oUser to read object oUser = GetNearestObject (OBJECT_TYPE_CREATURE);
//to get the original un-edited script go to www.nwvault.ign.com
//and search "Silverwand Sample Campaign" or "King's Festival Campaign"

#include "ginc_param_const"

void main()
{
	string myTag = GetTag(OBJECT_SELF);

	string sUseTemplate = GetLocalString(OBJECT_SELF, "UseTemplate");
	string sReqItemTag = GetLocalString(OBJECT_SELF, "ReqItem");
	string sEffectObject = GetLocalString(OBJECT_SELF, "EffectObject");
	string sEffectToApply = GetLocalString(OBJECT_SELF, "EffectToApply");
	string sEffectToRemove = GetLocalString(OBJECT_SELF, "EffectToRemove");
	string sSpeakString = GetLocalString(OBJECT_SELF, "SpeakString");
	string sLightObject = GetLocalString(OBJECT_SELF, "LightObject");
	int nLight = GetLocalInt(OBJECT_SELF, "LightState"); // 0=Inactive, 1=Active (Lit)
	string sSoundObject = GetLocalString(OBJECT_SELF, "SoundObject");
	int nSound = GetLocalInt(OBJECT_SELF, "SoundState"); // 0=Inactive, 1=Active (Playing)
	string sLockedObject = GetLocalString(OBJECT_SELF, "LockedObject");
	int nLock = GetLocalInt(OBJECT_SELF, "LockState"); // 0=Inactive, 1=Active (Locked)
	string sObjectToOpen = GetLocalString(OBJECT_SELF, "ObjectToOpen");
	int nOpenState = GetLocalInt(OBJECT_SELF, "OpenState"); // 0=Close, 1=Open, -1=Reverse State
	string sTrapObject = GetLocalString(OBJECT_SELF, "TrapObject");
	int nTrap = GetLocalInt(OBJECT_SELF, "TrapState"); // 0=Inactive, 1=Active (Armed)
	string sUseableObject = GetLocalString(OBJECT_SELF, "UseableObject");
	int nUseable = GetLocalInt(OBJECT_SELF, "UseableState"); // 0=Unuseable, 1=Useable
	string sDestroyObject = GetLocalString(OBJECT_SELF, "DestroyObject");
	string sDoOnceObject = GetLocalString(OBJECT_SELF, "DoOnceObject");
	int nSuppressFailMsg = GetLocalInt(OBJECT_SELF, "SuppressFailMsg"); // 0=Show Fail Msg; 1=Suppress Fail Msg
	int nXP = GetLocalInt(OBJECT_SELF, "XP"); // experience points to award
	
	// template values
	if (sUseTemplate == "Light_Candle") // Lights candle and then makes object unuseable
	{
		if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001";
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_candle";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = 1;
		if (sUseableObject == "") sUseableObject = myTag;
		nUseable = 0;
	}
	else if (sUseTemplate == "Light_Tiki") // Lights tiki and then makes object unuseable
	{
		if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001";
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_torchglow";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = 1;
		if (sSoundObject == "") sSoundObject = myTag + "_sound";
		nSound = 1;
		if (sUseableObject == "") sUseableObject = myTag;
		nUseable = 0;
	}
	else if (sUseTemplate == "Light_Blue") // Lights tiki with blue flame and then makes object unuseable
	{
		if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001";
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_torch_blue";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = 1;
		if (sSoundObject == "") sSoundObject = myTag + "_sound";
		nSound = 1;
		if (sUseableObject == "") sUseableObject = myTag;
		nUseable = 0;
	}
	else if (sUseTemplate == "Darken_Light") // Darkens light and then makes object unuseable
	{ // hasn't been tested
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToRemove == "") sEffectToRemove = "fx_torchglow";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = 0;
		if (sUseableObject == "") sUseableObject = myTag;
		nUseable = 0;
	}
	else if (sUseTemplate == "Toggle_Candle") // Toggle candle on and off
	{
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_candle";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = (GetLocalInt(OBJECT_SELF,"LightState") == 0);
		if (nLight != 0 && nLight != 1) nLight = 1;
		SetLocalInt(OBJECT_SELF,"LightState",nLight);
		if (nLight == 0)
		{
			sEffectToRemove = sEffectToApply;
			sEffectToApply = "";
			sReqItemTag = "";
		}
		else if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001"; // torch rqd to turn on

	}
	else if (sUseTemplate == "Toggle_Tiki") // Toggle tiki on and off
	{
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_torchglow";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = (GetLocalInt(OBJECT_SELF,"LightState") == 0);
		if (nLight != 0 && nLight != 1) nLight = 1;
		SetLocalInt(OBJECT_SELF,"LightState",nLight);
		if (sSoundObject == "") sSoundObject = myTag + "_sound";
		nSound = nLight;
		if (nLight == 0)
		{
			sEffectToRemove = sEffectToApply;
			sEffectToApply = "";
			sReqItemTag = "";
		}
		else if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001"; // torch rqd to turn on
	}
	else if (sUseTemplate == "Toggle_Blue") // Toggle tiki with blue flame on and off
	{
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_torch_blue";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = (GetLocalInt(OBJECT_SELF,"LightState") == 0);
		if (nLight != 0 && nLight != 1) nLight = 1;
		SetLocalInt(OBJECT_SELF,"LightState",nLight);
		if (sSoundObject == "") sSoundObject = myTag + "_sound";
		nSound = nLight;
		if (nLight == 0)
		{
			sEffectToRemove = sEffectToApply;
			sEffectToApply = "";
			sReqItemTag = "";
		}
		else if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001"; // torch rqd to turn on
	}
	else if (sUseTemplate == "Toggle_Fire") // Toggle fire  on and off
	{
		if (sEffectObject == "") sEffectObject = myTag + "_effect";
		if (sEffectToApply == "") sEffectToApply = "fx_fireplace";
		if (sLightObject == "") sLightObject = myTag + "_light";
		nLight = (GetLocalInt(OBJECT_SELF,"LightState") == 0);
		if (nLight != 0 && nLight != 1) nLight = 1;
		SetLocalInt(OBJECT_SELF,"LightState",nLight);
		if (sSoundObject == "") sSoundObject = myTag + "_sound";
		nSound = nLight;
		if (nLight == 0)
		{
			sEffectToRemove = sEffectToApply;
			sEffectToApply = "";
			sReqItemTag = "";
		}
		else if (sReqItemTag == "") sReqItemTag = "NW_IT_TORCH001"; // torch rqd to turn on
	}	
	int doit = 1;
	object oUser = GetNearestObject (OBJECT_TYPE_CREATURE);
	if (sReqItemTag != "")
	{
		object oRH = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oUser);
		object oLH = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oUser);
		doit = (GetTag(oRH) == sReqItemTag || GetTag(oLH) == sReqItemTag);
	}
	
	if (doit)
	{
		if (sLightObject != "")
		{
			object oLightObject;
			if (sLightObject == myTag) oLightObject = OBJECT_SELF;
			else oLightObject = GetNearestObjectByTag(sLightObject);
			SetLightActive(oLightObject, nLight);
		}
	
		if (sSoundObject != "")
		{
			object oSoundObject;
			if (sSoundObject == myTag) oSoundObject = OBJECT_SELF;
			else oSoundObject = GetNearestObjectByTag(sSoundObject);
			if (nSound == 0) SoundObjectStop(oSoundObject);
			else SoundObjectPlay(oSoundObject);
		}
	
		if (sLockedObject != "")
		{
			object oLockedObject;
			if (sLockedObject == myTag) oLockedObject = OBJECT_SELF;
			else oLockedObject = GetNearestObjectByTag(sLockedObject);
			SetLocked(oLockedObject, nLock);
		}

		if (sObjectToOpen != "")
		{
			object oObjectToOpen;
			if (sObjectToOpen == myTag) oObjectToOpen = OBJECT_SELF;
			else oObjectToOpen = GetNearestObjectByTag(sObjectToOpen);
			if (nOpenState == 0)
				ActionCloseDoor(oObjectToOpen);
			else if (nOpenState == 1)
				ActionOpenDoor(oObjectToOpen);
			else // -1, so Toggle door state
			{
				if (GetIsOpen(oObjectToOpen) == TRUE)
					ActionCloseDoor(oObjectToOpen);
				else
					ActionOpenDoor(oObjectToOpen);
			}
		}

		if (sTrapObject != "")
		{
			object oTrapObject;
			if (sTrapObject == myTag) oTrapObject = OBJECT_SELF;
			else oTrapObject = GetNearestObjectByTag(sTrapObject);
			SetTrapActive(oTrapObject, nTrap);
		}

		if (sUseableObject != "")
		{
			object oUseableObject;
			if (sUseableObject == myTag) oUseableObject = OBJECT_SELF;
			else oUseableObject = GetNearestObjectByTag(sUseableObject);
			SetUseableFlag(oUseableObject, nUseable);
		}

		if (sEffectObject != "" && sEffectToApply != "")
		{
			object oEffectObject;
			if (sEffectObject == myTag) oEffectObject = OBJECT_SELF;
			else oEffectObject = GetNearestObjectByTag(sEffectObject);
		    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNWN2SpecialEffectFile(sEffectToApply), oEffectObject);
		}

		if (sEffectObject != "" && sEffectToRemove != "")
		{
			object oEffectObject;
			if (sEffectObject == myTag) oEffectObject = OBJECT_SELF;
			else oEffectObject = GetNearestObjectByTag(sEffectObject);
		    RemoveSEFFromObject(oEffectObject, sEffectToRemove);
		}

		if (sDestroyObject != "")
		{
			object oDestroyObject;
			if (sDestroyObject == myTag) oDestroyObject = OBJECT_SELF;
			else oDestroyObject = GetNearestObjectByTag(sDestroyObject);
			DestroyObject(oDestroyObject, 0.0, TRUE);
		}
			
		if (sSpeakString != "")
			FloatingTextStringOnCreature(sSpeakString, oUser, FALSE, 3.0);
//		ExecuteScript("bb_speakstring", OBJECT_SELF);

		ExecuteScript("bb_journal_update", OBJECT_SELF); // update journal entry

		if (nXP) // award experience points
		{
			object oFM = GetFirstFactionMember(oUser, TRUE);
			while( oFM != OBJECT_INVALID )
			{
        		GiveXPToCreature( oFM, nXP );
        		oFM = GetNextFactionMember(oUser, TRUE);
    		}
		}

		if (sDoOnceObject != "")
		{
			if (sDoOnceObject == myTag) SetLocalInt(GetFirstPC(), "DO_ONCE" + ObjectToString(OBJECT_SELF), 1);
			else SetLocalInt(GetFirstPC(), "DO_ONCE" + ObjectToString(GetNearestObjectByTag(sDoOnceObject)), 1);
		}
	}
	else // display fail msg unless fail msg is suppressed
	{
		if (!nSuppressFailMsg) FloatingTextStringOnCreature("Nothing happens.", oUser, FALSE, 3.0);
	}
}