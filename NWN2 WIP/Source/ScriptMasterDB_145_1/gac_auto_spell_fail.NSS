/* 

Script created by Gildren for the Dallands Beyond server

Script is used to cuase spell casting to fail for player characters that are within 
the triggered area

script is used in the Szith-Morcane interior jail cells

Put this script OnEnter of a trigger
*/

void main()
{
    effect eEffect;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Apply an effect.
    eEffect = ExtraordinaryEffect(EffectSpellFailure(100));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
}
