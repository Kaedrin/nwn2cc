int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "PLAYER_CARD_3") == 0  && GetGold(GetPCSpeaker()) >= GetLocalInt(OBJECT_SELF, "MINIMUM_BET")) {
        return TRUE;
    }
    return FALSE;
}
