// Script to make the PC pass a search DC of 20

// Put this on the "Condition" for a line of text you wish to
//appear if they succeed the roll
// If they do not, the line of text with no "condition" bellow it appears

int StartingConditional()
{
    // Get the PC who is involved in this conversation
    object oPC = GetPCSpeaker();

    // The PC must pass a DC 15 search check.
    if (  !GetIsSkillSuccessful(oPC, SKILL_SEARCH, 15))
        return FALSE;

    // If we make it this far, we have passed all tests.
    return TRUE;
}