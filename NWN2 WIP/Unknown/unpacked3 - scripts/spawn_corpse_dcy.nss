//
// NESS V8.0
// Spawn: Corpse Decay Script
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

#include "spawn_functions"

void main()
{
    object oHostBody = OBJECT_SELF;
    object oLootCorpse = GetLocalObject(oHostBody, "Corpse");
    object oItem;
    float fCorpseDecay;

    // Don't Decay while Someone is Looting
    if (GetIsOpen(oLootCorpse) == TRUE)
    {
        // try again
        fCorpseDecay = GetLocalFloat(oHostBody, "CorpseDecay");
        DelayCommand(fCorpseDecay, ExecuteScript("spawn_corpse_dcy", oHostBody));
        return;
    }

    // Don't Decay if not Empty and Timer not Expired
    oItem = GetFirstItemInInventory(oLootCorpse);
    int nDecayTimerExpired = GetLocalInt(oHostBody, "DecayTimerExpired");

    // Don't think this should ever happen, since nDecayTimerExpired should
    // be set to try by the command immediately beforethe one invoking this
    // script!
    if (oItem != OBJECT_INVALID && nDecayTimerExpired == FALSE)
    {
        fCorpseDecay = GetLocalFloat(oHostBody, "CorpseDecay");
        DelayCommand(fCorpseDecay  - 0.1, SetLocalInt(oHostBody, "DecayTimerExpired", TRUE));
        DelayCommand(fCorpseDecay, ExecuteScript("spawn_corpse_dcy", oHostBody));
        return;
    }

    int bDeleteLootOnDecay = GetLocalInt(oHostBody, "CorpseDeleteLootOnDecay");

    // To avoid potential memory leaks, we clean everything that might be left on the
    // original creatures body
    NESS_CleanCorpse(oHostBody);

    // Destroy all loot if indicated (R7 subflag)
    if (bDeleteLootOnDecay)
    {
        NESS_CleanInventory(oLootCorpse);
    }

    // Destroy the invis corpse and drop a loot bag (if any loot left)
    SetPlotFlag(oLootCorpse, FALSE);
    DestroyObject(oLootCorpse);

    // Destroy the visible corpse
    SetObjectIsDestroyable(oHostBody, TRUE, FALSE, FALSE);
    DestroyObject(oHostBody, 0.2);
}
