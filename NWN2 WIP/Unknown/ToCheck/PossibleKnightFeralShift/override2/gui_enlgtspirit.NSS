//::///////////////////////////////////////////////
//:: Enlightened Spirit GUI Handle
//:: gui_enlgtspirit
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

void main()
{

	SendMessageToPC(GetFirstPC(), "G1");
	SetGUIObjectHidden(OBJECT_SELF, GUI_PANEL_ENLIGHTENED_SPIRIT, GUI_PANE_TITLE, FALSE);
	SetGUIObjectHidden(OBJECT_SELF, GUI_PANEL_ENLIGHTENED_SPIRIT, GUI_PANE_BUTTONS, FALSE);		
	SetGUIObjectHidden(OBJECT_SELF, GUI_PANEL_ENLIGHTENED_SPIRIT, GUI_BUTTON_SPIRIT_BLAST, FALSE);				
					
}      