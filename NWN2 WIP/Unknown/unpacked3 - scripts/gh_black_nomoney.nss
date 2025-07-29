int StartingConditional()
{
    if(GetGold(GetPCSpeaker()) < GetLocalInt(OBJECT_SELF, "MINIMUM_BET")) {
        return FALSE;
    }
    return TRUE;
}
