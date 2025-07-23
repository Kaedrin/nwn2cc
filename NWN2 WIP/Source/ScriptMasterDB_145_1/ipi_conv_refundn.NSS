#include "ipi_constants"

int StartingConditional()
{
    return ! GetLocalInt(OBJECT_SELF, REFUNDAMOUNT_VAR);
}