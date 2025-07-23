#include "ipi_defaults"

void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(theObject))
        { ActionCloseDoor(theObject); }
    ActionDoCommand (SetLocked (theObject, TRUE));
}

void main()
{
    DelayCommand(DOOR_DELAY, ActionAutoCloseAndLock(OBJECT_SELF));
}