string sLevels;
int FindPreviousLevel( string sVar )
{
  string sTmp;
  int iPos = FindSubString( sLevels, sVar );
  if ( iPos > -1 )
  {
    iPos += GetStringLength( sVar);
    while ( GetSubString( sLevels, iPos, 1 ) != ";" )
      sTmp += GetSubString( sLevels, iPos++, 1 );
    if ( sTmp != "" )
    {
      return StringToInt( sTmp );
    }
  }
  return -100;
}
void main()
{
  int index, iLev, iCurLev;
  object oPC = GetEnteringObject();
  sLevels = GetCampaignString("mycampaign", GetPCPlayerName( oPC ) + GetName( oPC ) + "Levels" );
  if ( sLevels != "" )
  {
    iCurLev = GetCurrentHitPoints( oPC );
    iLev = FindPreviousLevel( "HP=" );
    if ( iLev > -100 && iCurLev > iLev )
    {
      effect eDamage = EffectDamage( iCurLev - iLev, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_ENERGY );
      ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPC );
    }
    for( index = 0; index < 2807; index++ )
    {
      iCurLev = GetHasSpell( index, oPC );
      if ( iCurLev > 0 )
      {
        iLev = FindPreviousLevel( "S" + IntToString( index ) + "=" );
        if ( iLev == -100 )
           iLev = 0;
        while ( iLev < iCurLev )
        {
          DecrementRemainingSpellUses( oPC, index );
          iLev++;
        }
      }
    }
    for( index = 0; index < 480; index++ )
    {
      iCurLev = GetHasFeat( index, oPC );
      if ( iCurLev > 0 )
      {
        iLev = FindPreviousLevel( "F" + IntToString( index ) + "=" );
        if ( iLev == -100 )
          iLev = 0;
        while ( iLev < iCurLev )
        {
          DecrementRemainingFeatUses( oPC, index );
          iLev++;
        }
      }
    }
  }
}