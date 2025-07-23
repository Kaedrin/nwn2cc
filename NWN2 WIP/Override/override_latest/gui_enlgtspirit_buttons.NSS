//::///////////////////////////////////////////////
//:: Enlightened Spirit GUI Buttons Handle
//:: gui_enlgtspirit_buttons
//:: Purpose: 
//:: Created By: Selea
//:: Created On:
//:: Modified By: Selea
//:://////////////////////////////////////////////


//Common
const string GUI_PANE_TITLE                             = "TitlePane";
const string GUI_PANE_BUTTONS                           = "ButtonsPane";

//Panels
const string GUI_ENLIGHTENED_SPIRIT                     = "GUIEnlightnedSpirit";
const string GUI_PANEL_ENLIGHTENED_SPIRIT               = "SCREEN_ENLGTSPIRIT";
const string GUI_FILE_ENLIGHTENED_SPIRIT                = "enlgtspirit.xml";

//Buttons
const string GUI_BUTTON_SPIRIT_BLAST                    = "SpiritBlastButton";
const string GUI_BUTTON_HOLY_BLAST1                      = "HolyBlastButton1";
const string GUI_BUTTON_HOLY_BLAST2                      = "HolyBlastButton2";
const string GUI_BUTTON_CELESTIAL_SPEED                 = "CelestialSpeedButton";


void main(int nButton)
{
	object oCharacter = GetControlledCharacter(OBJECT_SELF);
	SendMessageToPC(GetFirstPC(), "G2: " + IntToString(nButton));		

}      