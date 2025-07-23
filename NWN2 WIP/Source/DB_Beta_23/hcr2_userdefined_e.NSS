/*
Filename:           hcr2_userdefined_e
System:             core (user defined event script)
Author:             Edward Beck (0100010)
Date Created:       Oct 7th, 2006.
Summary:
HCR2 OnUserDefined Event.
This script should be attachted to the OnUserDefined event under
the scripts section of Module properties.

Revision Info should only be included for post-release revisions.
-----------------
Revision:

*/

#include "hcr2_core_i"

void main()
{
    h2_RunModuleEventScripts(H2_EVENT_ON_USER_DEFINED);
}