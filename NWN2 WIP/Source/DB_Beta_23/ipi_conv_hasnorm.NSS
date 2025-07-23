#include "ipi_constants"

int StartingConditional()
{
    return ! GetLocalInt(OBJECT_SELF, HASROOM_VAR);
}