/*
Filename:           hcr2_cutsceneabort_e
System:             core (module player cutscene abort event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnCutSceneAbort Event.
This script should be attachted to the OnCutSceneAbort event under
the scripts section of Module properties.

-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunModuleEventScripts(H2_EVENT_ON_CUTSCENE_ABORT);
}