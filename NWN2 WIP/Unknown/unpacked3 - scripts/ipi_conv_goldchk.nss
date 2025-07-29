#include "ipi_constants"

int StartingConditional()
{
    int roomCost = GetLocalInt(OBJECT_SELF, TOTALCOST_VAR);
    return (GetGold(GetPCSpeaker()) >= roomCost);
}
