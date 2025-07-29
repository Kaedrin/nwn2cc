//#include "hv_p_h_mirrors_inc"
#include "hv_p_h_mirrors_inc_v2"

// Various gui commands for mirror puzzle
void main(string sCommand, string sData1, string sData2, string sData3)
{
	// Make sure we're in the right area
	if (GetTag(GetArea(OBJECT_SELF)) != "hv_p_h_level2")
		return;

	// Set Machine to face a new angle
	if (sCommand == "SetMachineAngle") {
	
		object oMachine = GetNearestObjectByTag("hv_p_h_machine");
		float fAngle = StringToFloat(sData1);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_DARKNESS), oMachine, 2.0);
		AssignCommand(oMachine, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_CRAFT_MAGIC), oMachine));
		AssignCommand(oMachine, DelayCommand(0.2, SetFacing(fAngle)));
	}
	
	// Update machine angle in gui
	else if (sCommand == "UpdateMachineAngle") {
		object oMachine = GetNearestObjectByTag("hv_p_h_machine");
		SetScrollBarValue(OBJECT_SELF, "hv_p_h_mirror_puzzle2", "scrollbar_angle_mirror", FloatToInt(GetFacing(oMachine)));			
	}
	
	// Activate Machine
	else if (sCommand == "ActivateMachine") {
		object oMachine = GetNearestObjectByTag("hv_p_h_machine", OBJECT_SELF);
		//object oMirror = GetNearestObjectByTag("hv_p_h_mirror1", OBJECT_SELF);
		//AssignCommand(oMachine, TryToFireAtTarget(oMirror, GetFacing(oMachine)));
		SetLocalInt(GetArea(oMachine), "hv_max_hops", 0);
		if (GetLocalInt(oMachine, "hv_machine_busy") == 1) {
			SendMessageToPC(OBJECT_SELF, "<C=red>Machine isn't ready.");
		}
		else {
			AssignCommand(oMachine, TryToFireAtTarget(GetFacing(oMachine)));
			
			// Reset mirrors that were hit last time
			ResetMirrorsPassCheck(GetArea(OBJECT_SELF));
			
			SetLocalInt(oMachine, "hv_machine_busy", 1);
			AssignCommand(oMachine, DelayCommand(ANTI_SPAM_DELAY, SetLocalInt(oMachine, "hv_machine_busy", 0)));
		}
	}
	
	// Set mirror angle
	else if (sCommand == "SetMirrorAngle") {
		//SpeakString("Angle: " + sData1);
		//SpeakString("Mirror: " +sData2);
		
		// See if Machine was selected
		if (sData2 == "Machine") {
			object oMachine = GetNearestObjectByTag("hv_p_h_machine");
			float fAngle = StringToFloat(sData1);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_DARKNESS), oMachine, 2.0);
			AssignCommand(oMachine, DelayCommand(0.2, SetFacing(fAngle)));
		}
		else {
			object oCrystal = GetNearestObjectByTag(CRYSTAL, OBJECT_SELF);
			
			// See if it's busy
			if (GetLocalInt(oCrystal, "hv_crystal_busy") == 1) {
				SendMessageToPC(OBJECT_SELF, "<C=red>Crystal isn't ready.");
			}
			else {			
				SetLocalInt(oCrystal, "hv_crystal_busy", 1);
				AssignCommand(oCrystal, DelayCommand(ANTI_SPAM_DELAY, SetLocalInt(oCrystal, "hv_crystal_busy", 0)));
			
				object oMirror = GetMirrorByName(sData2);
				float fAngle = StringToFloat(sData1);
				AssignCommand(oCrystal, CrystalSetMirrorAngle(oCrystal, oMirror, fAngle));
			
				//GolemSetMirrorAngle(oMirror, fAngle);
			}
		}
	}
	
	// Move mirror X steps in Y direction
	else if (sCommand == "MoveMirror") {
		//SpeakString("Steps: " + sData1);
		//SpeakString("Mirror: " + sData2);
		//SpeakString("Direction: " + sData3);
		
		// Make sure machine isn't selected
		if (sData2 == "Machine")
			return;
		
		object oCrystal = GetNearestObjectByTag(CRYSTAL, OBJECT_SELF);
		// See if it's busy
		if (GetLocalInt(oCrystal, "hv_crystal_busy") == 1) {
			SendMessageToPC(OBJECT_SELF, "<C=red>Crystal isn't ready.");
		}
		else {			
			SetLocalInt(oCrystal, "hv_crystal_busy", 1);
			AssignCommand(oCrystal, DelayCommand(ANTI_SPAM_DELAY, SetLocalInt(oCrystal, "hv_crystal_busy", 0)));	
			object oMirror = GetMirrorByName(sData2);
			AssignCommand(oCrystal, CrystalMoveMirror(oCrystal, oMirror, sData3, StringToInt(sData1)));
		}
		
		
		//GolemMoveMirror(oMirror, sData3, StringToInt(sData1));
	}
	
	// Update scrollbar angle to mirror's
	else if (sCommand == "UpdateMirrorAngle") {
		object oMirror = GetMirrorByName(sData1);
		SetScrollBarValue(OBJECT_SELF, "hv_p_h_mirror_puzzle2", "scrollbar_angle_mirror", FloatToInt(GetFacing(oMirror)));
	}
}