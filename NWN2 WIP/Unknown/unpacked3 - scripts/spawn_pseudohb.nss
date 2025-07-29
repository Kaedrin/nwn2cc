//
// NESS V8.1
//
// Spawn Pseudo-heartbeat
//
// This script is executed when a PC enters an otherwise empty area
//
#include "hcr2_core_i"

#include "spawn_functions"

void main()
{
 h2_RunObjectEventScripts(H2_AREAEVENT_ON_ENTER, OBJECT_SELF);
  object oArea = OBJECT_SELF;

  // No pseudo-heartbeats scheduled, since we just fired this one
  SetLocalInt( oArea, SPAWN_HEARTBEAT_SCHEDULED, FALSE );

  // Do a heartbeat if there are PCs in the area or any spawns up
  if ( NeedPseudoHeartbeat( oArea ) )
  {
    // This defaults to spawn_sample_hb.  You can pass the name of any script
    // to use in the function Spawn_OnAreaEnter()
    string sHeartbeatFunc = GetLocalString( oArea, SPAWN_HEARTBEAT_SCRIPT );

    // start actual heartbeat code
    ExecuteScript( sHeartbeatFunc, oArea );
    // end actual heartbeat code

    // This function sets SPAWN_HEARTBEAT_SCHEDULED to TRUE
    ScheduleNextPseudoHeartbeat( oArea );
  }
  else     
  {
    ReleaseAreaRefs(OBJECT_SELF); 
  }


//**FLAG else here to remove refcounts
}