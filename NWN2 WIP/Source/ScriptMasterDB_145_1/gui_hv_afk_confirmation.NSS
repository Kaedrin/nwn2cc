#include "alex_constants"

// Popup messagebox to confirm player is not AFK
void main()
{
	SetLocalInt(OBJECT_SELF, AFK_CHAT, 1);
}