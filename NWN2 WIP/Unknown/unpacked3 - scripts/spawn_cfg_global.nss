//
// ALFA NESS V1.2.3
// Spawn Global Defaults
//
// History:
//    09/21/03   Cereborn          Created
//
//  This file is for the USER to make changes to NESS default values.  It will
//  normally not be overwritten by UPDATE releases, so remerging can be avoided.
//

#include "spawn_defaults"

void SetUserGlobalDefaults()
{
  // SXn
  // Set this value to TRUE (or 1) to have dim returns suppression be the default
  // when no SX flag is present.
  //
  // **** uncomment me to make DR off by default
  // nGlobalSuppressDR = TRUE;

  // This is the default value for the SX flag when no value is specified.
  // Set to FALSE (or 0) to make SX (without a value) enable dim returns.
  //
  // **** uncomment me to make the SX flag (without arguments) turn DR on for
  // a spawn. Note that this is not strictly necessary, as you can also just use
  // SX0 on the spawn.  This was added for Albereth because he had already created
  // spawn points using SX without the 0...
  // nSuppressDR = FALSE;

}