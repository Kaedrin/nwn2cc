////////////////////////////////////////////////////////////
// OnConversation
// g_ConversationDG.nss
// Copyright (c) 2001 Bioware Corp.
////////////////////////////////////////////////////////////
// Created By: Noel Borstad
// Created On: 04/25/02001
// Description: This is the default script that is called if
//              no OnConversation script is specified.
////////////////////////////////////////////////////////////

//#include "mvd_02_conversat"

void main()
{
    if ( GetListenPatternNumber() == -1 )
    {
        BeginConversation();
    }
	//MvD_02_Conversat();
}